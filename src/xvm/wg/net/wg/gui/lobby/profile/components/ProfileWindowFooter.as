package net.wg.gui.lobby.profile.components 
{
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ProfileWindowFooter extends scaleform.clik.core.UIComponent
    {
        public function ProfileWindowFooter()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*;
            this.textFieldRight.autoSize = loc1 = flash.text.TextFieldAutoSize.LEFT;
            this.textFieldLeft.autoSize = loc1;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.textFieldLeft.htmlText = this._textLeft;
                this.textFieldRight.htmlText = this._textRight;
                invalidate(LAYOUT_INVALID);
            }
            if (isInvalid(LAYOUT_INVALID)) 
            {
                this.textFieldLeft.x = this._sidesGap;
                this.textFieldRight.x = this.width - this._sidesGap - this.textFieldRight.width;
            }
            return;
        }

        public function setTexts(arg1:String, arg2:String):void
        {
            this._textLeft = arg1;
            this._textRight = arg2;
            invalidateData();
            return;
        }

        public function get sidesGap():uint
        {
            return this._sidesGap;
        }

        public function set sidesGap(arg1:uint):void
        {
            this._sidesGap = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        internal static const LAYOUT_INVALID:String="layInv";

        internal var _sidesGap:uint=10;

        public var textFieldLeft:flash.text.TextField;

        public var textFieldRight:flash.text.TextField;

        internal var _textLeft:String;

        internal var _textRight:String;
    }
}
