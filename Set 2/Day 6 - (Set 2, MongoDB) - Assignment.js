// Day 6 (Set 2) --

// Creating and Switching Database
db = db.getSiblingDB("InsuranceMongoDB");

// Removing Existing Collection
db.claimsNotes.drop();


// Creating Collection with Schema Validation

db.createCollection("claimsNotes", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: [
                "claimId",
                "policyId",
                "productName",
                "claimStatus",
                "claimDate",
                "damageCategory",
                "claimAmount",
                "settledAmount"
            ],
            properties: {
                claimId: {
                    bsonType: "int"
                },
                policyId: {
                    bsonType: "int"
                },
                productName: {
                    bsonType: "string"
                },
                claimStatus: {
                    enum: ["Submitted", "Under Review", "Approved", "Rejected", "Settled"]
                },
                claimDate: {
                    bsonType: "date"
                },
                settlementDate: {
                    bsonType: ["date", "null"]
                },
                damageCategory: {
                    bsonType: "string"
                },
                claimAmount: {
                    bsonType: ["double", "int", "decimal"],
                    minimum: 0
                },
                settledAmount: {
                    bsonType: ["double", "int", "decimal"],
                    minimum: 0
                },
                notes: {
                    bsonType: "string"
                }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});


// Inserting Data

db.claimsNotes.insertMany([
    {
        claimId: NumberInt(1),
        policyId: NumberInt(1001),
        productName: "Health",
        claimStatus: "Settled",
        claimDate: ISODate("2026-03-10"),
        settlementDate: ISODate("2026-04-10"),
        damageCategory: "Medical",
        claimAmount: 50000,
        settledAmount: 45000,
        notes: "Hospitalization and medical treatment expenses."
    },
    {
        claimId: NumberInt(2),
        policyId: NumberInt(1002),
        productName: "Life",
        claimStatus: "Settled",
        claimDate: ISODate("2026-05-15"),
        settlementDate: ISODate("2026-06-15"),
        damageCategory: "Life",
        claimAmount: 100000,
        settledAmount: 100000,
        notes: "Life insurance claim settled."
    },
    {
        claimId: NumberInt(3),
        policyId: NumberInt(1003),
        productName: "Motor",
        claimStatus: "Settled",
        claimDate: ISODate("2026-06-20"),
        settlementDate: ISODate("2026-07-20"),
        damageCategory: "Vehicle Collision",
        claimAmount: 30000,
        settledAmount: 25000,
        notes: "Vehicle collision damage."
    },
    {
        claimId: NumberInt(4),
        policyId: NumberInt(1004),
        productName: "Health",
        claimStatus: "Under Review",
        claimDate: ISODate("2026-07-05"),
        settlementDate: null,
        damageCategory: "Medical",
        claimAmount: 60000,
        settledAmount: 0,
        notes: "Claim is awaiting medical document verification."
    },
    {
        claimId: NumberInt(5),
        policyId: NumberInt(1005),
        productName: "Travel",
        claimStatus: "Rejected",
        claimDate: ISODate("2026-08-12"),
        settlementDate: null,
        damageCategory: "Lost Baggage",
        claimAmount: 15000,
        settledAmount: 0,
        notes: "Claim rejected due to missing supporting documents."
    },
    {
        claimId: NumberInt(6),
        policyId: NumberInt(1006),
        productName: "Life",
        claimStatus: "Settled",
        claimDate: ISODate("2026-09-01"),
        settlementDate: ISODate("2026-10-01"),
        damageCategory: "Life",
        claimAmount: 80000,
        settledAmount: 70000,
        notes: "Life insurance claim partially settled."
    },
    {
        claimId: NumberInt(7),
        policyId: NumberInt(1007),
        productName: "Motor",
        claimStatus: "Settled",
        claimDate: ISODate("2026-09-15"),
        settlementDate: ISODate("2026-10-15"),
        damageCategory: "Vehicle Collision",
        claimAmount: 25000,
        settledAmount: 20000,
        notes: "Accident damage repair settlement."
    },
    {
        claimId: NumberInt(8),
        policyId: NumberInt(1008),
        productName: "Health",
        claimStatus: "Submitted",
        claimDate: ISODate("2026-10-01"),
        settlementDate: null,
        damageCategory: "Medical",
        claimAmount: 40000,
        settledAmount: 0,
        notes: "Medical claim submitted for review."
    },
    {
        claimId: NumberInt(9),
        policyId: NumberInt(1009),
        productName: "Travel",
        claimStatus: "Rejected",
        claimDate: ISODate("2026-10-10"),
        settlementDate: null,
        damageCategory: "Travel Cancellation",
        claimAmount: 12000,
        settledAmount: 0,
        notes: "Travel cancellation claim rejected."
    },
    {
        claimId: NumberInt(10),
        policyId: NumberInt(1011),
        productName: "Health",
        claimStatus: "Settled",
        claimDate: ISODate("2026-10-20"),
        settlementDate: ISODate("2026-11-05"),
        damageCategory: "Medical",
        claimAmount: 35000,
        settledAmount: 30000,
        notes: "Medical reimbursement completed."
    }
]);


// Verify Inserted Data

db.claimsNotes.find();

db.claimsNotes.countDocuments();


// Aggregation Pipeline 1: Claims per Status

db.claimsNotes.aggregate([
    {
        $match: {}
    },
    {
        $group: {
            _id: "$claimStatus",
            totalClaims: { $sum: 1 },
            totalClaimAmount: { $sum: "$claimAmount" },
            totalSettledAmount: { $sum: "$settledAmount" }
        }
    },
    {
        $sort: {
            totalClaims: -1
        }
    }
]);


// Aggregation Pipeline 2: Average Settlement Time

db.claimsNotes.aggregate([
    {
        $match: {
            settlementDate: { $ne: null }
        }
    },
    {
        $project: {
            settlementDays: {
                $dateDiff: {
                    startDate: "$claimDate",
                    endDate: "$settlementDate",
                    unit: "day"
                }
            }
        }
    },
    {
        $group: {
            _id: null,
            averageSettlementDays: {
                $avg: "$settlementDays"
            },
            totalSettledClaims: {
                $sum: 1
            }
        }
    },
    {
        $project: {
            _id: 0,
            averageSettlementDays: {
                $round: ["$averageSettlementDays", 2]
            },
            totalSettledClaims: 1
        }
    }
]);


// Aggregation Pipeline 3: Top 3 Damage Categories

db.claimsNotes.aggregate([
    {
        $match: {}
    },
    {
        $group: {
            _id: "$damageCategory",
            totalClaims: {
                $sum: 1
            },
            totalClaimAmount: {
                $sum: "$claimAmount"
            }
        }
    },
    {
        $sort: {
            totalClaims: -1,
            totalClaimAmount: -1
        }
    },
    {
        $limit: 3
    },
    {
        $project: {
            _id: 0,
            damageCategory: "$_id",
            totalClaims: 1,
            totalClaimAmount: 1
        }
    }
]);
