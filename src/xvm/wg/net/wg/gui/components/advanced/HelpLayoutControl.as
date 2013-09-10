package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    
    public class HelpLayoutControl extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IDynamicContent
    {
        public function HelpLayoutControl()
        {
            super();
            return;
        }

        public function get connectorLength():Number
        {
            return this._connectorLength;
        }

        public function set connectorLength(arg1:Number):void
        {
            this._connectorLength = arg1;
            return;
        }

        public function set borderWidth(arg1:Number):void
        {
            this._borderWidth = arg1;
            return;
        }

        public function set borderHeight(arg1:Number):void
        {
            this._borderHeight = arg1;
            return;
        }

        public function set direction(arg1:String):void
        {
            App.utils.asserter.assert(!(net.wg.data.constants.Directions.LAYOUT_DIRECTIONS.indexOf(arg1) == -1), "invalid direction: " + arg1);
            this._direction = arg1;
            return;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            var loc1:*;
            scaleY = loc1 = 1;
            scaleX = loc1;
            this.border.width = this._borderWidth;
            this.border.height = this._borderHeight;
            this.setConnectorPosition();
            this.setTextFieldPosition();
            super.draw();
            return;
        }

        internal function setConnectorPosition():void
        {
            if (this.connector == null) 
                return;
            this.connector.height = this._connectorLength;
            var loc1:*=this._direction;
            switch (loc1) 
            {
                case "T":
                    this.connector.rotation = 180;
                    this.connector.x = this._borderWidth >> 1;
                    this.connector.y = 0;
                    break;
                case "R":
                    this.connector.rotation = -90;
                    this.connector.x = this._borderWidth;
                    this.connector.y = (this._borderHeight >> 1) - (this.connector.height >> 1);
                    break;
                case "B":
                    this.connector.x = this._borderWidth >> 1;
                    this.connector.y = this._borderHeight;
                    break;
                case "L":
                    this.connector.rotation = 90;
                    this.connector.x = 0;
                    this.connector.y = (this._borderHeight >> 1) - (this.connector.height >> 1);
                    break;
            }
            return;
        }

        internal function setTextFieldPosition():void
        {
            if (this.textField == null) 
                return;
            this.textField.wordWrap = true;
            var loc1:*=new flash.text.TextFormat();
            var loc2:*=this._direction;
            switch (loc2) 
            {
                case "T":
                    this.textField.autoSize = flash.text.TextFieldAutoSize.CENTER;
                    loc1.align = flash.text.TextFormatAlign.CENTER;
                    this.textField.text = this._text;
                    this.textField.x = (this._borderWidth >> 1) - (this.textField.width >> 1);
                    this.textField.y = -(this.connector.height + this.textField.textHeight + 2);
                    break;
                case "R":
                    this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                    loc1.align = flash.text.TextFormatAlign.LEFT;
                    this.textField.text = this._text;
                    this.textField.x = this._borderWidth + this.connector.width;
                    this.textField.y = (this._borderHeight >> 1) - (this.textField.textHeight >> 1) - 4;
                    break;
                case "B":
                    this.textField.autoSize = flash.text.TextFieldAutoSize.CENTER;
                    loc1.align = flash.text.TextFormatAlign.CENTER;
                    this.textField.text = this._text;
                    this.textField.x = (this._borderWidth >> 1) - (this.textField.width >> 1);
                    this.textField.y = this._borderHeight + this.connector.height + 2;
                    break;
                case "L":
                    this.textField.autoSize = flash.text.TextFieldAutoSize.RIGHT;
                    loc1.align = flash.text.TextFormatAlign.RIGHT;
                    this.textField.text = this._text;
                    this.textField.x = -(this.connector.width + this.textField.width);
                    this.textField.y = (this._borderHeight >> 1) - (this.textField.textHeight >> 1) - 4;
                    break;
            }
            this.textField.setTextFormat(loc1);
            return;
        }

        public var textField:flash.text.TextField;

        public var connector:flash.display.MovieClip;

        public var border:flash.display.MovieClip;

        internal var _text:String="";

        internal var _direction:String="T";

        internal var _borderWidth:Number=256;

        internal var _borderHeight:Number=256;

        internal var _connectorLength:Number=12;
    }
}
