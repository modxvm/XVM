package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.data.constants.Errors;
    
    public class TutorialControlMeta extends SoundButton
    {
        
        public function TutorialControlMeta()
        {
            super();
        }
        
        public var restart:Function = null;
        
        public var refuse:Function = null;
        
        public function restartS() : void
        {
            App.utils.asserter.assertNotNull(this.restart,"restart" + Errors.CANT_NULL);
            this.restart();
        }
        
        public function refuseS() : void
        {
            App.utils.asserter.assertNotNull(this.refuse,"refuse" + Errors.CANT_NULL);
            this.refuse();
        }
    }
}
