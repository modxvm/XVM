import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 0.1
 * DATE: 2010-04-29
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com
 **/
intrinsic class com.greensock.plugins.FrameForwardPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _start : Number;
	/** @private **/
	private var _change : Number;
	/** @private **/
	private var _max : Number;
	/** @private **/
	private var _target : MovieClip;
	/** @private Allows FrameBackwardPlugin to extend this class and only use an extremely small amount of kb (because the functionality is combined here) **/
	private var _backward : Boolean;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function FrameForwardPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}