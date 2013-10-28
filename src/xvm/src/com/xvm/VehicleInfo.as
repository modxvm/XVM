/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.veh.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.StringUtils;

    public class VehicleInfo
    {
        // PUBLIC

        public static function populateData():void
        {
            Cmd.getVehicleInfoData(instance, instance.onVehicleInfoData);
        }

        public static function get(vId:int):VehicleData
        {
            return instance._get(vId);
        }

        public static function getByIcon(icon:String):VehicleData
        {
            return instance._getByIcon(icon);
        }

        public static function getByLocalizedShortName(localizedShortName:String):VehicleData
        {
            return instance._getByLocalizedShortName(localizedShortName);
        }

        // PRIVATE

        private var vehicles:Object;
        private var vehiclesMapKey:Object;
        private var vehiclesMapName:Object;

        // instance
        private static var _instance:VehicleInfo = null;
        private static function get instance():VehicleInfo
        {
            if (_instance == null)
                _instance = new VehicleInfo();
            return _instance;
        }

        public function VehicleInfo()
        {
            //Logger.add("VehicleInfo::ctor()")
            this.vehicles = {};
            this.vehiclesMapKey = {};
            this.vehiclesMapName = {};
        }

        private function onVehicleInfoData(json_str:String):void
        {
            //Logger.add("onVehicleInfoData(): " + json_str);
            try
            {
                var data_array:Object = JSONx.parse(json_str);
                for each (var obj:Object in data_array)
                {
                    var data:VehicleData = new VehicleData(obj);

                    var preferredNames:Object = Config.config.vehicleNames[data.key];
                    if (preferredNames != null)
                    {
                        if (preferredNames['name'] != null && preferredNames['name'] != '')
                            data.localizedName = preferredNames['name'];
                        if (preferredNames['short'] != null && preferredNames['short'] != '')
                            data.shortName = preferredNames['short'];
                    }

                    //Logger.addObject(data);

                    vehicles[data.vid] = data;
                    vehiclesMapKey[data.key] = data.vid; // for getByIcon()
                    vehiclesMapName[data.localizedShortName] = data.vid; // for getByLocalizedShortName()
                }
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }

        private function _get(vId:int):VehicleData
        {
            return vehicles[vId];
        }

        private function _getByIcon(icon:String):VehicleData
        {
            // icon: "ussr-IS-3"
            //   or  "../maps/icons/vehicle/contour/ussr-IS-3.png"
            // key: "ussr:IS-3"
            var n:int = icon.lastIndexOf("/");
            if (n > 0)
                icon = icon.substring(n + 1);
            n = icon.indexOf(".");
            if (n > 0)
                icon = icon.substring(0, n);
            icon = icon.replace("-", ":");
            return vehicles[vehiclesMapKey[icon]];
        }

        private function _getByLocalizedShortName(localizedShortName:String):VehicleData
        {
            // localizedShortName: "ИС-3"
            return vehicles[vehiclesMapName[localizedShortName]];
        }
    }
}
