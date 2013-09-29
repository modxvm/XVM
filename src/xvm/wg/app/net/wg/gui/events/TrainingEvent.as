package net.wg.gui.events 
{
    import flash.events.*;
    
    public class TrainingEvent extends flash.events.Event
    {
        public function TrainingEvent(arg1:String, arg2:Object=null, arg3:Array=null)
        {
            super(arg1, true, true);
            this.initObj = arg2;
            this.initArr = arg3;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.TrainingEvent(type, this.initObj, this.initArr);
        }

        public static const OPEN_TRAINING_ROOM:String="openTrainingRoom";

        public var initObj:Object;

        public var initArr:Array;
    }
}
