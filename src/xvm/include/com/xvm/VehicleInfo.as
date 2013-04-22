import com.xvm.Config;
import com.xvm.Utils;
import com.xvm.VehicleInfoData;
import com.xvm.VehicleInfoData2;
import com.xvm.VehicleInfoDataAvg;
import com.xvm.VehicleInfoDataTop;
/**
 * @author sirmax2
 */
intrinsic class com.xvm.VehicleInfo
{
	static public function getVehicleName(icon:String) : String;

	static public function getInfo1(icon:String) : Object;

	static public function getInfo2(icon:String) : Object;

	static public function getVehicleNamesData() : Object;

	static public function mapVehicleName(iconSource:String, originalName:String) : String;

	static public function GetVTypeValue(iconSource:String) : String;

	static public function getName2(icon:String) : String;

	static public function getName1(icon:String) : String;

}