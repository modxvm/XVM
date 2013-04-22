import com.natecook.Sprintf;
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.GraphicsUtil;
import com.xvm.Locale;
import com.xvm.Utils;
import com.xvm.VehicleInfo;
import com.xvm.StatData;
intrinsic class com.xvm.Macros
{
	static private var data_provider : Object;
	public var formatArr : Array;

	static public function Format(playerName, format:String, options:Object) : String;

	/**
     * @param pname !!!NORMALIZED player name (Utils.GetNormalizedPlayerName(playerName))!!!
     */
	static public function RegisterPlayerData(pname:String, data:Object, team:Number);

	static public function RegisterStatMacros(playerName:String, stat:Object);

	static private function modXvmDevLabel(nick:String) : String;

	static public function damageFlagToDamageSource(damageFlag:Number) : String;

}