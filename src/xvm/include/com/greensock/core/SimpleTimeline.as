import com.greensock.core.TweenCore;
/**
 * VERSION: 1.672
 * DATE: 2011-08-29
 * AS3 (AS2 version is also available)
 * UPDATES AND DOCS AT: http://www.TweenLite.com
 **/
intrinsic class com.greensock.core.SimpleTimeline extends TweenCore
{
	/** @private **/
	private var _firstChild : TweenCore;
	/** @private **/
	private var _lastChild : TweenCore;
	/**If a timeline's autoRemoveChildren is true, its children will be removed and made eligible for garbage collection as soon as they complete. This is the default behavior for the main/root timeline. **/
	public var autoRemoveChildren : Boolean;

	/**
		 * @private
		 * Reports the totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum) which can be useful when
		 * unpausing tweens/timelines. Imagine a case where a paused tween is in a timeline that has already reached the end, but then
		 * the tween gets unpaused - it needs a way to place itself accurately in time AFTER what was previously the timeline's end time.
		 * In a SimpleTimeline, rawTime is always the same as cachedTotalTime, but in TimelineLite and TimelineMax, it can be different.
		 * 
		 * @return The totalTime of the timeline without capping the number at the totalDuration (max) and zero (minimum)
		 */
	public function get rawTime() : Number;


	public function SimpleTimeline(vars:Object);

	/**
		 * Inserts a TweenLite, TweenMax, TimelineLite, or TimelineMax instance into the timeline at a specific time. 
		 * 
		 * @param tween TweenLite, TweenMax, TimelineLite, or TimelineMax instance to insert
		 * @param time The time in seconds (or frames for frames-based timelines) at which the tween/timeline should be inserted. For example, myTimeline.insert(myTween, 3) would insert myTween 3-seconds into the timeline.
		 * @return TweenLite, TweenMax, TimelineLite, or TimelineMax instance that was inserted
		 */
	public function insert(tween:TweenCore, time:Object) : TweenCore;

	/** @private **/
	public function remove(tween:TweenCore, skipDisable:Boolean) : Void;

	/** @inheritDoc **/
	public function renderTime(time:Number, suppressEvents:Boolean, force:Boolean) : Void;

}