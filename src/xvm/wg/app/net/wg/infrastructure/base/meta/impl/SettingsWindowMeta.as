package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class SettingsWindowMeta extends AbstractWindowView
   {
          
      public function SettingsWindowMeta() {
         super();
      }

      public var applySettings:Function = null;

      public var autodetectQuality:Function = null;

      public var startVOIPTest:Function = null;

      public var updateCaptureDevices:Function = null;

      public var onSettingsChange:Function = null;

      public var altVoicesPreview:Function = null;

      public var isSoundModeValid:Function = null;

      public var showWarningDialog:Function = null;

      public var onTabSelected:Function = null;

      public function applySettingsS(param1:Object, param2:Boolean) : void {
         App.utils.asserter.assertNotNull(this.applySettings,"applySettings" + Errors.CANT_NULL);
         this.applySettings(param1,param2);
      }

      public function autodetectQualityS() : Number {
         App.utils.asserter.assertNotNull(this.autodetectQuality,"autodetectQuality" + Errors.CANT_NULL);
         return this.autodetectQuality();
      }

      public function startVOIPTestS(param1:Boolean) : Boolean {
         App.utils.asserter.assertNotNull(this.startVOIPTest,"startVOIPTest" + Errors.CANT_NULL);
         return this.startVOIPTest(param1);
      }

      public function updateCaptureDevicesS() : void {
         App.utils.asserter.assertNotNull(this.updateCaptureDevices,"updateCaptureDevices" + Errors.CANT_NULL);
         this.updateCaptureDevices();
      }

      public function onSettingsChangeS(param1:String, param2:Object) : void {
         App.utils.asserter.assertNotNull(this.onSettingsChange,"onSettingsChange" + Errors.CANT_NULL);
         this.onSettingsChange(param1,param2);
      }

      public function altVoicesPreviewS() : void {
         App.utils.asserter.assertNotNull(this.altVoicesPreview,"altVoicesPreview" + Errors.CANT_NULL);
         this.altVoicesPreview();
      }

      public function isSoundModeValidS() : Boolean {
         App.utils.asserter.assertNotNull(this.isSoundModeValid,"isSoundModeValid" + Errors.CANT_NULL);
         return this.isSoundModeValid();
      }

      public function showWarningDialogS(param1:String, param2:Object, param3:Boolean) : void {
         App.utils.asserter.assertNotNull(this.showWarningDialog,"showWarningDialog" + Errors.CANT_NULL);
         this.showWarningDialog(param1,param2,param3);
      }

      public function onTabSelectedS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.onTabSelected,"onTabSelected" + Errors.CANT_NULL);
         this.onTabSelected(param1);
      }
   }

}