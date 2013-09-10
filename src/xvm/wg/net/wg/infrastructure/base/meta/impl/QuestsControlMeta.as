package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class QuestsControlMeta extends net.wg.gui.components.controls.SoundButton
    {
        public function QuestsControlMeta()
        {
            super();
            return;
        }

        public function showQuestsWindowS():void
        {
            App.utils.asserter.assertNotNull(this.showQuestsWindow, "showQuestsWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showQuestsWindow();
            return;
        }

        public var showQuestsWindow:Function=null;
    }
}
