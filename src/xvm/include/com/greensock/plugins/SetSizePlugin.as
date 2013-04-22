import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.12
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.SetSizePlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	public var width : Number;
	/** @private **/
	public var height : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _setWidth : Boolean;
	/** @private **/
	private var _setHeight : Boolean;
	/** @private **/
	private var _hasSetSize : Boolean;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function SetSizePlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function killProps(lookup:Object) : Void;

}