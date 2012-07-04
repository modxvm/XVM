module.exports = (function()
{
    // exports
    return {
        host: "127.0.0.1",
        port: <port>,
        maxSockets: 100, // per client
        cacheTtl: 7 * 24 * 60 * 60 * 1000, // 7 days
        lastErrorTtl: 5 * 1000, // in msec
        usageStatShowPeriod: 60 * 1000, // in msec
        dbName: "<dbname>",
        collectionName: "<collection>",
        missedCollectionName: "<missed_collection>",
        statHosts: [
            "worldoftanks.ru",      // RU:            0 ..  499999999
            "worldoftanks.eu",      // EU:    500000000 ..  999999999
            "worldoftanks.com",     // NA:   1000000000 .. 1499999999
            "worldoftanks-sea.com", // ???: 15000000000 .. 1999999999
            "worldoftanks-sea.com", // SEA: 20000000000 .. 2499999999
            "wot.go.vn"             // VTC: 25000000000 .. 2999999999
        ],
        statHostsTimeouts: [
            5000,      // RU
            5000,      // EU
            5000,      // NA
            6000,      // ???
            6000,      // SEA
            19000      // VTC
        ],
        wotApiVersion: "1.5",
        info: {
            RU: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            EU: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            NA: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            SEA: {
                ver: "<version>",
                message: ""
            },
            VTC: {
                ver: "<version>",
                message: ""
            },
            CT: {
                ver: "<version>",
                message: ""
            }
        }
    }
})();
