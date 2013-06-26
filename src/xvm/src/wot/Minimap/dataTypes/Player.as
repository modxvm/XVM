/**
 * PlayersPanel.swf
 * _level0.leftPanel.m_list._dataProvider[*]
 *
  "uid": 1170763,
  "vehicle": "BDR G1B",
  "position": 7,
  "denunciations": 4,
  "team": "team1",
  "squad": 0,
  "level": 5,
  "himself": false,
  "vehId": 24036255,
  "userName": "Zohan11981",
  "teamKiller": false,
  "VIP": false,
  "icon": "../maps/icons/vehicle/contour/france-BDR_G1B.png",
  "vipKilled": 0,
  "muted": false,
  "vehicleState": 3,
  "speaking": false,
  "roster": 0,
  "isPostmortemView": false,
  "clanAbbrev": "",
  "frags": 0,
  "label": "Zohan11981",
  "vehAction": 0
 */
class wot.Minimap.dataTypes.Player
{
    public static var PLAYER_REVEALED:Number = 1;
    public static var PLAYER_LOST:Number = 0;
    public static var PLAYER_DEAD:Number = -1;
    
    public var uid:Number;
    public var vehicle:String;
    public var team:String;
    public var level:Number;
    public var himself:Boolean;
    public var userName:String;
    public var icon:String;
    public var vehicleState:Number;
}