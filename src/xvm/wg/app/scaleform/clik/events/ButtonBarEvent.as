package scaleform.clik.events 
{
    import flash.events.*;
    import scaleform.clik.controls.*;
    
    public class ButtonBarEvent extends flash.events.Event
    {
        public function ButtonBarEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true, arg4:int=-1, arg5:scaleform.clik.controls.Button=null)
        {
            super(arg1, arg2, arg3);
            this.index = arg4;
            this.renderer = arg5;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.ButtonBarEvent(type, bubbles, cancelable, this.index, this.renderer);
        }

        public override function toString():String
        {
            return formatToString("ButtonBarEvent", "type", "bubbles", "cancelable", "index", "renderer");
        }

        public static const BUTTON_SELECT:String="buttonSelect";

        public var index:int=-1;

        public var renderer:scaleform.clik.controls.Button;
    }
}
