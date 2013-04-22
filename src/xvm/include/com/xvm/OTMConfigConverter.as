import com.xvm.Utils;
/**
 * ...
 * @author sirmax2
 */
intrinsic class com.xvm.OTMConfigConverter
{
	static private var otm : Object;
	static private var xvm : Object;
	static private var otmComponentsMap : Array;
	static private var xp_status_mode_ally : Array;
	static private var xp_status_mode_enemy : Array;

	static public function convert(otm:Object);

	static public function int(path:String, defaultValue:Number) : Number;

	static public function bool(path:String, defaultValue:Boolean) : Boolean;

	static public function string(path:String, defaultValue:String) : String;

	static public function value(path:String, convertFunc:Function);

	static public function setValue(path:String, v);

	static private function Copy(otmpath:String, xvmpath:String);

	static private function CopyX(otmpath:String, xvmpaths:Array, xvmpath_suffix:String);

	static private function ConvertComponents();

	static private function ConvertBehavior();

	static private function GetTextField(team:String, mode:String, fieldName:String);

	static private function GetInfoTextField(infoText, ocp);

	static private function GetInfoTextFields(team, mode);

	static private function ConvertTextFields();

}