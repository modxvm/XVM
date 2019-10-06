package net.wg.gui.components.controls
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import scaleform.gfx.TextFieldEx;

    public class TextFieldContainer extends Sprite implements IDisposable
    {

        protected static const TEXT_FIELD_BOUNDS_HEIGHT:Number = 4;

        public var textField:TextField = null;

        private var _text:String = "";

        private var _isMultiline:Boolean = false;

        private var _isUpdateWidth:Boolean = false;

        private var _tf:TextFormat = null;

        public function TextFieldContainer()
        {
            super();
            this.textField.cacheAsBitmap = true;
            this._tf = this.textField.getTextFormat();
        }

        public final function dispose() : void
        {
            this._tf = null;
            this.textField = null;
        }

        private function updateSize() : void
        {
            App.utils.commons.updateTextFieldSize(this.textField,this._isUpdateWidth,this._isMultiline);
            this.textField.height = this.textField.textHeight + TEXT_FIELD_BOUNDS_HEIGHT | 0;
        }

        public function set noTranslateTextfield(param1:Boolean) : void
        {
            TextFieldEx.setNoTranslate(this.textField,param1);
        }

        public function set label(param1:String) : void
        {
            if(this._text == param1)
            {
                return;
            }
            this._text = param1;
            this.textField.text = param1;
            this.updateSize();
        }

        public function set htmlLabel(param1:String) : void
        {
            if(this._text == param1)
            {
                return;
            }
            this._text = param1;
            this.textField.htmlText = param1;
            this.updateSize();
        }

        public function set isMultiline(param1:Boolean) : void
        {
            if(this._isMultiline == param1)
            {
                return;
            }
            this._isMultiline = param1;
            this.updateSize();
        }

        public function set isUpdateWidth(param1:Boolean) : void
        {
            if(this._isUpdateWidth == param1)
            {
                return;
            }
            this._isUpdateWidth = param1;
            this.updateSize();
        }

        public function set fontSize(param1:int) : void
        {
            if(this._tf.size == param1)
            {
                return;
            }
            this._tf.size = param1;
            this.textField.setTextFormat(this._tf);
            this.updateSize();
        }
    }
}
