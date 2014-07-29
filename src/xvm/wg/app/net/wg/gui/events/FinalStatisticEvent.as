package net.wg.gui.events
{
    import flash.events.Event;
    
    public class FinalStatisticEvent extends Event
    {
        
        public function FinalStatisticEvent(param1:String, param2:Object = null)
        {
            super(param1,true,true);
            this.data = param2;
        }
        
        public static var EFFENSY_ICON_ROLL_OVER:String = "EffensyRollOver";
        
        public static var EFFENSY_ICON_ROLL_OUT:String = "EffensyRollOut";
        
        public static var SHOW_CONTEXT_MENU:String = "showContextMenu";
        
        public static var HIDE_STATS_VIEW:String = "hideStatsView";
        
        public var data:Object;
        
        override public function clone() : Event
        {
            return new FinalStatisticEvent(type,this.data);
        }
    }
}
