import com.greensock.*;
import com.greensock.core.*;
/**
 * VERSION: 1.699
 * DATE: 2012-06-30
 * AS2 (AS3 version is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com/timelinelite/
 **/
intrinsic class com.greensock.TimelineLite extends SimpleTimeline
{
	/** @private **/
	static public var version : Number;
	/** @private **/
	static private var _overwriteMode : Number;
	/** @private **/
	private var _labels : Object;
	/** @private Just stores the first and last tweens when the timeline is disabled (enabled=false). We do this in an Array in order to avoid circular references which can cause garbage collection issues (timeline referencing TweenCore, and TweenCore referencing timeline) **/
	private var _endCaps : Array;

	/** 
		 * Value between 0 and 1 indicating the progress of the timeline according to its <code>duration</code> 
 		 * where 0 is at the beginning, 0.5 is halfway finished, and 1 is finished. <code>totalProgress</code>, 
 		 * by contrast, describes the overall progress according to the timeline's <code>totalDuration</code> 
 		 * which includes repeats and repeatDelays (if there are any). Since TimelineLite doesn't offer 
 		 * "repeat" and "repeatDelay" functionality, <code>currentProgress</code> and <code>totalProgress</code> are always the same
 		 * but in TimelineMax, they could be different. For example, if a TimelineMax instance 
		 * is set to repeat once, at the end of the first cycle <code>totalProgress</code> would only be 0.5 
		 * whereas <code>currentProgress</code> would be 1. If you tracked both properties over the course of the 
		 * tween, you'd see <code>currentProgress</code> go from 0 to 1 twice (once for each cycle) in the same
		 * time it takes the <code>totalProgress</code> property to go from 0 to 1 once.
		 **/
	public function get currentProgress() : Number;
	public function set currentProgress(n:Number) : Void;

	/**
		 * Duration of the timeline in seconds (or frames for frames-based timelines) not including any repeats
		 * or repeatDelays. "totalDuration", by contrast, does include repeats and repeatDelays but since TimelineLite
		 * doesn't offer "repeat" and "repeatDelay" functionality, duration and totalDuration will always be the same. 
		 * In TimelineMax, however, they could be different. 
		 **/
	public function get duration() : Number;
	public function set duration(n:Number) : Void;

	/**
		 * Duration of the timeline in seconds (or frames for frames-based timelines) including any repeats
		 * or repeatDelays. "duration", by contrast, does NOT include repeats and repeatDelays. Since TimelineLite
		 * doesn't offer "repeat" and "repeatDelay" functionality, duration and totalDuration will always be the same. 
		 * In TimelineMax, however, they could be different. 
		 **/
	public function get totalDuration() : Number;
	public function set totalDuration(n:Number) : Void;

	/** Multiplier describing the speed of the timeline where 1 is normal speed, 0.5 is half-speed, 2 is double speed, etc. **/
	public function get timeScale() : Number;
	public function set timeScale(n:Number) : Void;

	/** 
		 * Indicates whether or not the timeline's timing mode is frames-based as opposed to time-based. 
		 * This can only be set via the vars object in the constructor, or by attaching it to a timeline with the desired
		 * timing mode (a timeline's timing mode is always determined by its parent timeline) 
		 **/
	public function get useFrames() : Boolean;

	/**
		 * @private
		 * Reports the totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum) which can be useful when
		 * unpausing tweens/timelines. Imagine a case where a paused tween is in a timeline that has already reached the end, but then
		 * the tween gets unpaused - it needs a way to place itself accurately in time AFTER what was previously the timeline's end time.
		 * 
		 * @return The totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum)
		 */
	public function get rawTime() : Number;


	/**
		 * Constructor <br /><br />
		 * 
		 * <b>SPECIAL PROPERTIES</b><br />
		 * The following special properties may be passed in via the constructor's vars parameter, like
		 * <code>new TimelineLite({paused:true, onComplete:myFunction})</code>
		 * 
		 * 	<ul>
		 * 	<li><b> delay : Number</b>			Amount of delay before the timeline should begin (in seconds unless "useFrames" is set 
		 * 										to true in which case the value is measured in frames).</li>
		 * 
		 *  <li><b> paused : Boolean</b> 		Sets the initial paused state of the timeline (by default, timelines automatically begin playing immediately)</li>
		 * 								
		 * 	<li><b> useFrames : Boolean</b>		If useFrames is set to true, the timeline's timing mode will be based on frames. 
		 * 										Otherwise, it will be based on seconds/time. NOTE: a TimelineLite's timing mode is 
		 * 										always determined by its parent timeline. </li>
		 * 
		 * 	<li><b> reversed : Boolean</b>		If true, the timeline will be reversed initially. This does NOT force it to the very end and start 
		 * 										playing backwards. It simply affects the orientation of the timeline, so if reversed is set to 
		 * 										true initially, it will appear not to play because it is already at the beginning. To cause it to
		 * 										play backwards from the end, set reversed to true and then set the <code>currentProgress</code> property to 1 immediately
		 * 										after creating the timeline.</li>
		 * 									
		 * 	<li><b> tweens : Array</b>			To immediately insert several tweens into the timeline, use the "tweens" special property
		 * 										to pass in an Array of TweenLite/TweenMax/TimelineLite/TimelineMax instances. You can use this in conjunction
		 * 										with the align and stagger special properties to set up complex sequences with minimal code.
		 * 										These values simply get passed to the insertMultiple() method.</li>
		 * 	
		 * 	<li><b> align : String</b>			Only used in conjunction with the "tweens" special property when multiple tweens are
		 * 										to be inserted immediately. The value simply gets passed to the 
		 * 										insertMultiple() method. Default is NORMAL. Options are:
		 * 										<ul>
		 * 											<li><b> TweenAlign.SEQUENCE:</b> aligns the tweens one-after-the-other in a sequence</li>
		 * 											<li><b> TweenAlign.START:</b> aligns the start times of all of the tweens (ignores delays)</li>
		 * 											<li><b> TweenAlign.NORMAL:</b> aligns the start times of all the tweens (honors delays)</li>
		 * 										</ul></li>
		 * 										
		 * 	<li><b> stagger : Number</b>		Only used in conjunction with the "tweens" special property when multiple tweens are
		 * 										to be inserted immediately. It staggers the tweens by a set amount of time (in seconds) (or
		 * 										in frames if "useFrames" is true). For example, if the stagger value is 0.5 and the "align" 
		 * 										property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one 
		 * 										starts, then 0.5 seconds later the third one will start, etc. If the align property is 
		 * 										TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. This value simply gets 
		 * 										passed to the insertMultiple() method. Default is 0.</li>
		 * 	
		 * 	<li><b> onStart : Function</b>		A function that should be called when the timeline begins (the <code>currentProgress</code> won't necessarily
		 * 										be zero when onStart is called. For example, if the timeline is created and then its <code>currentProgress</code>
		 * 										property is immediately set to 0.5 or if its <code>time</code> property is set to something other than zero,
		 * 										onStart will still get fired because it is the first time the timeline is getting rendered.)</li>
		 * 	
		 * 	<li><b> onStartParams : Array</b>	An Array of parameters to pass the onStart function.</li>
		 * 	
		 * 	<li><b> onStartScope: Object</b>	Defines the scope of the onStart function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> onUpdate : Function</b>		A function that should be called every time the timeline's time/position is updated 
		 * 										(on every frame while the timeline is active)</li>
		 * 	
		 * 	<li><b> onUpdateParams : Array</b>	An Array of parameters to pass the onUpdate function</li>
		 * 	
		 * 	<li><b> onUpdateScope: Object</b>	Defines the scope of the onUpdate function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> onComplete : Function</b>	A function that should be called when the timeline has finished </li>
		 * 	
		 * 	<li><b> onCompleteParams : Array</b> An Array of parameters to pass the onComplete function</li>
		 * 	
		 * 	<li><b> onCompleteScope: Object</b>	Defines the scope of the onComplete function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> onReverseComplete : Function</b> A function that should be called when the timeline has reached its starting point again after having been reversed </li>
		 * 	
		 * 	<li><b> onReverseCompleteParams : Array</b> An Array of parameters to pass the onReverseComplete functions</li>
		 * 	
		 * 	<li><b> onReverseScope: Object</b>	Defines the scope of the onReverseComplete function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> autoRemoveChildren : Boolean</b> If autoRemoveChildren is set to true, as soon as child tweens/timelines complete,
		 * 										they will automatically get killed/removed. This is normally undesireable because
		 * 										it prevents going backwards in time (like if you want to reverse() or set the 
		 * 										<code>currentProgress</code> value to a lower value, etc.). It can, however, improve speed and memory
		 * 										management. TweenLite's root timelines use autoRemoveChildren:true.</li>
		 * 	</ul>
		 * 
		 * @param vars optionally pass in special properties like useFrames, onComplete, onCompleteParams, onUpdate, onUpdateParams, onStart, onStartParams, tweens, align, stagger, delay, reversed, and/or autoRemoveChildren.
		 */
	public function TimelineLite(vars:Object);

	/**
		 * Removes a TweenLite, TweenMax, TimelineLite, or TimelineMax instance from the timeline.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to remove
		 * @param skipDisable If false (the default), the TweenLite/Max/TimelineLite/Max instance is disabled. This is primarily used internally - there's really no reason to set it to true. 
		 */
	public function remove(tween:TweenCore, skipDisable:Boolean) : Void;

	/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance into the timeline at a specific time, frame, or label. 
		 * If you insert at a label that doesn't exist yet, one is created at the end of the timeline.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to insert
		 * @param timeOrLabel The time in seconds (or frames for frames-based timelines) or label at which the tween/timeline should be inserted. For example, myTimeline.insert(myTween, 3) would insert myTween 3-seconds into the timeline, and myTimeline.insert(myTween, "myLabel") would insert it at the "myLabel" label.
		 * @return The TweenLite, TweenMax, TimelineLite, or TimelineMax that was inserted
		 */
	public function insert(tween:TweenCore, timeOrLabel:Object) : TweenCore;

	/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance at the <strong>end</strong> of the timeline,
		 * optionally offsetting its insertion point by a certain amount (to make it overlap with the end of 
		 * the timeline or leave a gap before its insertion point). 
		 * This makes it easy to build sequences by continuing to append() tweens or timelines.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to append
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the tween from the end of the timeline. For example, to append a tween 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tween appended so that it overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline.
		 * @return The TweenLite, TweenMax, TimelineLite, or TimelineMax that was appended
		 */
	public function append(tween:TweenCore, offset:Number) : TweenCore;

	/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance at the beginning of the timeline,
		 * pushing all existing tweens back in time to make room for the newly inserted one. You can optionally
		 * affect the positions of labels too.
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to prepend
		 * @param adjustLabels If true, all existing labels will be adjusted back in time along with the existing tweens to keep them aligned. (default is false)
		 * @return The TweenLite, TweenMax, TimelineLite, or TimelineMax that was prepended
		 */
	public function prepend(tween:TweenCore, adjustLabels:Boolean) : TweenCore;

	/**
		 * Inserts multiple tweens and/or timelines into the timeline at once, optionally aligning them (as a sequence for example)
		 * and/or staggering the timing. This is one of the most powerful methods in TimelineLite because it accommodates
		 * advanced timing effects and builds complex sequences with relatively little code.<br /><br />
		 *  
		 * @param tweens an Array containing any or all of the following: TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances.  
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label that serves as the point of insertion. For example, the number 2 would insert the tweens beginning at 2-seconds into the timeline, or "myLabel" would ihsert them wherever "myLabel" is.
		 * @param align determines how the tweens will be aligned in relation to each other before getting inserted. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is TweenAlign.NORMAL.
		 * @param stagger staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. Default is 0.
		 * @return The array of tweens that were inserted
		 */
	public function insertMultiple(tweens:Array, timeOrLabel:Object, align:String, stagger:Number) : Array;

	/**
		 * Appends multiple tweens/timelines at the end of the timeline at once, optionally offsetting the insertion point by a certain amount, 
		 * aligning them (as a sequence for example), and/or staggering their relative timing. This is one of the most powerful methods in 
		 * TimelineLite because it accommodates advanced timing effects and builds complex sequences with relatively little code.<br /><br />
		 *  
		 * @param tweens an Array containing any or all of the following: TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances  
		 * @param offset Amount of seconds (or frames for frames-based timelines) to offset the insertion point of the tweens from the end of the timeline. For example, to start appending the tweens 3 seconds after the end of the timeline (leaving a 3-second gap), set the offset to 3. Or to have the tweens appended so that the insertion point overlaps with the last 2 seconds of the timeline, set the offset to -2. The default is 0 so that the insertion point is exactly at the end of the timeline. 
		 * @param align determines how the tweens will be aligned in relation to each other before getting appended. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is TweenAlign.NORMAL.
		 * @param stagger staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. Default is 0.
		 * @return The array of tweens that were appended
		 */
	public function appendMultiple(tweens:Array, offset:Number, align:String, stagger:Number) : Array;

	/**
		 * Prepends multiple tweens/timelines to the beginning of the timeline at once, moving all existing children back to make
		 * room, and optionally aligning the new children (as a sequence for example) and/or staggering the timing.<br /><br />
		 *  
		 * @param tweens an Array containing any or all of the following: TweenLite, TweenMax, TimelineLite, and/or TimelineMax instances  
		 * @param align determines how the tweens will be aligned in relation to each other before getting prepended. Options are: TweenAlign.SEQUENCE (aligns the tweens one-after-the-other in a sequence), TweenAlign.START (aligns the start times of all of the tweens (ignores delays)), and TweenAlign.NORMAL (aligns the start times of all the tweens (honors delays)). The default is TweenAlign.NORMAL.
		 * @param stagger staggers the tweens by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. Default is 0.
		 * @return The array of tweens that were prepended
		 */
	public function prependMultiple(tweens:Array, align:String, stagger:Number, adjustLabels:Boolean) : Array;

	/**
		 * Adds a label to the timeline, making it easy to mark important positions/times. gotoAndStop() and gotoAndPlay()
		 * allow you to skip directly to any label. This works just like timeline labels in the Flash IDE.
		 * 
		 * @param label The name of the label
		 * @param time The time in seconds (or frames for frames-based timelines) at which the label should be added. For example, myTimeline.addLabel("myLabel", 3) adds the label "myLabel" at 3 seconds into the timeline.
		 */
	public function addLabel(label:String, time:Number) : Void;

	/**
		 * Removes a label from the timeline and returns the time of that label.
		 * 
		 * @param label The name of the label to remove
		 * @return Time associated with the label that was removed
		 */
	public function removeLabel(label:String) : Number;

	/**
		 * Returns the time associated with a particular label. If the label isn't found, -1 is returned.
		 * 
		 * @param label Label name
		 * @return Time associated with the label (or -1 if there is no such label)
		 */
	public function getLabelTime(label:String) : Number;

	/** @private **/
	private function parseTimeOrLabel(timeOrLabel:Object) : Number;

	/** Pauses the timeline (same as pause() - added stop() for consistency with Flash's MovieClip.stop() functionality) **/
	public function stop() : Void;

	/**
		 * Skips to a particular time, frame, or label and plays the timeline forwards from there (unpausing it)
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, myTimeline.gotoAndPlay(2) will skip to 2-seconds into a timeline, and myTimeline.gotoAndPlay("myLabel") will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered) 
		 */
	public function gotoAndPlay(timeOrLabel:Object, suppressEvents:Boolean) : Void;

	/**
		 * Skips to a particular time, frame, or label and stops the timeline (pausing it)
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, myTimeline.gotoAndStop(2) will skip to 2-seconds into a timeline, and myTimeline.gotoAndStop("myLabel") will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered) 
		 */
	public function gotoAndStop(timeOrLabel:Object, suppressEvents:Boolean) : Void;

	/**
		 * Skips to a particular time, frame, or label without changing the paused state of the timeline
		 * 
		 * @param timeOrLabel time in seconds (or frame if the timeline is frames-based) or label to skip to. For example, myTimeline.goto(2) will skip to 2-seconds into a timeline, and myTimeline.goto("myLabel") will skip to wherever "myLabel" is. 
		 * @param suppressEvents If true, no callbacks will be triggered as the "virtual playhead" moves to the new position (onComplete, onUpdate, onReverseComplete, etc. of this timeline and any of its child tweens/timelines won't be triggered) 
		 */
	public function goto(timeOrLabel:Object, suppressEvents:Boolean) : Void;

	/**
		 * @private
		 * Renders all tweens and sub-timelines in the state they'd be at a particular time (or frame for frames-based timelines). 
		 * 
		 * @param time time in seconds (or frames for frames-based timelines) that should be rendered. 
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 * @param force Normally the tween will skip rendering if the time matches the cachedTotalTime (to improve performance), but if force is true, it forces a render. This is primarily used internally for tweens with durations of zero in TimelineLite/Max instances.
		 */
	public function renderTime(time:Number, suppressEvents:Boolean, force:Boolean) : Void;

	/**
		 * @private
		 * Due to occassional floating point rounding errors in Flash, sometimes child tweens/timelines were not being
		 * rendered at the very beginning (their progress might be 0.000000000001 instead of 0 because when Flash 
		 * performed this.cachedTime - tween.startTime, floating point errors would return a value that
		 * was SLIGHTLY off). This method forces them to the beginning.
		 * 
		 * @param time Time that should be rendered (either zero or a negative number). The reason a negative number could be important is because if there are zero-duration tweens at the very beginning (startTime=0), we need a way to sense when the timeline has gone backwards BEYOND zero so that the tweens know to render their starting values instead of their ending values. If the time is exactly zero, those tweens would render their end values.
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 */
	private function forceChildrenToBeginning(time:Number, suppressEvents:Boolean) : Number;

	/**
		 * @private
		 * Due to occassional floating point rounding errors in Flash, sometimes child tweens/timelines were not being
		 * fully completed (their progress might be 0.999999999999998 instead of 1 because when Flash 
		 * performed this.cachedTime - tween.startTime, floating point errors would return a value that
		 * was SLIGHTLY off). This method forces them to completion.
		 * 
		 * @param time Time that should be rendered (either this.totalDuration or greater). The reason a greater number could be important is because if there are reversed zero-duration tweens at the very end, we need a way to sense when the timeline has gone BEYOND the end so that the tweens know to render their starting values instead of their ending values. If the time is exactly this.totalDuration, those reversed zero-duration tweens would render their end values.
		 * @param suppressEvents If true, no events or callbacks will be triggered for this render (like onComplete, onUpdate, onReverseComplete, etc.)
		 */
	private function forceChildrenToEnd(time:Number, suppressEvents:Boolean) : Number;

	/**
		 * @private
		 * Checks the timeline to see if it has any paused children (tweens/timelines). 
		 * 
		 * @return Indicates whether or not the timeline contains any paused children
		 */
	public function hasPausedChild() : Boolean;

	/**
		 * Provides an easy way to get all of the tweens and/or timelines nested in this timeline (as an Array). 
		 *  
		 * @param nested determines whether or not tweens and/or timelines that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
		 * @param tweens determines whether or not tweens (TweenLite and TweenMax instances) should be included in the results
		 * @param timelines determines whether or not timelines (TimelineLite and TimelineMax instances) should be included in the results
		 * @param ignoreBeforeTime All children with start times that are less than this value will be ignored. By default, no children are excluded unless you define a value.
		 * @return an Array containing the child tweens/timelines.
		 */
	public function getChildren(nested:Boolean, tweens:Boolean, timelines:Boolean, ignoreBeforeTime:Number) : Array;

	/**
		 * Returns the tweens of a particular object that are inside this timeline.
		 * 
		 * @param target the target object of the tweens
		 * @param nested determines whether or not tweens that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
		 * @return an Array of TweenLite and TweenMax instances
		 */
	public function getTweensOf(target:Object, nested:Boolean) : Array;

	/**
		 * Shifts the startTime of the timeline's children by a certain amount and optionally adjusts labels too. This can be useful
		 * when you want to prepend children or splice them into a certain spot, moving existing ones back to make room for the new ones.
		 * 
		 * @param amount Number of seconds (or frames for frames-based timelines) to move each child.
		 * @param adjustLabels If true, the timing of all labels will be adjusted as well.
		 * @param ignoreBeforeTime All children that begin at or after the startAtTime will be affected by the shift (the default is 0, causing all children to be affected). This provides an easy way to splice children into a certain spot on the timeline, pushing only the children after that point back to make room.
		 */
	public function shiftChildren(amount:Number, adjustLabels:Boolean, ignoreBeforeTime:Number) : Void;

	/**
		 * Kills all the tweens (or certain tweening properties) of a particular object inside this TimelineLite, 
		 * optionally completing them first. If, for example, you want to kill all tweens of the "mc" object, you'd do:<br /><br /><code>
		 * 
		 * myTimeline.killTweensOf(mc);<br /><br /></code>
		 * 
		 * But if you only want to kill all the "_alpha" and "_x" portions of mc's tweens, you'd do:<br /><br /><code>
		 * 
		 * myTimeline.killTweensOf(mc, false, {_alpha:true, _x:true});<br /><br /></code>
		 * 
		 * Killing a tween also removes it from the timeline.
		 * 
		 * @param target the target object of the tweens
		 * @param nested determines whether or not tweens that are inside nested timelines should be affected. If you only want the "top level" tweens/timelines to be affected, set this to false.
		 * @param vars An object defining which tweening properties should be killed (<code>undefined</code>, the default, causes all properties to be killed). For example, if you only want to kill "_alpha" and "_x" tweens of object "mc", you'd do <code>myTimeline.killTweensOf(mc, true, {_alpha:true, _x:true})</code>. If there are no tweening properties remaining in a tween after the indicated properties are killed, the entire tween is killed, meaning any onComplete, onUpdate, onStart, etc. won't fire.
		 */
	public function killTweensOf(target:Object, nested:Boolean, vars:Object) : Boolean;

	/**
		 * Empties the timeline of all child tweens/timelines, or you can optionally pass an Array containing specific 
		 * tweens/timelines to remove. So <code>myTimeline.clear()</code> would remove all children whereas 
		 * <code>myTimeline.clear([tween1, tween2])</code> would only remove tween1 and tween2. You could even clear only 
		 * the tweens of a particular object with <code>myTimeline.clear(myTimeline.getTweensOf(myObject));</code>
		 * 
		 * @param tweens (optional) An Array containing specific children to remove.
		 */
	public function clear(tweens:Array) : Void;

	/** @inheritDoc **/
	public function invalidate() : Void;

	/** @inheritDoc **/
	public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean) : Boolean;

}