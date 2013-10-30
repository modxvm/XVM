/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Cmd;
import com.xvm.Config;
import com.xvm.Strings;
import com.xvm.JSONx;
import com.xvm.DataTypes.VehicleData;
import com.xvm.Logger;

class com.xvm.VehicleInfo
{
    // PUBLIC

    public static function populateData()
    {
        Cmd.getVehicleInfoData(instance, instance.onVehicleInfoData);
    }

    public static function get(vId:Number):VehicleData
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

    public static function getVTypeValue(vtype:String):String
    {
        // vtype = HT
        if (!vtype || !Config.s_config.texts.vtype[vtype])
            return "";
        return Config.s_config.texts.vtype[vtype];
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

    private function onVehicleInfoData(json_str:String)
    {
        //Logger.add("onVehicleInfoData(): " + json_str);
        try
        {
            var data_array:Object = JSONx.parse(json_str);
            for (var n in data_array)
            {
                var obj:Object = data_array[n];
                var data:VehicleData = new VehicleData(obj);

                var preferredNames:Object = Config.s_config.vehicleNames[data.key];
                if (preferredNames != null)
                {
                    if (preferredNames['name'] != null && preferredNames['name'] != '')
                        data.localizedName = preferredNames['name'];
                    if (preferredNames['short'] != null && preferredNames['short'] != '')
                        data.shortName = preferredNames['short'];
                }

                //Logger.addObject(data);

                vehicles[data.vid] = data;
                vehiclesMapKey[data.key] = data.vid; // for getByIcon
                vehiclesMapName[data.localizedShortName] = data.vid; // for getByLocalizedShortName
            }
        }
        catch (e:Error)
        {
            Logger.add(e.message);
        }
    }

    private function _get(vId:Number):VehicleData
    {
        return vehicles[vId];
    }

    private function _getByIcon(icon:String):VehicleData
    {
        // icon: "ussr-IS-3"
        //   or  "../maps/icons/vehicle/contour/ussr-IS-3.png"
        // key: "ussr:IS-3"
        var n:Number = icon.lastIndexOf("/");
        if (n > 0)
            icon = icon.substring(n + 1);
        n = icon.indexOf(".");
        if (n > 0)
            icon = icon.substring(0, n);
        n = icon.indexOf("-");
        if (n > 0)
            icon = icon.substring(0, n) + ":" + icon.substring(n + 1);
        return vehicles[vehiclesMapKey[icon]];
    }

    private function _getByLocalizedShortName(localizedShortName:String):VehicleData
    {
        // localizedShortName: "ИС-3"
        return vehicles[vehiclesMapName[localizedShortName]];
    }

}
