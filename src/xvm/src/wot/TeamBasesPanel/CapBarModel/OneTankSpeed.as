class wot.TeamBasesPanel.CapBarModel.OneTankSpeed
{
   /**
    * Minimal capturing speed values for various battle types.
    * Average for one cycle - two updates.
    * 
    * Cap speed may differ by map??
    * El halloof, Himmel 0.4, 0.835
    * Any other map 0.5, 1
    */
    
    public static var MIN_SPEED_ENCOUNTER:Number = 0.4;
    public static var MIN_SPEED_OTHER:Number = 1; /** For Standart battle type and Assault */
    
    private static var ENCOUNTER_INTERNAL_TYPE:String = "#arenas:type/domination/name";
    
    public static function get speed():Number
    {
        /**
         * _root.statsData.arenaData.battleName values are
         * "#arenas:type/domination/name" for encounter battle type
         * "#arenas:type/ctf/name" for standart battle type
         * Did not test Assault type
         */
        
        if (_root.statsData.arenaData.battleName == ENCOUNTER_INTERNAL_TYPE)
        {
            return MIN_SPEED_ENCOUNTER;
        }
        
        return MIN_SPEED_OTHER;
    }
}
