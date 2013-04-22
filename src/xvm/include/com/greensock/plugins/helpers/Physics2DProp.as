/**
 * Stores information about Physics2DPlugin tweens. <br /><br />
 * 
 * <b>Copyright 2011, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
intrinsic class com.greensock.plugins.helpers.Physics2DProp
{
	public var start : Number;
	public var velocity : Number;
	public var v : Number;
	public var a : Number;
	public var value : Number;
	public var acceleration : Number;

	public function Physics2DProp(start:Number, velocity:Number, acceleration:Number, stepsPerTimeUnit:Number);

}