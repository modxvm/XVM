import com.greensock.easing.*;
/**
 * EaseLookup enables you to find the easing function associated with a particular name (String), 
 * like "strongEaseOut" which can be useful when loading in XML data that comes in as Strings but 
 * needs to be translated to native function references.
 * 
 * <b>Copyright 2011, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
intrinsic class com.greensock.easing.EaseLookup
{
	/** @private **/
	static private var _lookup : Object;

	/**
		 * Finds the easing function associated with a particular name (String), like "strongEaseOut". This can be useful when
		 * loading in XML data that comes in as Strings but needs to be translated to native function references. You can pass in
		 * the name with or without the period, and it is case insensitive, so any of the following will find the Strong.easeOut function: <br /><br /><code>
		 * EaseLookup.find("Strong.easeOut") <br />
		 * EaseLookup.find("strongEaseOut") <br />
		 * EaseLookup.find("strongeaseout") <br /><br /></code>
		 * 
		 * You can translate Strings directly when tweening, like this: <br /><code>
		 * TweenLite.to(mc, 1, {x:100, ease:EaseLookup.find(myString)});<br /><br /></code>
		 * 
		 * @param name The name of the easing function, with or without the period and case insensitive (i.e. "Strong.easeOut" or "strongEaseOut")
		 * @return The easing function associated with the name
		 */
	static public function find(name:String) : Function;

	/** @private **/
	static private function buildLookup() : Void;

	/** @private **/
	static private function addInOut(easeClass:Function, names:Array) : Void;

}