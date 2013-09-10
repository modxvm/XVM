package net.wg.gui.tutorial.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TutorialBattleStatisticMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function TutorialBattleStatisticMeta()
        {
            super();
            return;
        }

        public function restartS():void
        {
            App.utils.asserter.assertNotNull(this.restart, "restart" + net.wg.data.constants.Errors.CANT_NULL);
            this.restart();
            return;
        }

        public function showVideoDialogS():void
        {
            App.utils.asserter.assertNotNull(this.showVideoDialog, "showVideoDialog" + net.wg.data.constants.Errors.CANT_NULL);
            this.showVideoDialog();
            return;
        }

        public var restart:Function=null;

        public var showVideoDialog:Function=null;
    }
}
