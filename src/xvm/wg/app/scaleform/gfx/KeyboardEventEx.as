package scaleform.gfx 
{
    import flash.events.*;
    
    public final class KeyboardEventEx extends flash.events.KeyboardEvent
    {
        public function KeyboardEventEx(arg1:String)
        {
            super(arg1);
            return;
        }

        public var controllerIdx:uint=0;
    }
}
