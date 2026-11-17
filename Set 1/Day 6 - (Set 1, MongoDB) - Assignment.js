// Day 6 (Set 1) --

// Creating and Switching Database
db = db.getSiblingDB("RetailSalesMongoDB");

// Removing Existing Collection
db.salesOrders.drop();


// Creating Collection with Schema Validation

db.createCollection("salesOrders", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: [
                "orderId",
                "customerId",
                "customerName",
                "city",
                "orderDate",
                "orderStatus",
                "items"
            ],
            properties: {
                orderId: {
                    bsonType: "int"
                },
                customerId: {
                    bsonType: "int"
                },
                customerName: {
                    bsonType: "string"
                },
                city: {
                    bsonType: "string"
                },
                orderDate: {
                    bsonType: "date"
                },
                orderStatus: {
                    enum: ["Placed", "Shipped", "Delivered", "Cancelled"]
                },
                items: {
                    bsonType: "array",
                    minItems: 1,
                    items: {
                        bsonType: "object",
                        required: [
                            "productId",
                            "productName",
                            "category",
                            "quantity",
                            "unitPrice"
                        ],
                        properties: {
                            productId: {
                                bsonType: "int"
                            },
                            productName: {
                                bsonType: "string"
                            },
                            category: {
                                bsonType: "string"
                            },
                            quantity: {
                                bsonType: "int",
                                minimum: 1
                            },
                            unitPrice: {
                                bsonType: ["double", "int", "decimal"],
                                minimum: 0
                            }
                        }
                    }
                }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});


// Inserting Data

db.salesOrders.insertMany([
    {
        orderId: NumberInt(101),
        customerId: NumberInt(1),
        customerName: "Arun Kumar",
        city: "Chennai",
        orderDate: ISODate("2026-10-01"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(1), productName: "Wireless Mouse", category: "Electronics", quantity: NumberInt(2), unitPrice: 799 },
            { productId: NumberInt(6), productName: "Notebook Pack", category: "Stationery", quantity: NumberInt(3), unitPrice: 299 }
        ]
    },
    {
        orderId: NumberInt(102),
        customerId: NumberInt(2),
        customerName: "Priya Sharma",
        city: "Coimbatore",
        orderDate: ISODate("2026-10-03"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(2), productName: "Mechanical Keyboard", category: "Electronics", quantity: NumberInt(1), unitPrice: 2499 },
            { productId: NumberInt(7), productName: "Pen Set", category: "Stationery", quantity: NumberInt(2), unitPrice: 149 }
        ]
    },
    {
        orderId: NumberInt(103),
        customerId: NumberInt(1),
        customerName: "Arun Kumar",
        city: "Chennai",
        orderDate: ISODate("2026-10-05"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(3), productName: "USB-C Hub", category: "Electronics", quantity: NumberInt(1), unitPrice: 1499 },
            { productId: NumberInt(8), productName: "Water Bottle", category: "Accessories", quantity: NumberInt(2), unitPrice: 499 }
        ]
    },
    {
        orderId: NumberInt(104),
        customerId: NumberInt(3),
        customerName: "Rahul Verma",
        city: "Chennai",
        orderDate: ISODate("2026-10-08"),
        orderStatus: "Shipped",
        items: [
            { productId: NumberInt(4), productName: "Office Chair", category: "Furniture", quantity: NumberInt(1), unitPrice: 5999 },
            { productId: NumberInt(6), productName: "Notebook Pack", category: "Stationery", quantity: NumberInt(2), unitPrice: 299 }
        ]
    },
    {
        orderId: NumberInt(105),
        customerId: NumberInt(4),
        customerName: "Sneha Reddy",
        city: "Madurai",
        orderDate: ISODate("2026-10-12"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(5), productName: "Study Desk", category: "Furniture", quantity: NumberInt(1), unitPrice: 7999 },
            { productId: NumberInt(7), productName: "Pen Set", category: "Stationery", quantity: NumberInt(3), unitPrice: 149 }
        ]
    },
    {
        orderId: NumberInt(106),
        customerId: NumberInt(1),
        customerName: "Arun Kumar",
        city: "Chennai",
        orderDate: ISODate("2026-10-15"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(1), productName: "Wireless Mouse", category: "Electronics", quantity: NumberInt(1), unitPrice: 799 },
            { productId: NumberInt(2), productName: "Mechanical Keyboard", category: "Electronics", quantity: NumberInt(1), unitPrice: 2499 }
        ]
    },
    {
        orderId: NumberInt(107),
        customerId: NumberInt(5),
        customerName: "Vikram Singh",
        city: "Coimbatore",
        orderDate: ISODate("2026-10-15"),
        orderStatus: "Placed",
        items: [
            { productId: NumberInt(8), productName: "Water Bottle", category: "Accessories", quantity: NumberInt(2), unitPrice: 499 },
            { productId: NumberInt(6), productName: "Notebook Pack", category: "Stationery", quantity: NumberInt(5), unitPrice: 299 }
        ]
    },
    {
        orderId: NumberInt(108),
        customerId: NumberInt(6),
        customerName: "Ananya Das",
        city: "Chennai",
        orderDate: ISODate("2026-10-20"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(3), productName: "USB-C Hub", category: "Electronics", quantity: NumberInt(2), unitPrice: 1499 },
            { productId: NumberInt(7), productName: "Pen Set", category: "Stationery", quantity: NumberInt(4), unitPrice: 149 }
        ]
    },
    {
        orderId: NumberInt(109),
        customerId: NumberInt(2),
        customerName: "Priya Sharma",
        city: "Coimbatore",
        orderDate: ISODate("2026-11-02"),
        orderStatus: "Delivered",
        items: [
            { productId: NumberInt(4), productName: "Office Chair", category: "Furniture", quantity: NumberInt(1), unitPrice: 5999 },
            { productId: NumberInt(1), productName: "Wireless Mouse", category: "Electronics", quantity: NumberInt(1), unitPrice: 799 }
        ]
    },
    {
        orderId: NumberInt(110),
        customerId: NumberInt(1),
        customerName: "Arun Kumar",
        city: "Chennai",
        orderDate: ISODate("2026-11-05"),
        orderStatus: "Shipped",
        items: [
            { productId: NumberInt(5), productName: "Study Desk", category: "Furniture", quantity: NumberInt(1), unitPrice: 7999 },
            { productId: NumberInt(6), productName: "Notebook Pack", category: "Stationery", quantity: NumberInt(4), unitPrice: 299 }
        ]
    },
    {
        orderId: NumberInt(111),
        customerId: NumberInt(7),
        customerName: "Karthik Raj",
        city: "Trichy",
        orderDate: ISODate("2026-11-10"),
        orderStatus: "Placed",
        items: [
            { productId: NumberInt(2), productName: "Mechanical Keyboard", category: "Electronics", quantity: NumberInt(1), unitPrice: 2499 },
            { productId: NumberInt(8), productName: "Water Bottle", category: "Accessories", quantity: NumberInt(3), unitPrice: 499 }
        ]
    },
    {
        orderId: NumberInt(112),
        customerId: NumberInt(8),
        customerName: "Meera Nair",
        city: "Madurai",
        orderDate: ISODate("2026-11-12"),
        orderStatus: "Placed",
        items: [
            { productId: NumberInt(1), productName: "Wireless Mouse", category: "Electronics", quantity: NumberInt(2), unitPrice: 799 },
            { productId: NumberInt(7), productName: "Pen Set", category: "Stationery", quantity: NumberInt(5), unitPrice: 149 }
        ]
    }
]);


// Verify Inserted Data

db.salesOrders.find();

db.salesOrders.countDocuments();


// Aggregation Pipeline 1: Month-wise Sales

db.salesOrders.aggregate([
    {
        $match: {
            orderStatus: { $ne: "Cancelled" }
        }
    },
    {
        $unwind: "$items"
    },
    {
        $group: {
            _id: {
                year: { $year: "$orderDate" },
                month: { $month: "$orderDate" }
            },
            totalSales: {
                $sum: {
                    $multiply: ["$items.quantity", "$items.unitPrice"]
                }
            },
            totalOrders: {
                $addToSet: "$orderId"
            }
        }
    },
    {
        $project: {
            _id: 0,
            salesMonth: {
                $concat: [
                    { $toString: "$_id.year" },
                    "-",
                    {
                        $cond: [
                            { $lt: ["$_id.month", 10] },
                            { $concat: ["0", { $toString: "$_id.month" }] },
                            { $toString: "$_id.month" }
                        ]
                    }
                ]
            },
            totalSales: 1,
            totalOrders: { $size: "$totalOrders" }
        }
    },
    {
        $sort: {
            salesMonth: 1
        }
    }
]);


// Aggregation Pipeline 2: Top 5 Products by Revenue

db.salesOrders.aggregate([
    {
        $match: {
            orderStatus: { $ne: "Cancelled" }
        }
    },
    {
        $unwind: "$items"
    },
    {
        $group: {
            _id: "$items.productId",
            productName: { $first: "$items.productName" },
            category: { $first: "$items.category" },
            totalRevenue: {
                $sum: {
                    $multiply: ["$items.quantity", "$items.unitPrice"]
                }
            }
        }
    },
    {
        $sort: {
            totalRevenue: -1
        }
    },
    {
        $limit: 5
    },
    {
        $project: {
            _id: 0,
            productId: "$_id",
            productName: 1,
            category: 1,
            totalRevenue: 1
        }
    }
]);


// Aggregation Pipeline 3: Average Basket Value per City

db.salesOrders.aggregate([
    {
        $match: {
            orderStatus: { $ne: "Cancelled" }
        }
    },
    {
        $unwind: "$items"
    },
    {
        $group: {
            _id: {
                orderId: "$orderId",
                city: "$city"
            },
            basketValue: {
                $sum: {
                    $multiply: ["$items.quantity", "$items.unitPrice"]
                }
            }
        }
    },
    {
        $group: {
            _id: "$_id.city",
            totalOrders: { $sum: 1 },
            averageBasketValue: { $avg: "$basketValue" }
        }
    },
    {
        $project: {
            _id: 0,
            city: "$_id",
            totalOrders: 1,
            averageBasketValue: {
                $round: ["$averageBasketValue", 2]
            }
        }
    },
    {
        $sort: {
            averageBasketValue: -1
        }
    }
]);