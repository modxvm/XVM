/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.*;

class com.xvm.VehicleInfo
{
    // PUBLIC

    public static function onVehicleInfoData(json_str:String)
    {
        instance._onVehicleInfoData(json_str);
    }

    public static function get(vid:Number):VehicleData
    {
        return instance._get(vid);
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

    public static function getVIconName(vkey:String):String
    {
        // vkey = ussr:KV-220_action
        // return: ussr-KV-220_action
        if (!vkey)
            return "";
        return vkey.split(":").join("-");
    }

    // PRIVATE

    public static var initialized:Boolean = false;

    private var vehicles:Object;

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
    }

    private function _onVehicleInfoData(json_str:String)
    {
        //Logger.add("onVehicleInfoData(): " + json_str);
        try
        {
            initialized = true;
            var data_array:Object = JSONx.parse(json_str);
            for (var n in data_array)
            {
                var obj:Object = data_array[n];
                var data:VehicleData = new VehicleData(obj);

                var preferredNames:Object = Config.config.vehicleNames[data.key.split(':').join('-')];
                if (preferredNames != null)
                {
                    if (preferredNames['name'] != null && preferredNames['name'] != '')
                        data.localizedName = preferredNames['name'];
                    if (preferredNames['short'] != null && preferredNames['short'] != '')
                        data.shortName = preferredNames['short'];
                }

                //Logger.addObject(data);

                vehicles[data.vid] = data;
            }
        }
        catch (ex)
        {
            Logger.add(Utils.parseError(ex));
        }
    }

    private function _get(vid:Number):VehicleData
    {
        return vehicles[vid];
    }
}
