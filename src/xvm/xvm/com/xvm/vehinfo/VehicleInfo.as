/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.vehinfo
{
    import org.idmedia.as3commons.util.StringUtils;
    import com.xvm.*;
    import com.xvm.types.cfg.CVehicleNames;

    public class VehicleInfo
    {
        // icon = "ussr-IS-3"
        // return: "IS-3"
        public static function getShortVehicleName(icon: String): String
        {
            if (!icon)
                return null;
            icon = icon.slice(icon.indexOf("-") + 1);
            icon = StringUtils.trim(icon);
            return icon;
        }

        // icon = "ussr-IS-3"
        // return: "ussr_IS_3"
        public static function getVehicleKey1(icon:String):String
        {
            if (!icon)
                return null;
            icon = icon.replace("-", "_");
            icon = StringUtils.trim(icon);
            return icon;
        }

        // icon = "ussr-IS-3"
        // return: "is_3"
        public static function getVehicleKey2(icon:String):String
        {
            if (!icon)
                return null;
            icon = getShortVehicleName(icon);
            icon = icon.replace("-", "_");
            icon = icon.toLowerCase();
            return icon;
        }

        // vname = "IS-3"
        // return: "is_3"
        public static function getVehicleKey2ByVname(vname:String):String
        {
            if (!vname)
                return null;
            vname = StringUtils.trim(vname);
            vname = vname.replace("-", "_");
            vname = vname.toLowerCase();
            return vname;
        }


        public static function getVehicleNamesData():CVehicleNames
        {
            var result:CVehicleNames = new CVehicleNames();
            for (var vname:String in VehicleInfoData.data)
                result[vname] = {name:VehicleInfoData.data[vname].name, short:VehicleInfoData.data[vname].short};
            return result;
        }

        public static function mapVehicleName(icon:String, originalName:String):String
        {
            try
            {
                return Config.config.vehicleNames[getVehicleKey1(icon)].name || originalName;
            }
            catch (ex:Error)
            {
            }
            return originalName;
        }

        // icon = "ussr-IS-3.png" or "../maps/icons/vehicle/contour/ussr-IS-3.png"
        public static function getInfo1(icon: String): Object
        {
            return VehicleInfoData.data[getVehicleKey1(icon)] || null;
        }

        // icon = "ussr-IS-3.png" or "../maps/icons/vehicle/contour/ussr-IS-3.png"
        public static function getInfo2ByIcon(icon:String):Object
        {
            return _getInfo2(getVehicleKey2(icon));
        }

        public static function getInfo2ByVname(vname:String):Object
        {
            return _getInfo2(getVehicleKey2ByVname(vname));
        }

        public static function getInfo2ByVid(vid:Number):Object
        {
            return _getInfo2(VehicleInfoData2.vidToVname[vid]);
        }

        private static function _getInfo2(vn:String):Object
        {
            var res:Object = VehicleInfoData2.data[vn];
            if (!res)
                return null;
            res.avg = VehicleInfoDataAvg.data[vn] || null;
            res.top = VehicleInfoDataTop.data[vn] || null;
            return res;
        }

        public static function GetVTypeValue(icon:String):String
        {
            var vi2:Object = getInfo2ByIcon(icon);
            if (vi2 == null)
                return "";
            var vtype:String = vi2.type;
            if (!vtype || !Config.config.texts.vtype[vtype])
                return "";
            return Config.config.texts.vtype[vtype];
        }

/*
        public static function mapVehicleName2(tankName:String, originalName:String):String
        {
                return Config.s_config.vehicleNames[tankName].name || originalName;
        }

        public static function mapVehicleShortName(vehicleShortName:String,originalName:String):String
        {
            try
            {
                return Config.s_config.vehicleNames[vehicleShortName].short || VehicleInfoData.data[vehicleShortName].short || originalName;
            }
            catch (ex:Error)
            {
                return originalName;
            }
        }

        public static function GetVTypeValue2(iconSource:String): String
        {
            var vi2 = com.xvm.VehicleInfo.getInfo2(iconSource);
            if (vi2 == null)
                return "";
            var vtype = vi2.type;
            if (!vtype)
                return "";
            return vtype;
        }
        }*/
    }
}
