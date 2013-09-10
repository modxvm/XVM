package net.wg.infrastructure.events 
{
    import flash.events.*;
    
    public class ColorSchemeEvent extends flash.events.Event
    {
        public function ColorSchemeEvent(arg1:String)
        {
            super(arg1);
            return;
        }

        public static const SCHEMAS_UPDATED:String="schemas";
    }
}
