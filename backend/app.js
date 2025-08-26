require("dotenv").config();
const express = require('express')
const app = express()
const path = require('path')
const methodOverride = require('method-override')
const NodeCache = require('node-cache')

const PORT = process.env.PORT || 3000;

//Connect to DB
const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
try {
    // Parse the JSON string from the environment variable
    const serviceAccount = process.env.NODE_ENV === 'production' ? JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT) : require('./serviceAccountKey.json');

    // Initialize Firebase Admin SDK
    admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });

    console.log('🔥 Firebase Admin SDK initialized successfully!');
    console.log('✅ Database connection established');
} catch (error) {
    console.error('❌ Firebase initialization error:');
    console.error(`   → Error type: ${error.name}`);
    console.error(`   → Message: ${error.message}`);
    console.error('   → Please check your service account configuration');
    process.exit(1); // Exit if Firebase initialization fails
}

const firestore = admin.firestore(); // Firestore Database Reference

// Cache Configuration
const cache = new NodeCache({
    stdTTL: 300, // Default TTL of 5 minutes (300 seconds)
    checkperiod: 60, // Check for expired keys every minute
    useClones: false, // Disable cloning for better performance
    deleteOnExpire: true,
    maxKeys: 1000 // Maximum number of keys to prevent memory overflow
});

// Cache Helper Functions
const cacheHelper = {
    // Get data from cache
    get: (key) => {
        try {
            const data = cache.get(key);
            if (data !== undefined) {
                console.log(`🎯 Cache HIT for key: ${key}`);
                return data;
            }
            console.log(`❌ Cache MISS for key: ${key}`);
            return null;
        } catch (error) {
            console.error(`Error getting cache key ${key}:`, error);
            return null;
        }
    },

    // Set data in cache with optional TTL
    set: (key, data, ttl = null) => {
        try {
            const success = cache.set(key, data, ttl);
            if (success) {
                console.log(`✅ Cache SET for key: ${key}${ttl ? ` (TTL: ${ttl}s)` : ''}`);
            }
            return success;
        } catch (error) {
            console.error(`Error setting cache key ${key}:`, error);
            return false;
        }
    },

    // Delete specific cache key
    delete: (key) => {
        try {
            const deleted = cache.del(key);
            if (deleted > 0) {
                console.log(`🗑️  Cache DELETE for key: ${key}`);
            }
            return deleted;
        } catch (error) {
            console.error(`Error deleting cache key ${key}:`, error);
            return 0;
        }
    },

    // Delete multiple cache keys
    deleteMultiple: (keys) => {
        try {
            const deleted = cache.del(keys);
            if (deleted > 0) {
                console.log(`🗑️  Cache DELETE for keys: ${keys.join(', ')}`);
            }
            return deleted;
        } catch (error) {
            console.error(`Error deleting cache keys:`, error);
            return 0;
        }
    },

    // Clear all cache
    flush: () => {
        try {
            cache.flushAll();
            console.log(`🧹 Cache FLUSH - All keys cleared`);
            return true;
        } catch (error) {
            console.error(`Error flushing cache:`, error);
            return false;
        }
    },

    // Get cache statistics
    getStats: () => {
        return cache.getStats();
    },

    // Get all cache keys
    getKeys: () => {
        return cache.keys();
    }
};

// Cache key generators
const getCacheKey = {
    questions: () => 'questions:all',
    questionsBySet: (setNumber) => `questions:set:${setNumber}`,
    question: (id) => `question:${id}`,
    coupons: (type = 'all') => `coupons:${type}`,
    coupon: (id) => `coupon:${id}`,
    dashboard: () => 'dashboard:data'
};

// configuration
app.set("view engine", "ejs")
app.set("views", path.join(__dirname, "views"))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(methodOverride('_method'))

app.get('/', (req, res) => res.render('home'))


// Question Dashboard
app.get('/screen/q-dashboard', async (req, res) => {
    try {
        const cacheKey = getCacheKey.dashboard();

        // Try to get data from cache first
        let cachedData = cacheHelper.get(cacheKey);
        if (cachedData) {
            return res.render('q-dashboard', cachedData);
        }

        // Fetch all questions
        const snapshot = await firestore.collection('questions').get();
        const questions = {};
        let totalQuestions = 0;
        const questionsBySet = {};

        // Group questions by set
        snapshot.forEach(doc => {
            const question = { id: doc.id, ...doc.data() };
            const setNumber = question.questionSet;

            if (!questions[setNumber]) {
                questions[setNumber] = [];
                questionsBySet[setNumber] = 0;
            }

            questions[setNumber].push(question);
            questionsBySet[setNumber]++;
            totalQuestions++;
        });

        // Sort questions within each set by createdAt timestamp
        for (let setNumber in questions) {
            questions[setNumber].sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));
        }

        const dashboardData = { questions, questionsBySet, totalQuestions };

        // Cache the dashboard data for 5 minutes
        cacheHelper.set(cacheKey, dashboardData, 300);

        res.render('q-dashboard', dashboardData);
    } catch (error) {
        console.error('Error fetching dashboard data:', error);
        res.status(500).send('Error loading dashboard');
    }
})

// Question Form
app.get('/screen/question', async (req, res) => {
    const questionId = req.query.id;
    if (questionId) {
        try {
            const cacheKey = getCacheKey.question(questionId);

            // Try to get question from cache first
            let cachedQuestion = cacheHelper.get(cacheKey);
            if (cachedQuestion) {
                return res.render('question-form', { question: cachedQuestion });
            }

            const doc = await firestore.collection('questions').doc(questionId).get();
            if (doc.exists) {
                const question = { id: doc.id, ...doc.data() };

                // Cache the question for 10 minutes
                cacheHelper.set(cacheKey, question, 600);

                return res.render('question-form', { question });
            }
        } catch (error) {
            console.error('Error fetching question:', error);
        }
    }
    res.render('question-form', { question: null });
})

// Coupon Dashboard
app.get('/screen/c-dashboard', async (req, res) => {
    try {
        const snapshot = await firestore.collection('coupons').get();
        const coupons = [];
        let totalCoupons = 0;
        let activeCoupons = 0;
        let expiredCoupons = 0;

        snapshot.forEach(doc => {
            const coupon = { id: doc.id, ...doc.data() };
            coupons.push(coupon);
            totalCoupons++;

            // Check if coupon is active or expired
            const now = new Date();
            let expirationDate;

            // Handle Firestore timestamp or regular date
            if (coupon.expirationDate && coupon.expirationDate.toDate) {
                expirationDate = coupon.expirationDate.toDate();
            } else if (coupon.expirationDate) {
                expirationDate = new Date(coupon.expirationDate);
            } else {
                expirationDate = new Date(0); // Invalid date
            }

            // Check if coupon is active (not expired and not fully used)
            if (expirationDate > now && coupon.usedQuantity < coupon.totalQuantity) {
                activeCoupons++;
            } else {
                expiredCoupons++;
            }
        });

        // Sort coupons by creation date (newest first)
        coupons.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

        res.render('c-dashboard', {
            coupons,
            totalCoupons,
            activeCoupons,
            expiredCoupons
        });
    } catch (error) {
        console.error('Error fetching coupons:', error);
        res.status(500).send('Error loading coupons');
    }
});

// Coupon Form
app.get('/screen/coupon', async (req, res) => {
    const couponId = req.query.id;
    if (couponId) {
        try {
            const cacheKey = getCacheKey.coupon(couponId);

            // Try to get coupon from cache first
            let cachedCoupon = cacheHelper.get(cacheKey);
            if (cachedCoupon) {
                return res.render('coupon-form', { coupon: cachedCoupon });
            }

            const doc = await firestore.collection('coupons').doc(couponId).get();

            if (doc.exists) {
                const coupon = { id: doc.id, ...doc.data() };

                // Cache the coupon for 5 minutes
                cacheHelper.set(cacheKey, coupon, 300);

                res.render('coupon-form', { coupon });
            } else {
                res.status(404).send('Coupon not found');
            }
        } catch (error) {
            console.error('Error fetching coupon:', error);
            res.status(500).send('Error loading coupon');
        }
    }
    res.render('coupon-form', { coupon: null });
});

// Question CRUD operations
// Question Create
app.post('/method/question', async (req, res) => {
    try {
        const { questionSet, question, imageUrl, correctAnswer, explanation } = req.body;

        // Validate required fields
        if (!questionSet || !question || !correctAnswer || !explanation) {
            return res.status(400).json({
                status: false,
                error: 'Required fields are missing!'
            });
        }

        // Validate options for duplicate slNo
        const optionSlNos = new Set();
        const options = ['A', 'B', 'C', 'D'].map(opt => {
            const slNo = opt;
            if (optionSlNos.has(slNo)) {
                throw new Error(`Duplicate option number ${slNo} found!`);
            }
            optionSlNos.add(slNo);
            return {
                slNo,
                value: req.body[`option${opt}Value`],
                answer: correctAnswer === opt
            };
        });

        // Create question document
        const questionData = {
            questionSet: parseInt(questionSet),
            question,
            mediaFile: imageUrl,
            options,
            explanation,
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        };

        // Add question to Firestore
        const docRef = await firestore.collection('questions').add(questionData);
        console.log(`✅ Question added with ID: ${docRef.id}`);

        // Invalidate related caches
        cacheHelper.delete(getCacheKey.questions());
        cacheHelper.delete(getCacheKey.dashboard());
        cacheHelper.delete(getCacheKey.questionsBySet(parseInt(questionSet)));

        return res.redirect('/screen/q-dashboard');
    } catch (error) {
        console.error("Error adding document: ", error);
        return res.status(400).json({ 'status': false, 'error': 'Question addition failed!' })
    }
})

// Question Update
app.post('/method/question/:id', async (req, res) => {
    try {
        const questionId = req.params.id;
        const { questionSet, question, imageUrl, correctAnswer, explanation } = req.body;

        // Validate required fields
        if (!questionSet || !question || !correctAnswer || !explanation) {
            return res.status(400).json({
                status: false,
                error: 'Required fields are missing!'
            });
        }

        // Create options array
        const options = ['A', 'B', 'C', 'D'].map(opt => ({
            slNo: opt,
            value: req.body[`option${opt}Value`],
            answer: correctAnswer === opt
        }));

        // Update the question
        await firestore.collection('questions').doc(questionId).update({
            questionSet: parseInt(questionSet),
            question,
            mediaFile: imageUrl,
            options,
            explanation,
            updatedAt: new Date().toISOString()
        });

        // Invalidate related caches
        cacheHelper.delete(getCacheKey.questions());
        cacheHelper.delete(getCacheKey.dashboard());
        cacheHelper.delete(getCacheKey.question(questionId));
        cacheHelper.delete(getCacheKey.questionsBySet(parseInt(questionSet)));

        res.redirect('/screen/q-dashboard');
    } catch (error) {
        console.error('Error updating question:', error);
        res.status(500).json({
            status: false,
            error: 'Failed to update question'
        });
    }
});

// Question Delete
app.delete('/method/question/:id', async (req, res) => {
    try {
        const questionId = req.params.id;

        // Get question data before deletion for cache invalidation
        const doc = await firestore.collection('questions').doc(questionId).get();
        let questionSet = null;
        if (doc.exists) {
            questionSet = doc.data().questionSet;
        }

        await firestore.collection('questions').doc(questionId).delete();

        // Invalidate related caches
        cacheHelper.delete(getCacheKey.questions());
        cacheHelper.delete(getCacheKey.dashboard());
        cacheHelper.delete(getCacheKey.question(questionId));
        if (questionSet !== null) {
            cacheHelper.delete(getCacheKey.questionsBySet(questionSet));
        }

        res.json({ success: true, message: 'Question deleted successfully' });
    } catch (error) {
        console.error('Error deleting question:', error);
        res.status(500).json({ success: false, error: 'Failed to delete question' });
    }
});

// Coupon CRUD operations
// Coupon Create
app.post('/method/coupon', async (req, res) => {
    try {
        const { title, couponCode, category, discount, totalQuantity, expirationDate, type } = req.body;

        // Validate required fields
        if (!title || !couponCode || !category || !discount || !totalQuantity || !expirationDate) {
            return res.status(400).json({
                status: false,
                error: 'Required fields are missing!'
            });
        }

        // Validate discount and quantity
        if (parseFloat(discount) <= 0 || parseInt(totalQuantity) <= 0) {
            return res.status(400).json({
                status: false,
                error: 'Discount and quantity must be positive numbers!'
            });
        }

        // Validate expiration date
        if (new Date(expirationDate) <= new Date()) {
            return res.status(400).json({
                status: false,
                error: 'Expiration date must be in the future!'
            });
        }

        // Create coupon document
        const totalQty = parseInt(totalQuantity);
        const usedQty = 0;
        const couponData = {
            title: title.trim(),
            couponCode: couponCode.trim().toUpperCase(),
            category,
            discount: parseFloat(discount),
            totalQuantity: totalQty,
            usedQuantity: usedQty,
            remainingQuantity: totalQty - usedQty, // Calculate remaining quantity
            expirationDate: new Date(expirationDate),
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        };

        // Add type field only if provided
        if (type) {
            const validTypes = ['expiry-soon', 'most-popular', 'almost-gone'];
            if (validTypes.includes(type)) {
                couponData.type = type;
            }
        }

        // Add coupon to Firestore
        const docRef = await firestore.collection('coupons').add(couponData);
        console.log(`✅ Coupon added with ID: ${docRef.id}`);

        // Invalidate all coupon caches
        cacheHelper.deleteMultiple([
            getCacheKey.coupons('all'),
            getCacheKey.coupons('active'),
            getCacheKey.coupons('expired'),
            getCacheKey.coupons('expiry-soon'),
            getCacheKey.coupons('most-popular'),
            getCacheKey.coupons('almost-gone')
        ]);

        return res.redirect('/screen/c-dashboard');
    } catch (error) {
        console.error("Error adding coupon: ", error);
        return res.status(400).json({ 'status': false, 'error': 'Coupon addition failed!' });
    }
});

// Coupon Update
app.post('/method/coupon/:id', async (req, res) => {
    try {
        const couponId = req.params.id;
        const { title, couponCode, category, discount, totalQuantity, expirationDate, type } = req.body;

        // Validate required fields
        if (!title || !couponCode || !category || !discount || !totalQuantity || !expirationDate) {
            return res.status(400).json({
                status: false,
                error: 'Required fields are missing!'
            });
        }

        // Validate discount and quantity
        if (parseFloat(discount) <= 0 || parseInt(totalQuantity) <= 0) {
            return res.status(400).json({
                status: false,
                error: 'Discount and quantity must be positive numbers!'
            });
        }

        // Validate expiration date
        if (new Date(expirationDate) <= new Date()) {
            return res.status(400).json({
                status: false,
                error: 'Expiration date must be in the future!'
            });
        }

        // Get existing coupon to check used quantity
        const existingDoc = await firestore.collection('coupons').doc(couponId).get();
        if (!existingDoc.exists) {
            return res.status(404).json({
                status: false,
                error: 'Coupon not found!'
            });
        }

        const existingCoupon = existingDoc.data();
        const newTotalQuantity = parseInt(totalQuantity);

        // Ensure new total quantity is not less than used quantity
        if (newTotalQuantity < existingCoupon.usedQuantity) {
            return res.status(400).json({
                status: false,
                error: `Total quantity cannot be less than used quantity (${existingCoupon.usedQuantity})!`
            });
        }

        // Prepare update data
        const usedQty = existingCoupon.usedQuantity;
        const updateData = {
            title: title.trim(),
            couponCode: couponCode.trim().toUpperCase(),
            category,
            discount: parseFloat(discount),
            totalQuantity: newTotalQuantity,
            remainingQuantity: newTotalQuantity - usedQty, // Recalculate remaining quantity
            expirationDate: new Date(expirationDate),
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        };

        // Add type field only if provided and valid
        if (type) {
            const validTypes = ['expiry-soon', 'most-popular', 'almost-gone'];
            if (validTypes.includes(type)) {
                updateData.type = type;
            }
        } else {
            // Remove type field if not provided (make it optional)
            updateData.type = admin.firestore.FieldValue.delete();
        }

        // Update the coupon
        await firestore.collection('coupons').doc(couponId).update(updateData);

        console.log(`✅ Coupon updated with ID: ${couponId}`);

        // Invalidate all coupon caches
        cacheHelper.deleteMultiple([
            getCacheKey.coupons('all'),
            getCacheKey.coupons('active'),
            getCacheKey.coupons('expired'),
            getCacheKey.coupons('expiry-soon'),
            getCacheKey.coupons('most-popular'),
            getCacheKey.coupons('almost-gone'),
            getCacheKey.coupon(couponId)
        ]);

        res.redirect('/screen/c-dashboard');
    } catch (error) {
        console.error('Error updating coupon:', error);
        res.status(500).json({
            status: false,
            error: 'Failed to update coupon'
        });
    }
});

// Coupon Delete
app.delete('/method/coupon/:id', async (req, res) => {
    try {
        const couponId = req.params.id;
        await firestore.collection('coupons').doc(couponId).delete();

        // Invalidate all coupon caches
        cacheHelper.deleteMultiple([
            getCacheKey.coupons('all'),
            getCacheKey.coupons('active'),
            getCacheKey.coupons('expired'),
            getCacheKey.coupons('expiry-soon'),
            getCacheKey.coupons('most-popular'),
            getCacheKey.coupons('almost-gone'),
            getCacheKey.coupon(couponId)
        ]);

        res.json({ success: true, message: 'Coupon deleted successfully' });
    } catch (error) {
        console.error('Error deleting coupon:', error);
        res.status(500).json({ success: false, error: 'Failed to delete coupon' });
    }
});

app.get('/api/question', async (req, res) => {
    try {
        const cacheKey = getCacheKey.questions();

        // Try to get data from cache first
        let cachedResult = cacheHelper.get(cacheKey);
        if (cachedResult) {
            return res.json(cachedResult);
        }

        // Get all questions from Firestore, ordered by createdAt
        const questionsSnapshot = await firestore
            .collection('questions')
            .orderBy('createdAt', 'asc')
            .get();

        if (questionsSnapshot.empty) {
            const emptyResult = [];
            cacheHelper.set(cacheKey, emptyResult, 60); // Cache empty result for 1 minute
            return res.json(emptyResult);
        }

        // Group questions by questionSet
        const questionsBySet = {};
        const examQuestions = [];

        questionsSnapshot.forEach(doc => {
            const questionData = doc.data();
            const questionSet = questionData.questionSet;

            // Separate exam questions (set 13) from practice questions (sets 1-12)
            if (questionSet === 13) {
                examQuestions.push({
                    id: doc.id,
                    ...questionData
                });
            } else {
                if (!questionsBySet[questionSet]) {
                    questionsBySet[questionSet] = [];
                }

                questionsBySet[questionSet].push({
                    id: doc.id,
                    ...questionData
                });
            }
        });

        // Format the practice sets (1-12)
        const practiceSets = Object.keys(questionsBySet)
            .sort((a, b) => parseInt(a) - parseInt(b)) // Sort question sets numerically
            .map(questionSet => {
                // Sort questions within each set by createdAt and assign 'no'
                const sortedQuestions = questionsBySet[questionSet]
                    .sort((a, b) => {
                        // Handle cases where createdAt might be null/undefined
                        const timeA = a.createdAt ? a.createdAt.toDate() : new Date(0);
                        const timeB = b.createdAt ? b.createdAt.toDate() : new Date(0);
                        return timeA - timeB;
                    })
                    .map((question, index) => ({
                        no: index + 1, // Incremental number starting from 1
                        question: question.question,
                        mediaFile: question.mediaFile,
                        options: question.options || [],
                        explanation: question.explanation,
                    }));

                return {
                    questionSet: parseInt(questionSet),
                    type: 'practice',
                    data: sortedQuestions
                };
            });

        // Format the exam set (13) if it exists
        let examSet = null;
        if (examQuestions.length > 0) {
            const sortedExamQuestions = examQuestions
                .sort((a, b) => {
                    const timeA = a.createdAt ? a.createdAt.toDate() : new Date(0);
                    const timeB = b.createdAt ? b.createdAt.toDate() : new Date(0);
                    return timeA - timeB;
                })
                .map((question, index) => ({
                    no: index + 1,
                    question: question.question,
                    mediaFile: question.mediaFile,
                    options: question.options || [],
                    explanation: question.explanation,
                }));

            examSet = {
                questionSet: 13,
                type: 'exam',
                data: sortedExamQuestions
            };
        }

        // Combine both types of sets in the response
        const result = [...practiceSets];
        if (examSet) {
            result.push(examSet);
        }

        // Cache the result for 10 minutes (600 seconds)
        cacheHelper.set(cacheKey, result, 600);

        return res.json(result);

    } catch (error) {
        console.error("Error retrieving questions: ", error);
        return res.status(500).json({
            status: false,
            error: 'Failed to retrieve questions!'
        });
    }
});

// API endpoint for getting coupons with various filters
app.get('/api/coupon/list', async (req, res) => {
    try {
        const { type } = req.query;
        const cacheKey = getCacheKey.coupons(type || 'all');

        // Try to get data from cache first
        let cachedResult = cacheHelper.get(cacheKey);
        if (cachedResult) {
            return res.json(cachedResult);
        }

        const now = new Date();
        let query = firestore.collection('coupons');
        let snapshot;

        // Build optimized queries based on type
        switch (type) {
            case 'active':
                // Active coupons: not expired and not fully used
                query = query.where('expirationDate', '>', now);
                snapshot = await query.get();
                break;

            case 'expired':
                // Expired coupons
                query = query.where('expirationDate', '<=', now);
                snapshot = await query.get();
                break;

            case 'expiry-soon':
                // Filter by type field
                query = query.where('type', '==', 'expiry-soon').where('expirationDate', '>', now);
                snapshot = await query.get();
                break;

            case 'most-popular':
                // Filter by type field
                query = query.where('type', '==', 'most-popular').where('expirationDate', '>', now);
                snapshot = await query.get();
                break;

            case 'almost-gone':
                // Filter by type field
                query = query.where('type', '==', 'almost-gone').where('expirationDate', '>', now);
                snapshot = await query.get();
                break;
            default:
                // Get all coupons
                query = query.where('category', '==', type).where('expirationDate', '>', now);
                snapshot = await query.get();
                break;
        }

        if (snapshot.empty) {
            const emptyResult = {
                status: true,
                data: [],
                total: 0,
                message: 'No coupons found'
            };
            cacheHelper.set(cacheKey, emptyResult, 60); // Cache empty result for 1 minute
            return res.json(emptyResult);
        }

        let coupons = [];

        // Process each coupon
        snapshot.forEach(doc => {
            const coupon = { id: doc.id, ...doc.data() };

            // Handle Firestore timestamp or regular date
            let expirationDate;
            if (coupon.expirationDate && coupon.expirationDate.toDate) {
                expirationDate = coupon.expirationDate.toDate();
            } else if (coupon.expirationDate) {
                expirationDate = new Date(coupon.expirationDate);
            } else {
                expirationDate = new Date(0);
            }

            // Add calculated fields
            coupon.expirationDate = expirationDate;
            coupon.daysUntilExpiry = Math.ceil((expirationDate - now) / (1000 * 60 * 60 * 24));

            coupons.push(coupon);
        });

        // Filter based on type parameter
        let filteredCoupons = [];

        filteredCoupons = coupons.filter(coupon =>
            coupon.usedQuantity < coupon.totalQuantity
        );

        // Sort by creation date (newest first)
        filteredCoupons.sort((a, b) => {
            const timeA = a.createdAt ? a.createdAt.toDate() : new Date(0);
            const timeB = b.createdAt ? b.createdAt.toDate() : new Date(0);
            return timeB - timeA;
        });

        // Format response data
        const formattedCoupons = filteredCoupons.map(coupon => ({
            id: coupon.id,
            title: coupon.title,
            couponCode: coupon.couponCode,
            category: coupon.category,
            discount: coupon.discount,
            totalQuantity: coupon.totalQuantity,
            usedQuantity: coupon.usedQuantity,
            remainingQuantity: coupon.remainingQuantity !== undefined ? coupon.remainingQuantity : (coupon.totalQuantity - coupon.usedQuantity), // Calculate if not present
            expirationDate: coupon.expirationDate.toISOString(),
            daysUntilExpiry: coupon.daysUntilExpiry,
            type: coupon.type || null, // Type is optional, no default value
            createdAt: coupon.createdAt ? coupon.createdAt.toDate().toISOString() : null,
            updatedAt: coupon.updatedAt ? coupon.updatedAt.toDate().toISOString() : null
        }));

        const result = {
            status: true,
            data: formattedCoupons,
            total: formattedCoupons.length,
            message: `Successfully retrieved ${formattedCoupons.length} coupons`
        };

        // Cache the result for different durations based on type
        let cacheTTL = 300; // Default 5 minutes
        if (type === 'expiry-soon' || type === 'almost-gone') {
            cacheTTL = 120; // 2 minutes for time-sensitive data
        } else if (type === 'most-popular') {
            cacheTTL = 180; // 3 minutes for usage-based data
        }

        cacheHelper.set(cacheKey, result, cacheTTL);

        return res.json(result);

    } catch (error) {
        console.error("Error retrieving coupons: ", error);
        return res.status(500).json({
            status: false,
            error: 'Failed to retrieve coupons!',
            message: error.message
        });
    }
});

// API endpoint to increase coupon usage by 1
app.post('/api/coupon/use', async (req, res) => {
    try {
        const { couponId } = req.body;

        // Validate required fields
        if (!couponId) {
            return res.status(400).json({
                status: false,
                error: 'Coupon ID is required!'
            });
        }

        // Get the coupon document
        const couponDoc = await firestore.collection('coupons').doc(couponId).get();

        if (!couponDoc.exists) {
            return res.status(404).json({
                status: false,
                error: 'Coupon not found!'
            });
        }

        const coupon = couponDoc.data();

        // Check if coupon is expired
        let expirationDate;
        if (coupon.expirationDate && coupon.expirationDate.toDate) {
            expirationDate = coupon.expirationDate.toDate();
        } else if (coupon.expirationDate) {
            expirationDate = new Date(coupon.expirationDate);
        } else {
            expirationDate = new Date(0);
        }

        if (expirationDate <= new Date()) {
            return res.status(400).json({
                status: false,
                error: 'Coupon has expired!'
            });
        }

        // Check if coupon is fully used
        if (coupon.usedQuantity >= coupon.totalQuantity) {
            return res.status(400).json({
                status: false,
                error: 'Coupon has been fully used!'
            });
        }

        // Increase used quantity by 1
        const newUsedQuantity = coupon.usedQuantity + 1;
        const newRemainingQuantity = coupon.totalQuantity - newUsedQuantity;

        // Update the coupon in Firestore
        await firestore.collection('coupons').doc(couponId).update({
            usedQuantity: newUsedQuantity,
            remainingQuantity: newRemainingQuantity, // Update remaining quantity
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });

        console.log(`✅ Coupon ${couponId} usage increased to ${newUsedQuantity}/${coupon.totalQuantity}`);

        // Invalidate coupon caches since usage data changed
        cacheHelper.deleteMultiple([
            getCacheKey.coupons('all'),
            getCacheKey.coupons('active'),
            getCacheKey.coupons('most-popular'),
            getCacheKey.coupons('almost-gone'),
            getCacheKey.coupon(couponId)
        ]);

        return res.json({
            status: true,
            message: 'Coupon usage increased successfully!',
        });

    } catch (error) {
        console.error("Error increasing coupon usage: ", error);
        return res.status(500).json({
            status: false,
            error: 'Failed to increase coupon usage!',
            message: error.message
        });
    }
});

// Get categories with coupon counts (optimized with Firestore aggregation)
app.get('/api/category/list', async (req, res) => {
    try {
        console.log('📊 Fetching categories with coupon counts (optimized)...');

        // Check cache first
        const cacheKey = 'category-list';
        const cachedResult = cacheHelper.get(cacheKey);

        if (cachedResult) {
            console.log('📋 Returning cached categories data');
            return res.json(cachedResult);
        }

        // Define all possible categories based on your form options
        const allCategories = [
            'electronics', 'fashion', 'home', 'garden', 'beauty',
            'health', 'sports', 'toys', 'automotive', 'books',
            'food', 'other'
        ];

        const categoryCounts = {};

        // Use Firestore aggregation to count documents efficiently
        console.log('🔥 Using optimized Firestore count aggregation...');

        // Execute all category count queries in parallel for maximum performance
        const countPromises = allCategories.map(async (category) => {
            try {
                // Use getCountFromServer for efficient counting (Firebase Admin SDK v11+)
                const query = firestore.collection('coupons').where('category', '==', category).where('expirationDate', '>', new Date()).where('remainingQuantity', '>', 0);

                // Try using count aggregation first
                try {
                    const snapshot = await query.count().get();
                    const count = snapshot.data().count;

                    if (count > 0) {
                        return { category, count };
                    }
                    return null;
                } catch (countError) {
                    // Fallback to traditional query if count aggregation is not available
                    console.warn(`⚠️ Count aggregation not available for ${category}, using fallback`);
                    const snapshot = await query.select().get();
                    const count = snapshot.size;

                    if (count > 0) {
                        return { category, count };
                    }
                    return null;
                }
            } catch (error) {
                console.warn(`⚠️ Failed to count category '${category}':`, error.message);
                return null;
            }
        });

        // Wait for all count queries to complete
        const results = await Promise.all(countPromises);

        // Build the final counts object
        results.forEach(result => {
            if (result && result.count > 0) {
                categoryCounts[result.category] = result.count;
            }
        });

        console.log('📈 Category counts calculated (optimized):', categoryCounts);

        // Cache the result for 5 minutes
        cacheHelper.set(cacheKey, categoryCounts, 300);

        res.json(categoryCounts);

    } catch (error) {
        console.error('❌ Error fetching categories:', error);
        res.status(500).json({
            error: 'Failed to fetch categories',
            message: error.message
        });
    }
});

// Function to import mock coupons into database
async function importMockCoupons() {
    try {
        console.log('🚀 Starting mock coupons import...');

        // Import mock coupons data
        const mockCoupons = require('./mock-coupons');

        if (!Array.isArray(mockCoupons) || mockCoupons.length === 0) {
            throw new Error('No mock coupons found or invalid format');
        }

        console.log(`📦 Found ${mockCoupons.length} mock coupons to import`);

        let successCount = 0;
        let errorCount = 0;
        const errors = [];

        // Process each coupon one by one
        for (let i = 0; i < mockCoupons.length; i++) {
            const mockCoupon = mockCoupons[i];

            try {
                // Check if coupon already exists (by coupon code)
                const existingSnapshot = await firestore
                    .collection('coupons')
                    .where('couponCode', '==', mockCoupon.couponCode)
                    .get();

                if (!existingSnapshot.empty) {
                    console.log(`⚠️  Coupon ${mockCoupon.couponCode} already exists, skipping...`);
                    continue;
                }

                // Prepare coupon data for database
                const totalQty = mockCoupon.totalQuantity;
                const usedQty = mockCoupon.usedQuantity || 0;
                const couponData = {
                    title: mockCoupon.title,
                    couponCode: mockCoupon.couponCode,
                    category: mockCoupon.category,
                    discount: mockCoupon.discount,
                    totalQuantity: totalQty,
                    usedQuantity: usedQty,
                    remainingQuantity: totalQty - usedQty, // Calculate remaining quantity
                    expirationDate: new Date(mockCoupon.expirationDate),
                    createdAt: admin.firestore.FieldValue.serverTimestamp(),
                    updatedAt: admin.firestore.FieldValue.serverTimestamp()
                };

                // Add type field only if specified in mock data
                if (mockCoupon.type) {
                    couponData.type = mockCoupon.type;
                }

                // Add coupon to Firestore
                const docRef = await firestore.collection('coupons').add(couponData);

                console.log(`✅ Imported coupon ${mockCoupon.couponCode} with ID: ${docRef.id}`);
                successCount++;

                // Add small delay to avoid overwhelming the database
                await new Promise(resolve => setTimeout(resolve, 100));

            } catch (error) {
                console.error(`❌ Error importing coupon ${mockCoupon.couponCode}:`, error.message);
                errors.push({
                    couponCode: mockCoupon.couponCode,
                    error: error.message
                });
                errorCount++;
            }
        }

        // Summary
        console.log('\n📊 Import Summary:');
        console.log(`✅ Successfully imported: ${successCount} coupons`);
        console.log(`❌ Failed to import: ${errorCount} coupons`);

        if (errors.length > 0) {
            console.log('\n❌ Errors encountered:');
            errors.forEach(error => {
                console.log(`   - ${error.couponCode}: ${error.error}`);
            });
        }

        if (successCount > 0) {
            console.log(`\n🎉 Successfully imported ${successCount} out of ${mockCoupons.length} mock coupons!`);
        }

        return {
            success: true,
            total: mockCoupons.length,
            imported: successCount,
            failed: errorCount,
            errors: errors
        };

    } catch (error) {
        console.error('💥 Fatal error during mock coupons import:', error);
        return {
            success: false,
            error: error.message
        };
    }
}

// CLI command to import mock coupons (for development/testing)
if (process.argv.includes('--import-mock-coupons')) {
    console.log('🔄 CLI import triggered');
    importMockCoupons()
        .then(result => {
            if (result.success) {
                console.log('✅ CLI import completed successfully');
                process.exit(0);
            } else {
                console.error('❌ CLI import failed');
                process.exit(1);
            }
        })
        .catch(error => {
            console.error('💥 CLI import error:', error);
            process.exit(1);
        });
}

app.listen(PORT, () => {
    console.log('🚗 Driving Mock Test Admin Portal');
    console.log(`🌐 Server running on: http://localhost:${PORT}`);
})