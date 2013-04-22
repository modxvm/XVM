import com.greensock.*;
import com.greensock.core.*;
/**
 * VERSION: 1.4
 * DATE: 2010-12-16
 * AS2
 * UPDATES AND DOCS AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.TweenPlugin
{
	/** @private **/
	static public var VERSION : Number;
	/** @private **/
	static public var API : Number;
	/** Name of the special property that the plugin should intercept/handle **/
	public var propName : String;
	/**
		 * Array containing the names of the properties that should be overwritten in OverwriteManager's 
		 * AUTO mode. Typically the only value in this Array is the propName, but there are cases when it may 
		 * be different. For example, a bezier tween's propName is "bezier" but it can manage many different properties 
		 * like _x, _y, etc. depending on what's passed in to the tween.
		 */
	public var overwriteProps : Array;
	/** If the values should be rounded to the nearest integer, set this to true. **/
	public var round : Boolean;
	/** Priority level in the render queue **/
	public var priority : Number;
	/** @private if the plugin actively changes properties of the target when it gets disabled (like the MotionBlurPlugin swaps out a temporary BitmapData for the target), activeDisplay should be true. Otherwise it should be false (it is much more common for it to be false). This is important because if it gets overwritten by another tween, that tween may init() with stale values - if activeDisable is true, it will force the new tween to re-init() when this plugin is overwritten (if ever). **/
	public var activeDisable : Boolean;
	/** @private Called when the tween has finished initting all of the properties in the vars object (useful for things like roundProps which must wait for everything else to init). IMPORTANT: in order for the onInitAllProps to get called properly, you MUST set the TweenPlugin's "priority" property to a non-zero value (this is for optimization and file size purposes) **/
	public var onInitAllProps : Function;
	/** Called when the tween is complete. **/
	public var onComplete : Function;
	/** Called when the tween gets re-enabled after having been initted. Like if it finishes and then gets restarted later. **/
	public var onEnable : Function;
	/** Called either when the plugin gets overwritten or when its parent tween gets killed/disabled **/
	public var onDisable : Function;
	/** @private **/
	private var _tweens : Array;
	/** @private **/
	private var _changeFactor : Number;

	/**
		 * In most cases, your custom updating code should go here. The changeFactor value describes the amount 
		 * of change based on how far along the tween is and the ease applied. It will be zero at the beginning
		 * of the tween and 1 at the end, but inbetween it could be any value based on the ease applied (for example, 
		 * an Elastic tween would cause the value to shoot past 1 and back again before the end of the tween) 
		 * This value gets updated on every frame during the course of the tween.
		 * 
		 * @param n Multiplier describing the amount of change that should be applied. It will be zero at the beginning of the tween and 1 at the end, but inbetween it could be any value based on the ease applied (for example, an Elastic tween would cause the value to shoot past 1 and back again before the end of the tween) 
		 */
	public function get changeFactor() : Number;
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function TweenPlugin();

	/**
		 * Gets called when any tween of the special property begins. Store any initial values
		 * and/or variables that will be used in the "changeFactor" setter when this method runs. 
		 * 
		 * @param target target object of the TweenLite instance using this plugin
		 * @param value The value that is passed in through the special property in the tween. 
		 * @param tween The TweenLite or TweenMax instance using this plugin.
		 * @return If the initialization failed, it returns false. Otherwise true. It may fail if, for example, the plugin requires that the target be a DisplayObject or has some other unmet criteria in which case the plugin is skipped and a normal property tween is used inside TweenLite
		 */
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

	/**
		 * Offers a simple way to add tweening values to the plugin. You don't need to use this,
		 * but it is convenient because the tweens get updated in the updateTweens() method which also 
		 * handles rounding. killProps() nicely integrates with most tweens added via addTween() as well,
		 * but if you prefer to handle this manually in your plugin, you're welcome to.
		 *  
		 * @param object target object whose property you'd like to tween. (i.e. myClip)
		 * @param propName the property name that should be tweened. (i.e. "_x")
		 * @param start starting value
		 * @param end end value (can be either numeric or a string value. If it's a string, it will be interpreted as relative to the starting value)
		 * @param overwriteProp name of the property that should be associated with the tween for overwriting purposes. Normally, it's the same as propName, but not always. For example, you may tween the "changeFactor" property of a VisiblePlugin, but the property that it's actually controling in the end is "visible", so if a new overlapping tween of the target object is created that affects its "visible" property, this allows the plugin to kill the appropriate tween(s) when killProps() is called. 
		 */
	private function addTween(object:Object, propName:String, start:Number, end:Object, overwriteProp:String) : Void;

	/**
		 * Updates all the tweens in the _tweens Array. 
		 *  
		 * @param changeFactor Multiplier describing the amount of change that should be applied. It will be zero at the beginning of the tween and 1 at the end, but inbetween it could be any value based on the ease applied (for example, an Elastic tween would cause the value to shoot past 1 and back again before the end of the tween) 
		 */
	private function updateTweens(changeFactor:Number) : Void;

	/**
		 * Gets called on plugins that have multiple overwritable properties by OverwriteManager when 
		 * in AUTO mode. Basically, it instructs the plugin to overwrite certain properties. For example,
		 * if a bezier tween is affecting _x, _y, and _width, and then a new tween is created while the 
		 * bezier tween is in progress, and the new tween affects the "_x" property, we need a way
		 * to kill just the "_x" part of the bezier tween. 
		 * 
		 * @param lookup An object containing properties that should be overwritten. We don't pass in an Array because looking up properties on the object is usually faster because it gives us random access. So to overwrite the "_x" and "_y" properties, a {_x:true, _y:true} object would be passed in. 
		 */
	public function killProps(lookup:Object) : Void;

	/**
		 * @private
		 * This method is called inside TweenLite after significant events occur, like when a tween
		 * has finished initializing, when it has completed, and when its "enabled" property changes.
		 * For example, the MotionBlurPlugin must run after normal _x/_y/_alpha PropTweens are rendered,
		 * so the "init" event reorders the PropTweens linked list in order of priority. Some plugins
		 * need to do things when a tween completes or when it gets disabled. Again, this 
		 * method is only for internal use inside TweenLite. It is separated into
		 * this static method in order to minimize file size inside TweenLite.
		 * 
		 * @param type The type of event "onInitAllProps", "onComplete", "onEnable", or "onDisable"
		 * @param tween The TweenLite/Max instance to which the event pertains
		 * @return A Boolean value indicating whether or not properties of the tween's target may have changed as a result of the event
		 */
	static private function onTweenEvent(type:String, tween:TweenLite) : Boolean;

	/**
		 * Handles integrating the plugin into the GreenSock tweening platform. 
		 * 
		 * @param plugin An Array of Plugin classes (that all extend TweenPlugin) to be activated. For example, TweenPlugin.activate([FrameLabelPlugin, ShortRotationPlugin, TintPlugin]);
		 */
	static public function activate(plugins:Array) : Boolean;

}