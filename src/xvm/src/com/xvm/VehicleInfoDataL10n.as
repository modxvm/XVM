/**
 * @author Mr.A
 */
import com.xvm.VehicleInfoData2;
import net.wargaming.managers.Localization;

class com.xvm.VehicleInfoDataL10n
{
    private static var data:Object;

    // name = "Об. 907"
    // return: "object_907"
    public static function LocalizedNameToVehicleKey(name:String):String
    {
        if (data == null)
            setupData();
        return data[name] || "";
    }

    private static function setupData():Void
    {
        data = new Object();

        // <280ms
        for (var tankKey:String in VehicleInfoData2.data) {
            var nation:String = (VehicleInfoData2.data[tankKey].nation == "uk" ? "gb" : VehicleInfoData2.data[tankKey].nation);
            var tmp:String = Localization.makeString("#" + nation + "_vehicles:" + VehicleInfoData2.data[tankKey].name, { } );
            var tmpShort:String = Localization.makeString("#" + nation + "_vehicles:" + VehicleInfoData2.data[tankKey].name + "_short", { } );
            data[tmp] = data[tmpShort] = tankKey;
        }
    }
}
