import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.12
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.HexColorsPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _colors : Array;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function HexColorsPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function initColor(target:Object, propName:String, start:Number, end:Number) : Void;

	/** @private **/
	public function killProps(lookup:Object) : Void;

}