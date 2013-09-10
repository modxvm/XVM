package net.wg.gui.components.common.ticker 
{
    import flash.text.*;
    import scaleform.clik.controls.*;
    
    public class TickerItem extends scaleform.clik.controls.Button
    {
        public function TickerItem()
        {
            super();
            autoSize = flash.text.TextFieldAutoSize.LEFT;
            return;
        }

        public function get model():net.wg.gui.components.common.ticker.RSSEntryVO
        {
            return this._model;
        }

        public function set model(arg1:net.wg.gui.components.common.ticker.RSSEntryVO):void
        {
            this._model = arg1;
            invalidate(INVALID_MODEL);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this._model) 
            {
                this._model.dispose();
                this._model = null;
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(INVALID_MODEL) && this._model) 
                label = this._model.title;
            super.draw();
            return;
        }

        internal static const INVALID_MODEL:String="invalidModel";

        internal var _model:net.wg.gui.components.common.ticker.RSSEntryVO;
    }
}
