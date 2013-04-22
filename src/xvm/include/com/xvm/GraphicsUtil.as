import flash.geom.ColorTransform;
import flash.filters.DropShadowFilter;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.Utils;
/**
 * ...
 * @author sirmax2
 */
intrinsic class com.xvm.GraphicsUtil
{
	static public function createShadowFilter(distance:Number, angle:Number, color:Number, alpha:Number, size:Number, strength:Number) : DropShadowFilter;

	static public function colorByRatio($value:Number, $start:Number, $end:Number) : Number;

	static public function setColor(item:Object, col:Number, ratio:Number);

	static public function brightenColor(hexColor:Number, percent:Number) : Number;

	static public function darkenColor(hexColor:Number, percent:Number) : Number;

	static public function rgbToHex(r:Number, g:Number, b:Number) : Number;

	static public function hexToRgb(hex:Number) : Object;

	static public function brightness(hex:Number) : Number;

	static public function GetVTypeColorValue(iconSource:String, vtype:String, prefix:String, darker:Boolean) : String;

	static public function GetDmgSrcValue(damageSource:String, damageDest:String, isDead:Boolean, isBlowedUp:Boolean, prefix:String) : String;

	static public function GetDmgKindValue(dmg_kind:String, prefix:String) : String;

	static public function GetDynamicColorValueInt(type:Number, value:Number, darker:Boolean) : Number;

	static public function GetDynamicColorValue(type:Number, value:Number, prefix:String, darker:Boolean) : String;

	static public function GetDynamicAlphaValue(type:Number, value:Number) : Number;

	static public function fillRect(target:MovieClip, x:Number, y:Number, width:Number, height:Number, color:Number, alpha:Number);

}