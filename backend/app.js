require("dotenv").config();
const express = require('express')
const app = express()

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

// configuration
app.set("view engine", "ejs")
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.get('/', (req, res) => res.render('home'))

app.get('/screen/dashboard', async (req, res) => {
    try {
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

        res.render('dashboard', { questions, questionsBySet, totalQuestions });
    } catch (error) {
        console.error('Error fetching dashboard data:', error);
        res.status(500).send('Error loading dashboard');
    }
})

app.get('/screen/question', (req, res) => res.render('question'))

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
            mediaFile: imageUrl || '',
            options,
            explanation,
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        };

        // Add question to Firestore
        const docRef = await firestore.collection('questions').add(questionData);
        console.log(`✅ Question added with ID: ${docRef.id}`);

        return res.redirect('/');
    } catch (error) {
        console.error("Error adding document: ", error);
        return res.status(400).json({ 'status': false, 'error': 'Question addition failed!' })
    }
})

app.get('/api/question', async (req, res) => {
    try {
        // Get all questions from Firestore, ordered by createdAt
        const questionsSnapshot = await firestore
            .collection('questions')
            .orderBy('createdAt', 'asc')
            .get();

        if (questionsSnapshot.empty) {
            return res.json([]);
        }

        // Group questions by questionSet
        const questionsBySet = {};

        questionsSnapshot.forEach(doc => {
            const questionData = doc.data();
            const questionSet = questionData.questionSet;

            if (!questionsBySet[questionSet]) {
                questionsBySet[questionSet] = [];
            }

            questionsBySet[questionSet].push({
                id: doc.id,
                ...questionData
            });
        });

        // Format the response and assign incremental 'no' for each set
        const result = Object.keys(questionsBySet)
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
                    data: sortedQuestions
                };
            });

        return res.json(result);

    } catch (error) {
        console.error("Error retrieving questions: ", error);
        return res.status(500).json({
            status: false,
            error: 'Failed to retrieve questions!'
        });
    }
});

app.delete('/question/:id', async (req, res) => {
    try {
        const questionId = req.params.id;
        await firestore.collection('questions').doc(questionId).delete();
        res.json({ success: true, message: 'Question deleted successfully' });
    } catch (error) {
        console.error('Error deleting question:', error);
        res.status(500).json({ success: false, error: 'Failed to delete question' });
    }
});

app.listen(PORT, () => {
    console.log('🚗 Driving Mock Test Admin Portal');
    console.log(`🌐 Server running on: http://localhost:${PORT}`);
})