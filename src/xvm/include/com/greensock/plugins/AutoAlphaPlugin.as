import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 2.3
 * DATE: 10/17/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.AutoAlphaPlugin extends VisiblePlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _ignoreVisible : Boolean;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function AutoAlphaPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function killProps(lookup:Object) : Void;

}