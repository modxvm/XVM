import com.xvm.JSONx;
import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.Macros;
import com.xvm.StatData;
import com.xvm.Utils;
import com.xvm.VehicleInfo;
intrinsic class com.xvm.StatLoader
{
	static public var s_players_count : Object;
	static public var teams : Object;
	static private var s_loading : Object;
	static private var dirty : Boolean;

	static public function AddPlayerData(data:Object, team:Number);

	static public function StartLoadData();

	static private function StartLoadDataInternal();

	static private function LoadStatDataCallback(event);

	static public function CalculateStatValues(stat, forceTeff) : Object;

	static public function LoadLastStat(event);

	static private function GetPlayersCallback(event);

	static private function ProcessForFogOfWar(event);

	static public function LoadUserData(value, isId);

	static private function LoadUserDataCallback(event, value, isId);

}