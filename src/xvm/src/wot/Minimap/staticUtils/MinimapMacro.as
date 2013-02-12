import wot.utils.VehicleTypeShort;
import wot.utils.VehicleInfo;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.MinimapEntry;

class wot.Minimap.staticUtils.MinimapMacro
{
    private static var LEVEL_MACRO:String = "{{level}}";
    private static var NICK_MACRO:String = "{{short-nick}}";
    private static var VEHCLASS_MACRO:String = "{{vehicle-class}}";
    private static var VEH_MACRO:String = "{{vehicle-type}}";
    private static var SHORT_VEH__MACRO:String = "{{vehicle-type-short}}"; // TODO
    
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
            var vi2 = VehicleInfo.getInfo2(player.icon);
            format = formatArr.join(vi2.level);
        }
        
        /** Vehicle short type */
        formatArr = format.split(SHORT_VEH__MACRO);
        if (formatArr.length > 1)
        {
            var type:String = VehicleInfo.getVehicleName(player.icon).split("-").join("_");
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
        
        //Logger.addObject(format, "format", 3);
        /** {{vehicle-class}} returns special symbol depending on class */
        formatArr = format.split(VEHCLASS_MACRO);
        if (formatArr.length > 1)
        {
            switch (vehicleClass)
            {
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_LIGHT:
                    format = formatArr.join(MapConfig.lightSymbol);
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_MEDIUM:
                    format = formatArr.join(MapConfig.mediumSymbol);
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_HEAVY:
                    format = formatArr.join(MapConfig.heavySymbol);
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_TD:
                    format = formatArr.join(MapConfig.tdSymbol);
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_SPG:
                    format = formatArr.join(MapConfig.spgSymbol);
                    break;
                case MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_SUPER:
                    format = formatArr.join(MapConfig.superSymbol);
                    break;
            }
        }
        
        return format;
    }
}