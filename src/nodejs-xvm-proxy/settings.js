module.exports = (function()
{
    var numNodes = 2; // use X CPU core(s)

    // exports
    return {
        updateMissed: true,
        updateUsers: true,
        numNodes: numNodes,
        host: "127.0.0.1",
        port: 1333,
        maxSockets: Math.floor(1000 / numNodes), // per client
        cacheTtl: 5 * 24 * 60 * 60 * 1000, // 7 days
        lastErrorTtl: 1 * 1000, // in msec
        usageStatShowPeriod: 20 * 1000, // in msec
        mongoServer: "localhost",
        mongoPort: 27017,
        dbName: "xvm",
        collectionName: "players",
        missedCollectionName: "missed",
        usersCollectionName: "users",
        statHostMaxConnections: 99,
        mongoMaxConnections: Math.floor(200 / numNodes),
        mongoMinTime: 1000, // msec
        mongoMaxTime: 5000, // msec
        statHosts: [
            "api.worldoftanks.ru",      // RU:           0 ..  499999999
            "api.worldoftanks.eu",      // EU:   500000000 ..  999999999
            "api.worldoftanks.com",     // US:  1000000000 .. 1499999999
            "",                         // ???: 1500000000 .. 1999999999 (disabled - unknown stat server)
            "api.worldoftanks-sea.com", // SEA: 2000000000 .. 2499999999
            "portal-wot.go.vn",         // VTC: 2500000000 .. 2999999999
            "worldoftanks.kr"           // KR:  3000000000 .. 3499999999
        ],
        statHostsTimeouts: [
            5000,      // RU
            5000,      // EU
            5000,      // US
            6000,      // ???
            6000,      // SEA
            12000,     // VTC
            6000       // KR
        ],
        wotApiVersion: "1.5",
        serverName: ""
    }
})();
