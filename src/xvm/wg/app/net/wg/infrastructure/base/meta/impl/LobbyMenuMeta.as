package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class LobbyMenuMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function LobbyMenuMeta()
        {
            super();
            return;
        }

        public function settingsClickS():void
        {
            App.utils.asserter.assertNotNull(this.settingsClick, "settingsClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.settingsClick();
            return;
        }

        public function cancelClickS():void
        {
            App.utils.asserter.assertNotNull(this.cancelClick, "cancelClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.cancelClick();
            return;
        }

        public function refuseTrainingS():void
        {
            App.utils.asserter.assertNotNull(this.refuseTraining, "refuseTraining" + net.wg.data.constants.Errors.CANT_NULL);
            this.refuseTraining();
            return;
        }

        public function logoffClickS():void
        {
            App.utils.asserter.assertNotNull(this.logoffClick, "logoffClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.logoffClick();
            return;
        }

        public function quitClickS():void
        {
            App.utils.asserter.assertNotNull(this.quitClick, "quitClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.quitClick();
            return;
        }

        public var settingsClick:Function=null;

        public var cancelClick:Function=null;

        public var refuseTraining:Function=null;

        public var logoffClick:Function=null;

        public var quitClick:Function=null;
    }
}
