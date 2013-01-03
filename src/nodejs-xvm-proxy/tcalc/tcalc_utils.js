module.exports = (function() {

    var def = require("./tcalc_defines.js"),
        tcalc_base = require("./tcalc_base.js");

    // Parse user stats
    parseStatData = function(data) {
        var log = "";
        data.battles = 0; // total count of "good" battles (more 100 battles for tank)
        var vd = []; // filtered array of vehicles data
        for (var i in data.v) {
            var vdata = data.v[i];
            if (!vdata.b || vdata.b <= def.MIN_VEHICLE_BATTLES)
                continue;
            vdata.link = tcalc_base.tanks[vdata.name.toLowerCase()];
            vdata.rate = vdata.w / vdata.b * 100;
            if (!vdata.link) {
                log += "WARNING: No data in base.csv for " + vdata.name +
                    " (b=" + vdata.b + " r=" + vdata.rate.toFixed(2) + "). This tank is skipped.\n";
                continue;
            }
            data.battles += vdata.b;
            vdata.damage = (vdata.d || 0) / vdata.b;
            vd.push(vdata);
        }
        // replace original array with filtered array
        data.v = vd;
        return log;
    }

    // remove battles with bad stats (teaching)
    delFirst = function(data, battles) {
        var log = "";
        data.v.sort(function(a,b){ return b.rate-a.rate; });
        for (var i = data.v.length - 1; i >= 0 && battles > 0; --i) {
            var vdata = data.v[i];

            // skip top tanks (level 8+)
            if (vdata.l >= 8)
                continue;

            // skip tanks with good percent
            if (vdata.rate >= 53)
                continue;

            battles -= vdata.b;
            log += "Deleted: b=" + vdata.b + "\t%=" + Math.round(vdata.rate) + "\t" + vdata.name + "\n";
            delete data.v[i];
        }

        return log;
    }

    // calculate average win rate
    getAvgRate = function(data) {
        var b = 0, w = 0;
        for (var vname in data.v)
        {
            var vdata = data.v[vname];
            b += vdata.b;
            w += vdata.w;
        }

        return w / b * 100;
    }

    // calculate average corrected win rate
    getAvgRatePlus = function(data) {
        var b = 0, w = 0;
        for (var vname in data.v)
        {
            var vdata = data.v[vname];
            b += vdata.b;
            w += vdata.rate_plus * vdata.b / 100;
        }

        return w / b * 100;
    }

    return {
        parseStatData: parseStatData,
        delFirst: delFirst,
        getAvgRate: getAvgRate,
        getAvgRatePlus: getAvgRatePlus
    }
})();
