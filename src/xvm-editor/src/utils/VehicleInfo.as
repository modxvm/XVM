/**
 * ...
 * @author sirmax2
 */
package utils
{

public class VehicleInfo
{
    public static function getVehicleNamesData():Object
    {
        var result:Object = {};
        for (var vname:String in VehicleInfoData.data)
        {
            result[vname] = VehicleInfoData.data[vname].name;
        }
        return result;
    }
}

}
