package net.wg.gui.components.common
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.DisplayObject;

    public class CounterView extends UIComponentEx
    {

        public var label:TextField = null;

        public var back:DisplayObject = null;

        private var _originalBackWidth:int = 0;

        private var _tfPadding:int = 0;

        public function CounterView()
        {
            super();
            this._originalBackWidth = this.back.width;
        }

        override protected function onDispose() : void
        {
            this.label = null;
            this.back = null;
            super.onDispose();
        }

        public function setCount(param1:String) : void
        {
            var _loc2_:* = 0;
            if(this.label != null && this.label.htmlText != param1)
            {
                this.label.htmlText = param1;
                App.utils.commons.updateTextFieldSize(this.label);
                _loc2_ = this.label.width + (this._tfPadding << 1);
                this.back.width = _loc2_ < this._originalBackWidth?this._originalBackWidth:_loc2_;
                this.label.x = this.back.x + this._tfPadding + (this.back.width - _loc2_ >> 1) | 0;
            }
        }

        public function get tfPadding() : int
        {
            return this._tfPadding;
        }

        public function set tfPadding(param1:int) : void
        {
            this._tfPadding = param1;
        }
    }
}
