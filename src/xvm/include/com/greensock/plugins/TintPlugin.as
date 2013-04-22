import com.greensock.*;
import com.greensock.core.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.3
 * DATE: 2011-09-15
 * AS2 
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/
intrinsic class com.greensock.plugins.TintPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _color : Color;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function TintPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function init(target:Object, end:Object) : Void;

}