package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ISettingsWindowMeta extends flash.events.IEventDispatcher
    {
        function closeWindowS():void;

        function applySettingsS(arg1:Object, arg2:Boolean):void;

        function autodetectQualityS():Number;

        function startVOIPTestS(arg1:Boolean):Boolean;

        function updateCaptureDevicesS():void;

        function onSettingsChangeS(arg1:String, arg2:Object):void;

        function altVoicesPreviewS():void;

        function isSoundModeValidS():Boolean;

        function showWarningDialogS(arg1:String, arg2:Object, arg3:Boolean):void;

        function as_setData(arg1:Object):void;

        function as_setCaptureDevices(arg1:Number, arg2:Array):void;

        function as_onVibroManagerConnect(arg1:Boolean):void;

        function as_updateVideoSettings(arg1:Object):void;

        function as_confirmWarningDialog(arg1:Boolean, arg2:String):void;
    }
}
