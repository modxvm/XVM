import com.xvm.Utils;
import com.xvm.VehicleInfo;
import com.xvm.VehicleInfoDataL10n;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.model.externalProxy.MapConfig;
import com.xvm.DataTypes.VehicleData;

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

        var vdata:VehicleData = VehicleInfo.getByIcon(player.icon);
        var formatArr:Array;

        /**
         * Level
         * player.level is undefined when Show Level at Game Menu is not checked.
         * PlayersPanel does not populate itself with level in that case.
         * Alternative level definition is used here.
         */
        formatArr = format.split(LEVEL_MACRO);
        if (formatArr.length > 1)
            format = formatArr.join(vdata.level.toString());

        /** Vehicle short type */
        formatArr = format.split(VEH_SHORT_MACRO);
        if (formatArr.length > 1)
            format = formatArr.join(vdata.shortName);

        /** Vehicle system name - usa-M24_Chaffee */
        formatArr = format.split(VEH_NAME);
        if (formatArr.length > 1)
            format = formatArr.join(VehicleInfo.getVIconName(vdata.key));
        formatArr = format.split(VEH_NAME_ALT);
        if (formatArr.length > 1)
            format = formatArr.join(VehicleInfo.getVIconName(vdata.key));

        /** Vehicle type readable - Chaffee */
        formatArr = format.split(VEH_MACRO);
        if (formatArr.length > 1)
            format = formatArr.join(vdata.localizedName);
        formatArr = format.split(VEH_MACRO_ALT);
        if (formatArr.length > 1)
            format = formatArr.join(vdata.localizedName);



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
