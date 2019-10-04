package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    import net.wg.data.constants.Values;

    public class StoreActionCardTitle extends Sprite implements IDisposable
    {

        public var textField:TextField = null;

        private var _textAlign:String = "left";

        private var _tooltip:String = "";

        public function StoreActionCardTitle()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setAvailableWidth(param1:Number) : void
        {
            this.textField.width = param1;
        }

        public function setText(param1:String, param2:String = "") : void
        {
            var _loc3_:String = App.utils.commons.truncateTextFieldText(this.textField,param1,true);
            if(_loc3_ != param1)
            {
                this._tooltip = param2;
                this.addListeners();
            }
            this.updateAlign();
        }

        public function setTextAlign(param1:String) : void
        {
            if(this._textAlign == param1)
            {
                return;
            }
            this._textAlign = param1;
            this.updateAlign();
        }

        protected function onDispose() : void
        {
            this.textField = null;
            this.removeListeners();
        }

        private function removeListeners() : void
        {
            this.removeEventListener(MouseEvent.MOUSE_OVER,this.onThisMouseOverHandler);
            this.removeEventListener(MouseEvent.MOUSE_OUT,this.onThisMouseOutHandler);
        }

        private function addListeners() : void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER,this.onThisMouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT,this.onThisMouseOutHandler);
            this.mouseEnabled = true;
            this.buttonMode = true;
        }

        private function updateAlign() : void
        {
            var _loc1_:TextFormat = this.textField.getTextFormat();
            _loc1_.align = this._textAlign;
            this.textField.setTextFormat(_loc1_);
        }

        private function onThisMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onThisMouseOverHandler(param1:MouseEvent) : void
        {
            if(this._tooltip != Values.EMPTY_STR)
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }
    }
}
