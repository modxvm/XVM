import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 2.12
 * DATE: 10/2/2009
 * AS2
 * UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.BezierPlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	static private var _RAD2DEG : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _orientData : Array;
	/** @private **/
	private var _orient : Boolean;
	/** @private used for orientToBezier projections **/
	private var _future : Object;
	/** @private **/
	private var _beziers : Object;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function BezierPlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/** @private **/
	private function init(tween:TweenLite, beziers:Array, through:Boolean) : Void;

	/**
		 * Helper method for translating control points into bezier information.
		 * 
		 * @param props Object containing a property corresponding to each one you'd like bezier paths for. Each property's value should be a single Array with the numeric point values (i.e. <code>props.x = [12,50,80]</code> and <code>props.y = [50,97,158]</code>). 
		 * @param through If you want the paths drawn THROUGH the supplied control points, set this to true.
		 * @return A new object with an Array of values for each property. The first element in the Array is the start value, the second is the control point, and the 3rd is the end value. (i.e. <code>returnObject.x = [[12, 32, 50}, [50, 65, 80]]</code>)
		 */
	static public function parseBeziers(props:Object, through:Boolean) : Object;

	/** @private **/
	public function killProps(lookup:Object) : Void;

}