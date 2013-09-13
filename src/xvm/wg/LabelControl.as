package 
{
    import net.wg.gui.components.controls.*;
    
    public dynamic class LabelControl extends net.wg.gui.components.controls.LabelControl
    {
        public function LabelControl()
        {
            super();
            addFrameScript(9, this.frame10, 19, this.frame20);
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
    }
}
