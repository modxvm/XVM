import com.xvm.Logger;
/**
 * ...
 * @author sirmax2
 */
intrinsic class com.xvm.Utils
{
	static private var TRACE_XVM_MODULES : Object;
	static private var xvmModules : Array;

	static public function startsWith(substr:String, str:String) : Boolean;

	static public function endsWith(substr:String, str:String) : Boolean;

	static public function trim(str:String) : String;

	static public function toInt(value:Object, defaultValue:Number) : Number;

	static public function toFloat(value:Object, defaultValue:Number) : Number;

	static public function toBool(value:Object, defaultValue:Boolean) : Boolean;

	static public function elapsedMSec(start, end) : Number;

	static public function fixPath(path:String) : String;

	static public function vehicleClassToVehicleType(vclass:String) : String;

	static public function indexOf(array:Array, value:Object) : Number;

	static public function padLeft(str:String, len:Number, char:String);

	static public function compareVersions(v1:String, v2:String) : Number;

	static public function GetPlayerName(fullplayername:String) : String;

	static public function GetNormalizedPlayerName(fullplayername:String) : String;

	static public function GetClanName(fullplayername:String) : String;

	static public function GetClanNameWithBrackets(fullplayername:String) : String;

	static public function TraceXvmModule(moduleName:String);

	static public function FormatDate(format:String, date:Date);

	/**
     * Get children MovieClips of MovieClip
     */
	static public function getChildrenOf(target:MovieClip, recursive:Boolean) : Array;

	/**
     * Array subtraction
     * [1,2,3,4,5,6] - [1,2,3] = [4,5,6]
     * minuend − subtrahend = difference
     */
	static public function subtractArray(minuend, subtrahend);

	/**
     * Create CSS
     */
	static public function createCSS(className:String, color:Number, fontName:String, fontSize:Number, align:String, bold:Boolean, italic:Boolean) : String;

	/**
     * Create CSS based on config
     */
	static public function createCSSFromConfig(config_font:Object, color:Number, className:String) : String;

	static public function createStyleSheet(css:String) : TextField.StyleSheet;

	static public function duplicateTextField(mc, name, textField, yOffset, align);

	static public function createButton(mc:MovieClip, name, x, y, txt, align:String) : MovieClip;

	static public function duplicateButton(src:Object, name:String, offsetX:Number, offsetY:Number, text:String, iconSource:String, toolTip:String) : MovieClip;

	static public function addEventListeners(obj:Object, target:Object, handlers:Object);

	static private function onShowTooltip(e);

	static private function onHideTooltip(e);

	static public function XEFF(value);

	static public function XWN(value);

}