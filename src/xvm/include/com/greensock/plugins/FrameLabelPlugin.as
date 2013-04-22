import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.2
 * DATE: 2011-02-03
 * AS2
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/
intrinsic class com.greensock.plugins.FrameLabelPlugin extends FramePlugin
{
	/** @private **/
	static public var API : Number;

	/** @private **/
	public function FrameLabelPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}