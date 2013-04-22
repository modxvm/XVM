import com.greensock.*;
import com.greensock.core.*;
/**
 * VERSION: 1.698
 * DATE: 2012-03-29
 * AS2 (AS3 version is also available)
 * UPDATES AND DOCS AT: http://www.greensock.com/timelinemax/
 **/
intrinsic class com.greensock.TimelineMax extends TimelineLite
{
	/** @private **/
	static public var version : Number;
	/** @private **/
	private var _repeat : Number;
	/** @private **/
	private var _repeatDelay : Number;
	/** @private **/
	private var _cyclesComplete : Number;
	/** 
		 * Works in conjunction with the repeat property, determining the behavior of each cycle; when yoyo is true, 
		 * the timeline will go back and forth, appearing to reverse every other cycle (this has no affect on the "reversed" property though). 
		 * So if repeat is 2 and yoyo is false, it will look like: start - 1 - 2 - 3 - 1 - 2 - 3 - 1 - 2 - 3 - end. 
		 * But if repeat is 2 and yoyo is true, it will look like: start - 1 - 2 - 3 - 3 - 2 - 1 - 1 - 2 - 3 - end.  
		 **/
	public var yoyo : Boolean;

	/** @inheritDoc **/
	public function set currentProgress(n:Number) : Void;

	/** 
		 * Value between 0 and 1 indicating the progress of the timeline according to its totalDuration 
 		 * where 0 is at the beginning, 0.5 is halfway finished, and 1 is finished. <code>currentProgress</code>, 
 		 * by contrast, describes the progress according to the timeline's duration which does not
 		 * include repeats and repeatDelays. For example, if a TimelineMax instance is set 
 		 * to repeat once, at the end of the first cycle <code>totalProgress</code> would only be 0.5 
		 * whereas <code>currentProgress</code> would be 1. If you tracked both properties over the course of the 
		 * tween, you'd see <code>currentProgress</code> go from 0 to 1 twice (once for each cycle) in the same
		 * time it takes the <code>totalProgress</code> property to go from 0 to 1 once.
		 **/
	public function get totalProgress() : Number;
	public function set totalProgress(n:Number) : Void;

	/**
		 * Duration of the timeline in seconds (or frames for frames-based timelines) including any repeats
		 * or repeatDelays. "duration", by contrast, does NOT include repeats and repeatDelays.
		 **/
	public function get totalDuration() : Number;

	/** @inheritDoc **/
	public function get currentTime() : Number;
	public function set currentTime(n:Number) : Void;

	/** Number of times that the timeline should repeat; -1 repeats indefinitely. **/
	public function get repeat() : Number;
	public function set repeat(n:Number) : Void;

	/** Amount of time in seconds (or frames for frames-based timelines) between repeats **/
	public function get repeatDelay() : Number;
	public function set repeatDelay(n:Number) : Void;

	/** The closest label that is at or before the current time. **/
	public function get currentLabel() : String;


	/**
		 * Constructor <br /><br />
		 * 
		 * <b>SPECIAL PROPERTIES</b><br />
		 * The following special properties may be passed in via the constructor's vars parameter, like
		 * <code>new TimelineMax({paused:true, onComplete:myFunction, repeat:2, yoyo:true})</code> 
		 * 
		 * <ul>
		 * 	<li><b> delay : Number</b>				Amount of delay before the timeline should begin (in seconds unless "useFrames" is set 
		 * 											to true in which case the value is measured in frames).</li>
		 * 								
		 * 	<li><b> useFrames : Boolean</b>			If useFrames is set to true, the timeline's timing mode will be based on frames. 
		 * 											Otherwise, it will be based on seconds/time. NOTE: a TimelineLite's timing mode is 
		 * 											always determined by its parent timeline. </li>
		 * 
		 *  <li><b> paused : Boolean</b> 			Sets the initial paused state of the timeline (by default, timelines automatically begin playing immediately)</li>
		 * 
		 * 	<li><b> reversed : Boolean</b>			If true, the timeline will be reversed initially. This does NOT force it to the very end and start 
		 * 											playing backwards. It simply affects the orientation of the timeline, so if reversed is set to 
		 * 											true initially, it will appear not to play because it is already at the beginning. To cause it to
		 * 											play backwards from the end, set reversed to true and then set the <code>currentProgress</code> property to 1 immediately
		 * 											after creating the timeline.</li>
		 * 									
		 * 	<li><b> tweens : Array</b>				To immediately insert several tweens into the timeline, use the "tweens" special property
		 * 											to pass in an Array of TweenLite/TweenMax/TimelineLite/TimelineMax instances. You can use this in conjunction
		 * 											with the align and stagger special properties to set up complex sequences with minimal code.
		 * 											These values simply get passed to the insertMultiple() method.</li>
		 * 	
		 * 	<li><b> align : String</b>				Only used in conjunction with the "tweens" special property when multiple tweens are
		 * 											to be inserted immediately. The value simply gets passed to the 
		 * 											insertMultiple() method. Default is NORMAL. Options are:
		 * 											<ul>
		 * 												<li><b> TweenAlign.SEQUENCE:</b> aligns the tweens one-after-the-other in a sequence</li>
		 * 												<li><b> TweenAlign.START:</b> aligns the start times of all of the tweens (ignores delays)</li>
		 * 												<li><b> TweenAlign.NORMAL:</b> aligns the start times of all the tweens (honors delays)</li>
		 * 											</ul></li>
		 * 										
		 * 	<li><b> stagger : Number</b>			Only used in conjunction with the "tweens" special property when multiple tweens are
		 * 											to be inserted immediately. It staggers the tweens by a set amount of time (in seconds) (or
		 * 											in frames if "useFrames" is true). For example, if the stagger value is 0.5 and the "align" 
		 * 											property is set to TweenAlign.START, the second tween will start 0.5 seconds after the first one 
		 * 											starts, then 0.5 seconds later the third one will start, etc. If the align property is 
		 * 											TweenAlign.SEQUENCE, there would be 0.5 seconds added between each tween. This value simply gets 
		 * 											passed to the insertMultiple() method. Default is 0.</li>
		 * 	
		 * 	<li><b> onStart : Function</b>			A function that should be called when the timeline begins (the <code>currentProgress</code> won't necessarily
		 * 											be zero when onStart is called. For example, if the timeline is created and then its <code>currentProgress</code>
		 * 											property is immediately set to 0.5 or if its <code>currentTime</code> property is set to something other than zero,
		 * 											onStart will still get fired because it is the first time the timeline is getting rendered.)</li>
		 * 	
		 * 	<li><b> onStartParams : Array</b>		An Array of parameters to pass the onStart function.</li>
		 * 	
		 * 	<li><b> onStartScope: Object</b>		Defines the scope of the onStart function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> onUpdate : Function</b>			A function that should be called every time the timeline's time/position is updated 
		 * 											(on every frame while the timeline is active)</li>
		 * 	
		 * 	<li><b> onUpdateParams : Array</b>		An Array of parameters to pass the onUpdate function</li>
		 * 	
		 * 	<li><b> onUpdateScope: Object</b>		Defines the scope of the onUpdate function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> onComplete : Function</b>		A function that should be called when the timeline has finished </li>
		 * 	
		 * 	<li><b> onCompleteParams : Array</b>	An Array of parameters to pass the onComplete function</li>
		 * 	
		 * 	<li><b> onCompleteScope: Object</b>		Defines the scope of the onComplete function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> onReverseComplete : Function</b> A function that should be called when the timeline has reached its starting point again after having been reversed </li>
		 * 	
		 * 	<li><b> onReverseCompleteParams : Array</b> An Array of parameters to pass the onReverseComplete functions</li>
		 * 	
		 * 	<li><b> onReverseCompleteScope: Object</b>	Defines the scope of the onReverseComplete function (what "this" refers to inside that function).</li>
		 *  
		 * 	<li><b> onRepeat : Function</b>			A function that should be called every time the timeline repeats </li>
		 * 	
		 * 	<li><b> onRepeatParams : Array</b>		An Array of parameters to pass the onRepeat function</li>
		 * 	
		 * 	<li><b> onRepeatScope: Object</b>		Defines the scope of the onRepeat function (what "this" refers to inside that function).</li>
		 * 	
		 * 	<li><b> autoRemoveChildren : Boolean</b> If autoRemoveChildren is set to true, as soon as child tweens/timelines complete,
		 * 											they will automatically get killed/removed. This is normally undesireable because
		 * 											it prevents going backwards in time (like if you want to reverse() or set the 
		 * 											<code>currentProgress</code> value to a lower value, etc.). It can, however, improve speed and memory
		 * 											management. TweenLite's root timelines use <code>autoRemoveChildren:true.</code></li>
		 * 
		 * 	<li><b> repeat : Number</b>				Number of times that the timeline should repeat. To repeat infinitely, use -1.</li>
		 * 	
		 * 	<li><b> repeatDelay : Number</b>		Amount of time in seconds (or frames for frames-based timelines) between repeats.</li>
		 * 	
		 * 	<li><b> yoyo : Boolean</b> 				Works in conjunction with the repeat property, determining the behavior of each 
		 * 											cycle. When yoyo is true, the timeline will go back and forth, appearing to reverse 
		 * 											every other cycle (this has no affect on the <code>reversed</code> property though). So if repeat is
		 * 											2 and yoyo is false, it will look like: start - 1 - 2 - 3 - 1 - 2 - 3 - 1 - 2 - 3 - end. But 
		 * 											if repeat is 2 and yoyo is true, it will look like: start - 1 - 2 - 3 - 3 - 2 - 1 - 1 - 2 - 3 - end. </li>
		 * 	</ul>
		 * 
		 * @param vars optionally pass in special properties like useFrames, onComplete, onCompleteParams, onUpdate, onUpdateParams, onStart, onStartParams, tweens, align, stagger, delay, autoRemoveChildren, onCompleteListener, onStartListener, onUpdateListener, repeat, repeatDelay, and/or yoyo.
		 */
	public function TimelineMax(vars:Object);

	/**
		 * If you want a function to be called at a particular time or label, use addCallback.
		 * 
		 * @param function the function to be called
		 * @param timeOrLabel the time in seconds (or frames for frames-based timelines) or label at which the callback should be inserted. For example, myTimeline.addCallback(myFunction, 3) would call myFunction() 3-seconds into the timeline, and myTimeline.addCallback(myFunction, "myLabel") would call it at the "myLabel" label.
		 * @param params an Array of parameters to pass the callback
		 * @param scope the scope to use for the callback (what "this" will refer to inside the callback function)
		 * @return TweenLite instance
		 */
	public function addCallback(callback:Function, timeOrLabel:Object, params:Array, scope:Object) : TweenLite;

	/**
		 * Removes a callback from a particular time or label. If timeOrLabel is undefined, all callbacks of that
		 * particular function are removed from the timeline.
		 * 
		 * @param function callback function to be removed
		 * @param timeOrLabel the time in seconds (or frames for frames-based timelines) or label from which the callback should be removed. For example, myTimeline.removeCallback(myFunction, 3) would remove the callback from 3-seconds into the timeline, and myTimeline.removeCallback(myFunction, "myLabel") would remove it from the "myLabel" label, and myTimeline.removeCallback(myFunction, undefined) would remove ALL callbacks of that function regardless of where they are on the timeline.
		 * @return true if any callbacks were successfully found and removed. false otherwise.
		 */
	public function removeCallback(callback:Function, timeOrLabel:Object) : Boolean;

	/**
		 * Creates a linear tween that essentially scrubs the playhead to a particular time or label and then stops. For 
		 * example, to make the TimelineMax play to the "myLabel2" label, simply do: <br /><br /><code>
		 * 
		 * myTimeline.tweenTo("myLabel2"); <br /><br /></code>
		 * 
		 * If you want advanced control over the tween, like adding an onComplete or changing the ease or adding a delay, 
		 * just pass in a vars object with the appropriate properties. For example, to tween to the 5-second point on the 
		 * timeline and then call a function named <code>myFunction</code> and pass in a parameter that's references this 
		 * TimelineMax and use a Strong.easeOut ease, you'd do: <br /><br /><code>
		 * 
		 * myTimeline.tweenTo(5, {onComplete:myFunction, onCompleteParams:[myTimeline], ease:Strong.easeOut});<br /><br /></code>
		 * 
		 * Remember, this method simply creates a TweenLite instance that tweens the <code>currentTime</code> property of your timeline. 
		 * So you can store a reference to that tween if you want, and you can kill() it anytime. Also note that <code>tweenTo()</code>
		 * does <b>NOT</b> affect the timeline's <code>reversed</code> property. So if your timeline is oriented normally
		 * (not reversed) and you tween to a time/label that precedes the current time, it will appear to go backwards
		 * but the <code>reversed</code> property will <b>not</b> change to <code>true</code>. Also note that <code>tweenTo()</code>
		 * pauses the timeline immediately before tweening its <code>currentTime</code> property, and it stays paused after the tween completes.
		 * If you need to resume playback, you could always use an onComplete to call the <code>resume()</code> method.<br /><br />
		 * 
		 * If you plan to sequence multiple playhead tweens one-after-the-other, it is typically better to use 
		 * <code>tweenFromTo()</code> so that you can define the starting point and ending point, allowing the 
		 * duration to be accurately determined immediately. 
		 * 
		 * @see #tweenFromTo()
		 * @param timeOrLabel The destination time in seconds (or frame if the timeline is frames-based) or label to which the timeline should play. For example, myTimeline.tweenTo(5) would play from wherever the timeline is currently to the 5-second point whereas myTimeline.tweenTo("myLabel") would play to wherever "myLabel" is on the timeline.
		 * @param vars An optional vars object that will be passed to the TweenLite instance. This allows you to define an onComplete, ease, delay, or any other TweenLite special property. onInit is the only special property that is not available (tweenTo() sets it internally)
		 * @return TweenLite instance that handles tweening the timeline to the desired time/label.
		 */
	public function tweenTo(timeOrLabel:Object, vars:Object) : TweenLite;

	/**
		 * Creates a linear tween that essentially scrubs the playhead from a particular time or label to another 
		 * time or label and then stops. If you plan to sequence multiple playhead tweens one-after-the-other, 
		 * <code>tweenFromTo()</code> is better to use than <code>tweenTo()</code> because it allows the duration 
		 * to be determined immediately, ensuring that subsequent tweens that are appended to a sequence are 
		 * positioned appropriately. For example, to make the TimelineMax play from the label "myLabel1" to the "myLabel2" 
		 * label, and then from "myLabel2" back to the beginning (a time of 0), simply do: <br /><br /><code>
		 * 
		 * var playheadTweens:TimelineMax = new TimelineMax(); <br />
		 * playheadTweens.append( myTimeline.tweenFromTo("myLabel1", "myLabel2") );<br />
		 * playheadTweens.append( myTimeline.tweenFromTo("myLabel2", 0); <br /><br /></code>
		 * 
		 * If you want advanced control over the tween, like adding an onComplete or changing the ease or adding a delay, 
		 * just pass in a vars object with the appropriate properties. For example, to tween from the start (0) to the 
		 * 5-second point on the timeline and then call a function named <code>myFunction</code> and pass in a parameter 
		 * that's references this TimelineMax and use a Strong.easeOut ease, you'd do: <br /><br /><code>
		 * 
		 * myTimeline.tweenFromTo(0, 5, {onComplete:myFunction, onCompleteParams:[myTimeline], ease:Strong.easeOut});<br /><br /></code>
		 * 
		 * Remember, this method simply creates a TweenLite instance that tweens the <code>currentTime</code> property of your timeline. 
		 * So you can store a reference to that tween if you want, and you can <code>kill()</code> it anytime. Also note that <code>tweenFromTo()</code>
		 * does <b>NOT</b> affect the timeline's <code>reversed</code> property. So if your timeline is oriented normally
		 * (not reversed) and you tween to a time/label that precedes the current time, it will appear to go backwards
		 * but the <code>reversed</code> property will <b>not</b> change to <code>true</code>. Also note that <code>tweenFromTo()</code>
		 * pauses the timeline immediately before tweening its <code>currentTime</code> property, and it stays paused after the tween completes.
		 * If you need to resume playback, you could always use an onComplete to call the <code>resume()</code> method.
		 * 
		 * @see #tweenTo()
		 * @param fromTimeOrLabel The beginning time in seconds (or frame if the timeline is frames-based) or label from which the timeline should play. For example, <code>myTimeline.tweenTo(0, 5)</code> would play from 0 (the beginning) to the 5-second point whereas <code>myTimeline.tweenFromTo("myLabel1", "myLabel2")</code> would play from "myLabel1" to "myLabel2".
		 * @param toTimeOrLabel The destination time in seconds (or frame if the timeline is frames-based) or label to which the timeline should play. For example, <code>myTimeline.tweenTo(0, 5)</code> would play from 0 (the beginning) to the 5-second point whereas <code>myTimeline.tweenFromTo("myLabel1", "myLabel2")</code> would play from "myLabel1" to "myLabel2".
		 * @param vars An optional vars object that will be passed to the TweenLite instance. This allows you to define an onComplete, ease, delay, or any other TweenLite special property. onInit is the only special property that is not available (<code>tweenFromTo()</code> sets it internally)
		 * @return TweenLite instance that handles tweening the timeline between the desired times/labels.
		 */
	public function tweenFromTo(fromTimeOrLabel:Object, toTimeOrLabel:Object, vars:Object) : TweenLite;

	/** @private **/
	static private function onInitTweenTo(tween:TweenLite, timeline:TimelineMax, fromTime:Number) : Void;

	/** @private **/
	static private function easeNone(t:Number, b:Number, c:Number, d:Number) : Number;

	/** @inheritDoc **/
	public function renderTime(time:Number, suppressEvents:Boolean, force:Boolean) : Void;

	/**
		 * Returns the tweens/timelines that are currently active in the timeline.
		 * 
		 * @param nested determines whether or not tweens and/or timelines that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
		 * @param tweens determines whether or not tweens (TweenLite and TweenMax instances) should be included in the results
		 * @param timelines determines whether or not timelines (TimelineLite and TimelineMax instances) should be included in the results
		 * @return an Array of active tweens/timelines
		 */
	public function getActive(nested:Boolean, tweens:Boolean, timelines:Boolean) : Array;

	/**
		 * Returns the next label (if any) that occurs AFTER the time parameter. It makes no difference
		 * if the timeline is reversed. A label that is positioned exactly at the same time as the <code>time</code>
		 * parameter will be ignored. 
		 * 
		 * @param time Time after which the label is searched for. If you do not pass a time in, the currentTime will be used. 
		 * @return Name of the label that is after the time passed to getLabelAfter()
		 */
	public function getLabelAfter(time:Number) : String;

	/**
		 * Returns the previous label (if any) that occurs BEFORE the time parameter. It makes no difference
		 * if the timeline is reversed. A label that is positioned exactly at the same time as the <code>time</code>
		 * parameter will be ignored. 
		 * 
		 * @param time Time before which the label is searched for. If you do not pass a time in, the currentTime will be used. 
		 * @return Name of the label that is before the time passed to getLabelBefore()
		 */
	public function getLabelBefore(time:Number) : String;

	/** @private Returns an Array of label objects, each with a "time" and "name" property, in the order that they occur in the timeline. **/
	private function getLabelsArray() : Array;

}