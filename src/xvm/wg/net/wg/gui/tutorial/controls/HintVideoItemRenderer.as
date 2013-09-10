package net.wg.gui.tutorial.controls 
{
    import net.wg.gui.components.controls.*;
    
    public class HintVideoItemRenderer extends net.wg.gui.tutorial.controls.HintBaseItemRenderer
    {
        public function HintVideoItemRenderer()
        {
            super();
            return;
        }

        protected override function drawData():void
        {
            super.drawData();
            this.button.label = _data.label;
            this.button.validateNow();
            return;
        }

        public var button:net.wg.gui.components.controls.SoundButton;
    }
}
