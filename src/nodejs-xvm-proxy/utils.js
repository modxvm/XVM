module.exports = (function()
{
    // calculateEfficiency
    var calculateEfficiency = function(data) {
        var start = new Date();

        var battlesCount = data.summary.battles_count,
            tankLvl = { },
            mid = 0;

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

        var res = 0;
        if(battlesCount !== 0) {
            var battles = data.battles,
                dmg = battles.damage_dealt / battlesCount,
                des = battles.frags / battlesCount,
                det = battles.spotted / battlesCount,
                cap = battles.capture_points / battlesCount,
                def = battles.dropped_capture_points / battlesCount;

            res = Math.round((dmg * (10 / mid) * (0.15 + mid / 50) + des * (0.35 - mid / 50)
                * 1000 + det * 200 + cap * 150 + def * 150) / 10, 0) * 10;
        }

//        console.log("eff: " + (new Date() - start) + " ms (" + JSON.stringify(data).length + " bytes)");
        return res;
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
        getVehicleType: getVehicleType,
        clone: clone,
        log: log,
        debug: debug
    }
})();
