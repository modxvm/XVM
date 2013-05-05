/**
{
  "topR": 0.741935484,
  "teff": 1406,
  "vehicleClass": 4,
  "avgE": 0.574931403,
  "icon": "../maps/icons/vehicle/small/ussr-T-34-85.png",
  "topD": 1232,
  "topF": 1.891891892,
  "avgS": 0.976441166,
  "ts": 869,
  "avgU": 0.195910562,
  "tsb": 1.5462633451957,
  "type": 3,
  "topS": 3.056179775,
  "hp": 720,
  "topU": 0.52892562,
  "nation": 0,
  "level": 6,
  "avgF": 0.547490476,
  "avgD": 414,
  "toolTip": 4,
  "topE": 1.711636396,
  "id": 2561,
  "avgR": 0.489926555,
  "wins": "57\u0025",
  "fights": 562,
  "name": "Ò-34-85",
  "e": 7
},
 */
class wot.WGDataTypes.UserInfoDataItem
{
    var icon:String;
    var name:String;
    var vehicleClass:Number; // 1,2,3,4(M)
    var type:Number;
    var nation: Number;
    var level:Number;
    var toolTip:Number;
    var fights:Number;
    var wins:Number;
    
    public static function toType(s:String):Number
    {
        switch (s)
        {
            case "LT": return 2;
            case "MT": return 3;
            case "HT": return 5;
            case "TD": return 4;
            case "SPG": return 1;
            default: return 0;
        }
    }

    public static function toNation(s:String):Number
    {
        switch (s)
        {
            case "ussr": return 0;
            case "germany": return 1;
            case "usa": return 2;
            case "china": return 3;
            case "france": return 4;
            case "uk": return 5;
            case "japan": return 6;
            default: return -1;
        }
    }
}
