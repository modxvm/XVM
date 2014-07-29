package scaleform.gfx
{
    import flash.events.FocusEvent;
    
    public final class FocusEventEx extends FocusEvent
    {
        
        public function FocusEventEx(param1:String)
        {
            super(param1);
        }
        
        public var controllerIdx:uint = 0;
    }
}
