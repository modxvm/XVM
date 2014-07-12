package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISettingsWindowMeta extends IEventDispatcher
   {
      
      function applySettingsS(param1:Object, param2:Boolean) : void;
      
      function autodetectQualityS() : Number;
      
      function startVOIPTestS(param1:Boolean) : Boolean;
      
      function updateCaptureDevicesS() : void;
      
      function onSettingsChangeS(param1:String, param2:Object) : void;
      
      function altVoicesPreviewS() : void;
      
      function isSoundModeValidS() : Boolean;
      
      function showWarningDialogS(param1:String, param2:Object, param3:Boolean) : void;
      
      function onTabSelectedS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setCaptureDevices(param1:Number, param2:Array) : void;
      
      function as_onVibroManagerConnect(param1:Boolean) : void;
      
      function as_updateVideoSettings(param1:Object) : void;
      
      function as_confirmWarningDialog(param1:Boolean, param2:String) : void;
      
      function as_ConfirmationOfApplication(param1:Boolean) : void;
      
      function as_openTab(param1:Number) : void;
      
      function as_setGraphicsPreset(param1:Number) : void;
   }
}
