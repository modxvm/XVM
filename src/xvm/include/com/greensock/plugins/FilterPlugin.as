import com.greensock.core.*;
import com.greensock.plugins.*;
import flash.filters.*;
/**
 * VERSION: 2.03
 * DATE: 10/22/2009
 * AS2
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
intrinsic class com.greensock.plugins.FilterPlugin extends TweenPlugin
{
	/** @private **/
	static public var VERSION : Number;
	/** @private **/
	static public var API : Number;
	/** @private **/
	private var _target : Object;
	/** @private **/
	private var _type : Object;
	/** @private **/
	private var _filter : BitmapFilter;
	/** @private **/
	private var _index : Number;
	/** @private **/
	private var _remove : Boolean;

	/** @private **/
	public function set changeFactor(n:Number) : Void;


	/** @private **/
	public function FilterPlugin();

	/** @private **/
	private function initFilter(props:Object, defaultFilter:BitmapFilter, propNames:Array) : Void;

	/** @private **/
	public function onCompleteTween() : Void;

}