package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class LobbyMenuMeta extends AbstractWindowView
    {
        
        public function LobbyMenuMeta() {
            super();
        }
        
        public var settingsClick:Function = null;
        
        public var cancelClick:Function = null;
        
        public var refuseTraining:Function = null;
        
        public var logoffClick:Function = null;
        
        public var quitClick:Function = null;
        
        public function settingsClickS() : void {
            App.utils.asserter.assertNotNull(this.settingsClick,"settingsClick" + Errors.CANT_NULL);
            this.settingsClick();
        }
        
        public function cancelClickS() : void {
            App.utils.asserter.assertNotNull(this.cancelClick,"cancelClick" + Errors.CANT_NULL);
            this.cancelClick();
        }
        
        public function refuseTrainingS() : void {
            App.utils.asserter.assertNotNull(this.refuseTraining,"refuseTraining" + Errors.CANT_NULL);
            this.refuseTraining();
        }
        
        public function logoffClickS() : void {
            App.utils.asserter.assertNotNull(this.logoffClick,"logoffClick" + Errors.CANT_NULL);
            this.logoffClick();
        }
        
        public function quitClickS() : void {
            App.utils.asserter.assertNotNull(this.quitClick,"quitClick" + Errors.CANT_NULL);
            this.quitClick();
        }
    }
}
