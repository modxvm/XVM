import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.utils.Macros;

/*
  s_data members:
    playerId: Number,
    fullPlayerName: fullPlayerName,
    label: String,
    clanAbbrev: String,
    vehicle: String,
    vehicleId: String,
    icon: String,
    team: Defines.TEAM_ALLY | Defines.TEAM_ENEMY,
    selected: Boolean,
    loaded: Boolean
    stat:
        id - player id
        name - player name
        clan - player clan
        vn - vehicle name
        b - battles
        w - wins
        r - global win ratio (*)
        e - eff
        tb - tank battles
        tw - tank wins
        tr - tank win ratio (*)
        tl - tank level
        td - tank damage
        tf - tank frags
        ts - tank spotted
        tdb - average tank damage per battle (*)
        tdf - average tank frags per battle (*)
        tdv - average tank damage efficiency per battle (*)
            (*) - calculated in StatLoader.as
        te - per-vehicle efficiency (http://www.koreanrandom.com/forum/topic/1643-)
*/

/*
stat: {
    "id": 1797665,
    "name": "GRANDCHERROKI_RU",
    "clan": "",
    "vn": "CH15_59_16",
    "b": 16568,
    "w": 9200,
    "r": 56,
    "e": 1400
    "tb": 0,
    "tw": 0,
    "tr": 56,
    "tl": 0,
    "td": 0,
    "tf": 0,
    "ts": 0,
}
*/

class wot.utils.StatData
{
    public static var s_loaded = false;
    public static var s_data = {};



    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    public static function FormatText(data:Object, format:String, isDead:Boolean):String
    {
        //Logger.addObject(s_data);
        if (s_loaded)
        {
            var pname: String = Utils.GetNormalizedPlayerName(data.label);
            if (!data.uid)
                data.uid = s_data[pname].playerId;
            var stat = s_data[pname].stat;
            //Logger.addObject(s_data[pname]);
            //Logger.add("pname=" + pname + " uid=" + data.uid + " r=" + stat.r + " e=" + stat.e);
            if (!stat)
            {
                if (Config.s_config.rating.loadEnemyStatsInFogOfWar)
                    GlobalEventDispatcher.dispatchEvent( { type: "process_fow", data: data } );
            }
            else
            {
                if (Config.s_config.rating.loadEnemyStatsInFogOfWar && !s_data[pname].loaded && data.vehicleId != "UNKNOWN")
                    GlobalEventDispatcher.dispatchEvent( { type: "process_fow", data: data } );
            }
        }

        return Macros.Format(data.label, format, { darken:isDead } );
    }
}
