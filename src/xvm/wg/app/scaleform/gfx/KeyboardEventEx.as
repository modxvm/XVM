package scaleform.gfx
{
   import flash.events.KeyboardEvent;
   
   public final class KeyboardEventEx extends KeyboardEvent
   {
      
      public function KeyboardEventEx(param1:String) {
         super(param1);
      }
      
      public var controllerIdx:uint = 0;
   }
}
