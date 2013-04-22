import com.greensock.core.*;
/**
 * VERSION: 11.698
 * DATE: 2012-03-27
 * AS2 (AS3 version is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/
intrinsic class com.greensock.TweenLite extends TweenCore
{
	/** @private **/
	static public var version : Number;
	/** @private When plugins are activated, the class is added (named based on the special property) to this object so that we can quickly look it up in the initTweenVals() method.**/
	static public var plugins : Object;
	/** @private For notifying plugins of significant events like when the tween finishes initializing, when it is disabled/enabled, and when it completes (some plugins need to take actions when those events occur) **/
	static public var onPluginEvent : Function;
	/** @private **/
	static public var killDelayedCallsTo : Function;
	/** Provides an easy way to change the default easing equation.**/
	static public var defaultEase : Function;
	/** @private Makes it possible to integrate OverwriteManager for adding various overwriting capabilities. **/
	static public var overwriteManager : Object;
	/** @private Gets updated on every frame. This syncs all the tweens and prevents drifting of the startTime that happens under heavy loads with most other engines.**/
	static public var rootFrame : Number;
	/** @private All tweens get associated with a timeline. The rootTimeline is the default for all time-based tweens.**/
	static public var rootTimeline : SimpleTimeline;
	/** @private All tweens get associated with a timeline. The rootFramesTimeline is the default for all frames-based tweens.**/
	static public var rootFramesTimeline : SimpleTimeline;
	/** @private Holds references to all our tween instances organized by target for quick lookups (for overwriting).**/
	static public var masterList : Object;
	/** @private Drives all our onEnterFrame events.**/
	static private var _timingClip : MovieClip;
	/** @private Used to assign IDs to targets **/
	static private var _cnt : Number;
	/** @private Lookup for all of the reserved "special property" keywords.**/
	static private var _reservedProps : Object;
	/** Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. **/
	public var target : Object;
	/** @private Lookup object for PropTween objects. For example, if this tween is handling the "_x" and "_y" properties of the target, the propTweenLookup object will have an "_x" and "_y" property, each pointing to the associated PropTween object. This can be very helpful for speeding up overwriting. This is a public variable, but should almost never be used directly. **/
	public var propTweenLookup : Object;
	/** @private result of _ease(this.currentTime, 0, 1, this.duration). Usually between 0 and 1, but not always (like with Elastic.easeOut). **/
	public var ratio : Number;
	/** @private First PropTween instance - all of which are stored in a linked list for speed. Traverse them using nextNode and prevNode. Typically you should NOT use this property (it is made public for speed and file size purposes). **/
	public var cachedPT1 : PropTween;
	/** @private Easing method to use which determines how the values animate over time. Examples are Elastic.easeOut and Strong.easeIn. Many are found in the fl.motion.easing package or com.greensock.easing. **/
	private var _ease : Function;
	/** @private Target ID (a way to identify each end target, i.e. "t1", "t2", "t3") **/
	private var _targetID : String;
	/** @private 0 = NONE, 1 = ALL, 2 = AUTO 3 = CONCURRENT, 4 = ALL_AFTER **/
	private var _overwrite : Number;
	/** @private When other tweens overwrite properties in this tween, the properties get added to this object. Remember, sometimes properties are overwritten BEFORE the tween inits, like when two tweens start at the same time, the later one overwrites the previous one. **/
	private var _overwrittenProps : Object;
	/** @private If this tween has any TweenPlugins, we set this to true - it helps speed things up in onComplete **/
	private var _hasPlugins : Boolean;
	/** @private If this tween has any TweenPlugins that need to be notified of a change in the "enabled" status, this will be true. (speeds things up in the enabled setter) **/
	private var _notifyPluginsOfEnabled : Boolean;

	/**
		 * @private
		 * Initializes the class, activates default plugins, and starts the root timelines. This should only 
		 * be called internally. It is technically public only so that other classes in the GreenSock Tweening 
		 * Platform can access it, but again, please avoid calling this method directly.
		 */
	static public function initClass() : Void;

	/**
		 * Constructor
		 *  
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param vars An object containing the end values of the properties you're tweening. For example, to tween to _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 */
	public function TweenLite(target:Object, duration:Number, vars:Object);

	/**
		 * @private
		 * Initializes the property tweens, determining their start values and amount of change. 
		 * Also triggers overwriting if necessary and sets the _hasUpdate variable.
		 */
	private function init() : Void;

	/**
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
		 * Allows particular properties of the tween to be killed. For example, if a tween is affecting 
		 * the "_x", "_y", and "_alpha" properties and you want to kill just the "_x" and "_y" parts of the 
		 * tween, you'd do <code>myTween.killVars({_x:true, _y:true});</code>
		 * 
		 * @param vars An object containing a corresponding property for each one that should be killed. The values don't really matter. For example, to kill the _x and _y property tweens, do myTween.killVars({_x:true, _y:true});
		 * @param permanent If true, the properties specified in the vars object will be permanently disallowed in the tween. Typically the only time false might be used is while the tween is in the process of initting and a plugin needs to make sure tweens of a particular property (or set of properties) is killed. 
		 * @return Boolean value indicating whether or not properties may have changed on the target when any of the vars were disabled. For example, when a motionBlur (plugin) is disabled, it swaps out a BitmapData for the target and may alter the alpha. We need to know this in order to determine whether or not a new tween that is overwriting this one should be re-initted() with the changed properties. 
		 */
	public function killVars(vars:Object, permanent:Boolean) : Boolean;

	/** @inheritDoc **/
	public function invalidate() : Void;

	/** @private **/
	public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean) : Boolean;

	/**
		 * @private
		 * Only used for easing equations that accept extra parameters (like Elastic.easeOut and Back.easeOut).
		 * Basically, it acts as a proxy. To utilize it, pass an Array of extra parameters via the vars object's
		 * "easeParams" special property
		 *  
		 * @param t time
		 * @param b start
		 * @param c change
		 * @param d duration
		 * @return Eased value
		 */
	private function easeProxy(t:Number, b:Number, c:Number, d:Number) : Number;

	/**
		 * Static method for creating a TweenLite instance. This can be more intuitive for some developers 
		 * and shields them from potential garbage collection issues that could arise when assigning a
		 * tween instance to a variable that persists. The following lines of code produce exactly 
		 * the same result: <br /><br /><code>
		 * 
		 * var myTween:TweenLite = new TweenLite(mc, 1, {_x:100}); <br />
		 * TweenLite.to(mc, 1, {_x:100}); <br />
		 * var myTween:TweenLite = TweenLite.to(mc, 1, {_x:100});</code>
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param vars An object containing the end values of the properties you're tweening. For example, to tween to _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenLite instance
		 */
	static public function to(target:Object, duration:Number, vars:Object) : TweenLite;

	/**
		 * Static method for creating a TweenLite instance that tweens in the opposite direction
		 * compared to a TweenLite.to() tween. In other words, you define the START values in the 
		 * vars object instead of the end values, and the tween will use the current values as 
		 * the end values. This can be very useful for animating things into place on the stage
		 * because you can build them in their end positions and do some simple TweenLite.from()
		 * calls to animate them into place. <b>NOTE:</b> By default, <code>immediateRender</code>
		 * is <code>true</code> in from() tweens, meaning that they immediately render their starting state 
		 * regardless of any delay that is specified. You can override this behavior by passing 
		 * <code>immediateRender:false</code> in the <code>vars</code> object so that it will wait to 
		 * render until the tween actually begins (often the desired behavior when inserting into timelines). 
		 * To illustrate the default behavior, the following code will immediately set the <code>_alpha</code> of <code>mc</code> 
		 * to 0 and then wait 2 seconds before tweening the <code>_alpha</code> back to 100 over the course 
		 * of 1.5 seconds:<br /><br /><code>
		 * 
		 * TweenLite.from(mc, 1.5, {_alpha:0, delay:2});</code>
		 * 
		 * @param target Target object whose properties this tween affects. This can be ANY object, not just a MovieClip. 
		 * @param duration Duration in seconds (or in frames if the tween's timing mode is frames-based)
		 * @param vars An object containing the start values of the properties you're tweening. For example, to tween from _x=100, _y=100, you could pass {_x:100, _y:100}. It can also contain special properties like "onComplete", "ease", "delay", etc.
		 * @return TweenLite instance
		 */
	static public function from(target:Object, duration:Number, vars:Object) : TweenLite;

	/**
		 * Provides a simple way to call a function after a set amount of time (or frames). You can
		 * optionally pass any number of parameters to the function too. For example:<br /><br /><code>
		 * 
		 * TweenLite.delayedCall(1, myFunction, ["param1", 2]); <br />
		 * function myFunction(param1:String, param2:Number):Void { <br />
		 *     trace("called myFunction and passed params: " + param1 + ", " + param2); <br />
		 * } </code>
		 * 
		 * @param delay Delay in seconds (or frames if useFrames is true) before the function should be called
		 * @param onComplete Function to call
		 * @param onCompleteParams An Array of parameters to pass the function.
		 * @return TweenLite instance
		 */
	static public function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array, onCompleteScope:Object, useFrames:Boolean) : TweenLite;

	/**
		 * @private
		 * Updates the rootTimeline and rootFramesTimeline and collects garbage every 60 frames.
		 */
	static private function updateAll() : Void;

	/**
		 * Kills all the tweens of a particular object or delayedCalls to a particular function, optionally 
		 * completing them first. If, for example, you want to kill all tweens of the "mc" object, you'd do:<br /><br /><code>
		 * 
		 * TweenLite.killTweensOf(mc);<br /><br /></code>
		 * 
		 * But if you only want to kill all the "_alpha" and "_x" portions of mc's tweens, you'd do:<br /><br /><code>
		 * 
		 * TweenLite.killTweensOf(mc, false, {_alpha:true, _x:true});<br /><br /></code>
		 * 
		 * To kill all the delayedCalls that were created like <code>TweenLite.delayedCall(5, myFunction);</code>, 
		 * you can simply call <code>TweenLite.killTweensOf(myFunction);</code> because delayedCalls are just
		 * tweens that have their <code>target</code> and <code>onComplete</code> set to the same function (and 
		 * a <code>delay</code> of course). <br /><br />
		 * 
		 * <code>killTweensOf()</code> affects tweens that haven't begun yet too. If, for example, 
		 * a tween of object "mc" has a delay of 5 seconds and <code>TweenLite.killTweensOf(mc)</code> is called
		 * 2 seconds after the tween was created, it will still be killed even though it hasn't started yet. <br /><br />
		 * 
		 * @param target Object whose tweens should be immediately killed
		 * @param complete Indicates whether or not the tweens should be forced to completion before being killed (false by default)
		 * @param vars An object defining which tweening properties should be killed (<code>undefined</code>, the default, causes all properties to be killed). For example, if you only want to kill "_alpha" and "_x" tweens of object "mc", you'd do <code>myTimeline.killTweensOf(mc, true, {_alpha:true, _x:true})</code>. If there are no tweening properties remaining in a tween after the indicated properties are killed, the entire tween is killed, meaning any onComplete, onUpdate, onStart, etc. won't fire.
		 */
	static public function killTweensOf(target:Object, complete:Boolean, vars:Object) : Void;

	/** @private **/
	static public function getID(target:Object, lookup:Boolean) : String;

	/**
		 * @private
		 * Default easing equation
		 * 
		 * @param t time
		 * @param b start (must be 0)
		 * @param c change (must be 1)
		 * @param d duration
		 * @return Eased value
		 */
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

	/** 
		 * @private 
		 * This method was made public because in some very rare situations (like when an AS2/AS1-based swf 
		 * is subloaded into an AS3-based one, then unloaded, and another one is loaded subsequently), a bug in the Flash Player 
		 * prevented the onEnterFrame from working properly and the _root reference became invalid. If you run into a 
		 * situation where tweens appear to stop working in subsequent subloads, just make a call to TweenLite.jumpStart(_root) 
		 * on the first frame of those subloaded swfs to jump-start the rendering. 
		 **/
	static public function jumpStart(root:MovieClip) : Void;

}