/*
  s_data members:
    playerId: Number,
    fullPlayerName: fullPlayerName,
    label: String,
    clanAbbrev: String,
    vehicle: String,
    vehicleKey: String,
    icon: String,
    team: Defines.TEAM_ALLY | Defines.TEAM_ENEMY,
    vehicleId: Number,
    vehicleState: Number, // IS_ALIVE = 1, IS_AVATAR_READY = 2, IS_UNKNOWN = 4
    selected: Boolean,
    loadstate: LOADSTATE_NONE, LOADSTATE_LOADING, LOADSTATE_UNKNOWN, LOADSTATE_DONE
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
    public static var s_empty = true;
    public static var s_data = {};
}
