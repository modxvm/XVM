package scaleform.gfx 
{
    import flash.events.*;
    
    public final class FocusEventEx extends flash.events.FocusEvent
    {
        public function FocusEventEx(arg1:String)
        {
            super(arg1);
            return;
        }

        public var controllerIdx:uint=0;
    }
}
