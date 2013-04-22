import com.greensock.*;
import com.greensock.plugins.*;
import flash.geom.*;
/**
 * VERSION: 1.02
 * DATE: 2010-10-11
 * ACTIONSCRIPT VERSION: 2 
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com
 **/
intrinsic class com.greensock.plugins.TransformMatrixPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	static private var _DEG2RAD : Number;
	/** @private **/
	private var _transform : Transform;
	/** @private **/
	private var _matrix : Matrix;
	/** @private **/
	private var _txStart : Number;
	/** @private **/
	private var _txChange : Number;
	/** @private **/
	private var _tyStart : Number;
	/** @private **/
	private var _tyChange : Number;
	/** @private **/
	private var _aStart : Number;
	/** @private **/
	private var _aChange : Number;
	/** @private **/
	private var _bStart : Number;
	/** @private **/
	private var _bChange : Number;
	/** @private **/
	private var _cStart : Number;
	/** @private **/
	private var _cChange : Number;
	/** @private **/
	private var _dStart : Number;
	/** @private **/
	private var _dChange : Number;
	/** @private **/
	private var _angleChange : Number;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function TransformMatrixPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}