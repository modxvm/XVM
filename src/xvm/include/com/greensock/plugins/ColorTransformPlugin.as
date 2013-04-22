import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.7
 * DATE: 2011-09-15
 * AS2
 * UPDATES AND MORE DOCS AT: http://www.greensock.com
 **/
intrinsic class com.greensock.plugins.ColorTransformPlugin extends TintPlugin
{
	/** @private **/
	static public var API : Number;

	/** @private **/
	public function ColorTransformPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}