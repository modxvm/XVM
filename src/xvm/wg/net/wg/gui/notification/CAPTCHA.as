package net.wg.gui.notification 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class CAPTCHA extends net.wg.infrastructure.base.meta.impl.CAPTCHAMeta implements net.wg.infrastructure.base.meta.ICAPTCHAMeta
    {
        public function CAPTCHA()
        {
            super();
            showWindowBg = false;
            canClose = false;
            canDrag = false;
            isModal = true;
            return;
        }

        public function as_setImage(arg1:String, arg2:Number, arg3:Number):void
        {
            this._imageURL = arg1;
            this._imageWidth = arg2;
            this._imageHeight = arg3;
            invalidate(INVALID_IMAGE);
            return;
        }

        public function as_setErrorMessage(arg1:String):void
        {
            this._errorMessage = arg1;
            invalidate(INVALID_MESSAGE);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.submitButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSubmitClick);
            this.reloadButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onReloadClick);
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCloseClick);
            addEventListener(flash.events.Event.ENTER_FRAME, this.setInputFocus);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALID_IMAGE) && this._imageURL) 
            {
                this.imageHolder.width = this._imageWidth;
                this.imageHolder.height = this._imageHeight;
                this.captuteIcon.source = "img://" + this._imageURL;
            }
            if (isInvalid(INVALID_MESSAGE)) 
            {
                this.errorField.text = this._errorMessage;
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.getBackground().visible = false;
            window.getTitleBtn().visible = false;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.captuteIcon.dispose();
            this.submitButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSubmitClick);
            this.reloadButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onReloadClick);
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCloseClick);
            return;
        }

        internal function clearFields():void
        {
            this.inputField.text = "";
            this.errorField.text = "";
            if (!this.inputField.focused) 
            {
                App.utils.focusHandler.setFocus(this.inputField);
            }
            return;
        }

        internal function setInputFocus(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ENTER_FRAME, this.setInputFocus);
            App.utils.focusHandler.setFocus(this.inputField);
            return;
        }

        internal function onSubmitClick(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            submitS(this.inputField.text);
            this.clearFields();
            return;
        }

        internal function onReloadClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.clearFields();
            reloadS();
            return;
        }

        internal function onCloseClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=arg1.details.code;
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                var loc2:*=loc1;
                switch (loc2) 
                {
                    case flash.ui.Keyboard.ENTER:
                    {
                        arg1.handled = true;
                        this.onSubmitClick();
                        break;
                    }
                }
            }
            return;
        }

        internal static const INVALID_IMAGE:String="invalidImage";

        internal static const INVALID_MESSAGE:String="invalidMessage";

        public var imageHolder:flash.display.Sprite;

        public var inputField:net.wg.gui.components.controls.TextInput;

        public var errorField:flash.text.TextField;

        public var submitButton:net.wg.gui.components.controls.SoundButtonEx;

        public var reloadButton:net.wg.gui.components.controls.SoundButtonEx;

        public var closeButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var _imageURL:String;

        internal var _imageWidth:Number;

        internal var _imageHeight:Number;

        internal var _errorMessage:String;

        public var captuteIcon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
