package net.wg.infrastructure.base.meta
{
    import flash.events.*;

    public interface ILoginPageMeta extends flash.events.IEventDispatcher
    {
        function onLoginS(arg1:String, arg2:String, arg3:String):void;

        function onRegisterS():void;

        function onRecoveryS():void;

        function onSetRememberPasswordS(arg1:Boolean):void;

        function onExitFromAutoLoginS():void;

        function doUpdateS():void;

        function isTokenS():Boolean;

        function resetTokenS():void;

        function onEscapeS():void;

        function isPwdInvalidS(arg1:String):Boolean;

        function isLoginInvalidS(arg1:String):Boolean;

        function as_setDefaultValues(arg1:String, arg2:String, arg3:Boolean, arg4:Boolean, arg5:Boolean):void;

        function as_setErrorMessage(arg1:String, arg2:int):void;

        function as_setServersList(arg1:Array, arg2:int):void;

        function as_setVersion(arg1:String):void;

        function as_showWallpaper(arg1:Boolean, arg2:String):void;

        function as_setCapsLockState(arg1:Boolean):void;

        function as_cancelLoginQueue():void;

        function as_doAutoLogin():void;

        function as_enable(arg1:Boolean):void;
    }
}
