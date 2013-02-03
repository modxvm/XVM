var settings = require("./settings").settings,
    utils = require("./utils"),
    db = require("./worker_db"),
    tcalc = require("./tcalc/tcalc");

exports.processCommand = function(response, args) {
    try {
        if (db.isOverloaded()) {
            response.statusCode = 503; // Service Unavailable
            throw "db overloaded";
        }

        var cmd = args.shift();
        if (!cmd)
            throw "empty command";

        var pl = args.shift();
        if (!pl)
            throw "[" + cmd + "]: empty player name";

        utils.log(cmd + ": " + pl + " " + args.join(","));

        switch (cmd) {
            case "INFO":
                cmd_INFO(response, pl, args);
                break;

            case "WN":
                cmd_WN(response, pl, args);
                break;

            case "TWR":
                cmd_TWR(response, pl, args);
                break;

            default:
                throw "Unknown command: " + cmd;
        }
    } catch(e) {
        response.end('{"error":"' + e + '","server":"' + settings.serverName + '"}');
    }
};

// PRIVATE

var cmd_INFO = function(response, pl, args) {
    var cursor = db.find("players", {$or:[{nm:pl},{_id:parseInt(pl)}]});
    cursor.toArray(function(error, data) {
        try {
            if(error)
                throw "[" + cmd + "]: MongoDB find error: " + error;
            var vn = args.shift();
//            utils.log(pl + "," + vn);
            if (vn) {
                vn = vn.toUpperCase();
                for (var id in data) {
                    var d = data[id];
                    for (var vname in d.v) {
                        if (vname == vn) {
                            var v = d.v[vname];
                            v.name = vname;
                            d.v = [ v ];
                            break;
                        }
                    }
                }
            }
            response.end(JSON.stringify(data));
        } catch(e) {
            response.end('{"error":"' + e + '","server":"' + settings.serverName + '"}');
        }
    });
};

var cmd_WN = function(response, pl, args) {
    var cursor = db.find("players", {nm: pl});
    cursor.toArray(function(error, data) {
        try {
            if(error)
                response.end('[' + cmd + ']: MongoDB find error: ' + error);
            else if (data.length == 0)
                response.end('[' + cmd + ']: Player not found: ' + pl);
            else {
                var s = "";
                for (var i = 0; i < data.length; ++i) {
                    var start = new Date();
                    var d = data[i];
                    s += "<pre>";
                    s += "ID: " + d._id +
                        ", Nick: <a href='http://worldoftanks.ru/community/accounts/" + d._id + "-" + d.nm + "/'>" + d.nm + "</a>\n";
                    s += "--------------------------\n";
                    s += "WN6: " + utils.calculateWN(d) + "\n";
                    s += "duration: " + (new Date() - start) + " ms\n";
                    s += "</pre><hr>";
                }
                response.end(s);
            }
        } catch(e) {
            response.end('{"error":"' + e + '","server":"' + settings.serverName + '"}');
        }
    });
};

var cmd_TWR = function(response, pl, args) {
    var cursor = db.find("players", {nm: pl});
    cursor.toArray(function(error, data) {
        try {
            if(error)
                response.end('[' + cmd + ']: MongoDB find error: ' + error);
            else if (data.length == 0)
                response.end('[' + cmd + ']: Player not found: ' + pl);
            else {
                var s = "";
                for (var i = 0; i < data.length; ++i)
                    s += "<pre>" + tcalc.calc(data[i], true).log + "</pre><hr>";
                response.end(s);
            }
        } catch(e) {
            response.end('{"error":"' + e + '","server":"' + settings.serverName + '"}');
        }
    });
};