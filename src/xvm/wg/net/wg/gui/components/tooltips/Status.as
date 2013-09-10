package net.wg.gui.components.tooltips 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.tooltips.VO.*;
    import scaleform.clik.core.*;
    
    public class Status extends scaleform.clik.core.UIComponent
    {
        public function Status()
        {
            super();
            this.init();
            return;
        }

        internal function init():void
        {
            this.textFieldHeader.multiline = true;
            this.textFieldHeader.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.textFieldHeader.wordWrap = true;
            this.textField.multiline = true;
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.textField.wordWrap = true;
            this.textFormat = new flash.text.TextFormat();
            return;
        }

        public function setData(arg1:String=null, arg2:String=null, arg3:net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO=null, arg4:String="none"):Number
        {
            var loc1:*=0;
            this._header = arg1;
            this._text = arg2;
            this._statusColors = arg3;
            this._textColor = arg3.textColor ? arg3.textColor : 16777215;
            this._ico = arg4;
            this.icon.gotoAndStop(this._ico);
            if (this._ico != this.ICO_DEF) 
            {
                this.textFieldHeader.x = this.icon.width;
                this.textField.x = this.icon.width;
            }
            this.textFieldHeader.text = this._header;
            this.textField.text = this._text;
            this.textFormat.color = this._textColor;
            if (arg2) 
            {
                this.textFormat.align = flash.text.TextFormatAlign.LEFT;
                this.textField.y = arg1 ? this.textFieldHeader.textHeight + 4 | 0 : 0;
            }
            else 
            {
                this.textField.visible = false;
            }
            this.textFieldHeader.setTextFormat(this.textFormat);
            this.textField.setTextFormat(this.textFormat);
            this.filters = arg3.filters;
            loc1 = Math.max(this.textFieldHeader.textWidth, this.textField.textWidth);
            invalidate();
            return loc1;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public function updateWidth(arg1:Number):void
        {
            if (this._ico != this.ICO_DEF) 
            {
                arg1 = arg1 - this.icon.width;
                this.textFieldHeader.x = this.icon.width;
                this.textField.x = this.icon.width;
            }
            this.textFieldHeader.width = arg1;
            this.textField.width = arg1;
            if (this._text) 
            {
                this.textField.y = this._header ? this.textFieldHeader.textHeight + 4 | 0 : 0;
            }
            return;
        }

        public override function get height():Number
        {
            return _originalHeight;
        }

        
        {
            ICO_NEWSKILL = "newskill";
        }

        internal const ICO_DEF:String="none";

        public var textFieldHeader:flash.text.TextField=null;

        public var textField:flash.text.TextField=null;

        public var icon:flash.display.MovieClip=null;

        internal var _statusColors:net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;

        internal var _header:String;

        internal var _text:String;

        internal var _textColor:uint=0;

        internal var _ico:String="none";

        internal var textFormat:flash.text.TextFormat=null;

        public static var ICO_NEWSKILL:String="newskill";
    }
}
