package net.wg.gui.login.impl
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.login.ILoginForm;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.HyperLink;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.TextInput;
   import flash.events.Event;
   import scaleform.clik.events.ListEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import scaleform.clik.data.DataProvider;
   import flash.text.StyleSheet;
   import net.wg.data.constants.SoundTypes;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.constants.InputValue;


   public class LoginForm extends UIComponent implements ILoginForm
   {
          
      public function LoginForm() {
         super();
      }

      private static const DEBUG_SERVER_LIST_SIZE:Number = 250;

      private static const MAX_SERVER_ROW_COUNT:Number = 10;

      private static const MULTI_SYMBOL_CODE:Number = 106;

      public var server:DropdownMenu = null;

      public var capsLockIndicator:MovieClip = null;

      public var steamLogo:MovieClip = null;

      public var loginField:TextField = null;

      public var passwordField:TextField = null;

      public var igrWarning:MovieClip = null;

      private var _rememberPwdCheckbox:CheckBox = null;

      private var _registerLink:HyperLink = null;

      private var _recoveryLink:HyperLink = null;

      private var _submit:SoundButton = null;

      private var _login:TextInput = null;

      private var _pass:TextInput = null;

      private var _message:TextField = null;

      private var _lastDownKeyCode:Number = -1;

      private var _isIgrCredentialsReset:Boolean = false;

      override public function dispose() : void {
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
         this.steamLogo = null;
         this.igrWarning = null;
         this._message.styleSheet = null;
         this._message = null;
      }

      public function update(param1:Object, param2:Boolean) : void {
         var _loc3_:String = null;
         if((param1 == this._login || param1 == this._pass) && (param2))
         {
            _loc3_ = "";
            if(param1 == this._pass)
            {
               _loc3_ = this._pass.text.slice(-1);
               if(_loc3_ == "*" && !(this._lastDownKeyCode == MULTI_SYMBOL_CODE))
               {
                  _loc3_ = "";
               }
            }
            this._pass.text = _loc3_;
            dispatchEvent(new LoginEvent(LoginEvent.TOKEN_RESET));
         }
         this.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING,ErrorStates.NONE);
         this._submit.enabled = this._login.text.length > 1;
      }

      public function addChangeHandler(param1:Function) : void {
         this._login.addEventListener(Event.CHANGE,param1);
         this._pass.addEventListener(Event.CHANGE,param1);
         this.server.addEventListener(Event.CHANGE,param1);
         this.server.addEventListener(ListEvent.INDEX_CHANGE,param1);
         this._rememberPwdCheckbox.addEventListener(Event.SELECT,this.onRememberPwdCheckboxToggle);
      }

      public function removeChangeHandler(param1:Function) : void {
         this._login.removeEventListener(Event.CHANGE,param1);
         this._pass.removeEventListener(Event.CHANGE,param1);
         this.server.removeEventListener(Event.CHANGE,param1);
         this.server.removeEventListener(ListEvent.INDEX_CHANGE,param1);
         this._rememberPwdCheckbox.removeEventListener(Event.SELECT,this.onRememberPwdCheckboxToggle);
      }

      public function setDefaultValues(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void {
         if(param5)
         {
            this.igrWarning.visible = param3;
            this._rememberPwdCheckbox.width = 500;
            this._rememberPwdCheckbox.label = MENU.LOGIN_REMEMBERPASSWORDIGR;
         }
         else
         {
            this.igrWarning.visible = false;
            this._rememberPwdCheckbox.label = MENU.LOGIN_REMEMBERPASSWORD;
         }
         this._login.text = param1;
         this._pass.text = param2;
         this._isIgrCredentialsReset = param5;
         this._rememberPwdCheckbox.selected = param3;
         this._rememberPwdCheckbox.visible = param4;
         this._recoveryLink.visible = param6;
      }

      public function setServersList(param1:Array, param2:int) : void {
         var _loc3_:Array = [];
         var _loc4_:uint = param1.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.push(
               {
                  "label":param1[_loc5_].label,
                  "data":param1[_loc5_].data
               }
            );
            _loc5_++;
         }
         if(_loc3_.length > this.server.menuRowCount)
         {
            this.server.scrollBar = Linkages.SCROLL_BAR;
         }
         else
         {
            this.server.scrollBar = Values.EMPTY_STR;
         }
         this.server.dataProvider = new DataProvider(_loc3_);
         this.server.selectedIndex = param2;
         this.server.menuRowCount = Math.min(this.server.dataProvider.length,MAX_SERVER_ROW_COUNT);
      }

      public function setErrorMessage(param1:String, param2:int) : void {
         this.message.htmlText = param1;
         this.login.highlight = (param2 & ErrorStates.LOGIN_INVALID) == ErrorStates.LOGIN_INVALID;
         this.pass.highlight = (param2 & ErrorStates.PASSWORD_INVALID) == ErrorStates.PASSWORD_INVALID;
      }

      public function setCapsLockState(param1:Boolean) : void {
         this.capsLockIndicator.visible = param1;
         this.capsLockIndicator.x = this.passwordField.x + this.passwordField.getLineMetrics(0).x - this.capsLockIndicator.width;
      }

      public function getSelectedServerName() : String {
         var _loc1_:Number = this.server.selectedIndex;
         var _loc2_:Object = this.server.dataProvider.requestItemAt(_loc1_);
         return String(_loc2_.data);
      }

      public function get rememberPwdCheckbox() : CheckBox {
         return this._rememberPwdCheckbox;
      }

      public function set rememberPwdCheckbox(param1:CheckBox) : void {
         this._rememberPwdCheckbox = param1;
      }

      public function get registerLink() : HyperLink {
         return this._registerLink;
      }

      public function set registerLink(param1:HyperLink) : void {
         this._registerLink = param1;
      }

      public function get recoveryLink() : HyperLink {
         return this._recoveryLink;
      }

      public function set recoveryLink(param1:HyperLink) : void {
         this._recoveryLink = param1;
      }

      public function get submit() : SoundButton {
         return this._submit;
      }

      public function set submit(param1:SoundButton) : void {
         this._submit = param1;
      }

      public function get login() : TextInput {
         return this._login;
      }

      public function set login(param1:TextInput) : void {
         this._login = param1;
      }

      public function get pass() : TextInput {
         return this._pass;
      }

      public function set pass(param1:TextInput) : void {
         this._pass = param1;
      }

      public function get message() : TextField {
         return this._message;
      }

      public function set message(param1:TextField) : void {
         this._message = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("a:link",
            {
               "color":"#969687",
               "textDecoration":"underline"
            }
         );
         _loc1_.setStyle("a:hover",
            {
               "color":"#FF0000",
               "textDecoration":"underline"
            }
         );
         _loc1_.setStyle("a:active",
            {
               "color":"#FF0000",
               "textDecoration":"underline"
            }
         );
         this._message.styleSheet = _loc1_;
         this.server.menuWidth = App.globalVarsMgr.isDevelopmentS()?DEBUG_SERVER_LIST_SIZE:-1;
         this._submit.enabled = false;
         this._submit.soundType = SoundTypes.RED_BTN;
         this.capsLockIndicator.visible = false;
         this.capsLockIndicator.alpha = 1;
         LoginUtils.instance.initTabIndex([this._login.textField,this._pass.textField,this._rememberPwdCheckbox,this._submit,this._registerLink,this._recoveryLink,this.server]);
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.details.value == InputValue.KEY_DOWN)
         {
            this._lastDownKeyCode = param1.details.code;
         }
      }

      private function onRememberPwdCheckboxToggle(param1:Event) : void {
         if(this._isIgrCredentialsReset)
         {
            this.igrWarning.visible = this.rememberPwdCheckbox.selected;
         }
      }
   }

}