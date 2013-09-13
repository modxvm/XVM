package 
{
    import net.wg.gui.components.controls.*;
    
    public dynamic class NumericStepper extends net.wg.gui.components.controls.NumericStepper
    {
        public function NumericStepper()
        {
            super();
            addFrameScript(9, this.frame10, 19, this.frame20, 29, this.frame30, 39, this.frame40);
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

        internal function frame40():*
        {
            stop();
            return;
        }
    }
}
