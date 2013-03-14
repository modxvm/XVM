var db = require("./db"),
    settings = require("./settings").settings,
    tcalc = require("./tcalc/tcalc");

// calculate average level of tanks
var calculateAvgLvl = exports.calculateAvgLevel = function(vehicles) {
    var level_battles = 0,
        total_battles = 0;

    for(var vname in vehicles) {
        var item = vehicles[vname];
        level_battles += item.l * item.b;
        total_battles += item.b;
    }
    return total_battles <= 0 ? 0 : level_battles / total_battles;
};

// calculateEfficiency
// EFF formula:
// DAMAGE * (10 / (TIER + 2)) * (0.23 + 2 * TIER / 100)
// + FRAGS * 0.25 * 1000
// + SPOT * 0.15 * 1000 +
// + LOG((CAP + 1), 1.732) * 0.15 * 1000
// + DEF * 0.15 * 1000
exports.calculateEfficiency = function(data) {
    if(!data || !data.b || data.b <= 0)
        return 0;

    var TIER = data.lvl;
    var FRAGS = data.frg / data.b;
    var DAMAGE = data.dmg / data.b;
    var SPOT = data.spo / data.b;
    var CAP = data.cap / data.b;
    var DEF = data.def / data.b;

    return Math.round(
        DAMAGE * (10 / (TIER + 2)) * (0.23 + 2 * TIER / 100) +
            FRAGS * 250 +
            SPOT * 150 +
            Math.log(CAP + 1) / Math.log(1.732) * 150 +
            DEF * 150);
};

// WN rating
// Current: WN6
// http://forum.worldoftanks.com/index.php?/topic/184017-/page__st__1080__pid__3542824#entry3542824
// WN6 formula:
// (1240-1040/(MIN(TIER,6))^0.164)*FRAGS
// +DAMAGE*530/(184*e^(0.24*TIER)+130)
// +SPOT*125
// +MIN(DEF,2.2)*100
// +((185/(0.17+e^((WINRATE-35)*-0.134)))-500)*0.45
// +(6-MIN(TIER,6))*-60
exports.calculateWN = function(data) {
    if(!data || !data.b || data.b <= 0)
        return 0;

    var TIER = data.lvl;
    var TIER_N = Math.min(6, TIER);
    var FRAGS = data.frg / data.b;
    var DAMAGE = data.dmg / data.b;
    var SPOT = data.spo / data.b;
    var DEF = Math.min(2.2, data.def / data.b);
    var WINRATE = data.w / data.b * 100;

    return Math.max(1, Math.round(
        (1240 - 1040 / Math.pow(TIER_N, 0.164)) * FRAGS +
            DAMAGE * 530 / (184 * Math.exp(0.24 * TIER) + 130) +
            SPOT * 125 +
            DEF * 100 +
            ((185 / (0.17 + Math.exp((WINRATE - 35) * -0.134))) - 500) * 0.45 +
            (6 - TIER_N) * -60)) || 0;
};

// normalized EFF
// MAX(MIN(-2,523*10^(-9)*eff^3 + 3,351*10^(-6)*eff^2 + 0,07331*eff - 31,57; 100); 0)
exports.calculateNEFF = function(value) {
    var res = Math.round(Math.max(0, Math.min(100,
        -0.000000002523 * Math.pow(value, 3) + 0.000003351 * Math.pow(value, 2) + 0.07331 * value - 31.57)));
    return res == 100 ? "XX" : (res < 10 ? "0" : "") + res;
};

// normalized WN6
// MAX(MIN(1,984*10^(-9)*wn6^3 - 1,91*10^(-6)*wn6^2 + 0,04803*wn6 - 4,638; 100); 0)
exports.calculateNWN = function(value) {
    var res = Math.round(Math.max(0, Math.min(100,
        0.000000001984 * Math.pow(value, 3) - 0.00000191 * Math.pow(value, 2) + 0.04803 * value - 4.638)));
    return res == 100 ? "XX" : (res < 10 ? "0" : "") + res;
};

exports.getVehicleType = function(vclass) {
    switch(vclass.toLowerCase()) {
        case "lighttank":
            return "LT";
        case "mediumtank":
            return "MT";
        case "heavytank":
            return "HT";
        case "at-spg":
            return "TD";
        case "spg":
            return "SPG";
        default:
            return "unknown";
    }
};

var clone = exports.clone = function(obj) {
    // TODO: use FASTER implementation
    return JSON.parse(JSON.stringify(obj));
};

var log = exports.log = function(str) {
    var now = new Date();
    var s = now.getFullYear() + "-" +
        (now.getMonth() < 9 ? "0" : "") + (now.getMonth() + 1) + "-" +
        (now.getDate() < 10 ? "0" : "") + now.getDate() + " " +
        now.toLocaleTimeString();
    console.log(s + ": " + str);
};

exports.performanceReport = function(perfStat) {
    var now = new Date(),
        stat = clone(perfStat);

    stat._id = now;
    stat.uptime = now - perfStat.start;
    delete stat.start;

    db.insertPerformanceReport(stat);
};

exports.debug = function(str) {
    log("DEBUG: " + str);
};

exports.filterVehicleData = function(item, vname) {
    if(!vname || !item.v)
        return null;

    if(item.v instanceof Array) {
        // TODO: remove legacy code
        for(var i in item.v) {
            try {
                if(item.v[i].name.toUpperCase() == vname)
                    return item.v[i];
            } catch(e) {
                log("[ERROR]>  " + e + " id=" + item._id + " " + JSON.stringify(item));
            }
        }
        // [/TODO]
    } else {
        // NEW
        for(var vn in item.v) {
            try {
                if(vn == vname) {
                    var res = item.v[vn];
                    res["name"] = vn;
                    return res;
                }
            } catch(e) {
                log("[ERROR]>  " + e + " id=" + item._id + " " + JSON.stringify(item));
            }
        }
    }
    return null;
};

exports.filterByRegion = function(data, region) {
    if(!region)
        return data;
    region = region.toUpperCase();
    var res = [];
    for(var i in data) {
        var d = data[i];
        var id = d._id;
        switch(region) {
            case "RU":
                if(id >= 2 && id <= 499999999)
                    res.push(d);
                break;
            case "EU":
                if(id >= 500000000 && id <= 999999999)
                    res.push(d);
                break;
            case "US":
            case "NA":
                if(id >= 1000000000 && id <= 1499999999)
                    res.push(d);
                break;
            case "SEA":
                if(id >= 2000000000 && id <= 2499999999)
                    res.push(d);
                break;
            case "VTC":
                if(id >= 2500000000 && id <= 2999999999)
                    res.push(d);
                break;
            case "KR":
                if(id >= 3000000000 && id <= 3499999999)
                    res.push(d);
                break;
        }
    }
    return res;
};

exports.getStatServers = function(id) {
    var serverId = Math.floor(id / 500000000);
    if(serverId < 0 || serverId >= settings.statServers.length)
        return null;
    var servers = settings.statServers[serverId];
    if(!servers || servers.length == 0)
        return null;
    var res = [ ];
    for(var i in servers) {
        var srv = settings.servers[servers[i]];
        srv.id = servers[i];
        res.push(srv);
    }
    return res;
};

exports.tcalc = tcalc.calc;