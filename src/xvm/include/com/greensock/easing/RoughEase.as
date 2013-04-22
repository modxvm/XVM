import com.greensock.easing.helpers.EasePoint;
/**
 * VERSION: 0.7
 * DATE: 2011-11-29
 * AS2 (AS3 is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com/roughease/
 **/
intrinsic class com.greensock.easing.RoughEase
{
	/** @private **/
	static private var _lookup : Object;
	/** @private **/
	static private var _count : Number;
	/** @private **/
	private var _name : String;
	/** @private **/
	private var _first : EasePoint;
	/** @private **/
	private var _last : EasePoint;
	/** Easing equation to which tweens should refer. **/
	public var ease : Function;

	/** name of the RoughEase instance **/
	public function get name() : String;
	public function set name(value:String) : Void;


	/**
		 * Constructor
		 * 
		 * @param strength amount of variance from the templateEase (Linear.easeNone by default) that each random point can be placed. A low number like 0.1 will hug very closely to the templateEase whereas a larger number like 2 will allow the values to wander further away from the templateEase.
		 * @param points quantity of random points to plot in the ease. A larger number will cause more (and quicker) flickering.
		 * @param restrictMaxAndMin If true, the ease will prevent random points from exceeding the end value or dropping below the starting value. For example, if you're tweening the x property from 0 to 100, the RoughEase would force all random points to stay between 0 and 100 if restrictMaxAndMin is true, but if it is false, a x could potentially jump above 100 or below 0 at some point during the tween (it would always end at 100 though).
		 * @param templateEase an easing equation that should be used as a template or guide. Then random points are plotted at a certain distance away from the templateEase (based on the strength parameter). The default is Linear.easeNone.
		 * @param taper to make the strength of the roughness taper towards the end or beginning or both, use "out", "in", or "both" respectively here (default is "none").
		 * @param randomize to randomize the placement of the points, set randomize to true (otherwise the points will zig-zag evenly across the ease)
		 * @param name a name to associate with the ease so that you can use RoughEase.byName() to look it up later. Of course you should always make sure you use a unique name for each ease (if you leave it blank, a name will automatically be generated). 
		 */
	public function RoughEase(strength:Number, points:Number, restrictMaxAndMin:Boolean, templateEase:Function, taper:String, randomize:Boolean, name:String);

	/**
		 * This static function provides a quick way to create a RoughEase and immediately reference its ease function 
		 * in a tween, like:<br /><br /><code>
		 * 
		 * TweenLite.from(mc, 2, {_alpha:0, ease:RoughEase.create(1.5, 15)});<br />
		 * </code>
		 * 
		 * @param strength amount of variance from the templateEase (Linear.easeNone by default) that each random point can be placed. A low number like 0.1 will hug very closely to the templateEase whereas a larger number like 2 will allow the values to wander further away from the templateEase.
		 * @param points quantity of random points to plot in the ease. A larger number will cause more (and quicker) flickering.
		 * @param restrictMaxAndMin If true, the ease will prevent random points from exceeding the end value or dropping below the starting value. For example, if you're tweening the x property from 0 to 100, the RoughEase would force all random points to stay between 0 and 100 if restrictMaxAndMin is true, but if it is false, a x could potentially jump above 100 or below 0 at some point during the tween (it would always end at 100 though).
		 * @param templateEase an easing equation that should be used as a template or guide. Then random points are plotted at a certain distance away from the templateEase (based on the strength parameter). The default is Linear.easeNone.
		 * @param taper to make the strength of the roughness taper towards the end or beginning or both, use "out", "in", or "both" respectively here (default is "none").
		 * @param randomize to randomize the placement of the points, set randomize to true (otherwise the points will zig-zag evenly across the ease)
		 * @param name a name to associate with the ease so that you can use RoughEase.byName() to look it up later. Of course you should always make sure you use a unique name for each ease (if you leave it blank, a name will automatically be generated). 
		 * @return easing function
		 */
	static public function create(strength:Number, points:Number, restrictMaxAndMin:Boolean, templateEase:Function, taper:String, randomize:Boolean, name:String) : Function;

	/**
		 * Provides a quick way to look up a RoughEase by its name.
		 * 
		 * @param name the name of the RoughEase
		 * @return easing function from the RoughEase associated with the name
		 */
	static public function byName(name:String) : Function;

	/**
		 * Easing function that interpolates the numbers
		 * 
		 * @param t time
		 * @param b start
		 * @param c change
		 * @param d duration
		 * @return Result of the ease
		 */
	private function easeProxy(t:Number, b:Number, c:Number, d:Number) : Number;

	/** Disposes the RoughEase so that it is no longer stored for easy lookups by name with <code>byName()</code>, releasing it for garbage collection. **/
	public function dispose() : Void;

}