package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.IconButton;
    
    public class BlinkingButton extends IconButton
    {
        
        public function BlinkingButton() {
            super();
        }
        
        private var _blinking:Boolean;
        
        public function get blinking() : Boolean {
            return this._blinking;
        }
        
        override protected function configUI() : void {
            super.configUI();
            setState("up");
        }
        
        override protected function draw() : void {
            super.draw();
        }
        
        public function set blinking(param1:Boolean) : void {
            if(this._blinking == param1)
            {
                return;
            }
            this._blinking = param1;
            setState(state);
        }
        
        override protected function getStatePrefixes() : Vector.<String> {
            return this._blinking?Vector.<String>(["blinking_",""]):Vector.<String>([""]);
        }
    }
}
