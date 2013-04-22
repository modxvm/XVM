intrinsic class com.xvm.Round
{
	/**
     * Without rounding speed values vary too much.
     * 0.4, 0.41, 0.39
     * Such errors may lead to inaccurate calculation.
     * 
     * "to" val of 100 rounds 0.40999999 to 0.41
     */
	static public function round(num:Number, to:Number) : Number;

}