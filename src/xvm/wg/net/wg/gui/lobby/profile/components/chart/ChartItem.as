package net.wg.gui.lobby.profile.components.chart 
{
    import scaleform.clik.constants.*;
    
    public class ChartItem extends net.wg.gui.lobby.profile.components.chart.ChartItemBase
    {
        public function ChartItem()
        {
            super();
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            var loc1:*="percentValue";
            if (_data.hasOwnProperty(loc1)) 
            {
                this.value = _data[loc1];
            }
            else if (!isNaN(uint(_data))) 
            {
                this.value = uint(_data);
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.applyDataChange();
                invalidate(VALUE_INV);
            }
            if (isInvalid(VALUE_INV)) 
            {
                this.applyValueChange();
            }
            return;
        }

        protected function applyDataChange():void
        {
            return;
        }

        protected function applyValueChange():void
        {
            return;
        }

        public function get value():uint
        {
            return this._value;
        }

        public function set value(arg1:uint):void
        {
            this._value = arg1;
            invalidate(VALUE_INV);
            return;
        }

        internal static const VALUE_INV:String="valInv";

        internal var _value:uint=0;
    }
}
