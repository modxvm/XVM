/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.vehinfo
{
    import org.idmedia.as3commons.util.StringUtils;
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.utils.*;
    import com.xvm.types.cfg.CVehicleNames;
    import com.xvm.types.veh.*;

    public class VehicleInfo
    {
        // PUBLIC

        public static function populateData():void
        {
            Cmd.getVehicleInfoData(instance, instance.onVehicleInfoData);
        }

        // PRIVATE

        // instance
        private static var _instance:VehicleInfo = null;
        private static function get instance():VehicleInfo
        {
            if (_instance == null)
                _instance = new VehicleInfo();
            return _instance;
        }

        private function onVehicleInfoData(json_str:String):void
        {
            //Logger.add("onVehicleInfoData(): " + str_data);
            try
            {
                //var data:VehicleData = ObjectConverter.convertData(JSONx.parse(json_str), VehicleData);
                //Logger.addObject(data);
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }

        // TODO: complete refactoring. Use python to get values online.

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
            icon = icon.replace(/-/g, "_");
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
            icon = icon.replace(/-/g, "_");
            icon = icon.toLowerCase();
            return icon;
        }

        // vn = "IS-3"
        // return: "is_3"
        public static function getVehicleKey2ByVn(vn:String):String
        {
            if (!vn)
                return null;
            vn = StringUtils.trim(vn);
            vn = vn.replace(/-/g, "_");
            vn = vn.toLowerCase();
            return vn;
        }


        public static function getVehicleNamesData():CVehicleNames
        {
            var result:CVehicleNames = new CVehicleNames();
            for (var vn:String in VehicleInfoData.data)
                result[vn] = {name:VehicleInfoData.data[vn].name, short:VehicleInfoData.data[vn].short};
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

        // icon = "ussr-IS-3"
        public static function getInfo1(icon: String): Object
        {
            return VehicleInfoData.data[getVehicleKey1(icon)] || null;
        }

        // icon = "ussr-IS-3"
        public static function getInfo2ByIcon(icon:String):Object
        {
            return _getInfo2(getVehicleKey2(icon));
        }

        public static function getInfo2ByVn(vn:String):Object
        {
            return _getInfo2(getVehicleKey2ByVn(vn));
        }

        public static function getInfo2ByVid(vid:Number):Object
        {
            if (isNaN(vid))
                return null;
            // TODO: what is in the 1st bit?
            vid = vid & ~1;
            return _getInfo2(VehicleInfoData2.vidToVname[vid]);
        }

        private static function _getInfo2(vn:String):Object
        {
            var res:Object = VehicleInfoData2.data[vn];
            //Logger.add(vn + " " + String(res));
            if (!res)
                return null;
            res.avg = VehicleInfoDataAvg.data[vn] || {};
            res.top = VehicleInfoDataTop.data[vn] || {};
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
