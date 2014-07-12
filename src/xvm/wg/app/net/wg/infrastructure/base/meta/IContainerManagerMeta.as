package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContainerManagerMeta extends IEventDispatcher
   {
      
      function isModalViewsIsExistsS() : Boolean;
      
      function canCancelPreviousLoadingS(param1:String) : Boolean;
      
      function as_getView(param1:String) : Boolean;
      
      function as_show(param1:String, param2:int = 0, param3:int = 0) : Boolean;
      
      function as_hide(param1:String) : Boolean;
      
      function as_registerContainer(param1:String, param2:String) : void;
      
      function as_unregisterContainer(param1:String) : void;
      
      function as_closePopUps() : void;
      
      function as_isOnTop(param1:String, param2:String) : Boolean;
      
      function as_bringToFront(param1:String, param2:String) : void;
      
      function as_getNameByToken(param1:String) : String;
      
      function as_getViewTypeByToken(param1:String) : String;
   }
}
