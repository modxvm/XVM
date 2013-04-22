import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.22
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.BezierThroughPlugin extends BezierPlugin
{
	/** @private **/
	static public var API : Number;

	/** @private **/
	public function BezierThroughPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}