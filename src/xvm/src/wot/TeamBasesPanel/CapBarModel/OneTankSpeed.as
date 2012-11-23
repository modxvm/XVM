class wot.TeamBasesPanel.CapBarModel.OneTankSpeed
{
   /**
    * Minimal capturing speed values for various battle types.
    * Average for one cycle - two updates.
    * 
    * Cap speed may differ by map.
    * El halloof, Himmel 0.4, 0.835
    * Any other map 0.5, 1
    */
    
    public static var MIN_SPEED_ENCOUNTER:Number = 0.4;
    public static var MIN_SPEED_STANDART:Number = 1;
    
    private static var s_minimalCapSpeed:Number = MIN_SPEED_STANDART; 
    
    public static function checkSpeed(speed:Number):Void
    {
        if (speed == MIN_SPEED_ENCOUNTER)
            s_minimalCapSpeed = MIN_SPEED_ENCOUNTER;
    }
    
    public static function get speed():Number
    {
        return s_minimalCapSpeed;
    }
    
}