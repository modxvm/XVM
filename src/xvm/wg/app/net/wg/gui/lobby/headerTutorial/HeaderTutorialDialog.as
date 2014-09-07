package net.wg.gui.lobby.headerTutorial
{
    import net.wg.infrastructure.base.meta.impl.HeaderTutorialDialogMeta;
    import net.wg.infrastructure.base.meta.IHeaderTutorialDialogMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.VO.DialogSettingsVO;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.InteractiveObject;
    
    public class HeaderTutorialDialog extends HeaderTutorialDialogMeta implements IHeaderTutorialDialogMeta
    {
        
        public function HeaderTutorialDialog()
        {
            super();
            isCentered = true;
            isModal = true;
            canDrag = false;
        }
        
        public static var SUBMIT_BUTTON:String = "submit";
        
        public static var CLOSE_BUTTON:String = "close";
        
        private static var SETTINGS_INVALID:String = "settingsInv";
        
        public var textField:TextField;
        
        public var checkBox:CheckBox;
        
        public var submitBtn:SoundButtonEx;
        
        public var cancelBtn:SoundButtonEx;
        
        private var settings:DialogSettingsVO;
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
        }
        
        public function as_setSettings(param1:Object) : void
        {
            this.settings = new DialogSettingsVO(param1);
            invalidate(SETTINGS_INVALID);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.submitBtn.addEventListener(ButtonEvent.CLICK,this.handleBtnClick);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.handleBtnClick);
            this.textField.text = DIALOGS.HEADERTUTORIALDIALOG_MESSAGE;
            this.checkBox.label = DIALOGS.HEADERTUTORIALDIALOG_CHECKBOX;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(SETTINGS_INVALID))
            {
                if((window) && (this.settings))
                {
                    window.title = this.settings.title;
                    this.submitBtn.label = this.settings.submitBtnLabel;
                    this.cancelBtn.label = this.settings.cancelBtnLabel;
                }
            }
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.cancelBtn);
        }
        
        override protected function onDispose() : void
        {
            this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.handleBtnClick);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.handleBtnClick);
            this.checkBox.dispose();
            this.submitBtn.dispose();
            this.cancelBtn.dispose();
            this.textField = null;
            this.checkBox = null;
            this.submitBtn = null;
            this.cancelBtn = null;
            super.onDispose();
        }
        
        private function handleBtnClick(param1:ButtonEvent) : void
        {
            if(param1.target == this.submitBtn)
            {
                onButtonClickS(SUBMIT_BUTTON,this.checkBox.selected);
            }
            else
            {
                onButtonClickS(CLOSE_BUTTON,this.checkBox.selected);
            }
        }
    }
}
