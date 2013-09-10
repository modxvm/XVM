package net.wg.gui.messenger 
{
    import flash.ui.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.messenger.meta.*;
    import net.wg.gui.messenger.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class ChannelComponent extends net.wg.gui.messenger.meta.impl.ChannelComponentMeta implements net.wg.gui.messenger.meta.IChannelComponentMeta, scaleform.clik.interfaces.IUIComponent
    {
        public function ChannelComponent()
        {
            super();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this.messageInput.maxChars = getMessageMaxLengthS();
            this._isJoined = isJoinedS();
            invalidate(INVALIDATE_CONTROLS);
            if (this._isJoined) 
            {
                invalidate(INVALIDATE_HISTORY);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=new net.wg.gui.messenger.SmileyMap();
            this.sendButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSendBtnClick, false, 0, true);
            this.messageInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleTextInput);
            this.messageArea.autoScroll = true;
            this.messageArea.htmlText = "";
            this.messageArea.editable = false;
            this.messageArea.selectable = true;
            this.messageArea.textField.selectable = true;
            this.setFocusToInput();
            loc1.mapText(this.messageArea.textField);
            return;
        }

        public function setFocusToInput():void
        {
            if (initialized && isJoinedS()) 
            {
                this.updateFocus();
            }
            return;
        }

        internal function updateFocus():void
        {
            if (this.messageInput && this.messageInput.enabled && this.messageInput.focused == 0) 
            {
                this.messageInput.validateNow();
                App.utils.focusHandler.setFocus(this.messageInput);
            }
            return;
        }

        public function as_setJoined(arg1:Boolean):void
        {
            this._isJoined = arg1;
            this.enableControls(this._isJoined);
            if (this._isJoined) 
            {
                this.setHistory();
            }
            return;
        }

        internal function enableControls(arg1:Boolean):void
        {
            this.messageInput.enabled = arg1;
            this.sendButton.enabled = arg1;
            return;
        }

        public function as_addMessage(arg1:String):void
        {
            if (arg1) 
            {
                this.messageArea.appendHtmlResetPosition(arg1 + "\n");
                if (this.messageArea.textField.scrollV < this.messageArea.textField.maxScrollV) 
                {
                    this.messageArea.safePosition = true;
                }
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.sendButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSendBtnClick);
            this.sendButton.dispose();
            this.messageInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleTextInput);
            this.messageArea.dispose();
            if (this.messageAreaScrollBar) 
            {
                this.messageAreaScrollBar.dispose();
            }
            return;
        }

        internal function onSendBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.doMessage();
            return;
        }

        internal function doMessage():void
        {
            if (this.messageInput.text) 
            {
                if (sendMessageS(this.messageInput.text)) 
                {
                    this.messageInput.text = "";
                }
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_CONTROLS)) 
            {
                this.enableControls(this._isJoined);
            }
            if (isInvalid(INVALIDATE_HISTORY) && this._isJoined) 
            {
                this.setHistory();
            }
            return;
        }

        internal function setHistory():void
        {
            if (getHistoryS()) 
            {
                this.messageArea.htmlText = getHistoryS() + "\n";
            }
            else 
            {
                this.messageArea.htmlText = "";
            }
            this.updateFocus();
            return;
        }

        internal function handleTextInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=arg1.details;
            if (arg1.details.code == flash.ui.Keyboard.ENTER && loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                arg1.handled = true;
                this.doMessage();
            }
            return;
        }

        internal static const INVALIDATE_CONTROLS:String="invalidateControls";

        internal static const INVALIDATE_HISTORY:String="invalidateHistory";

        public var messageAreaScrollBar:net.wg.gui.components.controls.ScrollBar=null;

        public var messageArea:net.wg.gui.components.advanced.TextAreaSimple=null;

        public var sendButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var messageInput:net.wg.gui.components.controls.TextInput=null;

        internal var _isJoined:Boolean=false;
    }
}
