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

        // <280ms
        for (var tankKey:String in VehicleInfoData2.data) {
            var nation:String = (VehicleInfoData2.data[tankKey].nation == "uk" ? "gb" : VehicleInfoData2.data[tankKey].nation);
            var tmp:String = Localization.makeString("#" + nation + "_vehicles:" + VehicleInfoData2.data[tankKey].name, { } );
            var tmpShort:String = Localization.makeString("#" + nation + "_vehicles:" + VehicleInfoData2.data[tankKey].name + "_short", { } );
            _localizedNameList[tmp] = _localizedNameList[tmpShort] = tankKey;
        }
    }
}
