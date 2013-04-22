import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 2.11
 * DATE: 11/14/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.VisiblePlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _tween : TweenLite;
	/** @private **/
	private var _visible : Boolean;
	/** @private **/
	private var _initVal : Boolean;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function VisiblePlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}