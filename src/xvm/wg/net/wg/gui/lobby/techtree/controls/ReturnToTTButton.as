package net.wg.gui.lobby.techtree.controls 
{
    import net.wg.data.constants.*;
    
    public class ReturnToTTButton extends net.wg.gui.lobby.techtree.controls.NationButton
    {
        public function ReturnToTTButton()
        {
            super();
            return;
        }

        protected override function defineSoundProps():void
        {
            soundType = net.wg.data.constants.SoundTypes.CLOSE_WINDOW;
            return;
        }
    }
}
