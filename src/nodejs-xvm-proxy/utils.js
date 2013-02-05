// calculate average level of tanks
var calculateAvgLvl = exports.calculateAvgLevel = function(vehicles) {
    var level_battles = 0
    var total_battles = 0;
    for (var vname in vehicles) {
        var item = vehicles[vname];
        level_battles += item.l * item.b;
        total_battles += item.b;
    }
    return total_battles <= 0 ? 0 : level_battles / total_battles;
}

// calculateEfficiency
exports.calculateEfficiency = function(data) {
    if (!data || !data.b || data.b <= 0)
        return 0;

    var TIER = data.lvl;
    var FRAGS = data.frg / data.b;
    var DAMAGE = data.dmg / data.b;
    var SPOT = data.spo / data.b;
    var CAP = data.cap / data.b;
    var DEF = data.def / data.b;

    var res = Math.round((
        DAMAGE * (10 / TIER) * (0.15 + TIER / 50) +
        FRAGS * (0.35 - TIER / 50) * 1000 +
        SPOT * 200 +
        CAP * 150 +
        DEF * 150
        ) / 10) * 10;

//        console.log("eff: " + (new Date() - start) + " ms (" + JSON.stringify(data).length + " bytes)");
        return res;
}

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
    if (!data || !data.b || data.b <= 0)
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
}

exports.getVehicleType = function(vclass) {
    switch(vclass.toLowerCase()) {
        case "lighttank":       return "LT";
        case "mediumtank":      return "MT";
        case "heavytank":       return "HT";
        case "at-spg":          return "TD";
        case "spg":             return "SPG";
        default:                return "unknown";
    }
}

// deep-copy of object (only simple type values supported)
var clone = exports.clone = function(obj) {
    // TODO: use FASTER implementation
    return JSON.parse(JSON.stringify(obj));
//    var copy = {};
//    for(var i in obj) {
//        var v = obj[i];
//        copy[i] = v == null ? null
//            : typeof v == "object" ? clone(v)
//            : v;
//    }
//    return copy;
}

// log
var log = exports.log = function(str) {
    var now = new Date();
    var s = now.getFullYear() + "-" +
        (now.getMonth() < 9 ? "0" : "") + (now.getMonth() + 1) + "-" +
        (now.getDate() < 10 ? "0" : "") + now.getDate() + " " +
        now.toLocaleTimeString();
    console.log(s + ": " + str);
}

// debug
exports.debug = function(str) {
    log("DEBUG: " + str);
}

// Filter vehicle data
exports.filterVehicleData = function(item, vname) {
    if (!vname || !item.v)
        return null;

    if (item.v instanceof Array) {
        // TODO: remove legacy code
        for(var i in item.v) {
            try {
                if (item.v[i].name.toUpperCase() == vname) 
                    return item.v[i];
            } catch (e) {
                log("[ERROR]>  " + e + " id=" + item._id + " " + JSON.stringify(item));
            }
        }
        // [/TODO]
    } else {
        // NEW
        for (var vn in item.v) {
            try {
                if (vn == vname) {
                    var res = item.v[vn];
                    res["name"] = vn;
                    return res;
                }
            } catch (e) {
                log("[ERROR]>  " + e + " id=" + item._id + " " + JSON.stringify(item));
            }
        }
    }
    return null;
}
