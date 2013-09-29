package net.wg.gui.components.advanced 
{
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    
    public class DoubleProgressBar extends scaleform.clik.core.UIComponent
    {
        public function DoubleProgressBar()
        {
            super();
            return;
        }

        public function get frontPosition():Number
        {
            return this.frontBar.position;
        }

        public function set frontPosition(arg1:Number):void
        {
            this.frontBar.position = arg1;
            return;
        }

        public function get backPosition():Number
        {
            return this.backBar.position;
        }

        public function set backPosition(arg1:Number):void
        {
            this.backBar.position = arg1;
            return;
        }

        public function get minimum():Number
        {
            return this.frontBar.minimum;
        }

        public function set minimum(arg1:Number):void
        {
            this.frontBar.minimum = arg1;
            this.backBar.minimum = arg1;
            return;
        }

        public function get maximum():Number
        {
            return this.frontBar.maximum;
        }

        public function set maximum(arg1:Number):void
        {
            this.frontBar.maximum = arg1;
            this.backBar.maximum = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public var frontBar:scaleform.clik.controls.StatusIndicator;

        public var backBar:scaleform.clik.controls.StatusIndicator;
    }
}
