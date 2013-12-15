package net.wg.infrastructure.events
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IView;


   public class LoaderEvent extends Event
   {
          
      public function LoaderEvent(param1:String, param2:Object, param3:String=null, param4:IView=null) {
         super(param1,true,true);
         this.config = param2;
         this.token = param3;
         this.view = param4;
      }

      public static const VIEW_LOADED:String = "viewLoaded";

      public static const VIEW_LOADING:String = "viewLoading";

      public static const CURSOR_LOADED:String = "cursorLoaded";

      public static const WAITING_LOADED:String = "waitingLoaded";

      public static const VIEW_LOAD_ERROR:String = "viewLoadError";

      public static const VIEW_INIT_ERROR:String = "viewInitError";

      public var view:IView;

      public var config:Object;

      public var token:String;

      override public function clone() : Event {
         return new LoaderEvent(type,this.config,this.token,this.view);
      }
   }

}