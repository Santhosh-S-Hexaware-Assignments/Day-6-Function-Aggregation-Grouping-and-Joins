// Day 6 (Set 3) --

// Creating and Switching Database
db = db.getSiblingDB("TelecomMongoDB");

// Removing Existing Collection
db.usageEvents.drop();


// Creating Collection with Schema Validation

db.createCollection("usageEvents", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: [
                "subscriberId",
                "subscriberName",
                "circle",
                "eventDate",
                "eventType",
                "durationMinutes",
                "dataUsedGB",
                "cellTower"
            ],
            properties: {
                subscriberId: {
                    bsonType: "int"
                },
                subscriberName: {
                    bsonType: "string"
                },
                circle: {
                    bsonType: "string"
                },
                eventDate: {
                    bsonType: "date"
                },
                eventType: {
                    enum: ["Voice", "Data", "SMS"]
                },
                durationMinutes: {
                    bsonType: ["double", "int"],
                    minimum: 0
                },
                dataUsedGB: {
                    bsonType: ["double", "int", "decimal"],
                    minimum: 0
                },
                cellTower: {
                    bsonType: "string"
                }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});


// Inserting Data

db.usageEvents.insertMany([
    {
        subscriberId: NumberInt(1),
        subscriberName: "Arun Kumar",
        circle: "Chennai",
        eventDate: ISODate("2026-11-01T09:15:00"),
        eventType: "Data",
        durationMinutes: 45,
        dataUsedGB: 6.00,
        cellTower: "TOWER-CHN-01"
    },
    {
        subscriberId: NumberInt(1),
        subscriberName: "Arun Kumar",
        circle: "Chennai",
        eventDate: ISODate("2026-11-01T14:30:00"),
        eventType: "Data",
        durationMinutes: 30,
        dataUsedGB: 5.00,
        cellTower: "TOWER-CHN-02"
    },
    {
        subscriberId: NumberInt(2),
        subscriberName: "Priya Sharma",
        circle: "Coimbatore",
        eventDate: ISODate("2026-11-02T10:00:00"),
        eventType: "Voice",
        durationMinutes: 60,
        dataUsedGB: 0,
        cellTower: "TOWER-CBE-01"
    },
    {
        subscriberId: NumberInt(2),
        subscriberName: "Priya Sharma",
        circle: "Coimbatore",
        eventDate: ISODate("2026-11-02T16:45:00"),
        eventType: "Data",
        durationMinutes: 25,
        dataUsedGB: 1.50,
        cellTower: "TOWER-CBE-02"
    },
    {
        subscriberId: NumberInt(3),
        subscriberName: "Rahul Verma",
        circle: "Madurai",
        eventDate: ISODate("2026-11-03T11:20:00"),
        eventType: "Data",
        durationMinutes: 35,
        dataUsedGB: 3.00,
        cellTower: "TOWER-MDU-01"
    },
    {
        subscriberId: NumberInt(3),
        subscriberName: "Rahul Verma",
        circle: "Madurai",
        eventDate: ISODate("2026-11-03T18:00:00"),
        eventType: "Data",
        durationMinutes: 20,
        dataUsedGB: 4.00,
        cellTower: "TOWER-MDU-01"
    },
    {
        subscriberId: NumberInt(4),
        subscriberName: "Sneha Reddy",
        circle: "Chennai",
        eventDate: ISODate("2026-11-04T08:30:00"),
        eventType: "Voice",
        durationMinutes: 90,
        dataUsedGB: 0,
        cellTower: "TOWER-CHN-01"
    },
    {
        subscriberId: NumberInt(4),
        subscriberName: "Sneha Reddy",
        circle: "Chennai",
        eventDate: ISODate("2026-11-04T13:15:00"),
        eventType: "Data",
        durationMinutes: 40,
        dataUsedGB: 6.00,
        cellTower: "TOWER-CHN-02"
    },
    {
        subscriberId: NumberInt(5),
        subscriberName: "Vikram Singh",
        circle: "Coimbatore",
        eventDate: ISODate("2026-11-05T12:00:00"),
        eventType: "Data",
        durationMinutes: 120,
        dataUsedGB: 12.00,
        cellTower: "TOWER-CBE-01"
    },
    {
        subscriberId: NumberInt(5),
        subscriberName: "Vikram Singh",
        circle: "Coimbatore",
        eventDate: ISODate("2026-11-05T19:30:00"),
        eventType: "Data",
        durationMinutes: 75,
        dataUsedGB: 10.00,
        cellTower: "TOWER-CBE-01"
    },
    {
        subscriberId: NumberInt(6),
        subscriberName: "Ananya Das",
        circle: "Trichy",
        eventDate: ISODate("2026-11-06T09:45:00"),
        eventType: "Voice",
        durationMinutes: 55,
        dataUsedGB: 0,
        cellTower: "TOWER-TRY-01"
    },
    {
        subscriberId: NumberInt(6),
        subscriberName: "Ananya Das",
        circle: "Trichy",
        eventDate: ISODate("2026-11-06T15:20:00"),
        eventType: "Data",
        durationMinutes: 35,
        dataUsedGB: 1.00,
        cellTower: "TOWER-TRY-02"
    },
    {
        subscriberId: NumberInt(7),
        subscriberName: "Karthik Raj",
        circle: "Madurai",
        eventDate: ISODate("2026-11-07T10:10:00"),
        eventType: "Data",
        durationMinutes: 65,
        dataUsedGB: 7.00,
        cellTower: "TOWER-MDU-01"
    },
    {
        subscriberId: NumberInt(7),
        subscriberName: "Karthik Raj",
        circle: "Madurai",
        eventDate: ISODate("2026-11-07T17:40:00"),
        eventType: "Data",
        durationMinutes: 40,
        dataUsedGB: 5.00,
        cellTower: "TOWER-MDU-02"
    },
    {
        subscriberId: NumberInt(8),
        subscriberName: "Meera Nair",
        circle: "Chennai",
        eventDate: ISODate("2026-11-08T11:30:00"),
        eventType: "Voice",
        durationMinutes: 30,
        dataUsedGB: 0,
        cellTower: "TOWER-CHN-01"
    },
    {
        subscriberId: NumberInt(8),
        subscriberName: "Meera Nair",
        circle: "Chennai",
        eventDate: ISODate("2026-11-08T20:00:00"),
        eventType: "Data",
        durationMinutes: 25,
        dataUsedGB: 0.50,
        cellTower: "TOWER-CHN-01"
    },
    {
        subscriberId: NumberInt(9),
        subscriberName: "Aditya Rao",
        circle: "Salem",
        eventDate: ISODate("2026-11-09T08:00:00"),
        eventType: "Data",
        durationMinutes: 100,
        dataUsedGB: 15.00,
        cellTower: "TOWER-SLM-01"
    },
    {
        subscriberId: NumberInt(9),
        subscriberName: "Aditya Rao",
        circle: "Salem",
        eventDate: ISODate("2026-11-09T14:00:00"),
        eventType: "Data",
        durationMinutes: 50,
        dataUsedGB: 8.00,
        cellTower: "TOWER-SLM-02"
    }
]);


// Verify Inserted Data

db.usageEvents.find();

db.usageEvents.countDocuments();


// Aggregation Pipeline 1: Hourly Usage

db.usageEvents.aggregate([
    {
        $group: {
            _id: {
                hour: {
                    $hour: "$eventDate"
                }
            },
            totalEvents: {
                $sum: 1
            },
            totalDataUsedGB: {
                $sum: "$dataUsedGB"
            },
            totalDurationMinutes: {
                $sum: "$durationMinutes"
            }
        }
    },
    {
        $project: {
            _id: 0,
            hour: "$_id.hour",
            totalEvents: 1,
            totalDataUsedGB: 1,
            totalDurationMinutes: 1
        }
    },
    {
        $sort: {
            hour: 1
        }
    }
]);


// Aggregation Pipeline 2: Average Session Length

db.usageEvents.aggregate([
    {
        $match: {
            eventType: { $in: ["Voice", "Data"] }
        }
    },
    {
        $group: {
            _id: "$eventType",
            totalSessions: {
                $sum: 1
            },
            averageSessionLength: {
                $avg: "$durationMinutes"
            }
        }
    },
    {
        $project: {
            _id: 0,
            eventType: "$_id",
            totalSessions: 1,
            averageSessionLength: {
                $round: ["$averageSessionLength", 2]
            }
        }
    },
    {
        $sort: {
            averageSessionLength: -1
        }
    }
]);


// Aggregation Pipeline 3: Busiest Cell Tower

db.usageEvents.aggregate([
    {
        $group: {
            _id: "$cellTower",
            totalEvents: {
                $sum: 1
            },
            totalDurationMinutes: {
                $sum: "$durationMinutes"
            },
            totalDataUsedGB: {
                $sum: "$dataUsedGB"
            }
        }
    },
    {
        $sort: {
            totalEvents: -1,
            totalDurationMinutes: -1
        }
    },
    {
        $limit: 1
    },
    {
        $project: {
            _id: 0,
            cellTower: "$_id",
            totalEvents: 1,
            totalDurationMinutes: 1,
            totalDataUsedGB: 1
        }
    }
]);