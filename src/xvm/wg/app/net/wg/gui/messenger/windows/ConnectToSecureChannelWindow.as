package net.wg.gui.messenger.windows
{
    import net.wg.gui.messenger.meta.impl.ConnectToSecureChannelWindowMeta;
    import net.wg.gui.messenger.meta.IConnectToSecureChannelWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.TextInput;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.InputEvent;
    import flash.display.InteractiveObject;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    
    public class ConnectToSecureChannelWindow extends ConnectToSecureChannelWindowMeta implements IConnectToSecureChannelWindowMeta
    {
        
        public function ConnectToSecureChannelWindow()
        {
            super();
        }
        
        private static var UPDATE_COMPONENTS:String = "update_components";
        
        public var titleLabel:TextField;
        
        public var channelInfoLabel:TextField;
        
        public var passwordLabel:TextField;
        
        public var passwordInput:TextInput;
        
        public var connectButton:SoundButtonEx;
        
        public var cancelButton:SoundButtonEx;
        
        private var isUpdated:Boolean = true;
        
        private var channelInfoText:String = "";
        
        public function as_infoMessage(param1:String) : void
        {
            this.channelInfoText = param1;
            this.isUpdated = false;
            invalidate(UPDATE_COMPONENTS);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            showWindowBgForm = false;
            window.useBottomBtns = true;
            window.title = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_TITLE;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.top = 41;
            _loc1_.left = 11;
            _loc1_.right = 8;
            _loc1_.bottom = 18;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(UPDATE_COMPONENTS)) && !this.isUpdated)
            {
                this.isUpdated = true;
                this.updateData();
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.connectButton.addEventListener(ButtonEvent.CLICK,this.connectButtonClickHandler);
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.cancelButtonClickHandler);
            this.titleLabel.text = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_WARRNING;
            this.passwordLabel.text = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_PASSWORD;
            this.passwordInput.addEventListener(InputEvent.INPUT,this.passwordInputHandler);
            App.utils.scheduler.envokeInNextFrame(this.onSetModalFocus);
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            this.passwordInput.validateNow();
            setFocus(this.passwordInput);
        }
        
        override protected function onDispose() : void
        {
            this.connectButton.removeEventListener(ButtonEvent.CLICK,this.connectButtonClickHandler);
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.cancelButtonClickHandler);
            super.onDispose();
        }
        
        private function connectButtonClickHandler(param1:ButtonEvent) : void
        {
            this.prepareSendPassword();
        }
        
        private function prepareSendPassword() : void
        {
            sendPasswordS(this.passwordInput.text);
        }
        
        private function cancelButtonClickHandler(param1:ButtonEvent) : void
        {
            cancelPasswordS();
        }
        
        private function passwordInputHandler(param1:InputEvent) : void
        {
            var _loc2_:InputDetails = param1.details;
            if(param1.details.code == Keyboard.ENTER && _loc2_.value == InputValue.KEY_UP)
            {
                param1.handled = true;
                this.prepareSendPassword();
            }
        }
        
        private function updateData() : void
        {
            this.channelInfoLabel.text = this.channelInfoText;
        }
    }
}
