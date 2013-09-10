package net.wg.gui.login.impl 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.login.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class LoginForm extends scaleform.clik.core.UIComponent implements net.wg.gui.login.ILoginForm
    {
        public function LoginForm()
        {
            super();
            return;
        }

        public function get registerLink():net.wg.gui.components.controls.HyperLink
        {
            return this._registerLink;
        }

        public function set registerLink(arg1:net.wg.gui.components.controls.HyperLink):void
        {
            this._registerLink = arg1;
            return;
        }

        public function get recoveryLink():net.wg.gui.components.controls.HyperLink
        {
            return this._recoveryLink;
        }

        public function set recoveryLink(arg1:net.wg.gui.components.controls.HyperLink):void
        {
            this._recoveryLink = arg1;
            return;
        }

        public function setErrorMessage(arg1:String, arg2:int):void
        {
            this.message.htmlText = arg1;
            this.login.highlight = (arg2 & ErrorStates.LOGIN_INVALID) == ErrorStates.LOGIN_INVALID;
            this.pass.highlight = (arg2 & ErrorStates.PASSWORD_INVALID) == ErrorStates.PASSWORD_INVALID;
            return;
        }

        public function get submit():net.wg.gui.components.controls.SoundButton
        {
            return this._submit;
        }

        public function set submit(arg1:net.wg.gui.components.controls.SoundButton):void
        {
            this._submit = arg1;
            return;
        }

        public function get login():net.wg.gui.components.controls.TextInput
        {
            return this._login;
        }

        public function set login(arg1:net.wg.gui.components.controls.TextInput):void
        {
            this._login = arg1;
            return;
        }

        public function get pass():net.wg.gui.components.controls.TextInput
        {
            return this._pass;
        }

        public function set pass(arg1:net.wg.gui.components.controls.TextInput):void
        {
            this._pass = arg1;
            return;
        }

        public function get message():flash.text.TextField
        {
            return this._message;
        }

        public function set message(arg1:flash.text.TextField):void
        {
            this._message = arg1;
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                this._lastDownKeyCode = arg1.details.code;
            }
            return;
        }

        internal function onRememberPwdCheckboxToggle(arg1:flash.events.Event):void
        {
            if (this._isIgrCredentialsReset) 
            {
                this.igrWarning.visible = this.rememberPwdCheckbox.selected;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.server.dispose();
            this.loginField = null;
            this.passwordField = null;
            this._rememberPwdCheckbox.dispose();
            this._rememberPwdCheckbox = null;
            this._registerLink.dispose();
            this._registerLink = null;
            this._recoveryLink.dispose();
            this._recoveryLink = null;
            this._submit.dispose();
            this._submit = null;
            this._login = null;
            this._message.styleSheet = null;
            this._message = null;
            return;
        }

        public function update(arg1:Object, arg2:Boolean):void
        {
            var loc1:*=null;
            if ((arg1 == this._login || arg1 == this._pass) && arg2) 
            {
                loc1 = "";
                if (arg1 == this._pass) 
                {
                    loc1 = this._pass.text.slice(-1);
                    if (loc1 == "*" && !(this._lastDownKeyCode == MULTI_SYMBOL_CODE)) 
                    {
                        loc1 = "";
                    }
                }
                this._pass.text = loc1;
                dispatchEvent(new net.wg.gui.login.impl.LoginEvent(net.wg.gui.login.impl.LoginEvent.TOKEN_RESET));
            }
            this.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING, ErrorStates.NONE);
            this._submit.enabled = this._login.text.length > 1;
            return;
        }

        public function addChangeHandler(arg1:Function):void
        {
            this._login.addEventListener(flash.events.Event.CHANGE, arg1);
            this._pass.addEventListener(flash.events.Event.CHANGE, arg1);
            this.server.addEventListener(flash.events.Event.CHANGE, arg1);
            this.server.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, arg1);
            this._rememberPwdCheckbox.addEventListener(flash.events.Event.SELECT, this.onRememberPwdCheckboxToggle);
            return;
        }

        public function removeChangeHandler(arg1:Function):void
        {
            this._login.removeEventListener(flash.events.Event.CHANGE, arg1);
            this._pass.removeEventListener(flash.events.Event.CHANGE, arg1);
            this.server.removeEventListener(flash.events.Event.CHANGE, arg1);
            this.server.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, arg1);
            this._rememberPwdCheckbox.removeEventListener(flash.events.Event.SELECT, this.onRememberPwdCheckboxToggle);
            return;
        }

        public function setDefaultValues(arg1:String, arg2:String, arg3:Boolean, arg4:Boolean, arg5:Boolean, arg6:Boolean):void
        {
            if (arg5) 
            {
                this.igrWarning.visible = arg3;
                this._rememberPwdCheckbox.width = 500;
                this._rememberPwdCheckbox.label = MENU.LOGIN_REMEMBERPASSWORDIGR;
            }
            else 
            {
                this.igrWarning.visible = false;
                this._rememberPwdCheckbox.label = MENU.LOGIN_REMEMBERPASSWORD;
            }
            this._login.text = arg1;
            this._pass.text = arg2;
            this._isIgrCredentialsReset = arg5;
            this._rememberPwdCheckbox.selected = arg3;
            this._rememberPwdCheckbox.visible = arg4;
            this._recoveryLink.visible = arg6;
            return;
        }

        public function setServersList(arg1:Array, arg2:int):void
        {
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1.push({"label":arg1[loc3].label, "data":arg1[loc3].data});
                ++loc3;
            }
            if (loc1.length > this.server.menuRowCount) 
            {
                this.server.scrollBar = net.wg.data.constants.Linkages.SCROLL_BAR;
            }
            else 
            {
                this.server.scrollBar = net.wg.data.constants.Values.EMPTY_STR;
            }
            this.server.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            this.server.selectedIndex = arg2;
            this.server.menuRowCount = Math.min(this.server.dataProvider.length, MAX_SERVER_ROW_COUNT);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=new flash.text.StyleSheet();
            loc1.setStyle("a:link", {"color":"#969687", "textDecoration":"underline"});
            loc1.setStyle("a:hover", {"color":"#FF0000", "textDecoration":"underline"});
            loc1.setStyle("a:active", {"color":"#FF0000", "textDecoration":"underline"});
            this._message.styleSheet = loc1;
            this.server.menuWidth = App.globalVarsMgr.isDevelopmentS() ? DEBUG_SERVER_LIST_SIZE : -1;
            this._submit.enabled = false;
            this.capsLockIndicator.visible = false;
            this.capsLockIndicator.alpha = 1;
            LoginUtils.instance.initTabIndex([this._login.textField, this._pass.textField, this._rememberPwdCheckbox, this._submit, this._registerLink, this._recoveryLink, this.server]);
            return;
        }

        public function setCapsLockState(arg1:Boolean):void
        {
            this.capsLockIndicator.visible = arg1;
            this.capsLockIndicator.x = this.passwordField.x + this.passwordField.getLineMetrics(0).x - this.capsLockIndicator.width;
            return;
        }

        public function getSelectedServerName():String
        {
            var loc1:*=this.server.selectedIndex;
            var loc2:*=this.server.dataProvider.requestItemAt(loc1);
            return String(loc2.data);
        }

        public function get rememberPwdCheckbox():net.wg.gui.components.controls.CheckBox
        {
            return this._rememberPwdCheckbox;
        }

        public function set rememberPwdCheckbox(arg1:net.wg.gui.components.controls.CheckBox):void
        {
            this._rememberPwdCheckbox = arg1;
            return;
        }

        internal static const DEBUG_SERVER_LIST_SIZE:Number=250;

        internal static const MAX_SERVER_ROW_COUNT:Number=10;

        internal static const MULTI_SYMBOL_CODE:Number=106;

        public var server:net.wg.gui.components.controls.DropdownMenu=null;

        public var capsLockIndicator:flash.display.MovieClip=null;

        public var steamLogo:flash.display.MovieClip=null;

        public var loginField:flash.text.TextField=null;

        public var igrWarning:flash.display.MovieClip=null;

        internal var _rememberPwdCheckbox:net.wg.gui.components.controls.CheckBox=null;

        internal var _registerLink:net.wg.gui.components.controls.HyperLink=null;

        internal var _recoveryLink:net.wg.gui.components.controls.HyperLink=null;

        internal var _submit:net.wg.gui.components.controls.SoundButton=null;

        internal var _login:net.wg.gui.components.controls.TextInput=null;

        internal var _pass:net.wg.gui.components.controls.TextInput=null;

        internal var _message:flash.text.TextField=null;

        internal var _lastDownKeyCode:Number=-1;

        internal var _isIgrCredentialsReset:Boolean=false;

        public var passwordField:flash.text.TextField=null;
    }
}
