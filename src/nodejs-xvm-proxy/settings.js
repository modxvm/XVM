module.exports = (function()
{
    // exports
    return {
        host: "127.0.0.1",
        port: <port>,
        cacheTtl: 7 * 24 * 60 * 60 * 1000, // 7 days
        vcacheTtl: 3 * 24 * 60 * 60 * 1000, // not used yet
        lastErrorTtl: 5 * 1000, // in msec
        dbName: "<dbname>",
        collectionName: "<collection>",
        //           RU: 0..5E8         EU: 5E8..10E8      NA: 10E8..15E8
        statHosts: [ "worldoftanks.ru", "worldoftanks.eu", "worldoftanks.com" ],
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
            }
        }
    }
})();
