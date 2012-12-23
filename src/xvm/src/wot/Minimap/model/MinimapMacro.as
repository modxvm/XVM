import wot.utils.VehicleTypeShort;
import wot.utils.VehicleInfo;
import wot.utils.VehicleInfoData;
import wot.Minimap.model.MapConfig;

class wot.Minimap.model.MinimapMacro
{
    public static function process(format:String, player:Object):String
    {
        if (format.indexOf("{{") == -1)
            return format;

        // TODO: StatFormat
        var formatArr:Array

        /**
         * Level
         * player.level is undefined when Show Level at Game Menu is not checked.
         * PlayersPanel does not populate itself with level in that case.
         * Alternative level definition is used here.
         */
        formatArr = format.split("{{level}}");
        if (formatArr.length > 1)
        {
            var veh:String = VehicleInfo.getName(player.icon);
            var vehData:Object = VehicleInfoData.data[veh];
            format = formatArr.join(vehData.level);
        }
        
        /** Vehicle short type */
        formatArr = format.split("{{short-vehicle}}");
        if (formatArr.length > 1)
        {
            var type:String = VehicleInfo.getName(player.icon);
            format = formatArr.join(VehicleTypeShort.translate(type));
        }
            
        /** Vehicle type */
        formatArr = format.split("{{vehicle}}");
        if (formatArr.length > 1)
            format = formatArr.join(player.vehicle);

        /** Nickname shortened */
        formatArr = format.split("{{short-nick}}");
        if (formatArr.length > 1)
        {
            var userName:String = player.userName;
            var shortNick = userName.slice(0, MapConfig.nickShrink);
            format = formatArr.join(shortNick);
        }

        return format;
    }
}