import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.3
 * DATE: 2011-08-02
 * AS2 
 * UPDATES AND DOCS AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.ShortRotationPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;

	/** @private **/
	public function ShortRotationPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function initRotation(target:Object, propName:String, start:Number, end:Number, useRadians:Boolean) : Void;

}