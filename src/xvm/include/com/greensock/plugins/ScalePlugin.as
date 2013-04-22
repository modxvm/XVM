import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.02
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.ScalePlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _startX : Number;
	/** @private **/
	private var _changeX : Number;
	/** @private **/
	private var _startY : Number;
	/** @private **/
	private var _changeY : Number;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function ScalePlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	public function killProps(lookup:Object) : Void;

}