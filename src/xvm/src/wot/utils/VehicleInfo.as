/**
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Utils;
import wot.utils.VehicleInfoData;
import wot.utils.VehicleInfoData2;
import wot.utils.VehicleInfoData3;
import wot.utils.VehicleInfoDataMapping;

class wot.utils.VehicleInfo
{
    // icon = ../maps/icons/vehicle/contour/usa-M24_Chaffee.tga
    public static function getName(str: String): String
    {
        // incoming str:
        // ../maps/icons/vehicle/contour/germany-PzVIB_Tiger_II.png
        if (Utils.endsWith(".png", str))
            str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
        str = str.split("-").join("_");
        str = Utils.trim(str);
        return str;
        // return:
        // germany_PzVIB_Tiger_II
    }

    public static function getVehicleId(str: String): String
    {
        // incoming str:
        // ../maps/icons/vehicle/contour/usa-M46_Patton.png
        // ../maps/icons/vehicle/contour/ussr-KV-5.png
        if (Utils.endsWith(".png", str))
        {
            str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
            str = str.slice(str.indexOf("-") + 1);
            str = Utils.trim(str);
            return str.toUpperCase();
            // return:
            // M46_Patton
            // KV-5
        }
        return null;
    }

    public static function getInfo(iconSource: String): Object
    {
        // iconSource:
        // ../maps/icons/vehicle/contour/ussr-KV-5.png
        return VehicleInfoData.data[getName(iconSource)] || null;
    }

    public static function getInfoFromMappedName(vehicleName: String): Object
    {
        return VehicleInfoDataMapping.data2toData[vehicleName.split("-").join("_").toLowerCase()] || null;
    }

    public static function getInfo2(vehicleName: String): Object
    {
        return VehicleInfoData2.data[vehicleName.split("-").join("_").toLowerCase()] || null;
    }

    public static function getInfo3(vehicleName: String): Object
    {
        return VehicleInfoData3.data[vehicleName.split("-").join("_").toLowerCase()] || null;
    }

/*    public static function getInfo4(vehicleName: String): Object
    {
        var vn = vehicleName.split("-").join("_").toLowerCase();
        var vi = VehicleInfoDataMapping.data2toData[vn] || null;
        if (!vi)
            return null;
        var l = vi.level;
        var t = vi.type;
        var res = { b: 0, d: 0, f: 0, s: 0, w: 0 };
        for (var i in VehicleInfoData3.data)
        {
            vi = VehicleInfoDataMapping.data2toData[i];
            if (!vi || vi.level != l || vi.type != t)
                continue;
            var vi3 = VehicleInfoData3.data[i];
            res.b += vi3.b;
            res.d += vi3.d;
            res.f += vi3.f;
            res.s += vi3.s;
            res.w += vi3.w;
        }
        return res;
    }*/

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
            return Config.s_config.vehicleNames[getName(iconSource)] || originalName;
        }
        catch (ex:Error)
        {
            return originalName;
        }
    }

    public static function GetVTypeValue(iconSource:String): String
    {
        var vi = wot.utils.VehicleInfo.getInfo(iconSource);
        if (vi == null)
            return "";
        var vtype = vi.type;
        if (!vtype || !Config.s_config.texts.vtype[vtype])
            return "";
        return Config.s_config.texts.vtype[vtype];
    }
}
