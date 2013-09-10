package net.wg.gui.lobby.profile.components 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    
    public class LineDescrIconText extends net.wg.gui.lobby.profile.components.LineIconText
    {
        public function LineDescrIconText()
        {
            super();
            buttonMode = true;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.descriptionTextField.multiline = true;
            return;
        }

        public function get description():String
        {
            return this._description;
        }

        public function set description(arg1:String):void
        {
            this._description = arg1;
            this.isDescrInvalid = true;
            invalidate();
            return;
        }

        public override function get width():Number
        {
            return Math.max(textComponent.x, this.descriptionTextField.width);
        }

        protected override function draw():void
        {
            super.draw();
            if (this.isDescrInvalid) 
            {
                this.isDescrInvalid = false;
                this.descriptionTextField.text = this._description;
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE, true));
                this.descriptionTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            }
            if (this.isFontSizeInv) 
            {
                this.isFontSizeInv = false;
                textComponent.fontSize = this._fontSize;
            }
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
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
            return;
        }

        public override function dispose():void
        {
            this.disposeHandlers();
            super.dispose();
            return;
        }

        internal function disposeHandlers():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler);
            return;
        }

        public function get tooltip():String
        {
            return this._tooltip;
        }

        public function set tooltip(arg1:String):void
        {
            this._tooltip = arg1;
            this.disposeHandlers();
            if (this._tooltip) 
            {
                addEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler, false, 0, true);
            }
            return;
        }

        public function set fontSize(arg1:uint):void
        {
            this._fontSize = arg1;
            this.isFontSizeInv = true;
            invalidate();
            return;
        }

        internal static function hideToolTip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal var _description:String="";

        internal var isDescrInvalid:Boolean;

        public var descriptionTextField:flash.text.TextField;

        internal var _tooltip:String=null;

        internal var _fontSize:uint;

        internal var isFontSizeInv:Boolean;
    }
}
