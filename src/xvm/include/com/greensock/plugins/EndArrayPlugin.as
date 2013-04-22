import com.greensock.*;
import com.greensock.plugins.*;
import com.greensock.plugins.helpers.*;
/**
 * VERSION: 1.53
 * DATE: 10/2/2009
 * AS2 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.EndArrayPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _a : Array;
	/** @private **/
	private var _info : Array;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function EndArrayPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function init(start:Array, end:Array) : Void;

}