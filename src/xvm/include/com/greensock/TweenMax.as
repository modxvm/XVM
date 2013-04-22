import com.greensock.*;
import com.greensock.core.*;
import com.greensock.plugins.*;
/**
 * VERSION: 11.698
 * DATE: 2012-03-27
 * AS2 (AS3 version is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com 
 **/
intrinsic class com.greensock.TweenMax extends TweenLite
{
	/** @private **/
	static public var version : Number;
	/** @private **/
	static private var _activatedPlugins : Boolean;
	/** @private OverwriteManager is optional for TweenLite but it is used by default in TweenMax so we init it here (if it isn't already enabled).**/
	static private var _overwriteMode : Number;
	/** @private **/
	static private var _pauseAllTime : Number;
	/**
		 * Kills all the tweens of a particular object, optionally completing them first.
		 * 
		 * @param target Object whose tweens should be immediately killed
		 * @param complete Indicates whether or not the tweens should be forced to completion before being killed.
		 */
	static public var killTweensOf : Function;
	/** @private **/
	static public var killDelayedCallsTo : Function;
	/** @private **/
	private var _repeat : Number;
	/** @private **/
	private var _repeatDelay : Number;
	/** @private **/
	private var _cyclesComplete : Number;
	/** 
		 * Works in conjunction with the repeat property, determining the behavior of each cycle; when yoyo is true, 
		 * the tween will go back and forth, appearing to reverse every other cycle (this has no affect on the "reversed" 
		 * property though). So if repeat is 2 and yoyo is false, it will look like: start - 1 - 2 - 3 - 1 - 2 - 3 - 1 - 2 - 3 - end. 
		 * But if repeat is 2 and yoyo is true, it will look like: start - 1 - 2 - 3 - 3 - 2 - 1 - 1 - 2 - 3 - end.  
		 **/
	public var yoyo : Boolean;

	/** 
		 * Value between 0 and 1 indicating the progress of the tween according to its duration 
 		 * where 0 is at the beginning, 0.5 is halfway finished, and 1 is finished. <code>totalProgress</code>, 
 		 * by contrast, describes the overall progress according to the tween's totalDuration 
 		 * which includes repeats and repeatDelays (if there are any). For example, if a TweenMax instance 
		 * is set to repeat once, at the end of the first cycle <code>totalProgress</code> would only be 0.5 
		 * whereas <code>progress</code> would be 1. If you tracked both properties over the course of the 
		 * tween, you'd see <code>progress</code> go from 0 to 1 twice (once for each cycle) in the same
		 * time it takes the <code>totalProgress</code> property to go from 0 to 1 once.
		 **/
	public function get currentProgress() : Number;
	public function set currentProgress(n:Number) : Void;

	/** 
		 * Value between 0 and 1 indicating the progress of the tween according to its totalDuration 
 		 * where 0 is at the beginning, 0.5 is halfway finished, and 1 is finished. <code>progress</code>, 
 		 * by contrast, describes the progress according to the tween's duration which does not
 		 * include repeats and repeatDelays. For example, if a TweenMax instance is set to repeat 
 		 * once, at the end of the first cycle <code>totalProgress</code> would only be 0.5 
		 * whereas <code>progress</code> would be 1. If you tracked both properties over the course of the 
		 * tween, you'd see <code>progress</code> go from 0 to 1 twice (once for each cycle) in the same
		 * time it takes the <code>totalProgress</code> property to go from 0 to 1 once.
		 **/
	public function get totalProgress() : Number;
	public function set totalProgress(n:Number) : Void;

	/** @inheritDoc **/
	public function get currentTime() : Number;
	public function set currentTime(n:Number) : Void;

	/**
		 * Duration of the tween in seconds (or frames for frames-based timelines) including any repeats
		 * or repeatDelays. "duration", by contrast, does NOT include repeats and repeatDelays. 
		 **/
	public function get totalDuration() : Number;
	public function set totalDuration(n:Number) : Void;

	/** Multiplier describing the speed of the timeline where 1 is normal speed, 0.5 is half-speed, 2 is double speed, etc. **/
	public function get timeScale() : Number;
	public function set timeScale(n:Number) : Void;

	/** Number of times that the tween should repeat; -1 repeats indefinitely. **/
	public function get repeat() : Number;
	public function set repeat(n:Number) : Void;

	/** Amount of time in seconds (or frames for frames-based tweens) between repeats **/
	public function get repeatDelay() : Number;
	public function set repeatDelay(n:Number) : Void;

	/** Multiplier describing the speed of the root timelines where 1 is normal speed, 0.5 is half-speed, 2 is double speed, etc. **/
	static public function get globalTimeScale() : Number;
	static public function set globalTimeScale(n:Number) : Void;


	/**
		 * Constructor
		 *  
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param vars An object containing the end values of the properties you're tweening. For example, to tween to _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 */
	public function TweenMax(target:Object, duration:Number, vars:Object);

	/**
		 * @private
		 * Initializes the property tweens, determining their start values and amount of change. 
		 * Also triggers overwriting if necessary and sets the _hasUpdate variable.
		 */
	private function init() : Void;

	/** @inheritDoc **/
	public function invalidate() : Void;

	/**
		 * Updates tweening values on the fly so that they appear to seamlessly change course even if the tween is in-progress.
		 * Think of it as dynamically updating the <code>vars</code> object that you passed in to the tween when it was originally
		 * created. You do <b>NOT</b> need to redefine all of the <code>vars</code> values - only the ones that you want
		 * to update. You can even define new properties that you didn't define in the original <code>vars</code> object. 
		 * If the <code>resetDuration</code> parameter is <code>true</code> and the tween has already started (or finished), 
		 * <code>updateTo()</code> will restart the tween. Otherwise, the tween's timing will be honored. And if
		 * <code>resetDuration</code> is <code>false</code> and the tween is in-progress, the starting values of each 
		 * property will be adjusted so that the tween appears to seamlessly redirect to the new destination values. 
		 * For example:<br /><br /><code>
		 * 
		 * //create the tween <br />
		 * var tween:TweenMax = new TweenMax(mc, 2, {_x:100, _y:200, _alpha:50});<br /><br />
		 * 
		 * //then later, update the destination _x and _y values, restarting the tween<br />
		 * tween.updateTo({_x:300, _y:0}, true);<br /><br />
		 * 
		 * //or to update the values mid-tween while keeping the end time the same (don't restart the tween), do this:<br />
		 * tween.updateTo({_x:300, _y:0}, false);<br /><br /></code>
		 * 
		 * Note: If you plan to constantly update values, please look into using the <code>DynamicPropsPlugin</code>.
		 * 
		 * @param vars Object containing properties with the end values that should be udpated. You do <b>NOT</b> need to redefine all of the original <code>vars</code> values - only the ones that should be updated (although if you change a plugin value, you will need to fully define it). For example, to update the destination <code>_x</code> value to 300 and the destination <code>_y</code> value to 500, pass: <code>{_x:300, _y:500}</code>.
		 * @param resetDuration If the tween has already started (or finished) and <code>resetDuration</code> is true, the tween will restart. If <code>resetDuration</code> is false, the tween's timing will be honored (no restart) and each tweening property's starting value will be adjusted so that it appears to seamlessly redirect to the new destination value.
		 **/
	public function updateTo(vars:Object, resetDuration:Boolean) : Void;

	/**
		 * Adjusts a destination value on the fly, optionally adjusting the start values so that it appears to redirect seamlessly
		 * without skipping/jerking (<b>this method has been deprecated in favor of <code>updateTo()</code></b>). 
		 * If you plan to constantly update values, please look into using the DynamicPropsPlugin.
		 * 
		 * @param property Name of the property that should be updated. For example, "_x".
		 * @param value The new destination value
		 * @param adjustStartValues If true, the property's start value will be adjusted to make the tween appear to seamlessly/smoothly redirect without any skipping/jerking. Beware that if start values are adjusted, reversing the tween will not make it travel back to the original starting value.
		 */
	public function setDestination(property:String, value:Object, adjustStartValues:Boolean) : Void;

	/**
		 * Allows particular properties of the tween to be killed, much like the killVars() method
		 * except that killProperties() accepts an Array of property names.
		 * 
		 * @param names An Array of property names whose tweens should be killed immediately.
		 */
	public function killProperties(names:Array) : Void;

	/**
		 * @private
		 * Renders the tween at a particular time (or frame number for frames-based tweens). 
		 * The time is based simply on the overall duration. For example, if a tween's duration
		 * is 3, renderTime(1.5) would render it at the halfway finished point.
		 * 
		 * @param time time (or frame number for frames-based tweens) to render.
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 * @param force Normally the tween will skip rendering if the time matches the cachedTotalTime (to improve performance), but if force is true, it forces a render. This is primarily used internally for tweens with durations of zero in TimelineLite/Max instances.
		 */
	public function renderTime(time:Number, suppressEvents:Boolean, force:Boolean) : Void;

	/**
		 * Static method for creating a TweenMax instance. This can be more intuitive for some developers 
		 * and shields them from potential garbage collection issues that could arise when assigning a
		 * tween instance to a variable that persists. The following lines of code produce exactly 
		 * the same result: <br /><br /><code>
		 * 
		 * 		var myTween:TweenMax = new TweenMax(mc, 1, {_x:100}); <br />
		 * 		TweenMax.to(mc, 1, {_x:100}); <br />
		 * 		var myTween:TweenMax = TweenMax.to(mc, 1, {_x:100}); <br /><br /></code>
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param vars An object containing the end values of the properties you're tweening. For example, to tween to _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenMax instance
		 */
	static public function to(target:Object, duration:Number, vars:Object) : TweenMax;

	/**
		 * Static method for creating a TweenMax instance that tweens in the opposite direction
		 * compared to a TweenMax.to() tween. In other words, you define the START values in the 
		 * vars object instead of the end values, and the tween will use the current values as 
		 * the end values. This can be very useful for animating things into place on the stage
		 * because you can build them in their end positions and do some simple TweenMax.from()
		 * calls to animate them into place. <b>NOTE:</b> By default, <code>immediateRender</code>
		 * is <code>true</code> for from() tweens, meaning that they immediately render their starting state 
		 * regardless of any delay or stagger that is specified. You can override this behavior by passing 
		 * <code>immediateRender:false</code> in the <code>vars</code> object so that it will wait to 
		 * render until the tween actually begins (often the desired behavior when inserting into timelines). 
		 * To illustrate the default behavior, the following code will immediately set the <code>_alpha</code> of <code>mc</code> 
		 * to 0 and then wait 2 seconds before tweening the <code>_alpha</code> back to 100 over the course 
		 * of 1.5 seconds:<br /><br /><code>
		 * 
		 * TweenMax.from(mc, 1.5, {_alpha:0, delay:2});</code>
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param vars An object containing the start values of the properties you're tweening. For example, to tween from _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenMax instance
		 */
	static public function from(target:Object, duration:Number, vars:Object) : TweenMax;

	/**
		 * Static method for creating a TweenMax instance that tweens from a particular set of
		 * values to another set of values, as opposed to a normal to() or from() tween which are 
		 * based on the target's current values.
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param fromVars An object containing the starting values of the properties you're tweening. For example, to tween from _x=0, _y=0, you could pass {_x:0, _y:0}.
		 * @param toVars An object containing the ending values of the properties you're tweening. For example, to tween to _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenMax instance
		 */
	static public function fromTo(target:Object, duration:Number, fromVars:Object, toVars:Object) : TweenMax;

	/**
		 * Tween multiple objects to the same end values. The "stagger" parameter 
		 * staggers the start time of each tween. For example, you might want to have 5 MovieClips move down 
		 * 100 pixels while fading out, and stagger the start times slightly by 0.2 seconds:  
		 * TweenMax.allTo([mc1, mc2, mc3, mc4, mc5], 1, {_y:"100", _alpha:0}, 0.2); <br /><br />
		 * 
		 * Note: You can easily add a group of tweens to a TimelineLite/Max instance using allTo() in conjunction with the 
		 * insertMultipe() method of a timeline, like:<br />
		 * <code>myTimeline.insertMultiple(TweenMax.allTo([mc1, mc2, mc3], 1, {_alpha:0, _y:"100"}, 0.1));</code>
		 * 
		 * @param targets An Array of objects to tween.
		 * @param duration Duration (in seconds) of the tween (or in frames for frames-based tweens)
		 * @param vars An object containing the end values of all the properties you'd like to have tweened (or if you're using the TweenMax.allFrom() method, these variables would define the BEGINNING values).
		 * @param stagger Staggers the start time of each tween. For example, you might want to have 5 MovieClips move down 100 pixels while fading out, and stagger the start times slightly by 0.2 seconds, you could do: <code>TweenMax.allTo([mc1, mc2, mc3, mc4, mc5], 1, {_y:"100", _alpha:0}, 0.2)</code>.
		 * @param onCompleteAll A function to call when all of the tweens have completed.
		 * @param onCompleteAllParams An Array of parameters to pass the onCompleteAll function when all the tweens have completed.
		 * @return Array of TweenMax tweens
		 */
	static public function allTo(targets:Array, duration:Number, vars:Object, stagger:Number, onCompleteAll:Function, onCompleteAllParams:Array, onCompleteAllScope:Object) : Array;

	/**
		 * Exactly the same as TweenMax.allTo(), but instead of tweening the properties from where they're 
		 * at currently to whatever you define, this tweens them the opposite way - from where you define TO 
		 * where ever they are when the tweens begin. This is useful when things are set up on the stage the way they should 
		 * end up and you just want to tween them into place. <b>NOTE:</b> By default, <code>immediateRender</code>
		 * is <code>true</code> for allFrom() tweens, meaning that they immediately render their starting state 
		 * regardless of any delay or stagger that is specified. You can override this behavior by passing 
		 * <code>immediateRender:false</code> in the <code>vars</code> object so that each tween will wait to render until
		 * any delay/stagger has passed (often the desired behavior when inserting into timelines). To illustrate
		 * the default behavior, the following code will immediately set the <code>_alpha</code> of <code>mc1</code>, 
		 * <code>mc2</code>, and <code>mc3</code> to 0 and then wait 2 seconds before tweening each <code>_alpha</code> 
		 * back to 100 over the course of 1.5 seconds with 0.1 seconds lapsing between the start times of each:<br /><br /><code>
		 * 
		 * TweenMax.allFrom([mc1, mc2, mc3], 1.5, {_alpha:0, delay:2}, 0.1);</code>
		 * 
		 * @param targets An Array of objects to tween.
		 * @param duration Duration (in seconds) of the tween (or in frames for frames-based tweens)
		 * @param vars An object containing the start values of all the properties you'd like to have tweened.
		 * @param stagger Staggers the start time of each tween. For example, you might want to have 5 MovieClips move down 100 pixels while fading from _alpha:0, and stagger the start times slightly by 0.2 seconds, you could do: <code>TweenMax.allFromTo([mc1, mc2, mc3, mc4, mc5], 1, {_y:"-100", _alpha:0}, 0.2)</code>.
		 * @param onCompleteAll A function to call when all of the tweens have completed.
		 * @param onCompleteAllParams An Array of parameters to pass the onCompleteAll function when all the tweens have completed.
		 * @return Array of TweenMax instances
		 */
	static public function allFrom(targets:Array, duration:Number, vars:Object, stagger:Number, onCompleteAll:Function, onCompleteAllParams:Array, onCompleteAllScope:Object) : Array;

	/**
		 * Tweens multiple targets from a common set of starting values to a common set of ending values; exactly the same 
		 * as TweenMax.allTo(), but adds the ability to define the starting values. <b>NOTE</b>: Only put starting values
		 * in the fromVars parameter - all special properties for the tween (like onComplete, onUpdate, delay, etc.) belong
		 * in the toVars parameter. 
		 * 
		 * @param targets An Array of objects to tween.
		 * @param duration Duration (in seconds) of the tween (or in frames for frames-based tweens)
		 * @param fromVars An object containing the starting values of all the properties you'd like to have tweened.
		 * @param toVars An object containing the ending values of all the properties you'd like to have tweened.
		 * @param stagger Staggers the start time of each tween. For example, you might want to have 5 MovieClips move down from _y:0 to _y:100 while fading from _alpha:0 to _alpha:100, and stagger the start times slightly by 0.2 seconds, you could do: <code>TweenMax.allFromTo([mc1, mc2, mc3, mc4, mc5], 1, {_y:0, _alpha:0}, {_y:100, _alpha:100}, 0.2)</code>.
		 * @param onCompleteAll A function to call when all of the tweens have completed.
		 * @param onCompleteAllParams An Array of parameters to pass the onCompleteAll function when all the tweens have completed.
		 * @return Array of TweenMax instances
		 */
	static public function allFromTo(targets:Array, duration:Number, fromVars:Object, toVars:Object, stagger:Number, onCompleteAll:Function, onCompleteAllParams:Array, onCompleteAllScope:Object) : Array;

	/**
		 * Provides a simple way to call a function after a set amount of time (or frames). You can
		 * optionally pass any number of parameters to the function too. For example: <br /><br /><code>
		 * 
		 * 		TweenMax.delayedCall(1, myFunction, ["param1", 2]);<br />
		 * 		function myFunction(param1:String, param2:Number):Void {<br />
		 *  		   trace("called myFunction and passed params: " + param1 + ", " + param2);<br />
		 * 		}<br /><br /></code>
		 * 
		 * @param delay Delay in seconds (or frames if useFrames is true) before the function should be called
		 * @param onComplete Function to call
		 * @param onCompleteParams An Array of parameters to pass the function.
		 * @return TweenMax instance
		 */
	static public function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array, onCompleteScope:Object, useFrames:Boolean) : TweenMax;

	/**
		 * Gets all the tweens of a particular object.
		 *  
		 * @param target The target object whose tweens you want returned
		 * @return Array of tweens (could be TweenLite and/or TweenMax instances)
		 */
	static public function getTweensOf(target:Object) : Array;

	/**
		 * Determines whether or not a particular object is actively tweening. If a tween
		 * is paused or hasn't started yet, it doesn't count as active.
		 * 
		 * @param target Target object whose tweens you're checking
		 * @return Boolean value indicating whether or not any active tweens were found
		 */
	static public function isTweening(target:Object) : Boolean;

	/**
		 * Returns all tweens that are in the masterList. Tweens are automatically removed from the
		 * masterList when they complete and are not attached to a timeline that has 
		 * autoRemoveChildren set to true.
		 * 
		 * @return Array of TweenLite and/or TweenMax instances
		 */
	static public function getAllTweens() : Array;

	/**
		 * Kills all tweens and/or delayedCalls/callbacks, optionally forcing them to completion first. The 
		 * various parameters provide a way to distinguish between delayedCalls and tweens, so if you want to 
		 * kill EVERYTHING (tweens and delayedCalls), you'd do:<br /><br /><code>
		 * 
		 * TweenMax.killAll(false, true, true);<br /><br /></code>
		 * 
		 * But if you want to kill only the tweens but allow the delayedCalls to continue, you'd do:<br /><br /><code>
		 * 
		 * TweenMax.killAll(false, true, false);<br /><br /></code>
		 * 
		 * And if you want to kill only the delayedCalls but not the tweens, you'd do:<br /><br /><code>
		 * 
		 * TweenMax.killAll(false, false, true);<br /></code>
		 *  
		 * @param complete Determines whether or not the tweens/delayedCalls/callbacks should be forced to completion before being killed.
		 * @param tweens If true, all tweens will be killed
		 * @param delayedCalls If true, all delayedCalls will be killed. TimelineMax callbacks are treated the same as delayedCalls.
		 */
	static public function killAll(complete:Boolean, tweens:Boolean, delayedCalls:Boolean) : Void;

	/**
		 * Kills all tweens of the children of a particular MovieClip, optionally forcing them to completion first.
		 * 
		 * @param parent The MovieClip whose children should no longer be affected by any tweens. 
		 * @param complete Determines whether or not the tweens and/or delayedCalls should be forced to completion before being killed.
		 */
	static public function killChildTweensOf(parent:MovieClip, complete:Boolean) : Void;

	/**
		 * Pauses all TweenMax tweens and/or delayedCalls/callbacks.
		 * 
		 * @param tweens If true, all TweenMax instances should be paused.
		 * @param delayedCalls If true, all delayedCalls will be paused. TimelineMax callbacks are treated the same as delayedCalls.
		 */
	static public function pauseAll(tweens:Boolean, delayedCalls:Boolean) : Void;

	/**
		 * Resumes all paused TweenMax tweens and/or delayedCalls/callbacks.
		 * 
		 * @param tweens If true, all tweens will be resumed.
		 * @param delayedCalls If true, all delayedCalls will be resumed. TimelineMax callbacks are treated the same as delayedCalls.
		 */
	static public function resumeAll(tweens:Boolean, delayedCalls:Boolean) : Void;

	/**
		 * @private
		 * Changes the paused state of all TweenMax tweens and/or delayedCalls
		 * 
		 * @param pause Desired paused state
		 * @param tweens If true, all TweenMax instances should be affected.
		 * @param delayedCalls If true, all delayedCalls will be affected.
		 */
	static private function changePause(pause:Boolean, tweens:Boolean, delayedCalls:Boolean) : Void;

}