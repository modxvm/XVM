package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class LoginCreateAnAccountWindowMeta extends AbstractWindowView
    {
        
        public function LoginCreateAnAccountWindowMeta()
        {
            super();
        }
        
        public var onRegister:Function = null;
        
        public function onRegisterS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onRegister,"onRegister" + Errors.CANT_NULL);
            this.onRegister(param1);
        }
    }
}
