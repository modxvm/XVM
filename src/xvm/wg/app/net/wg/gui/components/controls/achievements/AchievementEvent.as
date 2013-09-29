package net.wg.gui.components.controls.achievements 
{
    import flash.events.*;
    
    public class AchievementEvent extends flash.events.Event
    {
        public function AchievementEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.components.controls.achievements.AchievementEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("AchievementEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const REQUEST_RARE_ACHIEVEMENT:String="requestRareAchievement";
    }
}
