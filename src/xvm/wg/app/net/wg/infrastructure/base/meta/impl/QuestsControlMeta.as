package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.data.constants.Errors;
    
    public class QuestsControlMeta extends SoundButton
    {
        
        public function QuestsControlMeta()
        {
            super();
        }
        
        public var showQuestsWindow:Function = null;
        
        public function showQuestsWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.showQuestsWindow,"showQuestsWindow" + Errors.CANT_NULL);
            this.showQuestsWindow();
        }
    }
}
