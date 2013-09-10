package net.wg.gui.lobby.profile.components.chart 
{
    import scaleform.clik.core.*;
    
    public class BarItem extends scaleform.clik.core.UIComponent
    {
        public function BarItem()
        {
            super();
            this.gotoAndStop(1);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(PERCENT_INV)) 
            {
                this.gotoAndStop(this._percent);
            }
            return;
        }

        public function get percent():uint
        {
            return this._percent;
        }

        public function set percent(arg1:uint):void
        {
            this._percent = arg1;
            invalidate(PERCENT_INV);
            return;
        }

        public static const PERCENT_INV:String="percInv";

        internal var _percent:uint=0;
    }
}
