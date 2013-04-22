import com.greensock.*;
import com.greensock.core.*;
/**
 * VERSION: 6.1
 * DATE: 2010-12-20
 * AS2 (AS3 is also available)
 * UPDATES AND DOCUMENTATION AT: http://www.TweenLite.com
 **/
intrinsic class com.greensock.OverwriteManager
{
	/** @private **/
	static public var version : Number;
	/** Won't overwrite any other tweens **/
	static public var NONE : Number;
	/** Overwrites all existing tweens of the same target immediately when the tween is created **/
	static public var ALL_IMMEDIATE : Number;
	/** Only overwrites individual overlapping tweening properties in other tweens of the same target. TweenMax, TimelineLite, and TimelineMax automatically init() OverwriteManager in this mode if you haven't already called OverwriteManager.init(). **/
	static public var AUTO : Number;
	/** Overwrites tweens of the same target that are active when the tween renders for the first time. **/
	static public var CONCURRENT : Number;
	/** Overwrites all tweens of the same target (regardless of overlapping properties or timing) when the tween renders for the first time as opposed to ALL_IMMEDIATE which performs overwriting immediately when the tween is created. **/
	static public var ALL_ONSTART : Number;
	/** Overwrites tweens of the same target that existed before this tween regardless of their start/end time or active state or overlapping properties. **/
	static public var PREEXISTING : Number;
	/** The default overwrite mode for all TweenLite and TweenMax instances **/
	static public var mode : Number;
	/** @private **/
	static public var enabled : Boolean;

	/** 
		 * Initializes OverwriteManager and sets the default management mode. Options include: 
		 * <ul>
		 * 		<li><b> NONE (0):</b> 
		 * 					<ol>
		 * 						<li><b>When:</b> Never</li>
		 * 						<li><b>Finds:</b> Nothing</li>
		 * 						<li><b>Kills:</b> Nothing</li>
		 * 						<li><b>Performance:</b> Excellent</li>
		 * 						<li><b>Good for:</b> When you know that your tweens won't conflict and you want maximum speed.</li>
		 * 					</ol>
		 * 		</li>
		 * 				
		 * 		<li><b> ALL_IMMEDIATE (1):</b> 
		 * 					<ol>
		 * 						<li><b>When:</b> Immediately when the tween is created.</li>
		 * 						<li><b>Finds:</b> All tweens of the same target (regardless of timing or overlapping properties).</li>
		 * 						<li><b>Kills:</b> Every tween found</li>
		 * 						<li><b>Performance:</b> Excellent</li>
		 * 						<li><b>Good for:</b> When you want the tween to take priority over all other tweens of the 
		 * 											 same target, like on button rollovers/rollouts. However, this mode is 
		 * 											 bad for setting up sequences.</li>
		 * 					</ol>
		 * 					This is the default mode for TweenLite unless TweenMax, TimelineLite, 
		 * 					or TimelineMax are used in the SWF (in which case <code>AUTO</code> is the default mode).
		 * 		</li>
		 * 					
		 * 		<li><b> AUTO (2):</b> 
		 * 					<ol>
		 * 						<li><b>When:</b> The first time the tween renders (you can <code>invalidate()</code> a tween to force it 
		 * 										 to re-init and run its overwriting routine again next time it renders)</li>
		 * 						<li><b>Finds:</b> Only tweens of the same target that are active (running). Tweens that haven't started yet are immune.</li>
		 * 						<li><b>Kills:</b> Only individual overlapping tweening properties. If all tweening properties 
		 * 										  have been overwritten, the entire tween will be killed as well.</li>
		 * 						<li><b>Performance:</b> Very good when there aren't many overlapping tweens; fair when there are.</li>
		 * 						<li><b>Good for:</b> Virtually all situations. This mode does the best job overall of handling 
		 * 											 overwriting in an intuitive way and is excellent for sequencing. </li>
		 * 					</ol>
		 * 					This is the default mode when TweenMax, TimelineLite, or TimelineMax is used in your swf (those classes
		 * 					automatically init() OverwriteManager in <code>AUTO</code> mode unless you have already initted OverwriteManager manually).
		 * 		</li>
		 * 					
		 * 		<li><b> CONCURRENT (3):</b> 
		 * 					<ol>
		 * 						<li><b>When:</b> The first time the tween renders (you can <code>invalidate()</code> a tween to force it 
		 * 										 to re-init and run its overwriting routine again next time it renders)</li>
		 * 						<li><b>Finds:</b> Only tweens of the same target that are active (running). Tweens that haven't started yet are immune.</li>
		 * 						<li><b>Kills:</b> Every tween found</li>
		 * 						<li><b>Performance:</b> Very good</li>
		 * 						<li><b>Good for:</b> When you want the target object to only be controled by one tween at a time. Good
		 * 											 for sequencing although AUTO mode is typically better because it will only kill
		 * 											 individual overlapping properties instead of entire tweens.</li>
		 * 					</ol>
		 * 		</li>
		 * 				
		 * 		<li><b> ALL_ONSTART (4):</b> 
		 * 					<ol>
		 * 						<li><b>When:</b> The first time the tween renders (you can <code>invalidate()</code> a tween to force it 
		 * 										 to re-init and run its overwriting routine again next time it renders)</li>
		 * 						<li><b>Finds:</b> All tweens of the same target (regardless of timing or overlapping properties).</li>
		 * 						<li><b>Kills:</b> Every tween found</li>
		 * 						<li><b>Performance:</b> Very good</li>
		 * 						<li><b>Good for:</b> When you want a tween to take priority and wipe out all other tweens of the 
		 * 											 same target even if they start later. This mode is rarely used.</li>
		 * 					</ol>
		 * 		</li>
		 * 
		 * 		<li><b> PREEXISTING (5):</b> 
		 * 					<ol>
		 * 						<li><b>When:</b> The first time the tween renders (you can <code>invalidate()</code> a tween to force it 
		 * 										 to re-init and run its overwriting routine again next time it renders)</li>
		 * 						<li><b>Finds:</b> Only the tweens of the same target that were created before this tween was created 
		 * 										  (regardless of timing or overlapping properties). Virtually identical to <code>ALL_IMMEDIATE</code>
		 * 										  except that <code>PREEXISTING</code> doesn't run its overwriting routines until it renders for the
		 * 										  first time, meaning that if it has a delay, other tweens won't be overwritten until the delay expires.</li>
		 * 						<li><b>Kills:</b> Every tween found</li>
		 * 						<li><b>Performance:</b> Very good</li>
		 * 						<li><b>Good for:</b> When the order in which your code runs plays a critical role, like when tweens
		 * 											 that you create later should always take precidence over previously created ones
		 * 											 regardless of when they're scheduled to run. If <code>ALL_IMMEDIATE</code> is great except
		 * 											 that you want to wait on overwriting until the tween begins, <code>PREEXISTING</code> is perfect.</li>
		 * 					</ol>
		 * 		</li>
		 * 	</ul>
		 * 
		 * @param defaultMode The default mode that OverwriteManager should use.
		 **/
	static public function init(defaultMode:Number) : Number;

	/** 
		 * @private
		 * @return Boolean value indicating whether or not properties may have changed on the target when overwriting occurred. For example, when a motionBlur (plugin) is disabled, it swaps out a BitmapData for the target and may alter the alpha. We need to know this in order to determine whether or not the new tween should be re-initted() with the changed properties. 
		 **/
	static public function manageOverwrites(tween:TweenLite, props:Object, targetTweens:Array, mode:Number) : Boolean;

	/** @private **/
	static public function getGlobalPaused(tween:TweenCore) : Boolean;

}