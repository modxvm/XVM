import com.greensock.*;
import com.greensock.plugins.*;
import flash.filters.*;
/**
 * VERSION: 2.0
 * DATE: 8/18/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.BlurFilterPlugin extends FilterPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	static private var _propNames : Array;

	/** @private **/
	public function BlurFilterPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}