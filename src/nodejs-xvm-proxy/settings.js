var numNodes = 2, // use X CPU core(s)
    maxConnPerNode = Math.floor(100 / numNodes);

exports.numNodes = numNodes;
exports.updateMissed = false;
exports.updateUsers = false;
exports.fixData = true;
exports.host = "127.0.0.1";
exports.port = 1333;
exports.maxSockets = Math.floor(1000 / numNodes); // per client
exports.cacheTtl = 7 * 24 * 60 * 60 * 1000; // 7 days
exports.lastErrorTtl = 60 * 1000; // in msec
exports.usageStatShowPeriod = 20 * 1000; // in msec
exports.mongoServer = "localhost";
exports.mongoPort = 27017;
exports.dbName = "xvm"; // for players database
exports.playersCollectionName = "players";
exports.missedCollectionName = "missed";
exports.usersCollectionName = "users";
exports.performanceLogCollectionName = "performance";
exports.dbMaxConnections = Math.floor(20 / numNodes);
exports.dbMaxConnections2 = Math.floor(10 / numNodes);
exports.dbMinTime = 1000; // msec
exports.dbMaxTime = 5000; // msec
exports.httpMaxTime = 5000;
exports.servers = [
        { name: "RU", options: { host: "api.worldoftanks.ru", port: 80 }, maxconn: maxConnPerNode, api: "1.5", timeout: 5000 },         // 0
        { name: "EU", options: { host: "api.worldoftanks.eu", port: 80 }, maxconn: maxConnPerNode, api: "1.5", timeout: 5000 },         // 1
        { name: "US", options: { host: "api.worldoftanks.com", port: 80 }, maxconn: maxConnPerNode, api: "1.5", timeout: 5000 },        // 2
        { name: "SEA", options: { host: "api.worldoftanks-sea.com", port: 80 }, maxconn: maxConnPerNode, api: "1.5", timeout: 6000 },   // 3
        { name: "VTC", options: { host: "portal-wot.go.vn", port: 80 }, maxconn: maxConnPerNode, api: "1.5", timeout: 12000 },          // 4
        { name: "KR", options: { host: "worldoftanks.kr", port: 80 }, maxconn: maxConnPerNode, api: "1.5", timeout: 6000 }              // 5
    ];
exports.statServers = [
        [ 0 ],      // RU:           0 ..  499999999
        [ 1 ],      // EU:   500000000 ..  999999999
        [ 2 ],      // US:  1000000000 .. 1499999999
        [   ],      // ???: 1500000000 .. 1999999999 (disabled - unknown stat server)
        [ 3 ],      // SEA: 2000000000 .. 2499999999
        [ 4 ],      // VTC: 2500000000 .. 2999999999
        [ 5 ]       // KR:  3000000000 .. 3499999999
    ];
exports.serverName = "?";