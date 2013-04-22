import com.greensock.*;
import com.greensock.plugins.*;
import flash.filters.*;
/**
 * VERSION: 2.01
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.GlowFilterPlugin extends FilterPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	static private var _propNames : Array;

	/** @private **/
	public function GlowFilterPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}