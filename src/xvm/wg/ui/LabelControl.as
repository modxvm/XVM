package
{
    import net.wg.gui.components.controls.LabelControl;
    
    public dynamic class LabelControl extends net.wg.gui.components.controls.LabelControl
    {
        
        public function LabelControl()
        {
            super();
            addFrameScript(9,this.frame10,19,this.frame20);
        }
        
        public function frame10() : *
        {
            stop();
        }
        
        public function frame20() : *
        {
            stop();
        }
    }
}
