package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class TutorialControlMeta extends net.wg.gui.components.controls.SoundButton
    {
        public function TutorialControlMeta()
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

        public function refuseS():void
        {
            App.utils.asserter.assertNotNull(this.refuse, "refuse" + net.wg.data.constants.Errors.CANT_NULL);
            this.refuse();
            return;
        }

        public var restart:Function=null;

        public var refuse:Function=null;
    }
}
