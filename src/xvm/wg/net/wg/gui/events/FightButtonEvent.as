package net.wg.gui.events 
{
    import flash.events.*;
    
    public class FightButtonEvent extends flash.events.Event
    {
        public function FightButtonEvent(arg1:String, arg2:String=null, arg3:int=0)
        {
            super(arg1, true, true);
            this.option = arg2;
            this.mapID = arg3;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.FightButtonEvent(type, this.option);
        }

        public static const FIGHT_CLICK:String="fightClick";

        public static const SELECT_CLICK:String="selectClick";

        public var option:String;

        public var mapID:Number;
    }
}
