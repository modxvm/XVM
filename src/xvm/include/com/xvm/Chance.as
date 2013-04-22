import com.xvm.Defines;
import com.xvm.Config;
import com.xvm.GraphicsUtil;
import com.xvm.Locale;
import com.xvm.StatData;
import com.xvm.VehicleInfo;
/**
 * ...
 * @author Maxim Schedriviy
 */
intrinsic class com.xvm.Chance
{
	static private var DEBUG_EXP : Object;
	static private var battleTier : Number;
	static public var lastChances : Object;
	static private var _x1Logged : Object;
	static private var _x2Logged : Object;

	static public function ShowChance(tf:TextField, showExp:Boolean) : String;

	static public function ChanceError(text:String) : String;

	static public function GetChanceText(showExp:Boolean) : String;

	static private function GetChance(chanceFunc:Function) : Object;

	static private function ChanceFuncG(vi1, vi2, team, stat, dead) : Number;

	static private function ChanceFuncT(vi1, vi2, team, stat, dead) : Number;

	static private function ChanceFuncX1(vi1, vi2, team, stat, dead) : Number;

	static private function ChanceFuncX2(vi1, vi2, team, stat, dead) : Number;

	static private function CalculateTeamPlayersCount() : Object;

	static private function PrepareChanceResults(Ea, Ee, chanceFunc);

	static private function GuessBattleTier() : Number;

	static private function FormatChangeText(txt, chance);

}