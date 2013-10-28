package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ILoginCreateAnAccountWindowMeta extends IEventDispatcher
   {
          
      function onRegisterS(param1:String) : void;

      function as_updateTexts(param1:String, param2:String, param3:String, param4:String) : void;

      function as_registerResponse(param1:Boolean, param2:String) : void;
   }

}