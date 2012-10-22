/**
 * ...
 * @author 
 */
class wot.TeamBasesPanel.TimeRound
{
    private static var TIME_ROUND:Number = 10; // val of 100 rounds 0.40999999 to 0.41
    
    /**
     * Without rounding speed values vary too much.
     * 0.4, 0.41, 0.39
     * Such errors lead to inaccurate calculation.
     */
    public static function round(num:Number):Number
    {
        num *= TIME_ROUND;
        num = Math.round(num);
        num /= TIME_ROUND;
        return num;
    }
}