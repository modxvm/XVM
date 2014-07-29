package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.controls.StatusIndicator;
    
    public class DoubleProgressBar extends UIComponent
    {
        
        public function DoubleProgressBar()
        {
            super();
        }
        
        public var frontBar:StatusIndicator;
        
        public var backBar:StatusIndicator;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.frontBar.dispose();
            this.frontBar = null;
            this.backBar.dispose();
            this.backBar = null;
        }
        
        public function get frontPosition() : Number
        {
            return this.frontBar.position;
        }
        
        public function set frontPosition(param1:Number) : void
        {
            this.frontBar.position = param1;
        }
        
        public function get backPosition() : Number
        {
            return this.backBar.position;
        }
        
        public function set backPosition(param1:Number) : void
        {
            this.backBar.position = param1;
        }
        
        public function get minimum() : Number
        {
            return this.frontBar.minimum;
        }
        
        public function set minimum(param1:Number) : void
        {
            this.frontBar.minimum = param1;
            this.backBar.minimum = param1;
        }
        
        public function get maximum() : Number
        {
            return this.frontBar.maximum;
        }
        
        public function set maximum(param1:Number) : void
        {
            this.frontBar.maximum = param1;
            this.backBar.maximum = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
    }
}
