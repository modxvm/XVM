package net.wg.gui.lobby.profile.components.chart
{
    import scaleform.clik.core.UIComponent;
    
    public class BarItem extends UIComponent
    {
        
        public function BarItem() {
            super();
            this.gotoAndStop(1);
        }
        
        public static var PERCENT_INV:String = "percInv";
        
        private var _percent:uint = 0;
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(PERCENT_INV))
            {
                this.gotoAndStop(this._percent);
            }
        }
        
        public function get percent() : uint {
            return this._percent;
        }
        
        public function set percent(param1:uint) : void {
            this._percent = param1;
            invalidate(PERCENT_INV);
        }
    }
}
