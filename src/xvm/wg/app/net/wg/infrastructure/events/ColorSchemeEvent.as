package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class ColorSchemeEvent extends Event
   {
      
      public function ColorSchemeEvent(param1:String) {
         super(param1);
      }
      
      public static const SCHEMAS_UPDATED:String = "schemas";
   }
}
