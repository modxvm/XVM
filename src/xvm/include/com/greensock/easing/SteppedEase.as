/**
 * VERSION: 0.5
 * DATE: 2010-12-01
 * AS2
 * UPDATES AND DOCS AT: http://www.greensock.com/
 **/
intrinsic class com.greensock.easing.SteppedEase
{
	/** @private **/
	private var _steps : Number;
	/** @private **/
	private var _stepAmount : Number;
	/** Easing equation to which tweens should refer. **/
	public var ease : Function;

	/** Number of steps between the start and the end values. **/
	public function get steps() : Number;


	/**
	 * Constructor
	 * 
	 * @param steps Number of steps between the start and the end values. 
	 */
	public function SteppedEase(steps:Number);

	/**
	 * This static function provides a quick way to create a SteppedEase and immediately reference its ease function 
	 * in a tween, like:<br /><br /><code>
	 * 
	 * TweenLite.to(mc, 2, {_x:100, ease:SteppedEase.create(5)});<br />
	 * </code>
	 * 
	 * @param steps Number of steps between the start and the end values. 
	 * @return The easing function that can be plugged into a tween
	 */
	static public function create(steps:Number) : Function;

	/**
	 * Easing function that interpolates values. 
	 * 
	 * @param t time
	 * @param b start (should always be 0)
	 * @param c change (should always be 1)
	 * @param d duration
	 * @return Result of the ease
	 */
	public function easeProxy(t:Number, b:Number, c:Number, d:Number) : Number;

}