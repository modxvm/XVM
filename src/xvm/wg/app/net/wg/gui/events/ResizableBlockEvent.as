package net.wg.gui.events
{
   import flash.events.Event;


   public class ResizableBlockEvent extends Event
   {
          
      public function ResizableBlockEvent(param1:String, param2:Boolean=false, param3:Number=undefined) {
         super(param1,true,true);
         this.contentWasChanged = param2;
         this.heightDiff = param3;
      }

      public static const READY_FOR_LAYOUT:String = "readyForLayout";

      public static const CONTETNT_WAS_CHANGED:String = "contentWasChanged";

      public static const CONTENT_IS_READY:String = "contentIsReady";

      public static const READY_FOR_ANIMATION:String = "readyForAnimation";

      public var contentWasChanged:Boolean = false;

      public var heightDiff:Number = 0;

      override public function clone() : Event {
         return new ResizableBlockEvent(type,this.contentWasChanged,this.heightDiff);
      }
   }

}