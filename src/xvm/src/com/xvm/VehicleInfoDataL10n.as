/**
 * @author Mr.A
 */
import com.xvm.VehicleInfoData2;
import net.wargaming.managers.Localization;

class com.xvm.VehicleInfoDataL10n
{
    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC

    // localizedName = "Obj. 907"
    // return: "object_907"
    public static function getVehicleName(localizedName:String):String
    {
        return localizedData[localizedName] || "";
    }

    // localizedName = "Obj. 907"
    // return: "ussr_Object_907"
    public static function getVehicleNationName(localizedName:String):String
    {
        if (VehicleInfoData2.data[localizedData[localizedName]].nation != null && VehicleInfoData2.data[localizedData[localizedName]].name != null)
            return VehicleInfoData2.data[localizedData[localizedName]].nation + "_" + VehicleInfoData2.data[localizedData[localizedName]].name.split("-").join("_");
        return "";
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private static var _localizedNameList:Object;

    private static function get localizedData():Object
    {
        if (_localizedNameList == null) 
            setupData();
        return _localizedNameList;
    }

    private static function setupData():Void
    {
        _localizedNameList = new Object();

        // ~30ms
        for (var tankKey:String in VehicleInfoData2.data) {
            var transKey = VehicleInfoData2.data[tankKey].translationKey;
            if (transKey == null)
                continue;

            if transKey.lastIndexOf("_short") > -1
            {
                var name:String = Localization.makeString(transKey.slice(0, -6), { } );
                _localizedNameList[name] = tankKey;
            }
            var shortName:String = Localization.makeString(transKey, { } );
            _localizedNameList[shortName] = tankKey;
        }
    }
}
