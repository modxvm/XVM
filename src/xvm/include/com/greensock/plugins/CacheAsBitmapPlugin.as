import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 0.9
 * DATE: 2010-07-28
 * ACTIONSCRIPT VERSION: 2.0
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.CacheAsBitmapPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _target : MovieClip;
	/** @private **/
	private var _tween : TweenLite;
	/** @private **/
	private var _cacheAsBitmap : Boolean;
	/** @private **/
	private var _initVal : Boolean;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function CacheAsBitmapPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}