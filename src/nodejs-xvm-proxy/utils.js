module.exports = (function()
{
    // calculateEfficiency
    var calculateEfficiency = function(data) {
        var start = new Date();

        var battlesCount = data.summary.battles_count,
            tankLvl = { },
            mid = 0;

        if (battlesCount == 0)
            return 0;

        tankLvl.battle_count = 0;

        for(var i = 1; i <= 10; i++) {
            tankLvl[i] = { battle_count: 0 };
        }

        data.vehicles.forEach(function(item) {
            tankLvl[item.level].battle_count += item.battle_count;
            tankLvl.battle_count += item.battle_count;
        });

        for(var j = 1; j <= 10; j++) {
            mid += j * tankLvl[j].battle_count / tankLvl.battle_count;
        }

        var battles = data.battles,
            dmg = battles.damage_dealt / battlesCount,
            des = battles.frags / battlesCount,
            det = battles.spotted / battlesCount,
            cap = battles.capture_points / battlesCount,
            def = battles.dropped_capture_points / battlesCount;

        var res = Math.round((dmg * (10 / mid) * (0.15 + mid / 50) + des * (0.35 - mid / 50)
            * 1000 + det * 200 + cap * 150 + def * 150) / 10, 0) * 10;

//        console.log("eff: " + (new Date() - start) + " ms (" + JSON.stringify(data).length + " bytes)");
        return res;
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
    var calculateWN = function(data) {
        if (!data || !data.b || data.b <= 0)
            return 0;

        var level_battles = 0
        var total_battles = 0;
        data.v.forEach(function(item) {
            level_battles += (item.l + (item.cl == "SPG" ? 2 : 0)) * item.b;
            total_battles += item.b;
        });
        var TIER = level_battles / total_battles;
        var TIER_N = Math.min(6, TIER);

        var FRAGS = data.frg / data.b;
        var DAMAGE = data.dmg / data.b;
        var SPOT = data.spo / data.b;
        var DEF = Math.min(2.2, data.def / data.b);
        var WINRATE = data.w / data.b * 100;

        return Math.round(
            (1240 - 1040 / Math.pow(TIER_N, 0.164)) * FRAGS +
            DAMAGE * 530 / (184 * Math.exp(0.24 * TIER) + 130) +
            SPOT * 125 +
            DEF * 100 +
            ((185 / (0.17 + Math.exp((WINRATE - 35) * -0.134))) - 500) * 0.45 +
            (6 - TIER_N) * -60) || 0;
    };

    var getVehicleType = function(vclass) {
        switch(vclass.toLowerCase()) {
            case "lighttank": return "LT";
            case "mediumtank": return "MT";
            case "heavytank": return "HT";
            case "at-spg": return "TD";
            case "spg": return "SPG";
            default: return "unknown";
        }
    }

    // deep-copy of object (only simple type values supported)
    var clone = function(obj) {
        var copy = {};
        for(var i in obj)
            copy[i] = (typeof(obj[i])=="object") ? clone(obj[i]) : obj[i];
        return copy;
    }

    // log
    var log = function(str) {
        var now = new Date();
        var s = now.getFullYear() + "-" +
            (now.getMonth() < 9 ? "0" : "") + (now.getMonth() + 1) + "-" +
            (now.getDate() < 10 ? "0" : "") + now.getDate() + " " +
            now.toLocaleTimeString();
        console.log(s + ": " + str);
    };

    // debug
    var debug = function(str) {
        log("DEBUG: " + str);
    };

    // exports
    return {
        calculateEfficiency: calculateEfficiency,
        calculateWN: calculateWN,
        getVehicleType: getVehicleType,
        clone: clone,
        log: log,
        debug: debug
    }
})();
