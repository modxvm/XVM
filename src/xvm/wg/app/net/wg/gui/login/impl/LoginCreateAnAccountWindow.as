package net.wg.gui.login.impl
{
    import net.wg.infrastructure.base.meta.impl.LoginCreateAnAccountWindowMeta;
    import net.wg.infrastructure.base.meta.ILoginCreateAnAccountWindowMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.TextInput;
    import flash.text.TextField;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.constants.InputValue;
    import flash.ui.Keyboard;
    
    public class LoginCreateAnAccountWindow extends LoginCreateAnAccountWindowMeta implements ILoginCreateAnAccountWindowMeta
    {
        
        public function LoginCreateAnAccountWindow() {
            super();
            canClose = false;
            showWindowBg = false;
            isCentered = true;
            isModal = true;
        }
        
        public var createBtn:SoundButtonEx = null;
        
        public var inputNick:TextInput = null;
        
        public var noteField:TextField = null;
        
        public var errorField:TextField = null;
        
        public var titleField:TextField = null;
        
        public var textField:TextField = null;
        
        private var _firstUpdate:Boolean = true;
        
        public function as_updateTexts(param1:String, param2:String, param3:String, param4:String) : void {
            this.inputNick.text = param1;
            this.titleField.htmlText = param2;
            if(this._firstUpdate)
            {
                this._firstUpdate = false;
                this.textField.htmlText = param3;
            }
            else
            {
                this.errorField.htmlText = param3;
            }
            this.createBtn.label = param4;
        }
        
        public function as_registerResponse(param1:Boolean, param2:String) : void {
            if(param1)
            {
                onWindowCloseS();
            }
            else
            {
                this.enableInputs(true);
                setFocus(this.inputNick);
                this.errorField.text = param2;
            }
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            window.getBackground().alpha = 0;
            this.noteField.htmlText = DIALOGS.CREATEANACCOUNT_NOTE;
            this.createBtn.addEventListener(ButtonEvent.CLICK,this.onCreateBtnClickHandler);
            setFocus(this.inputNick);
            this.enableInputs(true);
        }
        
        override protected function onDispose() : void {
            removeEventListener(InputEvent.INPUT,this.handleInput);
            this.createBtn.removeEventListener(ButtonEvent.CLICK,this.onCreateBtnClickHandler);
            this.createBtn.dispose();
            this.createBtn = null;
            this.inputNick.dispose();
            this.inputNick = null;
            this.noteField = null;
            this.errorField = null;
            this.titleField = null;
            this.textField = null;
            super.onDispose();
        }
        
        private function enableInputs(param1:Boolean) : void {
            if(param1)
            {
                addEventListener(InputEvent.INPUT,this.handleInput);
            }
            else
            {
                removeEventListener(InputEvent.INPUT,this.handleInput);
            }
            this.createBtn.enabled = param1;
            this.inputNick.enabled = param1;
        }
        
        private function doRegister() : void {
            this.enableInputs(false);
            onRegisterS(this.inputNick.text);
        }
        
        private function onCreateBtnClickHandler(param1:ButtonEvent) : void {
            this.doRegister();
        }
        
        override public function handleInput(param1:InputEvent) : void {
            super.handleInput(param1);
            if(param1.handled)
            {
                return;
            }
            if(param1.details.value == InputValue.KEY_DOWN)
            {
                switch(param1.details.code)
                {
                    case Keyboard.ESCAPE:
                        onWindowCloseS();
                        break;
                    case Keyboard.ENTER:
                        this.doRegister();
                        break;
                }
            }
        }
    }
}
