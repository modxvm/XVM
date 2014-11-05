package net.wg.gui.tutorial.meta.impl
{
    import net.wg.gui.tutorial.windows.TutorialDialog;
    import net.wg.data.constants.Errors;
    
    public class TutorialConfirmRefuseDialogMeta extends TutorialDialog
    {
        
        public function TutorialConfirmRefuseDialogMeta()
        {
            super();
        }
        
        public var setStartOnNextLogin:Function = null;
        
        public function setStartOnNextLoginS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setStartOnNextLogin,"setStartOnNextLogin" + Errors.CANT_NULL);
            this.setStartOnNextLogin(param1);
        }
    }
}
