package net.wg.gui.events 
{
    import flash.events.*;
    
    public class FinalStatisticEvent extends flash.events.Event
    {
        public function FinalStatisticEvent(arg1:String, arg2:Object=null)
        {
            super(arg1, true, true);
            this.data = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.FinalStatisticEvent(type, this.data);
        }

        public static const EFFENSY_ICON_ROLL_OVER:String="EffensyRollOver";

        public static const EFFENSY_ICON_ROLL_OUT:String="EffensyRollOut";

        public static const SHOW_CONTEXT_MENU:String="showContextMenu";

        public static const HIDE_STATS_VIEW:String="hideStatsView";

        public var data:Object;
    }
}
