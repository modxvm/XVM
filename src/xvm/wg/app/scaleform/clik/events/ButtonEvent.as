package scaleform.clik.events 
{
    import flash.events.*;
    
    public class ButtonEvent extends flash.events.Event
    {
        public function ButtonEvent(arg1:String, arg2:Boolean=true, arg3:Boolean=false, arg4:uint=0, arg5:uint=0, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, arg2, arg3);
            this.controllerIdx = arg4;
            this.buttonIdx = arg5;
            this.isKeyboard = arg6;
            this.isRepeat = arg7;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.ButtonEvent(type, bubbles, cancelable, this.controllerIdx, this.buttonIdx, this.isKeyboard, this.isRepeat);
        }

        public override function toString():String
        {
            return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "controllerIdx", "buttonIdx", "isKeyboard", "isRepeat");
        }

        public static const PRESS:String="buttonPress";

        public static const CLICK:String="buttonClick";

        public static const DRAG_OVER:String="dragOver";

        public static const DRAG_OUT:String="dragOut";

        public static const RELEASE_OUTSIDE:String="releaseOutside";

        public var controllerIdx:uint=0;

        public var buttonIdx:uint=0;

        public var isKeyboard:Boolean=false;

        public var isRepeat:Boolean=false;
    }
}
