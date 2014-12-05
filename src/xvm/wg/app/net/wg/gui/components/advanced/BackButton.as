package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.SoundButtonEx;
    
    public class BackButton extends SoundButtonEx
    {
        
        public function BackButton()
        {
            super();
        }
        
        override protected function updateText() : void
        {
            super.updateText();
            if(hitMc)
            {
                hitMc.width = textField.x + textField.textWidth + 5;
            }
        }
    }
}
