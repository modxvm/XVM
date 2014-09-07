package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.IconButton;
    import flash.events.MouseEvent;
    
    public class BlinkingButton extends IconButton
    {
        
        public function BlinkingButton()
        {
            super();
            setState("up");
        }
        
        private var _blinking:Boolean;
        
        public function get blinking() : Boolean
        {
            return this._blinking;
        }
        
        override public function showTooltip(param1:MouseEvent) : void
        {
            if(enabled)
            {
                super.showTooltip(param1);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        public function set blinking(param1:Boolean) : void
        {
            if(this._blinking == param1)
            {
                return;
            }
            this._blinking = param1;
            setState(state);
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            return this._blinking?Vector.<String>(["blinking_",""]):Vector.<String>([""]);
        }
    }
}
