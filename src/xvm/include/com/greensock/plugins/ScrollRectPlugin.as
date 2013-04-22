import flash.geom.Rectangle;
import com.greensock.*;
import com.greensock.plugins.TweenPlugin;
/**
 * VERSION: 1.03
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.ScrollRectPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _target : MovieClip;
	/** @private **/
	private var _rect : Rectangle;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function ScrollRectPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}