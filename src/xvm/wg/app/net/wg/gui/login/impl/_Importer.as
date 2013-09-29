package net.wg.gui.login.impl 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.login.impl.LoginEvent, net.wg.gui.login.impl.LoginForm, net.wg.gui.login.impl.LoginPage, net.wg.gui.login.impl.LoginQueueWindow, net.wg.gui.login.impl.Spark, net.wg.gui.login.impl.SparksManager, net.wg.gui.login.impl.LoginCreateAnAccountWindow]));
            return;
        }
    }
}
