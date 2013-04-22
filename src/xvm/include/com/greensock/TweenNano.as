/**
 * VERSION: 1.06
 * DATE: 2011-01-12
 * AS2 (AS3 is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/
intrinsic class com.greensock.TweenNano
{
	/** @private **/
	static private var version : Number;
	/** @private **/
	static private var _time : Number;
	/** @private **/
	static private var _frame : Number;
	/** @private Holds references to all our tweens based on their targets (an Array for each target) **/
	static private var _masterList : Object;
	/** @private A reference to the Shape that we use to drive all our ENTER_FRAME events. **/
	static private var _timingClip : MovieClip;
	/** @private Indicates whether or not the TweenNano class has been initted. **/
	static private var _tnInitted : Boolean;
	/** @private **/
	static private var _reservedProps : Object;
	/** @private **/
	static private var _cnt : Number;
	/** Duration of the tween in seconds (or in frames if "useFrames" is true). **/
	public var duration : Number;
	/** Stores variables (things like "alpha", "y" or whatever we're tweening, as well as special properties like "onComplete"). **/
	public var vars : Object;
	/** @private Start time in seconds (or frames for frames-based tweens) **/
	public var startTime : Number;
	/** Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. **/
	public var target : Object;
	/** @private Indicates whether or not the tween is currently active **/
	public var active : Boolean;
	/** @private Flagged for garbage collection **/
	public var gc : Boolean;
	/** Indicates that frames should be used instead of seconds for timing purposes. So if useFrames is true and the tween's duration is 10, it would mean that the tween should take 10 frames to complete, not 10 seconds. **/
	public var useFrames : Boolean;
	/** @private Target ID (a way to identify each end target, i.e. "t1", "t2", "t3") **/
	public var endTargetID : String;
	/** @private result of _ease(this.time, 0, 1, this.duration). Usually between 0 and 1, but not always (like with Elastic.easeOut). **/
	public var ratio : Number;
	/** @private Easing method to use which determines how the values animate over time. Examples are Elastic.easeOut and Strong.easeIn. Many are found in the fl.motion.easing package or com.greensock.easing. **/
	private var _ease : Function;
	/** @private Indicates whether or not init() has been called (where all the tween property start/end value information is recorded) **/
	private var _initted : Boolean;
	/** @private Contains parsed data for each property that's being tweened (property name, start, and change) **/
	private var _propTweens : Array;

	/**
		 * Constructor
		 *  
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if "useFrames" is true)
		 * @param vars An object containing the end values of the properties you're tweening, like {_x:100, _y:50}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 */
	public function TweenNano(target:Object, duration:Number, vars:Object);

	/**
		 * @private
		 * Initializes the property tweens, determining their start values and amount of change. 
		 * Also triggers overwriting if necessary and sets the _hasUpdate variable.
		 */
	public function init() : Void;

	/**
		 * Renders the tween at a particular time (or frame number for frames-based tweens)
		 * WITHOUT changing its startTime, meaning if the tween is in progress when you call
		 * renderTime(), it will not adjust the tween's timing to continue from the new time. 
		 * The time is based simply on the overall duration. For example, if a tween's duration
		 * is 3, renderTime(1.5) would render it at the halfway finished point.
		 * 
		 * @param time time (or frame number for frames-based tweens) to render.
		 */
	public function renderTime(time:Number) : Void;

	/**
		 * Forces the tween to completion.
		 * 
		 * @param skipRender To skip rendering the final state of the tween, set skipRender to true. 
		 */
	public function complete(skipRender:Boolean) : Void;

	/** Kills the tween, stopping it immediately. **/
	public function kill() : Void;

	/**
		 * Static method for creating a TweenNano instance which can be more intuitive for some developers 
		 * and shields them from potential garbage collection issues that could arise when assigning a
		 * tween instance to a variable that persists. The following lines of code all produce exactly 
		 * the same result: <br /><br /><code>
		 * 
		 * var myTween:TweenNano = new TweenNano(mc, 1, {_x:100}); <br />
		 * TweenNano.to(mc, 1, {_x:100}); <br />
		 * var myTween:TweenNano = TweenNano.to(mc, 1, {_x:100});</code>
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or frames if "useFrames" is true)
		 * @param vars An object containing the end values of the properties you're tweening, like {_x:100, _y:50}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenNano instance
		 */
	static public function to(target:Object, duration:Number, vars:Object) : TweenNano;

	/**
		 * Static method for creating a TweenNano instance that tweens in the opposite direction
		 * compared to a TweenNano.to() tween. In other words, you define the START values in the 
		 * vars object instead of the end values, and the tween will use the current values as 
		 * the end values. This can be very useful for animating things into place on the stage
		 * because you can build them in their end positions and do some simple TweenNano.from()
		 * calls to animate them into place. <b>NOTE:</b> By default, <code>immediateRender</code>
		 * is <code>true</code> in from() tweens, meaning that they immediately render their starting state 
		 * regardless of any delay that is specified. You can override this behavior by passing 
		 * <code>immediateRender:false</code> in the <code>vars</code> object so that it will wait to 
		 * render until the tween actually begins. To illustrate the default behavior, the following code 
		 * will immediately set the <code>alpha</code> of <code>mc</code> to 0 and then wait 2 seconds 
		 * before tweening the <code>alpha</code> back to 1 over the course of 1.5 seconds:<br /><br /><code>
		 * 
		 * TweenNano.from(mc, 1.5, {_alpha:0, delay:2});</code>
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or frames if "useFrames" is true)
		 * @param vars An object containing the start values of the properties you're tweening like {x:100, y:50}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenNano instance
		 */
	static public function from(target:Object, duration:Number, vars:Object) : TweenNano;

	/**
		 * Provides a simple way to call a function after a set amount of time (or frames). You can
		 * optionally pass any number of parameters to the function too. For example:<br /><br /><code>
		 * 
		 * TweenNano.delayedCall(1, myFunction, ["param1", 2]); <br />
		 * function myFunction(param1:String, param2:Number):Void { <br />
		 *     trace("called myFunction and passed params: " + param1 + ", " + param2); <br />
		 * } </code>
		 * 
		 * @param delay Delay in seconds (or frames if "useFrames" is true) before the function should be called
		 * @param onComplete Function to call
		 * @param onCompleteParams An Array of parameters to pass the function.
		 * @param onCompleteScope the scope that should be used for the delayed function call (scope basically defines what "this" refers to in the function).
		 * @param useFrames If true, the delay will be measured in frames instead of seconds.
		 * @return TweenNano instance
		 */
	static public function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array, onCompleteScope:Object, useFrames:Boolean) : TweenNano;

	/**
		 * @private
		 * Updates active tweens and activates those whose startTime is before the _time/_frame.
		 */
	static public function updateAll() : Void;

	/**
		 * Kills all the tweens of a particular object, optionally forcing them to completion too.
		 * 
		 * @param target Object whose tweens should be immediately killed
		 * @param complete Indicates whether or not the tweens should be forced to completion before being killed.
		 */
	static public function killTweensOf(target:Object, complete:Boolean) : Void;

	/** @private **/
	static public function getID(target:Object, lookup:Boolean) : String;

	/** @private **/
	static private function easeOut(t:Number, b:Number, c:Number, d:Number) : Number;

	/** 
		 * @private
		 * Subloaded SWFs in Flash Lite may not have access to _root.createEmptyMovieClip(), so we needed a way 
		 * to step through all the MovieClips on the Stage (including nested ones) until one is found that 
		 * can be used with createEmptyMovieClip(). Note: when getBytesLoaded() returns undefined, we know that
		 * the MovieClip has been deemed off-limits by the Flash Player and it won't allow createEmptyMovieClip()
		 * on that MovieClip.
		 **/
	static private function findSubloadedSWF(mc:MovieClip) : MovieClip;

}