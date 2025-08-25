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
        createdAt: '2024-01-15T10:00:00.000Z',
        updatedAt: '2024-12-20T15:30:00.000Z'
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
        createdAt: '2024-01-20T09:00:00.000Z',
        updatedAt: '2024-12-22T14:20:00.000Z'
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
        createdAt: '2024-02-01T11:00:00.000Z',
        updatedAt: '2024-12-21T16:45:00.000Z'
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
        createdAt: '2024-02-15T08:00:00.000Z',
        updatedAt: '2024-12-23T10:15:00.000Z'
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
        createdAt: '2024-03-01T12:00:00.000Z',
        updatedAt: '2024-12-24T13:30:00.000Z'
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
        createdAt: '2024-03-15T10:00:00.000Z',
        updatedAt: '2024-12-25T11:20:00.000Z'
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
        createdAt: '2024-04-01T09:00:00.000Z',
        updatedAt: '2024-12-26T14:45:00.000Z'
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
        createdAt: '2024-04-15T11:00:00.000Z',
        updatedAt: '2024-12-27T15:10:00.000Z'
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
        createdAt: '2024-05-01T08:00:00.000Z',
        updatedAt: '2024-12-28T12:30:00.000Z'
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
        createdAt: '2024-05-15T10:00:00.000Z',
        updatedAt: '2024-12-29T16:20:00.000Z'
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
        createdAt: '2024-06-01T12:00:00.000Z',
        updatedAt: '2024-12-30T13:45:00.000Z'
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
        createdAt: '2024-06-15T09:00:00.000Z',
        updatedAt: '2024-12-31T10:15:00.000Z'
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
        createdAt: '2024-07-01T11:00:00.000Z',
        updatedAt: '2024-12-31T17:30:00.000Z'
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
        createdAt: '2024-07-15T10:00:00.000Z',
        updatedAt: '2024-12-31T18:45:00.000Z'
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
        createdAt: '2024-08-01T08:00:00.000Z',
        updatedAt: '2024-12-31T19:20:00.000Z'
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
        createdAt: '2024-08-15T12:00:00.000Z',
        updatedAt: '2024-12-31T20:10:00.000Z'
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
        createdAt: '2024-09-01T09:00:00.000Z',
        updatedAt: '2024-12-31T21:30:00.000Z'
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
        createdAt: '2024-09-15T10:00:00.000Z',
        updatedAt: '2024-11-29T22:15:00.000Z'
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
        createdAt: '2024-10-01T11:00:00.000Z',
        updatedAt: '2024-12-01T23:45:00.000Z'
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
        createdAt: '2024-10-15T08:00:00.000Z',
        updatedAt: '2024-12-24T00:30:00.000Z'
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
        createdAt: '2024-11-01T10:00:00.000Z',
        updatedAt: '2024-12-31T22:00:00.000Z'
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
        createdAt: '2024-11-15T09:00:00.000Z',
        updatedAt: '2024-12-31T23:15:00.000Z'
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
        createdAt: '2024-12-01T11:00:00.000Z',
        updatedAt: '2024-12-31T00:30:00.000Z'
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
        createdAt: '2024-12-05T08:00:00.000Z',
        updatedAt: '2024-12-31T01:45:00.000Z'
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
        createdAt: '2024-12-10T12:00:00.000Z',
        updatedAt: '2024-12-31T02:20:00.000Z'
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
        createdAt: '2024-12-12T10:00:00.000Z',
        updatedAt: '2024-12-31T03:10:00.000Z'
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
        createdAt: '2024-12-14T09:00:00.000Z',
        updatedAt: '2024-12-31T04:25:00.000Z'
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
        createdAt: '2024-12-16T11:00:00.000Z',
        updatedAt: '2024-12-31T05:40:00.000Z'
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
        createdAt: '2024-12-18T08:00:00.000Z',
        updatedAt: '2024-12-31T06:55:00.000Z'
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
        createdAt: '2024-12-20T10:00:00.000Z',
        updatedAt: '2024-12-31T07:30:00.000Z'
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
        createdAt: '2024-12-22T12:00:00.000Z',
        updatedAt: '2024-12-31T08:15:00.000Z'
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
        createdAt: '2024-12-24T09:00:00.000Z',
        updatedAt: '2024-12-31T09:00:00.000Z'
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
        createdAt: '2024-12-26T11:00:00.000Z',
        updatedAt: '2024-12-31T10:45:00.000Z'
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
        createdAt: '2024-12-28T10:00:00.000Z',
        updatedAt: '2024-12-31T11:20:00.000Z'
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
        createdAt: '2024-12-30T08:00:00.000Z',
        updatedAt: '2024-12-31T12:35:00.000Z'
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
        createdAt: '2025-01-01T09:00:00.000Z',
        updatedAt: '2025-01-01T13:50:00.000Z'
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
        createdAt: '2025-01-02T10:00:00.000Z',
        updatedAt: '2025-01-02T14:25:00.000Z'
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
        createdAt: '2025-01-03T11:00:00.000Z',
        updatedAt: '2025-01-03T15:40:00.000Z'
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
        createdAt: '2025-01-04T12:00:00.000Z',
        updatedAt: '2025-01-04T16:15:00.000Z'
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
        createdAt: '2025-01-05T09:00:00.000Z',
        updatedAt: '2025-01-05T17:30:00.000Z'
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
        createdAt: '2025-01-06T10:00:00.000Z',
        updatedAt: '2025-01-06T18:45:00.000Z'
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
        createdAt: '2025-01-07T11:00:00.000Z',
        updatedAt: '2025-01-07T19:20:00.000Z'
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
        createdAt: '2025-01-08T12:00:00.000Z',
        updatedAt: '2025-01-08T20:15:00.000Z'
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
        createdAt: '2025-01-09T13:00:00.000Z',
        updatedAt: '2025-01-09T21:30:00.000Z'
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
        createdAt: '2025-01-10T14:00:00.000Z',
        updatedAt: '2025-01-10T22:45:00.000Z'
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
        createdAt: '2025-01-11T15:00:00.000Z',
        updatedAt: '2025-01-11T23:20:00.000Z'
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
        createdAt: '2025-01-12T16:00:00.000Z',
        updatedAt: '2025-01-12T00:35:00.000Z'
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
        createdAt: '2025-01-13T17:00:00.000Z',
        updatedAt: '2025-01-13T01:50:00.000Z'
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
        createdAt: '2025-01-14T18:00:00.000Z',
        updatedAt: '2025-01-14T02:25:00.000Z'
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
        createdAt: '2025-01-15T19:00:00.000Z',
        updatedAt: '2025-01-15T03:40:00.000Z'
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
        createdAt: '2025-01-16T20:00:00.000Z',
        updatedAt: '2025-01-16T04:15:00.000Z'
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
        createdAt: '2025-01-17T21:00:00.000Z',
        updatedAt: '2025-01-17T05:30:00.000Z'
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
        createdAt: '2025-01-18T22:00:00.000Z',
        updatedAt: '2025-01-18T06:45:00.000Z'
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
        createdAt: '2025-01-19T23:00:00.000Z',
        updatedAt: '2025-01-19T07:20:00.000Z'
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
        createdAt: '2025-01-20T00:00:00.000Z',
        updatedAt: '2025-01-20T08:10:00.000Z'
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
        createdAt: '2025-01-21T01:00:00.000Z',
        updatedAt: '2025-01-21T09:35:00.000Z'
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
        createdAt: '2025-01-22T02:00:00.000Z',
        updatedAt: '2025-01-22T10:50:00.000Z'
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
        createdAt: '2025-01-23T03:00:00.000Z',
        updatedAt: '2025-01-23T11:25:00.000Z'
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
        createdAt: '2025-01-24T04:00:00.000Z',
        updatedAt: '2025-01-24T12:40:00.000Z'
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
        createdAt: '2025-01-25T05:00:00.000Z',
        updatedAt: '2025-01-25T13:55:00.000Z'
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
        createdAt: '2025-01-26T06:00:00.000Z',
        updatedAt: '2025-01-26T14:20:00.000Z'
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
        createdAt: '2025-01-27T07:00:00.000Z',
        updatedAt: '2025-01-27T15:35:00.000Z'
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
        createdAt: '2025-01-28T08:00:00.000Z',
        updatedAt: '2025-01-28T16:50:00.000Z'
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
        createdAt: '2025-01-29T09:00:00.000Z',
        updatedAt: '2025-01-29T17:25:00.000Z'
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
        createdAt: '2025-01-30T10:00:00.000Z',
        updatedAt: '2025-01-30T18:40:00.000Z'
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
        createdAt: '2025-01-31T11:00:00.000Z',
        updatedAt: '2025-01-31T19:15:00.000Z'
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
        createdAt: '2025-02-01T12:00:00.000Z',
        updatedAt: '2025-02-01T20:30:00.000Z'
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
        createdAt: '2025-02-02T13:00:00.000Z',
        updatedAt: '2025-02-02T21:45:00.000Z'
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
        createdAt: '2025-02-03T14:00:00.000Z',
        updatedAt: '2025-02-03T22:20:00.000Z'
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
        createdAt: '2025-02-04T15:00:00.000Z',
        updatedAt: '2025-02-04T23:35:00.000Z'
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
        createdAt: '2025-02-05T16:00:00.000Z',
        updatedAt: '2025-02-05T00:50:00.000Z'
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
        createdAt: '2025-02-06T17:00:00.000Z',
        updatedAt: '2025-02-06T01:25:00.000Z'
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
        createdAt: '2025-02-07T18:00:00.000Z',
        updatedAt: '2025-02-07T02:40:00.000Z'
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
        createdAt: '2025-02-08T19:00:00.000Z',
        updatedAt: '2025-02-08T03:15:00.000Z'
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
        createdAt: '2025-02-09T20:00:00.000Z',
        updatedAt: '2025-02-09T04:30:00.000Z'
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
        createdAt: '2025-02-10T21:00:00.000Z',
        updatedAt: '2025-02-10T05:45:00.000Z'
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
        createdAt: '2025-02-11T22:00:00.000Z',
        updatedAt: '2025-02-11T06:20:00.000Z'
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
        createdAt: '2025-02-12T23:00:00.000Z',
        updatedAt: '2025-02-12T07:35:00.000Z'
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
        createdAt: '2025-02-13T00:00:00.000Z',
        updatedAt: '2025-02-13T08:50:00.000Z'
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
        createdAt: '2025-02-14T01:00:00.000Z',
        updatedAt: '2025-02-14T09:25:00.000Z'
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
        createdAt: '2025-02-15T02:00:00.000Z',
        updatedAt: '2025-02-15T10:40:00.000Z'
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
        createdAt: '2025-02-16T03:00:00.000Z',
        updatedAt: '2025-02-16T11:15:00.000Z'
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
        createdAt: '2025-02-17T04:00:00.000Z',
        updatedAt: '2025-02-17T12:30:00.000Z'
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
        createdAt: '2025-02-18T05:00:00.000Z',
        updatedAt: '2025-02-18T13:45:00.000Z'
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
        createdAt: '2025-02-19T06:00:00.000Z',
        updatedAt: '2025-02-19T14:20:00.000Z'
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
        createdAt: '2025-02-20T07:00:00.000Z',
        updatedAt: '2025-02-20T15:35:00.000Z'
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
        createdAt: '2025-02-21T08:00:00.000Z',
        updatedAt: '2025-02-21T16:50:00.000Z'
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
        createdAt: '2025-02-22T09:00:00.000Z',
        updatedAt: '2025-02-22T17:25:00.000Z'
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
        createdAt: '2025-02-23T10:00:00.000Z',
        updatedAt: '2025-02-23T18:40:00.000Z'
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
        createdAt: '2025-02-24T11:00:00.000Z',
        updatedAt: '2025-02-24T19:15:00.000Z'
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
        createdAt: '2025-02-25T12:00:00.000Z',
        updatedAt: '2025-02-25T20:30:00.000Z'
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
        createdAt: '2025-02-26T13:00:00.000Z',
        updatedAt: '2025-02-26T21:45:00.000Z'
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
        createdAt: '2025-02-27T14:00:00.000Z',
        updatedAt: '2025-02-27T22:20:00.000Z'
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
        createdAt: '2025-02-28T15:00:00.000Z',
        updatedAt: '2025-02-28T23:35:00.000Z'
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
        createdAt: '2025-03-01T16:00:00.000Z',
        updatedAt: '2025-03-01T00:50:00.000Z'
    }
];

module.exports = mockCoupons;