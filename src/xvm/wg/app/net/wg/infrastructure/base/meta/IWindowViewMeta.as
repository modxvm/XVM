package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IWindowViewMeta extends IEventDispatcher
   {
          
      function onWindowCloseS() : void;

      function onWindowMinimizeS() : void;

      function as_showWaiting(param1:String, param2:Object) : void;

      function as_hideWaiting() : void;

      function as_getGeometry() : Array;

      function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number) : void;
   }

}