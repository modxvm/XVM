var numNodes = 2, // use X CPU core(s)
    maxConnPerNode = Math.floor(100 / numNodes);

exports.settings = {
    numNodes: numNodes,
    updateMissed: false,
    updateUsers: false,
    host: "127.0.0.1",
    port: 1333,
    maxSockets: Math.floor(1000 / numNodes), // per client
    cacheTtl: 7 * 24 * 60 * 60 * 1000, // 7 days
    lastErrorTtl: 1 * 1000, // in msec
    usageStatShowPeriod: 20 * 1000, // in msec
    mongoServer: "localhost",
    mongoPort: 27017,
    dbName: "xvm", // for players database
    dbName2: "xvm2", // for users and missed
    playersCollectionName: "players",
    missedCollectionName: "missed",
    usersCollectionName: "users",
    dbMaxConnections: Math.floor(20 / numNodes),
    dbMaxConnections2: Math.floor(10 / numNodes),
    dbMinTime: 1000, // msec
    dbMaxTime: 5000, // msec
    servers: [
        { host:"api.worldoftanks.ru",      port:80, maxconn: maxConnPerNode, api: "1.5", timeout:5000 },  // 0
        { host:"worldoftanks.ru",          port:80, maxconn: maxConnPerNode, api: "1.5", timeout:5000 },  // 1
        { host:"api.worldoftanks.eu",      port:80, maxconn: maxConnPerNode, api: "1.5", timeout:5000 },  // 2
        { host:"api.worldoftanks.com",     port:80, maxconn: maxConnPerNode, api: "1.5", timeout:5000 },  // 3
        { host:"api.worldoftanks-sea.com", port:80, maxconn: maxConnPerNode, api: "1.5", timeout:6000 },  // 4
        { host:"portal-wot.go.vn",         port:80, maxconn: maxConnPerNode, api: "1.5", timeout:12000 }, // 5
        { host:"worldoftanks.kr",          port:80, maxconn: maxConnPerNode, api: "1.5", timeout:6000 }   // 6
    ],
    statServers: [
        [ 0, 1 ],   // RU:           0 ..  499999999
        [ 2 ],      // EU:   500000000 ..  999999999
        [ 3 ],      // US:  1000000000 .. 1499999999
        [   ],      // ???: 1500000000 .. 1999999999 (disabled - unknown stat server)
        [ 4 ],      // SEA: 2000000000 .. 2499999999
        [ 5 ],      // VTC: 2500000000 .. 2999999999
        [ 6 ],      // KR:  3000000000 .. 3499999999
    ],
    serverName: "?"
}
