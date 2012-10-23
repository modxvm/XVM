class wot.TeamBasesPanel.TimeRound
{
    /**
     * Without rounding speed values vary too much.
     * 0.4, 0.41, 0.39
     * Such errors lead to inaccurate calculation.
     * 
     * "to" val of 100 rounds 0.40999999 to 0.41
     */
    public static function round(num:Number, to:Number):Number
    {
        num *= to;
        num = Math.round(num);
        num /= to;
        return num;
    }
}