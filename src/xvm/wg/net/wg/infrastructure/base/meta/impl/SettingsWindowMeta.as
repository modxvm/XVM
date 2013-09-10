package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class SettingsWindowMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function SettingsWindowMeta()
        {
            super();
            return;
        }

        public function closeWindowS():void
        {
            App.utils.asserter.assertNotNull(this.closeWindow, "closeWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.closeWindow();
            return;
        }

        public function applySettingsS(arg1:Object, arg2:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.applySettings, "applySettings" + net.wg.data.constants.Errors.CANT_NULL);
            this.applySettings(arg1, arg2);
            return;
        }

        public function autodetectQualityS():Number
        {
            App.utils.asserter.assertNotNull(this.autodetectQuality, "autodetectQuality" + net.wg.data.constants.Errors.CANT_NULL);
            return this.autodetectQuality();
        }

        public function startVOIPTestS(arg1:Boolean):Boolean
        {
            App.utils.asserter.assertNotNull(this.startVOIPTest, "startVOIPTest" + net.wg.data.constants.Errors.CANT_NULL);
            return this.startVOIPTest(arg1);
        }

        public function updateCaptureDevicesS():void
        {
            App.utils.asserter.assertNotNull(this.updateCaptureDevices, "updateCaptureDevices" + net.wg.data.constants.Errors.CANT_NULL);
            this.updateCaptureDevices();
            return;
        }

        public function onSettingsChangeS(arg1:String, arg2:Object):void
        {
            App.utils.asserter.assertNotNull(this.onSettingsChange, "onSettingsChange" + net.wg.data.constants.Errors.CANT_NULL);
            this.onSettingsChange(arg1, arg2);
            return;
        }

        public function altVoicesPreviewS():void
        {
            App.utils.asserter.assertNotNull(this.altVoicesPreview, "altVoicesPreview" + net.wg.data.constants.Errors.CANT_NULL);
            this.altVoicesPreview();
            return;
        }

        public function isSoundModeValidS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isSoundModeValid, "isSoundModeValid" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isSoundModeValid();
        }

        public function showWarningDialogS(arg1:String, arg2:Object, arg3:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.showWarningDialog, "showWarningDialog" + net.wg.data.constants.Errors.CANT_NULL);
            this.showWarningDialog(arg1, arg2, arg3);
            return;
        }

        public var closeWindow:Function=null;

        public var applySettings:Function=null;

        public var autodetectQuality:Function=null;

        public var startVOIPTest:Function=null;

        public var updateCaptureDevices:Function=null;

        public var onSettingsChange:Function=null;

        public var altVoicesPreview:Function=null;

        public var isSoundModeValid:Function=null;

        public var showWarningDialog:Function=null;
    }
}
