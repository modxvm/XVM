package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class LoginPageMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function LoginPageMeta()
        {
            super();
            return;
        }

        public function onLoginS(arg1:String, arg2:String, arg3:String):void
        {
            App.utils.asserter.assertNotNull(this.onLogin, "onLogin" + net.wg.data.constants.Errors.CANT_NULL);
            this.onLogin(arg1, arg2, arg3);
            return;
        }

        public function onRegisterS():void
        {
            App.utils.asserter.assertNotNull(this.onRegister, "onRegister" + net.wg.data.constants.Errors.CANT_NULL);
            this.onRegister();
            return;
        }

        public function onRecoveryS():void
        {
            App.utils.asserter.assertNotNull(this.onRecovery, "onRecovery" + net.wg.data.constants.Errors.CANT_NULL);
            this.onRecovery();
            return;
        }

        public function onSetRememberPasswordS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.onSetRememberPassword, "onSetRememberPassword" + net.wg.data.constants.Errors.CANT_NULL);
            this.onSetRememberPassword(arg1);
            return;
        }

        public function onExitFromAutoLoginS():void
        {
            App.utils.asserter.assertNotNull(this.onExitFromAutoLogin, "onExitFromAutoLogin" + net.wg.data.constants.Errors.CANT_NULL);
            this.onExitFromAutoLogin();
            return;
        }

        public function doUpdateS():void
        {
            App.utils.asserter.assertNotNull(this.doUpdate, "doUpdate" + net.wg.data.constants.Errors.CANT_NULL);
            this.doUpdate();
            return;
        }

        public function isTokenS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isToken, "isToken" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isToken();
        }

        public function resetTokenS():void
        {
            App.utils.asserter.assertNotNull(this.resetToken, "resetToken" + net.wg.data.constants.Errors.CANT_NULL);
            this.resetToken();
            return;
        }

        public function onEscapeS():void
        {
            App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + net.wg.data.constants.Errors.CANT_NULL);
            this.onEscape();
            return;
        }

        public function isPwdInvalidS(arg1:String):Boolean
        {
            App.utils.asserter.assertNotNull(this.isPwdInvalid, "isPwdInvalid" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isPwdInvalid(arg1);
        }

        public function isLoginInvalidS(arg1:String):Boolean
        {
            App.utils.asserter.assertNotNull(this.isLoginInvalid, "isLoginInvalid" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isLoginInvalid(arg1);
        }

        public var onLogin:Function=null;

        public var onRegister:Function=null;

        public var onRecovery:Function=null;

        public var onSetRememberPassword:Function=null;

        public var onExitFromAutoLogin:Function=null;

        public var doUpdate:Function=null;

        public var isToken:Function=null;

        public var resetToken:Function=null;

        public var onEscape:Function=null;

        public var isPwdInvalid:Function=null;

        public var isLoginInvalid:Function=null;
    }
}
