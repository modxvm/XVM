package 
{
    import net.wg.gui.components.controls.*;
    
    public dynamic class Slider extends net.wg.gui.components.controls.Slider
    {
        public function Slider()
        {
            super();
            addFrameScript(9, this.frame10, 19, this.frame20, 29, this.frame30);
            return;
        }

        internal function frame10():*
        {
            stop();
            return;
        }

        internal function frame20():*
        {
            stop();
            return;
        }

        internal function frame30():*
        {
            stop();
            return;
        }
    }
}
