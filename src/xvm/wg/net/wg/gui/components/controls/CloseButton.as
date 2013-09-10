package net.wg.gui.components.controls 
{
    import net.wg.data.constants.*;
    
    public class CloseButton extends net.wg.gui.components.controls.SoundButton
    {
        public function CloseButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.CLOSE_WINDOW;
            return;
        }
    }
}
