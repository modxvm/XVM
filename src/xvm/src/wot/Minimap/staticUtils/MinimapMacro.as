import wot.utils.VehicleTypeShort;
import wot.utils.VehicleInfo;
import wot.utils.VehicleInfoData;
import wot.Minimap.model.MapConfig;
import wot.Minimap.dto.Player;
import wot.Minimap.model.IconsProxy;
import wot.Minimap.MinimapEntry;

class wot.Minimap.staticUtils.MinimapMacro
{
    private static var LEVEL_MACRO:String = "{{level}}";
    private static var SHORT_VEH__MACRO:String = "{{short-vehicle}}";
    private static var VEH_MACRO:String = "{{vehicle}}";
    private static var NICK_MACRO:String = "{{short-nick}}";
    private static var IFSPG_MACRO:String = "{{ifspg}}";
    private static var IFSPG_SYMBOL:String = "█";
    
    public static function process(format:String, player:Player, vehicleClass:String):String
    {
        if (format.indexOf("{{") == -1)
            return format;

        // TODO: StatFormat
        
        var formatArr:Array;

        /**
         * Level
         * player.level is undefined when Show Level at Game Menu is not checked.
         * PlayersPanel does not populate itself with level in that case.
         * Alternative level definition is used here.
         */
        formatArr = format.split(LEVEL_MACRO);
        if (formatArr.length > 1)
        {
            var veh:String = VehicleInfo.getName(player.icon);
            var vehData:Object = VehicleInfoData.data[veh];
            format = formatArr.join(vehData.level);
        }
        
        /** Vehicle short type */
        formatArr = format.split(SHORT_VEH__MACRO);
        if (formatArr.length > 1)
        {
            var type:String = VehicleInfo.getName(player.icon);
            format = formatArr.join(VehicleTypeShort.translate(type));
        }
            
        /** Vehicle type */
        formatArr = format.split(VEH_MACRO);
        if (formatArr.length > 1)
            format = formatArr.join(player.vehicle);

        /** Nickname shortened */
        formatArr = format.split(NICK_MACRO);
        if (formatArr.length > 1)
        {
            var userName:String = player.userName;
            var shortNick = userName.slice(0, MapConfig.nickShrink);
            format = formatArr.join(shortNick);
        }
        
        /** Returns special symbol if subject is artillery */
        formatArr = format.split(IFSPG_MACRO);
        if (formatArr.length > 1)
        {
            if (vehicleClass == MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_SPG)
                format = formatArr.join(IFSPG_SYMBOL);
            else
                format = formatArr.join("")
        }

        return format;
    }
}