package net.wg.gui.components.controls 
{
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ProgressBar extends scaleform.clik.core.UIComponent implements net.wg.gui.components.controls.IProgressBar
    {
        public function ProgressBar()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.applyDataChanges();
            }
            return;
        }

        protected function applyDataChanges():void
        {
            return;
        }

        public function set minimum(arg1:Number):void
        {
            if (this._minimum != arg1) 
            {
                this._minimum = arg1;
                invalidateData();
            }
            return;
        }

        public function get minimum():Number
        {
            return this._minimum;
        }

        public function set maximum(arg1:Number):void
        {
            if (this._maximum != arg1) 
            {
                this._maximum = arg1;
                invalidateData();
            }
            return;
        }

        public function get maximum():Number
        {
            return this._maximum;
        }

        public function set value(arg1:Number):void
        {
            if (this._value != arg1) 
            {
                this._value = arg1;
                invalidateData();
            }
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        internal var _minimum:Number=0;

        internal var _maximum:Number=1;

        internal var _value:Number=0;
    }
}
