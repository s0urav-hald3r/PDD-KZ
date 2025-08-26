const mockCoupons = [
    {
        id: 1,
        title: 'Summer Electronics Sale',
        couponCode: 'SUMMER20',
        category: 'electronics',
        discount: 20,
        totalQuantity: 100,
        usedQuantity: 85,
        expirationDate: '2024-12-25',
        type: 'most-popular'
    },
    {
        id: 2,
        title: 'Winter Fashion Collection',
        couponCode: 'WINTER25',
        category: 'fashion',
        discount: 25,
        totalQuantity: 150,
        usedQuantity: 142,
        expirationDate: '2024-12-31',
        type: 'almost-gone'
    },
    {
        id: 3,
        title: 'Home Decor Special',
        couponCode: 'HOME30',
        category: 'home',
        discount: 30,
        totalQuantity: 80,
        usedQuantity: 76,
        expirationDate: '2024-12-28',
        type: 'almost-gone'
    },
    {
        id: 4,
        title: 'Garden Tools Discount',
        couponCode: 'GARDEN15',
        category: 'garden',
        discount: 15,
        totalQuantity: 120,
        usedQuantity: 114,
        expirationDate: '2025-01-05',
        type: 'almost-gone'
    },
    {
        id: 5,
        title: 'Beauty Products Sale',
        couponCode: 'BEAUTY40',
        category: 'beauty',
        discount: 40,
        totalQuantity: 200,
        usedQuantity: 190,
        expirationDate: '2024-12-30',
        type: 'almost-gone'
    },
    {
        id: 6,
        title: 'Health & Wellness',
        couponCode: 'HEALTH35',
        category: 'health',
        discount: 35,
        totalQuantity: 90,
        usedQuantity: 86,
        expirationDate: '2025-01-10',
        type: 'almost-gone'
    },
    {
        id: 7,
        title: 'Sports Equipment',
        couponCode: 'SPORTS25',
        category: 'sports',
        discount: 25,
        totalQuantity: 110,
        usedQuantity: 105,
        expirationDate: '2024-12-29',
    },
    {
        id: 8,
        title: 'Toy Store Special',
        couponCode: 'TOYS50',
        category: 'toys',
        discount: 50,
        totalQuantity: 180,
        usedQuantity: 171,
        expirationDate: '2024-12-26',
        type: 'almost-gone'
    },
    {
        id: 9,
        title: 'Auto Parts Discount',
        couponCode: 'AUTO20',
        category: 'automotive',
        discount: 20,
        totalQuantity: 70,
        usedQuantity: 67,
        expirationDate: '2025-01-15',
        type: 'almost-gone'
    },
    {
        id: 10,
        title: 'Book Store Sale',
        couponCode: 'BOOKS30',
        category: 'books',
        discount: 30,
        totalQuantity: 160,
        usedQuantity: 152,
        expirationDate: '2024-12-27',
        type: 'almost-gone'
    },
    {
        id: 11,
        title: 'Food & Groceries',
        couponCode: 'FOOD25',
        category: 'food',
        discount: 25,
        totalQuantity: 300,
        usedQuantity: 285,
        expirationDate: '2024-12-31',
        type: 'almost-gone'
    },
    {
        id: 12,
        title: 'General Store Offer',
        couponCode: 'GENERAL15',
        category: 'other',
        discount: 15,
        totalQuantity: 250,
        usedQuantity: 238,
        expirationDate: '2025-01-20',
    },
    {
        id: 13,
        title: 'Holiday Electronics',
        couponCode: 'HOLIDAY40',
        category: 'electronics',
        discount: 40,
        totalQuantity: 95,
        usedQuantity: 90,
        expirationDate: '2024-12-24',
        type: 'expiry-soon'
    },
    {
        id: 14,
        title: 'New Year Fashion',
        couponCode: 'NEWYEAR30',
        category: 'fashion',
        discount: 30,
        totalQuantity: 130,
        usedQuantity: 124,
        expirationDate: '2025-01-01',
        type: 'expiry-soon'
    },
    {
        id: 15,
        title: 'Spring Cleaning Sale',
        couponCode: 'SPRING25',
        category: 'home',
        discount: 25,
        totalQuantity: 140,
        usedQuantity: 133,
        expirationDate: '2025-03-31',
        type: 'almost-gone'
    },
    {
        id: 16,
        title: 'Summer Beauty Collection',
        couponCode: 'SUMMERBEAUTY35',
        category: 'beauty',
        discount: 35,
        totalQuantity: 175,
        usedQuantity: 168,
        expirationDate: '2025-06-30',
        type: 'almost-gone'
    },
    {
        id: 17,
        title: 'Back to School',
        couponCode: 'SCHOOL20',
        category: 'other',
        discount: 20,
        totalQuantity: 220,
        usedQuantity: 209,
        expirationDate: '2025-09-15',
    },
    {
        id: 18,
        title: 'Black Friday Special',
        couponCode: 'BLACKFRIDAY50',
        category: 'electronics',
        discount: 50,
        totalQuantity: 85,
        usedQuantity: 81,
        expirationDate: '2024-11-30',
        type: 'expiry-soon'
    },
    {
        id: 19,
        title: 'Cyber Monday Deal',
        couponCode: 'CYBER30',
        category: 'electronics',
        discount: 30,
        totalQuantity: 160,
        usedQuantity: 152,
        expirationDate: '2024-12-02',
        type: 'expiry-soon'
    },
    {
        id: 20,
        title: 'Christmas Gift Cards',
        couponCode: 'CHRISTMAS25',
        category: 'other',
        discount: 25,
        totalQuantity: 190,
        usedQuantity: 181,
        expirationDate: '2024-12-25',
    },
    {
        id: 21,
        title: 'Valentine\'s Day Special',
        couponCode: 'VALENTINE45',
        category: 'fashion',
        discount: 45,
        totalQuantity: 120,
        usedQuantity: 45,
        expirationDate: '2025-02-14',
    },
    {
        id: 22,
        title: 'Easter Sale',
        couponCode: 'EASTER30',
        category: 'home',
        discount: 30,
        totalQuantity: 95,
        usedQuantity: 28,
        expirationDate: '2025-04-20',
        type: 'expiry-soon'
    },
    {
        id: 23,
        title: 'Mother\'s Day Collection',
        couponCode: 'MOMDAY40',
        category: 'beauty',
        discount: 40,
        totalQuantity: 140,
        usedQuantity: 42,
        expirationDate: '2025-05-11',
        type: 'expiry-soon'
    },
    {
        id: 24,
        title: 'Father\'s Day Tools',
        couponCode: 'DADDAY25',
        category: 'garden',
        discount: 25,
        totalQuantity: 85,
        usedQuantity: 17,
        expirationDate: '2025-06-15',
    },
    {
        id: 25,
        title: 'Independence Day Sale',
        couponCode: 'JULY4TH35',
        category: 'sports',
        discount: 35,
        totalQuantity: 110,
        usedQuantity: 33,
        expirationDate: '2025-07-04',
        type: 'expiry-soon'
    },
    {
        id: 26,
        title: 'Labor Day Weekend',
        couponCode: 'LABORDAY20',
        category: 'automotive',
        discount: 20,
        totalQuantity: 75,
        usedQuantity: 15,
        expirationDate: '2025-09-01',
        type: 'expiry-soon'
    },
    {
        id: 27,
        title: 'Halloween Spooktacular',
        couponCode: 'HALLOWEEN50',
        category: 'toys',
        discount: 50,
        totalQuantity: 160,
        usedQuantity: 48,
        expirationDate: '2025-10-31',
        type: 'expiry-soon'
    },
    {
        id: 28,
        title: 'Thanksgiving Feast',
        couponCode: 'THANKSGIVING30',
        category: 'food',
        discount: 30,
        totalQuantity: 200,
        usedQuantity: 60,
        expirationDate: '2025-11-27',
        type: 'expiry-soon'
    },
    {
        id: 29,
        title: 'New Year Resolution',
        couponCode: 'RESOLUTION25',
        category: 'health',
        discount: 25,
        totalQuantity: 130,
        usedQuantity: 26,
        expirationDate: '2025-01-31',
    },
    {
        id: 30,
        title: 'Graduation Special',
        couponCode: 'GRADUATE40',
        category: 'books',
        discount: 40,
        totalQuantity: 95,
        usedQuantity: 19,
        expirationDate: '2025-06-30',
        type: 'expiry-soon'
    },
    {
        id: 31,
        title: 'Wedding Season',
        couponCode: 'WEDDING35',
        category: 'fashion',
        discount: 35,
        totalQuantity: 110,
        usedQuantity: 22,
        expirationDate: '2025-08-31',
    },
    {
        id: 32,
        title: 'Baby Shower Collection',
        couponCode: 'BABYSHOWER30',
        category: 'home',
        discount: 30,
        totalQuantity: 85,
        usedQuantity: 17,
        expirationDate: '2025-05-31',
        type: 'expiry-soon'
    },
    {
        id: 33,
        title: 'Birthday Bash',
        couponCode: 'BIRTHDAY45',
        category: 'toys',
        discount: 45,
        totalQuantity: 120,
        usedQuantity: 24,
        expirationDate: '2025-12-31',
        type: 'expiry-soon'
    },
    {
        id: 34,
        title: 'Anniversary Celebration',
        couponCode: 'ANNIVERSARY40',
        category: 'jewelry',
        discount: 40,
        totalQuantity: 70,
        usedQuantity: 14,
        expirationDate: '2025-07-31',
        type: 'expiry-soon'
    },
    {
        id: 35,
        title: 'Retirement Planning',
        couponCode: 'RETIREMENT20',
        category: 'books',
        discount: 20,
        totalQuantity: 90,
        usedQuantity: 18,
        expirationDate: '2025-09-30',
    },
    {
        id: 36,
        title: 'Holiday Travel',
        couponCode: 'TRAVEL35',
        category: 'other',
        discount: 35,
        totalQuantity: 100,
        usedQuantity: 20,
        expirationDate: '2025-12-15',
        type: 'expiry-soon'
    },
    {
        id: 37,
        title: 'Tech Tuesday',
        couponCode: 'TECHTUESDAY25',
        category: 'electronics',
        discount: 25,
        totalQuantity: 150,
        usedQuantity: 30,
        expirationDate: '2025-01-07',
        type: 'expiry-soon'
    },
    {
        id: 38,
        title: 'Wellness Wednesday',
        couponCode: 'WELLNESS30',
        category: 'health',
        discount: 30,
        totalQuantity: 120,
        usedQuantity: 24,
        expirationDate: '2025-01-14',
        type: 'expiry-soon'
    },
    {
        id: 39,
        title: 'Fitness Friday',
        couponCode: 'FITNESSFRIDAY35',
        category: 'sports',
        discount: 35,
        totalQuantity: 95,
        usedQuantity: 19,
        expirationDate: '2025-01-17',
        type: 'expiry-soon'
    },
    {
        id: 40,
        title: 'Shopping Saturday',
        couponCode: 'SHOPPINGSATURDAY40',
        category: 'fashion',
        discount: 40,
        totalQuantity: 180,
        usedQuantity: 36,
        expirationDate: '2025-01-18',
    },
    // MOST POPULAR COUPONS (80-85% usage)
    {
        id: 41,
        title: 'Gaming Console Bundle',
        couponCode: 'GAMING25',
        category: 'electronics',
        discount: 25,
        totalQuantity: 200,
        usedQuantity: 168, // 84% usage
        expirationDate: '2025-02-15',
        type: 'most-popular'
    },
    {
        id: 42,
        title: 'Premium Headphones',
        couponCode: 'AUDIO30',
        category: 'electronics',
        discount: 30,
        totalQuantity: 150,
        usedQuantity: 127, // 84.7% usage
        expirationDate: '2025-02-20',
        type: 'most-popular'
    },
    {
        id: 43,
        title: 'Designer Handbags',
        couponCode: 'LUXURY40',
        category: 'fashion',
        discount: 40,
        totalQuantity: 120,
        usedQuantity: 98, // 81.7% usage
        expirationDate: '2025-02-25',
        type: 'most-popular'
    },
    {
        id: 44,
        title: 'Smart Home Devices',
        couponCode: 'SMARTHOME35',
        category: 'home',
        discount: 35,
        totalQuantity: 180,
        usedQuantity: 153, // 85% usage
        expirationDate: '2025-03-01',
        type: 'most-popular'
    },
    {
        id: 45,
        title: 'Organic Skincare Set',
        couponCode: 'ORGANIC45',
        category: 'beauty',
        discount: 45,
        totalQuantity: 100,
        usedQuantity: 82, // 82% usage
        expirationDate: '2025-03-05',
    },
    {
        id: 46,
        title: 'Fitness Tracker Pro',
        couponCode: 'FITNESS25',
        category: 'sports',
        discount: 25,
        totalQuantity: 160,
        usedQuantity: 136, // 85% usage
        expirationDate: '2025-03-10',
        type: 'most-popular'
    },
    {
        id: 47,
        title: 'Educational Toys',
        couponCode: 'EDUCATE30',
        category: 'toys',
        discount: 30,
        totalQuantity: 140,
        usedQuantity: 119, // 85% usage
        expirationDate: '2025-03-15',
        type: 'most-popular'
    },
    {
        id: 48,
        title: 'Car Accessories',
        couponCode: 'CARACC20',
        category: 'automotive',
        discount: 20,
        totalQuantity: 200,
        usedQuantity: 168, // 84% usage
        expirationDate: '2025-03-20',
        type: 'most-popular'
    },
    // ALMOST GONE COUPONS (95%+ usage)
    {
        id: 49,
        title: 'Limited Edition Sneakers',
        couponCode: 'SNEAKERS50',
        category: 'fashion',
        discount: 50,
        totalQuantity: 80,
        usedQuantity: 77, // 96.3% usage
        expirationDate: '2025-02-28',
        type: 'almost-gone'
    },
    {
        id: 50,
        title: 'Premium Coffee Beans',
        couponCode: 'COFFEE40',
        category: 'food',
        discount: 40,
        totalQuantity: 60,
        usedQuantity: 58, // 96.7% usage
        expirationDate: '2025-03-02',
    },
    {
        id: 51,
        title: 'Wireless Earbuds',
        couponCode: 'EARBUDS35',
        category: 'electronics',
        discount: 35,
        totalQuantity: 120,
        usedQuantity: 115, // 95.8% usage
        expirationDate: '2025-03-08',
        type: 'almost-gone'
    },
    {
        id: 52,
        title: 'Kitchen Appliances',
        couponCode: 'KITCHEN30',
        category: 'home',
        discount: 30,
        totalQuantity: 90,
        usedQuantity: 87, // 96.7% usage
        expirationDate: '2025-03-12',
        type: 'almost-gone'
    },
    {
        id: 53,
        title: 'Professional Makeup',
        couponCode: 'MAKEUP45',
        category: 'beauty',
        discount: 45,
        totalQuantity: 70,
        usedQuantity: 68, // 97.1% usage
        expirationDate: '2025-03-18',
        type: 'almost-gone'
    },
    {
        id: 54,
        title: 'Yoga Equipment',
        couponCode: 'YOGA25',
        category: 'sports',
        discount: 25,
        totalQuantity: 100,
        usedQuantity: 96, // 96% usage
        expirationDate: '2025-03-25',
        type: 'almost-gone'
    },
    {
        id: 55,
        title: 'Board Games Collection',
        couponCode: 'BOARDGAMES40',
        category: 'toys',
        discount: 40,
        totalQuantity: 85,
        usedQuantity: 82, // 96.5% usage
        expirationDate: '2025-03-30',
    },
    {
        id: 56,
        title: 'Motorcycle Gear',
        couponCode: 'MOTORCYCLE30',
        category: 'automotive',
        discount: 30,
        totalQuantity: 75,
        usedQuantity: 72, // 96% usage
        expirationDate: '2025-04-05',
        type: 'almost-gone'
    },
    {
        id: 57,
        title: 'Bestseller Books',
        couponCode: 'BESTSELLER35',
        category: 'books',
        discount: 35,
        totalQuantity: 110,
        usedQuantity: 106, // 96.4% usage
        expirationDate: '2025-04-10',
        type: 'almost-gone'
    },
    {
        id: 58,
        title: 'Gourmet Food Basket',
        couponCode: 'GOURMET50',
        category: 'food',
        discount: 50,
        totalQuantity: 50,
        usedQuantity: 48, // 96% usage
        expirationDate: '2025-04-15',
        type: 'almost-gone'
    },
    {
        id: 59,
        title: 'Pet Supplies Premium',
        couponCode: 'PETSUPPLIES25',
        category: 'other',
        discount: 25,
        totalQuantity: 160,
        usedQuantity: 154, // 96.3% usage
        expirationDate: '2025-04-20',
        type: 'almost-gone'
    },
    {
        id: 60,
        title: 'Art & Craft Supplies',
        couponCode: 'ARTCRAFT30',
        category: 'other',
        discount: 30,
        totalQuantity: 95,
        usedQuantity: 91, // 95.8% usage
        expirationDate: '2025-04-25',
    },
    // ADDITIONAL MOST POPULAR COUPONS (80-85% usage)
    {
        id: 61,
        title: 'Smartphone Accessories',
        couponCode: 'PHONEACC25',
        category: 'electronics',
        discount: 25,
        totalQuantity: 300,
        usedQuantity: 252, // 84% usage
        expirationDate: '2025-05-01',
        type: 'most-popular'
    },
    {
        id: 62,
        title: 'Summer Beach Collection',
        couponCode: 'BEACH35',
        category: 'fashion',
        discount: 35,
        totalQuantity: 180,
        usedQuantity: 153, // 85% usage
        expirationDate: '2025-05-15',
        type: 'most-popular'
    },
    {
        id: 63,
        title: 'Garden Furniture Set',
        couponCode: 'GARDENFURN40',
        category: 'garden',
        discount: 40,
        totalQuantity: 120,
        usedQuantity: 98, // 81.7% usage
        expirationDate: '2025-06-01',
        type: 'most-popular'
    },
    {
        id: 64,
        title: 'Anti-Aging Cream',
        couponCode: 'ANTIAGING50',
        category: 'beauty',
        discount: 50,
        totalQuantity: 150,
        usedQuantity: 127, // 84.7% usage
        expirationDate: '2025-06-15',
    },
    {
        id: 65,
        title: 'Tennis Equipment',
        couponCode: 'TENNIS30',
        category: 'sports',
        discount: 30,
        totalQuantity: 200,
        usedQuantity: 168, // 84% usage
        expirationDate: '2025-07-01',
        type: 'most-popular'
    },
    {
        id: 66,
        title: 'Building Blocks Set',
        couponCode: 'BLOCKS25',
        category: 'toys',
        discount: 25,
        totalQuantity: 160,
        usedQuantity: 136, // 85% usage
        expirationDate: '2025-07-15',
        type: 'most-popular'
    },
    {
        id: 67,
        title: 'Tire Replacement',
        couponCode: 'TIRES35',
        category: 'automotive',
        discount: 35,
        totalQuantity: 100,
        usedQuantity: 82, // 82% usage
        expirationDate: '2025-08-01',
        type: 'most-popular'
    },
    {
        id: 68,
        title: 'Science Fiction Books',
        couponCode: 'SCIFI40',
        category: 'books',
        discount: 40,
        totalQuantity: 140,
        usedQuantity: 119, // 85% usage
        expirationDate: '2025-08-15',
    },
    {
        id: 69,
        title: 'Organic Vegetables',
        couponCode: 'VEGGIES30',
        category: 'food',
        discount: 30,
        totalQuantity: 250,
        usedQuantity: 210, // 84% usage
        expirationDate: '2025-09-01',
        type: 'most-popular'
    },
    {
        id: 70,
        title: 'Pet Grooming Kit',
        couponCode: 'GROOMING25',
        category: 'other',
        discount: 25,
        totalQuantity: 180,
        usedQuantity: 153, // 85% usage
        expirationDate: '2025-09-15',
        type: 'most-popular'
    },
    {
        id: 71,
        title: 'Virtual Reality Headset',
        couponCode: 'VR45',
        category: 'electronics',
        discount: 45,
        totalQuantity: 80,
        usedQuantity: 66, // 82.5% usage
        expirationDate: '2025-10-01',
        type: 'most-popular'
    },
    {
        id: 72,
        title: 'Winter Boots Collection',
        couponCode: 'WINTERBOOTS35',
        category: 'fashion',
        discount: 35,
        totalQuantity: 220,
        usedQuantity: 187, // 85% usage
        expirationDate: '2025-10-15',
        type: 'most-popular'
    },
    {
        id: 73,
        title: 'Indoor Plants',
        couponCode: 'PLANTS20',
        category: 'garden',
        discount: 20,
        totalQuantity: 300,
        usedQuantity: 252, // 84% usage
        expirationDate: '2025-11-01',
        type: 'most-popular'
    },
    {
        id: 74,
        title: 'Hair Care Products',
        couponCode: 'HAIRCARE40',
        category: 'beauty',
        discount: 40,
        totalQuantity: 200,
        usedQuantity: 168, // 84% usage
        expirationDate: '2025-11-15',
        type: 'most-popular'
    },
    {
        id: 75,
        title: 'Swimming Gear',
        couponCode: 'SWIMMING30',
        category: 'sports',
        discount: 30,
        totalQuantity: 160,
        usedQuantity: 136, // 85% usage
        expirationDate: '2025-12-01',
    },
    {
        id: 76,
        title: 'Puzzle Collection',
        couponCode: 'PUZZLES25',
        category: 'toys',
        discount: 25,
        totalQuantity: 140,
        usedQuantity: 119, // 85% usage
        expirationDate: '2025-12-15',
        type: 'most-popular'
    },
    {
        id: 77,
        title: 'Car Audio System',
        couponCode: 'CARAUDIO50',
        category: 'automotive',
        discount: 50,
        totalQuantity: 60,
        usedQuantity: 51, // 85% usage
        expirationDate: '2026-01-01',
        type: 'most-popular'
    },
    {
        id: 78,
        title: 'Cookbook Collection',
        couponCode: 'COOKBOOKS35',
        category: 'books',
        discount: 35,
        totalQuantity: 120,
        usedQuantity: 102, // 85% usage
        expirationDate: '2026-01-15',
        type: 'most-popular'
    },
    {
        id: 79,
        title: 'Fresh Fruits Basket',
        couponCode: 'FRUITS30',
        category: 'food',
        discount: 30,
        totalQuantity: 180,
        usedQuantity: 153, // 85% usage
        expirationDate: '2026-02-01',
        type: 'most-popular'
    },
    {
        id: 80,
        title: 'Home Office Supplies',
        couponCode: 'OFFICE25',
        category: 'other',
        discount: 25,
        totalQuantity: 250,
        usedQuantity: 210, // 84% usage
        expirationDate: '2026-02-15',
    },
    // ADDITIONAL ALMOST GONE COUPONS (95%+ usage)
    {
        id: 81,
        title: 'Gaming Mouse Pro',
        couponCode: 'GAMINGMOUSE40',
        category: 'electronics',
        discount: 40,
        totalQuantity: 75,
        usedQuantity: 72, // 96% usage
        expirationDate: '2025-05-20',
        type: 'almost-gone'
    },
    {
        id: 82,
        title: 'Designer Sunglasses',
        couponCode: 'SUNGLASSES55',
        category: 'fashion',
        discount: 55,
        totalQuantity: 50,
        usedQuantity: 48, // 96% usage
        expirationDate: '2025-06-05',
        type: 'almost-gone'
    },
    {
        id: 83,
        title: 'Hydroponic System',
        couponCode: 'HYDROPONIC45',
        category: 'garden',
        discount: 45,
        totalQuantity: 40,
        usedQuantity: 39, // 97.5% usage
        expirationDate: '2025-06-20',
    },
    {
        id: 84,
        title: 'Luxury Perfume Set',
        couponCode: 'PERFUME60',
        category: 'beauty',
        discount: 60,
        totalQuantity: 30,
        usedQuantity: 29, // 96.7% usage
        expirationDate: '2025-07-05',
        type: 'almost-gone'
    },
    {
        id: 85,
        title: 'Golf Club Set',
        couponCode: 'GOLF40',
        category: 'sports',
        discount: 40,
        totalQuantity: 65,
        usedQuantity: 63, // 96.9% usage
        expirationDate: '2025-07-20',
        type: 'almost-gone'
    },
    {
        id: 86,
        title: 'Remote Control Car',
        couponCode: 'RCCAR50',
        category: 'toys',
        discount: 50,
        totalQuantity: 55,
        usedQuantity: 53, // 96.4% usage
        expirationDate: '2025-08-05',
        type: 'almost-gone'
    },
    {
        id: 87,
        title: 'Car Wash Kit',
        couponCode: 'CARWASH30',
        category: 'automotive',
        discount: 30,
        totalQuantity: 85,
        usedQuantity: 82, // 96.5% usage
        expirationDate: '2025-08-20',
        type: 'almost-gone'
    },
    {
        id: 88,
        title: 'Mystery Thriller Books',
        couponCode: 'MYSTERY45',
        category: 'books',
        discount: 45,
        totalQuantity: 70,
        usedQuantity: 68, // 97.1% usage
        expirationDate: '2025-09-05',
    },
    {
        id: 89,
        title: 'Gourmet Cheese Selection',
        couponCode: 'CHEESE40',
        category: 'food',
        discount: 40,
        totalQuantity: 45,
        usedQuantity: 43, // 95.6% usage
        expirationDate: '2025-09-20',
        type: 'almost-gone'
    },
    {
        id: 90,
        title: 'DIY Craft Kit',
        couponCode: 'DIYCRAFT35',
        category: 'other',
        discount: 35,
        totalQuantity: 80,
        usedQuantity: 77, // 96.3% usage
        expirationDate: '2025-10-05',
        type: 'almost-gone'
    },
    {
        id: 91,
        title: 'Bluetooth Speaker',
        couponCode: 'SPEAKER30',
        category: 'electronics',
        discount: 30,
        totalQuantity: 95,
        usedQuantity: 91, // 95.8% usage
        expirationDate: '2025-10-20',
        type: 'almost-gone'
    },
    {
        id: 92,
        title: 'Evening Gown Collection',
        couponCode: 'EVENING50',
        category: 'fashion',
        discount: 50,
        totalQuantity: 60,
        usedQuantity: 58, // 96.7% usage
        expirationDate: '2025-11-05',
        type: 'almost-gone'
    },
    {
        id: 93,
        title: 'Bonsai Tree Kit',
        couponCode: 'BONSAI40',
        category: 'garden',
        discount: 40,
        totalQuantity: 35,
        usedQuantity: 34, // 97.1% usage
        expirationDate: '2025-11-20',
        type: 'almost-gone'
    },
    {
        id: 94,
        title: 'Anti-Cellulite Cream',
        couponCode: 'CELLULITE55',
        category: 'beauty',
        discount: 55,
        totalQuantity: 50,
        usedQuantity: 48, // 96% usage
        expirationDate: '2025-12-05',
        type: 'almost-gone'
    },
    {
        id: 95,
        title: 'Treadmill Pro',
        couponCode: 'TREADMILL45',
        category: 'sports',
        discount: 45,
        totalQuantity: 40,
        usedQuantity: 39, // 97.5% usage
        expirationDate: '2025-12-20',
    }
];
module.exports = mockCoupons;