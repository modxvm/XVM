module.exports = (function() {

    var def = require("./tcalc_defines.js"),
        tcalc_base = require("./tcalc_base.js");

    // Parse user stats
    parseStatData = function(data, isLog) {
        var log = "";
        data.battles = 0; // total count of "good" battles (more 100 battles for tank)
        var vd = []; // filtered array of vehicles data
        for (var vname in data.v) {
            if (vname == "A-20" || vname == "M103") {
                if (isLog)
                    log += "WARNING: Skip dubious tank: " + vname + "\n";
                continue;
            }

            var vdata = data.v[vname];
            vdata.name = vname;

            if (!vdata.b || vdata.b <= def.MIN_VEHICLE_BATTLES) {
                if (isLog)
                    log += "WARNING: Not enough battles for tank: " + vname + " (" + vdata.b + "). This tank is skipped.\n";
                continue;
            }

            vdata.link = tcalc_base.tanks[vname];
            vdata.rate = vdata.w / vdata.b * 100;
            if (!vdata.link) {
                if (isLog) {
                    log += "WARNING: No configuration data for tank: " + vname +
                        " (b=" + vdata.b + " r=" + vdata.rate.toFixed(2) + "). This tank is skipped.\n";
                }
                continue;
            }
            // fix acc in depend of count of battles
            vdata.acc = vdata.link.acc * (1 - 1 / Math.sqrt(vdata.b));

            data.battles += vdata.b;
            vdata.damage = (vdata.d || 0) / vdata.b;
            vd.push(vdata);
        }

        // limit of calculated tanks
        vd.sort(function(a,b){ return b.b - a.b; });
/*        if (vd.length >= 30) {
            if (isLog)
                log += "Tanks limit is reached: 30. Skip some tanks (" + (vd.length - 30) + ").\n";
            vd = vd.slice(0, 30);
        }*/

        // replace original array with filtered array
        data.v = vd;
        return log;
    }

    // remove battles with bad stats (teaching)
    delFirst = function(data, battles, isLog) {
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
            if (isLog)
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
    getAvgRatePlus = function(data, isLog) {
        var b = 0, w = 0, b7 = 0, b8 = 0, b9 = 0;
        for (var vname in data.v)
        {
            var vdata = data.v[vname];
            b += vdata.b;
            w += vdata.rate_plus * vdata.b / 100;
            if (vdata.l >= 7) b7 += vdata.b;
            if (vdata.l >= 8) b8 += vdata.b;
            if (vdata.l >= 9) b9 += vdata.b;
        }

        var res = w / b * 100;
        if (res > 53 && b7 < 300)
            return { result: 53, log: isLog ? "\nWARNING: Not enough battles on level 7+, maximum rate is 53%\n" : "" };
        if (res > 55 && b8 < 300)
            return { result: 55, log: isLog ? "\nWARNING: Not enough battles on level 8+, maximum rate is 55%\n" : "" };
        if (res > 57 && b9 < 300)
            return { result: 57, log: isLog ? "\nWARNING: Not enough battles on level 9+, maximum rate is 57%\n" : "" };

        return { result: res, log: "" };
    }

    return {
        parseStatData: parseStatData,
        delFirst: delFirst,
        getAvgRate: getAvgRate,
        getAvgRatePlus: getAvgRatePlus
    }
})();
