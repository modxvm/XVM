package net.wg.gui.login.impl 
{
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class LoginCreateAnAccountWindow extends net.wg.infrastructure.base.meta.impl.LoginCreateAnAccountWindowMeta implements net.wg.infrastructure.base.meta.ILoginCreateAnAccountWindowMeta
    {
        public function LoginCreateAnAccountWindow()
        {
            super();
            canClose = false;
            showWindowBg = false;
            isCentered = true;
            isModal = true;
            return;
        }

        public function as_updateTexts(arg1:String, arg2:String, arg3:String, arg4:String):void
        {
            this.inputNick.text = arg1;
            this.titleField.htmlText = arg2;
            if (this._firstUpdate) 
            {
                this._firstUpdate = false;
                this.textField.htmlText = arg3;
            }
            else 
            {
                this.errorField.htmlText = arg3;
            }
            this.createBtn.label = arg4;
            return;
        }

        public function as_registerResponse(arg1:Boolean, arg2:String):void
        {
            if (arg1) 
            {
                onWindowCloseS();
            }
            else 
            {
                this.enableInputs(true);
                App.utils.scheduler.envokeInNextFrame(App.utils.focusHandler.setFocus, this.inputNick);
                this.errorField.text = arg2;
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.getBackground().alpha = 0;
            this.noteField.htmlText = DIALOGS.CREATEANACCOUNT_NOTE;
            this.createBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCreateBtnClickHandler);
            App.utils.scheduler.envokeInNextFrame(App.utils.focusHandler.setFocus, this.inputNick);
            this.enableInputs(true);
            return;
        }

        protected override function onDispose():void
        {
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            this.createBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCreateBtnClickHandler);
            this.createBtn.dispose();
            this.createBtn = null;
            this.inputNick.dispose();
            this.inputNick = null;
            this.noteField = null;
            this.errorField = null;
            this.titleField = null;
            this.textField = null;
            super.onDispose();
            return;
        }

        internal function enableInputs(arg1:Boolean):void
        {
            if (arg1) 
            {
                addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            }
            else 
            {
                removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            }
            this.createBtn.enabled = arg1;
            this.inputNick.enabled = arg1;
            return;
        }

        internal function doRegister():void
        {
            this.enableInputs(false);
            onRegisterS(this.inputNick.text);
            return;
        }

        internal function onCreateBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.doRegister();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                var loc1:*=arg1.details.code;
                switch (loc1) 
                {
                    case flash.ui.Keyboard.ESCAPE:
                    {
                        onWindowCloseS();
                        break;
                    }
                    case flash.ui.Keyboard.ENTER:
                    {
                        this.doRegister();
                        break;
                    }
                }
            }
            return;
        }

        public var createBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var inputNick:net.wg.gui.components.controls.TextInput=null;

        public var noteField:flash.text.TextField=null;

        public var errorField:flash.text.TextField=null;

        public var titleField:flash.text.TextField=null;

        public var textField:flash.text.TextField=null;

        internal var _firstUpdate:Boolean=true;
    }
}
