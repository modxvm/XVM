package net.wg.gui.components.common.ticker
{
    import scaleform.clik.controls.Button;
    import flash.text.TextFieldAutoSize;

    public class TickerItem extends Button
    {

        private static const INVALID_MODEL:String = "invalidModel";

        private var _model:RSSEntryVO;

        public function TickerItem()
        {
            super();
            autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function onDispose() : void
        {
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            if(isInvalid(INVALID_MODEL) && this._model)
            {
                label = this._model.title;
            }
            super.draw();
        }

        public function get model() : RSSEntryVO
        {
            return this._model;
        }

        public function set model(param1:RSSEntryVO) : void
        {
            this._model = param1;
            invalidate(INVALID_MODEL);
        }
    }
}
