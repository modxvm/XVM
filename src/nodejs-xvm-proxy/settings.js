module.exports = (function()
{
    // exports
    return {
        host: "127.0.0.1",
        port: <port>,
        maxSockets: 100, // per client
        cacheTtl: 7 * 24 * 60 * 60 * 1000, // 7 days
        lastErrorTtl: 6 * 1000, // in msec
        usageStatShowPeriod: 60 * 1000, // in msec
        dbName: "<dbname>",
        collectionName: "<collection>",
        missedCollectionName: "<missed_collection>",
        usersCollectionName: "<users_collection>",
        statHostMaxConnections: 100,
        mongoMaxConnections: 100,
        mongoMinTime: 1000, // msec
        mongoMaxTime: 5000, // msec
        statHosts: [
            "worldoftanks.ru",      // RU:           0 ..  49999999
            "worldoftanks.eu",      // EU:    50000000 ..  99999999
            "worldoftanks.com",     // US:   100000000 .. 149999999
            "", // ???: 1500000000 .. 199999999 (disabled - unknown stat server)
            "worldoftanks-sea.com", // SEA: 2000000000 .. 249999999
            "" // "wot.go.vn"       // VTC: 2500000000 .. 299999999 (disabled - stat server is not working)
        ],
        statHostsTimeouts: [
            5000,      // RU
            5000,      // EU
            5000,      // US
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
            US: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            SEA: { ver: "<version>", message: "" },
            VTC: { ver: "<version>", message: "" },
            CT: {  ver: "<version>", message: "" }
        }
    }
})();
