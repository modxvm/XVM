import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.12
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.FramePlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	public var frame : Number;
	/** @private **/
	private var _target : MovieClip;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function FramePlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}