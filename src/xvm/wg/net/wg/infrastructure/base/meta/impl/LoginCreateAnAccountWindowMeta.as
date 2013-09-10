package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class LoginCreateAnAccountWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function LoginCreateAnAccountWindowMeta()
        {
            super();
            return;
        }

        public function onRegisterS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.onRegister, "onRegister" + net.wg.data.constants.Errors.CANT_NULL);
            this.onRegister(arg1);
            return;
        }

        public var onRegister:Function=null;
    }
}
