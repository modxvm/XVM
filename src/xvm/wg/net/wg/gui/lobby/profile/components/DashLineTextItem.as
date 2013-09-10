package net.wg.gui.lobby.profile.components 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class DashLineTextItem extends scaleform.clik.core.UIComponent
    {
        public function DashLineTextItem()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.labelTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.valueTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            return;
        }

        protected function mouseRollOutHandler(arg1:flash.events.MouseEvent):void
        {
            hideToolTip();
            return;
        }

        protected function mouseRollOverHandler(arg1:flash.events.MouseEvent):void
        {
            this.showToolTip(null);
            return;
        }

        protected function showToolTip(arg1:net.wg.data.managers.IToolTipParams):void
        {
            if (this._tooltip) 
                App.toolTipMgr.showComplex(this._tooltip);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(LABEL_INV)) 
            {
                this.labelTextField.text = this._label;
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(VALUE_INV)) 
            {
                this.valueTextField.htmlText = this._value;
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.dashLine.width = Math.round(_width - this.labelTextField.width - this.valueTextField.width - dashLinePadding * 2);
                this.dashLine.x = Math.round(this.labelTextField.width + dashLinePadding);
                this.valueTextField.x = Math.round(_width - this.valueTextField.width);
            }
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            invalidate(LABEL_INV);
            return;
        }

        public function get value():String
        {
            return this._value;
        }

        public function set value(arg1:String):void
        {
            this._value = arg1;
            invalidate(VALUE_INV);
            return;
        }

        public function get tooltip():String
        {
            return this._tooltip;
        }

        public function set tooltip(arg1:String):void
        {
            this._tooltip = arg1;
            this.disposeListeners();
            if (this._tooltip) 
            {
                addEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler, false, 0, true);
            }
            return;
        }

        internal function disposeListeners():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler);
            return;
        }

        public override function dispose():void
        {
            this.disposeListeners();
            super.dispose();
            return;
        }

        internal static function hideToolTip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static const LABEL_INV:String="lblInv";

        internal static const HTML_VALUE_INV:String="htmlValInv";

        internal static const VALUE_INV:String="valInv";

        internal static const dashLinePadding:uint=1;

        public var labelTextField:flash.text.TextField;

        public var valueTextField:flash.text.TextField;

        public var dashLine:net.wg.gui.lobby.profile.components.DashLine;

        internal var _label:String="";

        internal var _value:String="0";

        internal var _tooltip:String;
    }
}
