package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ILoginPageMeta extends IEventDispatcher
   {
          
      function onLoginS(param1:String, param2:String, param3:String) : void;

      function onRegisterS() : void;

      function onRecoveryS() : void;

      function onSetRememberPasswordS(param1:Boolean) : void;

      function onExitFromAutoLoginS() : void;

      function doUpdateS() : void;

      function isTokenS() : Boolean;

      function resetTokenS() : void;

      function onEscapeS() : void;

      function isPwdInvalidS(param1:String) : Boolean;

      function isLoginInvalidS(param1:String) : Boolean;

      function as_setDefaultValues(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void;

      function as_setErrorMessage(param1:String, param2:int) : void;

      function as_setServersList(param1:Array, param2:int) : void;

      function as_setVersion(param1:String) : void;

      function as_showWallpaper(param1:Boolean, param2:String) : void;

      function as_setCapsLockState(param1:Boolean) : void;

      function as_cancelLoginQueue() : void;

      function as_doAutoLogin() : void;

      function as_enable(param1:Boolean) : void;
   }

}