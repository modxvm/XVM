/**
 * VERSION: 2.1
 * DATE: 2009-09-12
 * AS2 (AS3 version is also available)
 * UPDATES AND DOCUMENTATION AT: http://www.TweenLite.com
 **/
intrinsic class com.greensock.core.PropTween
{
	/** Target object **/
	public var target : Object;
	/** Name of the property that is being tweened **/
	public var property : String;
	/** Starting value  **/
	public var start : Number;
	/** Amount to change (basically, the difference between the starting value and ending value) **/
	public var change : Number;
	/** Alias to associate with the PropTween which is typically the same as the property, but can be different, particularly for plugins. **/
	public var name : String;
	/** Priority in the rendering queue. The lower the value the later it will be tweened. Typically all PropTweens get a priority of 0, but some plugins must be rendered later (or earlier) **/
	public var priority : Number;
	/** If the target of the PropTween is a TweenPlugin, isPlugin should be true. **/
	public var isPlugin : Boolean;
	/** Next PropTween in the linked list **/
	public var nextNode : PropTween;
	/** Previous PropTween in the linked list **/
	public var prevNode : PropTween;

	/**
		 * Constructor
		 * 
		 * @param target Target object
		 * @param property Name of the property that is being tweened
		 * @param start Starting value
		 * @param change Amount to change (basically, the difference between the starting value and ending value)
		 * @param name Alias to associate with the PropTween which is typically the same as the property, but can be different, particularly for plugins.
		 * @param isPlugin If the target of the PropTween is a TweenPlugin, isPlugin should be true.
		 * @param nextNode Next PropTween in the linked list
		 * @param priority Priority in the rendering queue. The lower the value the later it will be tweened. Typically all PropTweens get a priority of 0, but some plugins must be rendered later (or earlier)
		 */
	public function PropTween(target:Object, property:String, start:Number, change:Number, name:String, isPlugin:Boolean, nextNode:PropTween, priority:Number);

}