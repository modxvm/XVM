package net.wg.gui.messenger.windows 
{
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.messenger.meta.*;
    import net.wg.gui.messenger.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class ConnectToSecureChannelWindow extends net.wg.gui.messenger.meta.impl.ConnectToSecureChannelWindowMeta implements net.wg.gui.messenger.meta.IConnectToSecureChannelWindowMeta
    {
        public function ConnectToSecureChannelWindow()
        {
            super();
            return;
        }

        public function as_infoMessage(arg1:String):void
        {
            this.channelInfoText = arg1;
            this.isUpdated = false;
            invalidate(UPDATE_COMPONENTS);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            showWindowBg = false;
            window.useBottomBtns = true;
            window.title = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_TITLE;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.top = 41;
            loc1.left = 11;
            loc1.right = 8;
            loc1.bottom = 18;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_COMPONENTS) && !this.isUpdated) 
            {
                this.isUpdated = true;
                this.updateData();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.connectButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.connectButtonClickHandler);
            this.cancelButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelButtonClickHandler);
            this.titleLabel.text = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_WARRNING;
            this.passwordLabel.text = MESSENGER.DIALOGS_CONNECTINGTOSECURECHANNEL_LABELS_PASSWORD;
            this.passwordInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.passwordInputHandler);
            App.utils.scheduler.envokeInNextFrame(this.setFocus);
            return;
        }

        public override function setFocus():void
        {
            this.passwordInput.validateNow();
            App.utils.focusHandler.setFocus(this.passwordInput);
            return;
        }

        protected override function onDispose():void
        {
            this.connectButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.connectButtonClickHandler);
            this.cancelButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelButtonClickHandler);
            super.onDispose();
            return;
        }

        internal function connectButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.prepareSendPassword();
            return;
        }

        internal function prepareSendPassword():void
        {
            sendPasswordS(this.passwordInput.text);
            return;
        }

        internal function cancelButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            cancelPasswordS();
            return;
        }

        internal function passwordInputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=arg1.details;
            if (arg1.details.code == flash.ui.Keyboard.ENTER && loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                arg1.handled = true;
                this.prepareSendPassword();
            }
            return;
        }

        internal function updateData():void
        {
            this.channelInfoLabel.text = this.channelInfoText;
            return;
        }

        internal static const UPDATE_COMPONENTS:String="update_components";

        public var titleLabel:flash.text.TextField;

        public var channelInfoLabel:flash.text.TextField;

        public var passwordLabel:flash.text.TextField;

        public var passwordInput:net.wg.gui.components.controls.TextInput;

        public var connectButton:net.wg.gui.components.controls.SoundButtonEx;

        public var cancelButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var isUpdated:Boolean=true;

        internal var channelInfoText:String="";
    }
}
