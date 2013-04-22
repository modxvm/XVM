import com.xvm.Comm;
import com.xvm.Defines;
intrinsic class com.xvm.StatsLogger
{
	static private var resultsMapping : Object;
	static private var resultsCommonMapping : Object;
	static private var resultsPlayerMapping : Object;
	static private var resultsShotsMapping : Object;
	static private var statPlayerMapping : Object;

	static public function saveStatistics(key:String, data:Object);

	static private function mapData(data:Object, fieldName:String);

}