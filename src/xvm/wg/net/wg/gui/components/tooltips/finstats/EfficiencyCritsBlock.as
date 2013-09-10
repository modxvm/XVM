package net.wg.gui.components.tooltips.finstats 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class EfficiencyCritsBlock extends scaleform.clik.core.UIComponent
    {
        public function EfficiencyCritsBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.dirtyData) 
            {
                this.headerTF.text = this._header;
                this.headerTF.width = this.headerTF.textWidth + 5;
                this.contentTF.multiline = true;
                this.contentTF.wordWrap = true;
                this.contentTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.contentTF.htmlText = this._content;
                this.contentTF.width = this.contentTF.textWidth + 5;
            }
            return;
        }

        public function setData(arg1:String, arg2:String):void
        {
            this._header = arg1;
            this._content = arg2;
            this.dirtyData = true;
            validateNow();
            return;
        }

        public var headerTF:flash.text.TextField;

        public var contentTF:flash.text.TextField;

        internal var _header:String="";

        internal var _content:String="";

        internal var dirtyData:Boolean=false;
    }
}
