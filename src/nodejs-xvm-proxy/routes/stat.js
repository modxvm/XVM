var db = require("../db"),
    settings = require("../settings");

exports.performance = function(req, res) {

    db.getPerformanceReport(function(error, result) {

        var vm = result.map(function(item, index) {
            // TODO
            var uptime = item.uptime / 1000,
                d = (uptime / (60 * 60 * 24)).toFixed(),
                h =((uptime / 3600) % 24).toFixed(),
                m = ((uptime / 60) % 60).toFixed();

            var connections = [ ];

            item.connections.forEach(function(conn, index) {
                if(settings.servers[index].name) {
                    connections.push({
                        server: settings.servers[index].name,
                        current: conn && conn.cur,
                        max: conn && conn.max,
                        total: conn && conn.total,
                        fail: conn && conn.fail,
                        rate: conn && (conn.fail / conn.total * 100).toFixed()
                    });
                }
            });

            return {
                index: index,
                uptime: (d === 0 ? "" : d + "d") + h + "h" + m,
                requests: item.requests,
                req_s_now: (item.requests_current / settings.usageStatShowPeriod * 1000).toFixed(),
                req_s_total: (item.requests / uptime).toFixed(),
                players: item.players,
                pl_s_now: (item.players_current / settings.usageStatShowPeriod * 1000).toFixed(),
                pl_s_total: (item.players / uptime).toFixed(2),
                cached: (item.cached / item.players * 100).toFixed(2),
                updated: (item.updated / item.players * 100).toFixed(2),
                missed: (item.missed / item.players * 100).toFixed(2),
                updfail: (item.updatesFailed / item.players * 100).toFixed(2),
                max_conn: (item.max_conn / item.players * 100).toFixed(2),
                mongorq: item.mongorq,
                mongorq_max: item.mongorq_max,
                cmdInfo: item.cmdInfo,
                connections: connections
            };
        });

        res.render("performance", {
            error: error,
            title: "Performance statistic",
            db: vm
        });
    });

};