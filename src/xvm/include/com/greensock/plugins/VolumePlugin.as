import com.greensock.*;
import com.greensock.plugins.*;
/**
 * VERSION: 1.12
 * DATE: 10/2/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.VolumePlugin extends TweenPlugin
{
	/** @private **/
	static public var API : Number;
	/** @private **/
	public var volume : Number;
	/** @private **/
	private var _sound : Sound;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function VolumePlugin();

	/** @private **/
	public function onInitTween(target:Object, value:Object, tween:TweenLite) : Boolean;

}