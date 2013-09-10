package net.wg.gui.lobby.moduleInfo 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;
    
    public class ModuleParameters extends scaleform.clik.core.UIComponent
    {
        public function ModuleParameters()
        {
            super();
            return;
        }

        public function get bottomMargin():Number
        {
            return this._bottomMargin;
        }

        public function set bottomMargin(arg1:Number):void
        {
            this._bottomMargin = arg1;
            return;
        }

        public function setParameters(arg1:Array=null):void
        {
            var loc2:*=null;
            this.paramValue.htmlText = "";
            this.paramType.htmlText = "";
            var loc1:*=arg1.length;
            if (loc1 > 0) 
            {
                var loc3:*=0;
                var loc4:*=arg1;
                for each (loc2 in loc4) 
                {
                    if (this.paramValue.htmlText.length > 0) 
                        scaleform.gfx.TextFieldEx.appendHtml(this.paramValue, "\n");
                    scaleform.gfx.TextFieldEx.appendHtml(this.paramValue, loc2.value);
                    scaleform.gfx.TextFieldEx.appendHtml(this.paramType, loc2.type);
                }
            }
            updateTextHeight(this.paramValue, loc1);
            updateTextHeight(this.paramType, loc1);
            height = this.paramValue.y + this.paramValue.height + this._bottomMargin;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.HEADER_TEXT_INV)) 
                this.header.htmlText = this._headerText;
            return;
        }

        public function get headerText():String
        {
            return this._headerText;
        }

        public function set headerText(arg1:String):void
        {
            this._headerText = arg1;
            invalidate(this.HEADER_TEXT_INV);
            return;
        }

        internal static function updateTextHeight(arg1:flash.text.TextField, arg2:int):void
        {
            var loc1:*=arg1.getLineMetrics(0);
            arg1.height = (loc1.height + loc1.leading + LINE_SPACING_CORRECTION) * arg2;
            return;
        }

        internal const HEADER_TEXT_INV:String="headerTextInv";

        internal static const LINE_SPACING_CORRECTION:int=1;

        public var header:flash.text.TextField;

        public var paramValue:flash.text.TextField;

        public var paramType:flash.text.TextField;

        protected var _bottomMargin:Number;

        internal var _headerText:String="";
    }
}
