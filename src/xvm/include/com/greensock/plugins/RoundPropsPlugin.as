import com.greensock.*;
import com.greensock.plugins.*;
import com.greensock.core.PropTween;
/**
 * VERSION: 2.01
 * DATE: 2010-12-24
 * AS2
 * UPDATES AND DOCS AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.RoundPropsPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _tween : TweenLite;

	/** @private **/
	public function RoundPropsPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	private function _initAllProps() : Void;

	/** @private **/
	private function _removePropTween(propTween:PropTween) : Void;

	/** @private **/
	public function add(object:Object, propName:String, start:Number, change:Number) : Void;

}