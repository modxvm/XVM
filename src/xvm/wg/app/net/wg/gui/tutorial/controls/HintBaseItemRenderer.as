package net.wg.gui.tutorial.controls 
{
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class HintBaseItemRenderer extends scaleform.clik.core.UIComponent
    {
        public function HintBaseItemRenderer()
        {
            super();
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this._data = null;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this._data) 
            {
                this.drawData();
            }
            return;
        }

        protected function drawData():void
        {
            return;
        }

        protected var _data:Object;
    }
}
