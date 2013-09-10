package net.wg.gui.messenger.forms 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.messenger.evnts.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.managers.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class ChannelsCreateForm extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function ChannelsCreateForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.channelPasswordCheckBox.addEventListener(flash.events.Event.SELECT, this.onChannelPasswordCheckBox);
            this.channelCreateButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCreateChannelClick);
            this.onChannelPasswordCheckBox(null);
            this.channelNameInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            this.channelPasswordInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            this.channelRetypePasswordInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("channelNameLabel", this.channelNameLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelNameInput", this.channelNameInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelPasswordLabel", this.channelPasswordLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelPasswordCheckBox", this.channelPasswordCheckBox, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelFillPasswordLabel", this.channelFillPasswordLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelPasswordInput", this.channelPasswordInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelRetypePasswordLabel", this.channelRetypePasswordLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelRetypePasswordInput", this.channelRetypePasswordInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("channelCreateButton", this.channelCreateButton, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.BOTTOM);
            constraints.addElement("bg", this.bg, scaleform.clik.utils.Constraints.ALL);
            App.utils.scheduler.envokeInNextFrame(this.setFocusToInput);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
                return;
            var loc1:*=arg1.details;
            var loc2:*=loc1.controllerIndex;
            if (loc1.navEquivalent != null) 
                if (loc1.code != flash.ui.Keyboard.SPACE) 
                {
                    var loc3:*=loc1.navEquivalent;
                    switch (loc3) 
                    {
                        case scaleform.clik.constants.NavigationCode.ENTER:
                            if (loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
                            {
                                this.handlePress(loc2);
                                arg1.handled = true;
                            }
                            break;
                    }
                }
            else if (loc1.code == flash.ui.Keyboard.ENTER) 
            {
                this.handlePress(loc2);
                arg1.handled = true;
            }
            return;
        }

        internal function handlePress(arg1:uint):void
        {
            this.onCreateChannelClick(null);
            return;
        }

        internal function onCreateChannelClick(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            var loc1:*=this.channelNameInput.text;
            var loc2:*=this.channelPasswordCheckBox.selected;
            var loc3:*=loc2 ? this.channelPasswordInput.text : null;
            var loc4:*=loc2 ? this.channelRetypePasswordInput.text : null;
            dispatchEvent(new net.wg.gui.messenger.evnts.ChannelsFormEvent(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_CREATE_CHANNEL, true, false, loc1, loc3, loc4));
            return;
        }

        internal function setFocusToInput():void
        {
            if (this.channelNameInput.enabled) 
            {
                this.channelNameInput.validateNow();
                scaleform.clik.managers.FocusHandler.getInstance().setFocus(this.channelNameInput);
            }
            return;
        }

        internal function onChannelPasswordCheckBox(arg1:flash.events.Event=null):void
        {
            this.usePassword = this.channelPasswordCheckBox.selected;
            var loc1:*;
            this.channelRetypePasswordInput.enabled = loc1 = this.usePassword;
            this.channelPasswordInput.enabled = loc1 = loc1;
            this.channelRetypePasswordLabel.enabled = loc1 = loc1;
            this.channelFillPasswordLabel.enabled = loc1;
            invalidate(UPDATE_PASSWORD_TEXT);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (constraints && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                constraints.update(_width, _height);
            if (this.channelPasswordInput && isInvalid(UPDATE_PASSWORD_TEXT)) 
            {
                var loc1:*;
                this.channelRetypePasswordInput.displayAsPassword = loc1 = true;
                this.channelPasswordInput.displayAsPassword = loc1;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.channelPasswordCheckBox.removeEventListener(flash.events.Event.SELECT, this.onChannelPasswordCheckBox);
            this.channelNameInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            this.channelPasswordInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            this.channelRetypePasswordInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            return;
        }

        public function update(arg1:Object):void
        {
            this._data = arg1;
            this.setFocusToInput();
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public override function setSize(arg1:Number, arg2:Number):void
        {
            super.setSize(arg1, arg2);
            return;
        }

        public override function toString():String
        {
            return "[WG ChannelsCreateForm " + name + "]";
        }

        internal static const UPDATE_PASSWORD_TEXT:String="updatePasswordField";

        public var channelNameLabel:net.wg.gui.components.controls.LabelControl=null;

        public var channelPasswordLabel:net.wg.gui.components.controls.LabelControl=null;

        public var channelFillPasswordLabel:net.wg.gui.components.controls.LabelControl=null;

        public var channelRetypePasswordLabel:net.wg.gui.components.controls.LabelControl=null;

        public var channelNameInput:net.wg.gui.components.controls.TextInput=null;

        public var channelPasswordInput:net.wg.gui.components.controls.TextInput=null;

        public var channelRetypePasswordInput:net.wg.gui.components.controls.TextInput=null;

        public var channelPasswordCheckBox:net.wg.gui.components.controls.CheckBox=null;

        public var channelCreateButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var bg:flash.display.Sprite=null;

        internal var _data:Object=null;

        internal var usePassword:Boolean=false;
    }
}
