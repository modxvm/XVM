var fs = require('fs')

var resFN = "results.xml",
    plFN = "players.xml",
    players = {},
    results = {};

/**
 * [{
 *   a: "playerId",
 *         "a":6260143
 *   b: "team",
 *         "b":1
 *   c: "stat",
 *         "c":{"te":3,"cap":21607,"hip":51,"twr":0,"teff":560,"dmg":7337686,"tw":186,"teff2":736,
 *              "def":6369,"ts":341,"tsb":0.8,"vn":"IS-3","tl":8,"wn":573,"td":339744,"tf":249,
 *              "r":47,"tdb":786,"frg":8834,"tfb":0.6,"tb":432,"w":9153,"spo":19022,"id":5435596,
 *              "b":19587,"tr":43,"clan":"G_S_A","avglvl":5.8,"tdv":0.5,"name":"ZINNURTIGER",
 *              "e":690}
 *   d: "vehicleId",
 *         "d":"SU-100"
 *   e: "label",
 *         "e":"INSI74"
 *   f: "clanAbbrev",
 *         "f":""
 *   g: "realVehicleId"
 * },...]
 */
var process_setup = function(data)
{
  for (var i = 0; i < data.length; ++i) {
    var pdata = data[i];

    var vehicleId = pdata.g;
    var id = pdata.a;
    var vehicle = pdata.d;

    if (players[vehicleId]) {
      console.log('skip duplicate player: ' + id + "/" + vehicle);
      continue;
    }

    var b = pdata.c ? pdata.c.b : null;
    if (b == null) {
      console.log("no battles: " + id + "/" + vehicle);
      continue;
    }

    var avglvl = pdata.c.avglvl;
    if (avglvl == null && b > 0) {
      console.log("no avglvl: " + id + "/" + vehicle);
      continue;
    }

    var s = '';
    s += '  <player';
    s += ' id="' + id + '"';
    s += ' name="' + pdata.e + '"';
    s += ' vehicle="' + vehicle + '"';
    s += ' vehId="' + vehicleId + '"';
    s += ' battles="' + b + '"';
    s += ' wins="' + pdata.c.w + '"';
    s += ' tbattles="' + pdata.c.tb + '"';
    s += ' twins="' + pdata.c.tw + '"';
    s += ' level="' + pdata.c.tl + '"';
    s += ' avgl="' + avglvl + '"';
    s += ' eff="' + pdata.c.e + '"';
    s += ' wn6="' + pdata.c.wn + '"';
    s += ' twr="' + pdata.c.twr + '"';
    var teff = pdata.c.teff || 0;
    s += ' teff="' + teff + '"';
//    s += ' dmg="' + pdata.c.dmg + '"';
//    s += ' frg="' + pdata.c.frg + '"';
//    s += ' spo="' + pdata.c.spo + '"';
//    s += ' def="' + pdata.c.def + '"';
//    s += ' cap="' + pdata.c.cap + '"';
    s += '/>\n';
    players[vehicleId] = s;
  }
}

/**
 * a: "team1" : [...],
 * b: "team2" : [...],
 * c: "common",
 *  "c":{"b":2,"c":1353505545,"a":2,"f":"sirmax2","g":"Т-34-85","d":"win","e":7}
 *   a: "finishReason",
 *   b: "winnerTeam",
 *   c: "arenaCreateTime",
 *   d: "resultShortStr",
 *   e: "arenaTypeID",
 *   f: "playerNameStr",
 *   g: "vehicleName"
 * d: "dailyXPFactor"
 *   "d":2
 */
var process_results = function(data)
{
  var ctime = data.c.c;

  if (results[ctime]) {
    console.log("skip duplicate result: " + ctime);
    return;
  }

  var w = data.c.b;

  var t1 = process_results_2(w == 2 ? data.b : data.a, 1);
  var t2 = process_results_2(w == 2 ? data.a : data.b, 16);

  var draw = w == 0 ? 1 : 0;

  results[ctime] = {
    res: '  <result' + t1.res + t2.res + ' draw="' + draw + '" created="' + ctime + '"/>\n',
    ids: t1.ids.concat(t2.ids)
  }
}

/**
 * [{
 *   b: "vehicleId",		c: "playerId",		d: "name",
 *   e: "team",			f: "vehicleFullName",	g: "squadID",
 *   h:"isSelf",		i: "clanAbbrev",	//j: "vehicleStateStr",
 *   k: "killerID",		l: "health",		m: "healthPercents",
 *   n: "lifeTime",		o: "isTeamKiller",	p: "mileage",
 *   q: "spotted",		r: "capturePoints",	s: "droppedCapturePoints",
 *   t: "realKills",		u: "kills",		v: "damageAssisted",
 *   w: "shots",		x: "hits",		y: "pierced",
 *   z: "shotsReceived",	ac: "damaged",		ab: "damageReceived",
 *   ad: "tdamageDealt",	ae: "damageDealt",	af: "xp",
 *   ag: "freeXP",		ah: "credits",		ai: "repair",
 *   aj: "typeCompDescr"
 * },...]
 */
var process_results_2 = function(data, n)
{
  var res = "";
  var ids = [];
  for (var i = 0; i < data.length; ++i) {
    var vehicleId = data[i].b;
    res += ' vehId' + (n + i) + '="' + vehicleId + '"';
    ids.push(vehicleId);
  }
  return { res: res, ids: ids }
}

/// MAIN ///

var files = fs.readdirSync('log');
for (var fileId = 0; fileId < files.length; ++fileId) {
  var fn = files[fileId];
  if (!/\.log$/i.test(fn))
    continue;

  console.log(fn);

  var fdata = fs.readFileSync('log/' + fn, 'UTF-8').replace('\r', '').split('\n');

  var total = fdata.length;
  var curr = 1

  for (var lineId = 0; lineId < fdata.length; ++lineId) {
    var line = fdata[lineId];
    if (!/.*:.*:.*/.test(line))
      continue;
    var line = line.split(':');
    var date = line[0];
    var type = line[1];
    line.shift();
    line.shift();
    line = line.join(':');
    var data = JSON.parse(line);
    console.log("  [" + curr + "/" + total + "] " + type);
    curr++;
    try {
      switch (type) {
        case 'setup':
          process_setup(data);
          break;
        case 'results':
          process_results(data);
          break;
      }
    } catch (e) {
      console.log('data: ' + JSON.stringify(data) + '\n' + 'error: ' + e);
      process.exit();
    }
  }
}

console.log("Write results");

fs.writeFileSync(resFN, '<results>\n');
fs.writeFileSync(plFN, '<players>\n');

for (var i in results) {
  var result = results[i];
  var ok = true;
  for (var j = 0; j < result.ids.length; ++j) {
    var vehicleId = result.ids[j];
    if (!players[vehicleId]) {
      console.log("player with vehicleId=" + vehicleId + " not found, result skipped");
      ok = false;
      break;
    }
  }
  if (!ok)
    continue;
  fs.appendFileSync(resFN, result.res);
  for (var j = 0; j < result.ids.length; ++j)
    fs.appendFileSync(plFN, players[result.ids[j]]);
}

fs.appendFileSync(resFN, '</results>\n');
fs.appendFileSync(plFN, '</players>\n');
