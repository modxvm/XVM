module.exports = (function() {

    var fs = require('fs'),
        def = require("./tcalc_defines.js");

    var tanks = {};

    parseBaseCsv = function() {
        fs.readFile(def.base_csv, 'utf8', function (err,data) {
            if (err)
                return console.log(err);

            lines = data.split(/\r?\n/g);
            for (var lineId in lines) {
                var line = lines[lineId].trim().split(";");
                if (line.length <= 1)
                    continue;
                if (line.length != 12)
                    return console.log("Error: format error in base.csv:\n  " + lines[lineId]);

                tanks[line[3].toUpperCase()] = {
                    // skip [0] - vehicle country
                    // skip [1] - vehicle type
                    // skip [2] - vehicle level
                    name: line[3],
                    hp: parseInt(line[4]),
                    speed: parseFloat(line[5].replace(",", ".")),
                    turn: parseFloat(line[6].replace(",", ".")),
                    see: parseFloat(line[7].replace(",", ".")),
                    acc: parseFloat(line[8].replace(",", ".")),
                    dam55: parseFloat(line[9].replace(",", ".")),
                    dam5: parseFloat(line[10].replace(",", "."))
                };
            }
        });
    }
    return {
        tanks: tanks,
        parseBaseCsv: parseBaseCsv
    }
})();
