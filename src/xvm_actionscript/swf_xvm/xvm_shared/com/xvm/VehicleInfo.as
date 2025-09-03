/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.vo.*;

    public class VehicleInfo
    {
        // PUBLIC

        public static function setVehicleInfoData(data_array:Array):void
        {
            instance.onVehicleInfoData(data_array);
        }

        public static function get(vehCD:int):VOVehicleData
        {
            return instance._get(vehCD);
        }

        public static function getByIcon(icon:String):VOVehicleData
        {
            return getByIconName(getIconName(icon));
        }

        public static function getByIconName(icon:String):VOVehicleData
        {
            return instance._getByIconName(icon);
        }

        public static function getByLocalizedShortName(localizedShortName:String):VOVehicleData
        {
            return instance._getByLocalizedShortName(localizedShortName);
        }

        public static function getVTypeText(vtype:String):String
        {
            // vtype = HT
            // return: HT text
            if (!vtype || !Config.config.texts.vtype[vtype])
                return "";
            var v:String = Config.config.texts.vtype[vtype];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);
            return v;
        }

        public static function getIconName(icon:String):String
        {
            // icon: "ussr-IS-3" or "../maps/icons/vehicle/contour/ussr-IS-3.png"
            var n:int = icon.lastIndexOf("/");
            if (n > 0)
                icon = icon.slice(n + 1);
            n = icon.indexOf(".");
            if (n > 0)
                icon = icon.slice(0, n);
            return icon;
        }

        public static function getVIconName(vkey:String):String
        {
            // vkey = ussr:KV-220_action
            // return: ussr-KV-220_action
            if (!vkey)
                return "";
            return vkey.split(":").join("-");
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

        // .ctor() should be private
        public function VehicleInfo()
        {
            //Logger.add("VehicleInfo::ctor()")
            this.clear();
        }

        private function clear():void
        {
            this.vehicles = {};
            this.vehiclesMapKey = {};
            this.vehiclesMapName = {};
        }

        private function onVehicleInfoData(data_array:Array):void
        {
            this.clear();
            if (data_array == null)
                return;
            //Logger.add("onVehicleInfoData(): " + json_str);
            try
            {
                for each (var obj:Object in data_array)
                {
                    var data:VOVehicleData = new VOVehicleData(obj);
                    var preferredNames:Object = Config.config.vehicleNames[data.key.split(":").join("-")];
                    if (preferredNames)
                    {
                        if (preferredNames["name"])
                            data.localizedName = preferredNames["name"];
                        if (preferredNames["short"])
                            data.shortName = preferredNames["short"];
                    }
                    //Logger.addObject(data);
                    vehicles[data.vehCD] = data;
                    vehiclesMapKey[data.key] = data.vehCD; // for getByIconName()
                    vehiclesMapName[data.localizedShortName] = data.vehCD; // for getByLocalizedShortName()
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function _get(vehCD:int):VOVehicleData
        {
            return vehicles[vehCD];
        }

        private function _getByIconName(iconName:String):VOVehicleData
        {
            // iconName: "ussr-IS-3"
            return vehicles[vehiclesMapKey[iconName.replace("-", ":")]];
        }

        private function _getByLocalizedShortName(localizedShortName:String):VOVehicleData
        {
            // localizedShortName: "ИС-3"
            return vehicles[vehiclesMapName[localizedShortName]];
        }
    }
}
