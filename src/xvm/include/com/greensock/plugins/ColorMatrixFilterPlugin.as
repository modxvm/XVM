import flash.filters.*;
import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 2.0
 * DATE: 8/18/2009
 * AS2
 * UPDATES AND MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.ColorMatrixFilterPlugin extends FilterPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	static private var _propNames : Array;
	/** @private **/
	static private var _idMatrix : Array;
	/** @private **/
	static private var _lumR : Number;
	/** @private **/
	static private var _lumG : Number;
	/** @private **/
	static private var _lumB : Number;
	/** @private **/
	private var _matrix : Array;
	/** @private **/
	private var _matrixTween : EndArrayPlugin;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function ColorMatrixFilterPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	static public function colorize(m:Array, color:Number, amount:Number) : Array;

	/** @private **/
	static public function setThreshold(m:Array, n:Number) : Array;

	/** @private **/
	static public function setHue(m:Array, n:Number) : Array;

	/** @private **/
	static public function setBrightness(m:Array, n:Number) : Array;

	/** @private **/
	static public function setSaturation(m:Array, n:Number) : Array;

	/** @private **/
	static public function setContrast(m:Array, n:Number) : Array;

	/** @private **/
	static public function applyMatrix(m:Array, m2:Array) : Array;

}