package net.wg.gui.lobby.profile.components 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class LineIconText extends scaleform.clik.core.UIComponent
    {
        public function LineIconText()
        {
            super();
            return;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            this.isTextChanged = true;
            invalidate();
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.isTextChanged) 
            {
                this.isTextChanged = false;
                this.applyText();
            }
            if (this.isPaddingChanged) 
            {
                this.isPaddingChanged = false;
            }
            if (this.isIconSourceChanged) 
            {
                this.icon.source = this._iconSource;
            }
            return;
        }

        protected function applyText():void
        {
            this.textComponent.text = this._text;
            return;
        }

        public function get iconSource():String
        {
            return this._iconSource;
        }

        public function set iconSource(arg1:String):void
        {
            this._iconSource = arg1;
            this.isIconSourceChanged = true;
            invalidate();
            return;
        }

        public var textComponent:net.wg.gui.lobby.profile.components.UnderlinedText;

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        protected var _text:String="";

        protected var isTextChanged:Boolean;

        internal var isPaddingChanged:Boolean;

        internal var _iconSource:String;

        internal var isIconSourceChanged:Boolean;
    }
}
