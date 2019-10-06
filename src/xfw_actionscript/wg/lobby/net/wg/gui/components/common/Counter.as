package net.wg.gui.components.common
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextFormatAlign;

    public class Counter extends CounterBase
    {

        public var counterView:CounterView = null;

        public function Counter()
        {
            super();
        }

        override public function setTarget(param1:DisplayObject, param2:String, param3:Point = null, param4:String = null, param5:Boolean = true, param6:Number = 0) : void
        {
            super.setTarget(param1,param2,param3,param4,param5,param6);
            this.counterView.tfPadding = param6;
        }

        override protected function onDispose() : void
        {
            if(this.counterView)
            {
                this.counterView.dispose();
                this.counterView = null;
            }
            super.onDispose();
        }

        override protected function applyCountValue() : void
        {
            this.counterView.setCount(value);
            super.applyCountValue();
        }

        override protected function applyPosition() : void
        {
            var _loc1_:Rectangle = this.target.getBounds(this.target.parent);
            x = _loc1_.x + _loc1_.width | 0;
            if(this.horizontalAlign == TextFormatAlign.RIGHT)
            {
                x = x - this.counterView.label.width;
            }
            else if(this.horizontalAlign == TextFormatAlign.CENTER)
            {
                x = x - (this.counterView.label.width >> 1);
            }
            y = _loc1_.y | 0;
            if(this.offset != null)
            {
                x = x + (this.offset.x | 0);
                y = y + (this.offset.y | 0);
            }
        }
    }
}
