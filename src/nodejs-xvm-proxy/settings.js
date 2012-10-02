module.exports = (function()
{
    var numNodes = 1; // use X CPU core(s)

    // exports
    return {
        numNodes: numNodes,
        host: "127.0.0.1",
        port: 1333,
        maxSockets: Math.floor(1000 / numNodes), // per client
        cacheTtl: 5 * 24 * 60 * 60 * 1000, // 7 days
        lastErrorTtl: 1 * 1000, // in msec
        usageStatShowPeriod: 20 * 1000, // in msec
        dbName: "xvm",
        collectionName: "players",
        missedCollectionName: "missed",
        usersCollectionName: "users",
        statHostMaxConnections: 200,
        mongoMaxConnections: Math.floor(200 / numNodes),
        mongoMinTime: 1000, // msec
        mongoMaxTime: 5000, // msec
        statHosts: [
            "worldoftanks.ru",      // RU:           0 ..  49999999
            "worldoftanks.eu",      // EU:    50000000 ..  99999999
            "worldoftanks.com",     // US:   100000000 .. 149999999
            "", // ???: 1500000000 .. 199999999 (disabled - unknown stat server)
            "", // "worldoftanks-sea.com", // SEA: 2000000000 .. 249999999 (disabled - stat server is not working)
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
        wotApiVersion: "1.5"
    }
})();
