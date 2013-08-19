import com.xvm.Utils;
import com.xvm.VehicleInfo;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.model.externalProxy.MapConfig;

class wot.Minimap.staticUtils.MinimapMacro
{
    private static var LEVEL_MACRO:String = "{{level}}";
    private static var NICK_MACRO:String = "{{short-nick}}";
    private static var VEHCLASS_MACRO:String = "{{vehicle-class}}";
    private static var VEH_MACRO:String = "{{vehicle}}";
    private static var VEH_MACRO_ALT:String = "{{vehicle-type}}";
    private static var VEH_SHORT_MACRO:String = "{{vehicle-short}}";
    private static var VEH_NAME:String = "{{vehiclename}}";
    private static var VEH_NAME_ALT:String = "{{vehicle-name}}";

    public static function process(format:String, player:Player, vehicleClass:String):String
    {
        if (format.indexOf("{{") == -1)
            return Utils.fixImgTag(format);

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
        formatArr = format.split(VEH_SHORT_MACRO);
        if (formatArr.length > 1)
        {
            var type:String = VehicleInfo.getVehicleName(player.icon).split("-").join("_");
            format = formatArr.join(VehicleInfo.mapVehicleShortName(type, player.vehicle));
        }




        //var info:MovieClip = PlayersPanelProxy.getPlayerInfo(player.uid);
        //Logger.addObject(info._parent, "info", 2);

        /** Vehicle system name - usa-M24_Chaffee */
        var systemVehName:String = VehicleInfo.getName1(player.icon);
        formatArr = format.split(VEH_NAME);
        if (formatArr.length > 1)
            format = formatArr.join(systemVehName);
        formatArr = format.split(VEH_NAME_ALT);
        if (formatArr.length > 1)
            format = formatArr.join(systemVehName);

        /** Vehicle type readable - ×àôôè */
        formatArr = format.split(VEH_MACRO);
        if (formatArr.length > 1)
            format = formatArr.join(player.vehicle);
        formatArr = format.split(VEH_MACRO_ALT);
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
                case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_LIGHT:
                    format = formatArr.join(MapConfig.lightSymbol);
                    break;
                case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_MEDIUM:
                    format = formatArr.join(MapConfig.mediumSymbol);
                    break;
                case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_HEAVY:
                    format = formatArr.join(MapConfig.heavySymbol);
                    break;
                case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_TD:
                    format = formatArr.join(MapConfig.tdSymbol);
                    break;
                case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_SPG:
                    format = formatArr.join(MapConfig.spgSymbol);
                    break;
                case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_VEH_CLASS_SUPER:
                    format = formatArr.join(MapConfig.superSymbol);
                    break;
            }
        }

        return Utils.fixImgTag(format);
    }
}