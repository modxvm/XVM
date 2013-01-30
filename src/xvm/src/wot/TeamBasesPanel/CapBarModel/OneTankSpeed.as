import wot.utils.Utils;

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
    
    private var m_speed:Number;
    
    public function OneTankSpeed()
    {
        m_speed = defineOneTankCapSpeed();
    }
    
    public function getSpeed():Number
    {
        return m_speed;
    }
    
    // -- Private
    
    private function defineOneTankCapSpeed():Number
    {
        var entries:Array = Utils.getChildrenOf(icons);
        /**
         * Search for white cap point.
         * It has "teamPoint" field and "vehicleClass": "empty".
         */
        for (var i in entries)
        {
            var entry:MovieClip = entries[i];
            if (entry.teamPoint && entry.vehicleClass == "empty")
            {
                return MIN_SPEED_ENCOUNTER;
            }
        }
        
        return MIN_SPEED_OTHER;
    }
    
    private function get icons():MovieClip
    {
        return _root.minimap.icons;
    }
}