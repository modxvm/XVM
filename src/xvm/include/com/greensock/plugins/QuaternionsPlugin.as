import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.2
 * DATE: 2011-01-05
 * AS2
 * UPDATES AND DOCS AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.QuaternionsPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	static private var _RAD2DEG : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _quaternions : Array;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function QuaternionsPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function initQuaternion(start:Object, end:Object, propName:String) : Void;

	/** @private **/
	public function killProps(lookup:Object) : Void;

}