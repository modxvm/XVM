package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class LoginPageMeta extends AbstractView
    {
        
        public function LoginPageMeta() {
            super();
        }
        
        public var onLogin:Function = null;
        
        public var onRegister:Function = null;
        
        public var onRecovery:Function = null;
        
        public var onSetRememberPassword:Function = null;
        
        public var onExitFromAutoLogin:Function = null;
        
        public var doUpdate:Function = null;
        
        public var isToken:Function = null;
        
        public var resetToken:Function = null;
        
        public var onEscape:Function = null;
        
        public var isPwdInvalid:Function = null;
        
        public var isLoginInvalid:Function = null;
        
        public var showLegal:Function = null;
        
        public function onLoginS(param1:String, param2:String, param3:String) : void {
            App.utils.asserter.assertNotNull(this.onLogin,"onLogin" + Errors.CANT_NULL);
            this.onLogin(param1,param2,param3);
        }
        
        public function onRegisterS() : void {
            App.utils.asserter.assertNotNull(this.onRegister,"onRegister" + Errors.CANT_NULL);
            this.onRegister();
        }
        
        public function onRecoveryS() : void {
            App.utils.asserter.assertNotNull(this.onRecovery,"onRecovery" + Errors.CANT_NULL);
            this.onRecovery();
        }
        
        public function onSetRememberPasswordS(param1:Boolean) : void {
            App.utils.asserter.assertNotNull(this.onSetRememberPassword,"onSetRememberPassword" + Errors.CANT_NULL);
            this.onSetRememberPassword(param1);
        }
        
        public function onExitFromAutoLoginS() : void {
            App.utils.asserter.assertNotNull(this.onExitFromAutoLogin,"onExitFromAutoLogin" + Errors.CANT_NULL);
            this.onExitFromAutoLogin();
        }
        
        public function doUpdateS() : void {
            App.utils.asserter.assertNotNull(this.doUpdate,"doUpdate" + Errors.CANT_NULL);
            this.doUpdate();
        }
        
        public function isTokenS() : Boolean {
            App.utils.asserter.assertNotNull(this.isToken,"isToken" + Errors.CANT_NULL);
            return this.isToken();
        }
        
        public function resetTokenS() : void {
            App.utils.asserter.assertNotNull(this.resetToken,"resetToken" + Errors.CANT_NULL);
            this.resetToken();
        }
        
        public function onEscapeS() : void {
            App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
            this.onEscape();
        }
        
        public function isPwdInvalidS(param1:String) : Boolean {
            App.utils.asserter.assertNotNull(this.isPwdInvalid,"isPwdInvalid" + Errors.CANT_NULL);
            return this.isPwdInvalid(param1);
        }
        
        public function isLoginInvalidS(param1:String) : Boolean {
            App.utils.asserter.assertNotNull(this.isLoginInvalid,"isLoginInvalid" + Errors.CANT_NULL);
            return this.isLoginInvalid(param1);
        }
        
        public function showLegalS() : void {
            App.utils.asserter.assertNotNull(this.showLegal,"showLegal" + Errors.CANT_NULL);
            this.showLegal();
        }
    }
}
