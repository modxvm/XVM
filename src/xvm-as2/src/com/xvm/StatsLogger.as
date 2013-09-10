import com.xvm.Comm;
import com.xvm.Defines;

class com.xvm.StatsLogger
{
    public static function saveStatistics(key: String, data: Object)
    {
        var out: Object = mapData(data, key);
        var d: Date = new Date();
        // TODO Comm.SyncEncoded(Defines.COMMAND_LOGSTAT,
        // TODO     d.getTime() + ":" + key + ":" + com.xvm.JSONx.stringify(out, "", true));
    }

    private static function mapData(data: Object, fieldName: String)
    {
        var out: Object = { };
        var mapping: Object = null;

        if (fieldName == "results")
            mapping = resultsMapping;
        else if (fieldName == "common")
            mapping = resultsCommonMapping;
        else if (fieldName == "player")
            mapping = resultsPlayerMapping;
        else if (fieldName == "stats")
            mapping = statPlayerMapping;
        else if (fieldName == "setup")
        {
            var a: Array = [];
            var i: Number = 0;
            for (var k: String in data)
                a[i++] = mapData(data[k], "stats");
            return a;
        } else if (fieldName == "team1" || fieldName == "team2")
        {
            var a: Array = [];
            for (var i:Number = 0; i < data.length; ++i)
                a[i] = mapData(data[i], "player");
            return a;
        }

        if (mapping == null)
          return data;

        for (var key: String in mapping)
            out[key] = mapData(data[mapping[key]], mapping[key]);
        return out;
    }

    private static var resultsMapping: Object =
    {
        a: "team1",
        b: "team2",
        c: "common",
        d: "dailyXPFactor"
    }

    private static var resultsCommonMapping: Object =
    {
        a: "finishReason",
        b: "winnerTeam",
        c: "arenaCreateTime",
        d: "resultShortStr",
        e: "arenaTypeID",
        f: "playerNameStr",
        g: "vehicleName"
    }

    private static var resultsPlayerMapping: Object =
    {
        b: "vehicleId",
        c: "playerId",
        d: "name",
        e: "team",
        f: "vehicleFullName",
        g: "squadID",
        h:"isSelf",
        i: "clanAbbrev",
        //j: "vehicleStateStr",
        k: "killerID",
        l: "health",
        m: "healthPercents",
        n: "lifeTime",
        o: "isTeamKiller",
        p: "mileage",
        q: "spotted",
        r: "capturePoints",
        s: "droppedCapturePoints",
        t: "realKills",
        u: "kills",
        v: "damageAssisted",
        w: "shots",
        x: "hits",
        y: "pierced",
        z: "shotsReceived",
        ab: "damageReceived",
        ac: "damaged",
        ad: "tdamageDealt",
        ae: "damageDealt",
        af: "xp",
        ag: "freeXP",
        ah: "credits",
        ai: "repair",
        aj: "typeCompDescr"
    }

    private static var resultsShotsMapping: Object =
    {
        a: "fire",
        b: "teamKill",
        c: "crits",
        d: "damageDealt",
        e: "he_hits",
        f: "vehicleId",
        g: "xp",
        h: "pierced",
        i: "spotted",
        j: "killed",
        k: "balanceWeight",
        l: "hits",
        m: "damageAssisted"
    }

    private static var statPlayerMapping: Object =
    {
        a: "playerId",
        b: "team",
        c: "stat",
        d: "vehicleKey",
        e: "label",
        f: "clanAbbrev",
        g: "vehicleId"
    }

}