/**
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Utils;
import wot.utils.VehicleInfoData;
import wot.utils.VehicleInfoData2;
import wot.utils.VehicleInfoDataAvg;
import wot.utils.VehicleInfoDataTop;

class wot.utils.VehicleInfo
{
    // icon = "../maps/icons/vehicle/contour/usa-M24_Chaffee.tga"
    // return: "usa-M24_Chaffee"
    public static function getVehicleName(icon: String): String
    {
        icon = icon.slice(icon.lastIndexOf("/") + 1, icon.lastIndexOf("."));
        icon = Utils.trim(icon);
        return icon;
    }

    // icon = "../maps/icons/vehicle/contour/usa-M24_Chaffee.tga"
    public static function getInfo1(icon: String): Object
    {
        return VehicleInfoData.data[getName1(icon)] || null;
    }

    // icon = "../maps/icons/vehicle/contour/usa-M24_Chaffee.tga"
    public static function getInfo2(icon: String): Object
    {
        var vn = getName2(icon);
        var res = VehicleInfoData2.data[vn];
        if (!res)
            return null
        res.avg = VehicleInfoDataAvg.data[vn] || null;
        res.top = VehicleInfoDataTop.data[vn] || null;
        return res;
    }

    public static function getVehicleNamesData():Object
    {
        var result:Object = {};
        for (var vname:String in VehicleInfoData.data)
            result[vname] = VehicleInfoData.data[vname].name;
        return result;
    }

    public static function mapVehicleName(iconSource:String, originalName:String):String
    {
        try
        {
            return Config.s_config.vehicleNames[getName1(iconSource)] || originalName;
        }
        catch (ex:Error)
        {
            return originalName;
        }
    }

    public static function GetVTypeValue(iconSource:String): String
    {
        var vi2 = wot.utils.VehicleInfo.getInfo2(iconSource);
        if (vi2 == null)
            return "";
        var vtype = vi2.type;
        if (!vtype || !Config.s_config.texts.vtype[vtype])
            return "";
        return Config.s_config.texts.vtype[vtype];
    }
    
    // icon = "../maps/icons/vehicle/contour/usa-M24_Chaffee.tga"
    // return: "m24_chaffee"
    public static function getName2(icon: String): String
    {
        icon = icon.slice(icon.lastIndexOf("/") + 1, icon.lastIndexOf("."));
        icon = icon.slice(icon.indexOf("-") + 1);
        icon = Utils.trim(icon);
        icon = icon.split("-").join("_").toLowerCase();
        return icon;
    }

    // icon = "../maps/icons/vehicle/contour/usa-M24_Chaffee.tga"
    // return: "usa_M24_Chaffee"
    public static function getName1(icon: String): String
    {
        icon = icon.slice(icon.lastIndexOf("/") + 1, icon.lastIndexOf("."));
        icon = icon.split("-").join("_");
        icon = Utils.trim(icon);
        return icon;
    }
}

