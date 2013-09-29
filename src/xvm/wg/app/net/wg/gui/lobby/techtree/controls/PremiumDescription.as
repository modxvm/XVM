package net.wg.gui.lobby.techtree.controls 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class PremiumDescription extends scaleform.clik.core.UIComponent
    {
        public function PremiumDescription()
        {
            super();
            this.textFormat = new flash.text.TextFormat();
            this.textFormat.align = flash.text.TextFormatAlign.LEFT;
            this.textFormat.leading = -3;
            return;
        }

        public function setData(arg1:net.wg.gui.lobby.techtree.data.vo.ExtraInformation):void
        {
            if (arg1 == null) 
            {
                return;
            }
            this._data = arg1;
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            if (!(this._data == null) && isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this.titleField != null) 
                {
                    this.titleField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                    this.titleField.htmlText = this._data.title == null ? "" : this._data.title;
                    this.titleField.setTextFormat(this.textFormat);
                    this.titleField.width = this.titleField.textWidth + TITLE_PADDING;
                }
                if (this.benefitField != null) 
                {
                    this.benefitField.text = this._data.benefitsHead == null ? "" : this._data.benefitsHead;
                }
                if (this.contentField != null) 
                {
                    this.contentField.multiline = true;
                    this.contentField.wordWrap = true;
                    this.contentField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                    this.contentField.htmlText = this._data.benefitsList == null ? "" : this._data.benefitsList;
                }
                if (this.typeIcon != null) 
                {
                    this.typeIcon.gotoAndStop(this._data.type + ELITE_SUFFIX);
                }
            }
            super.draw();
            return;
        }

        public static const ELITE_SUFFIX:String="_elite";

        public static const TITLE_PADDING:Number=5;

        internal var _data:net.wg.gui.lobby.techtree.data.vo.ExtraInformation;

        internal var textFormat:flash.text.TextFormat;

        public var titleField:flash.text.TextField;

        public var benefitField:flash.text.TextField;

        public var contentField:flash.text.TextField;

        public var typeIcon:flash.display.MovieClip;
    }
}
