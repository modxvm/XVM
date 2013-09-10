package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.tooltips.helpers.*;
    
    public class ToolTipComplex extends net.wg.gui.components.tooltips.ToolTipBase
    {
        public function ToolTipComplex()
        {
            super();
            this.contentList = new Vector.<flash.text.TextField>();
            return;
        }

        public override function build(arg1:Object, arg2:net.wg.data.managers.ITooltipProps):void
        {
            this.setProp(arg2);
            this.setContent(arg1);
            redraw();
            return;
        }

        internal function setProp(arg1:net.wg.data.managers.ITooltipProps):void
        {
            _props = arg1;
            this._minWidth = arg1.minWidth;
            this._maxWidth = arg1.maxWidth;
            return;
        }

        protected override function updateSize():void
        {
            var loc1:*=null;
            loc1 = this.calcDimension();
            var loc2:*;
            background.y = loc2 = 0;
            background.x = loc2;
            background.width = Math.round(loc1.w) + this._leftMargin + this._rightMargin;
            background.height = Math.round(loc1.h) + this._topMargin + this._bottomMargin;
            return;
        }

        internal function calcDimension():Object
        {
            var loc7:*=null;
            var loc8:*=NaN;
            var loc1:*=this._maxWidth;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=this.contentList.length;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = this.contentList[loc5];
                if (this._maxWidth) 
                {
                    loc7.y = loc7.y + loc3;
                    if (loc1 < loc7.width) 
                    {
                        loc8 = loc7.textHeight;
                        loc7.width = loc1;
                        loc7.height = loc7.textHeight + 4;
                        loc3 = loc3 + (loc7.textHeight - loc8);
                    }
                }
                else if (loc1 < loc7.width) 
                    loc1 = this.contentList[loc5].width;
                if (loc2 < loc7.y + loc7.textHeight) 
                    loc2 = loc7.y + loc7.textHeight;
                ++loc5;
            }
            loc1 = loc1 + 5;
            var loc6:*;
            return loc6 = {"w":loc1, "h":loc2};
        }

        internal function setContent(arg1:Object):void
        {
            var loc6:*=null;
            this._leftMargin = 10;
            this._rightMargin = 10;
            this._topMargin = 6;
            this._bottomMargin = 11;
            var loc1:*=this.contTopMargin;
            var loc2:*=0;
            var loc3:*=new flash.text.TextFormat();
            var loc4:*=10;
            var loc5:*=this._minWidth != 0 ? this._minWidth : 500;
            var loc7:*=typeof arg1;
            switch (loc7) 
            {
                case "string":
                    (loc6 = new flash.text.TextField()).x = this.contLeftMargin;
                    loc6.y = loc1;
                    loc6.width = loc5;
                    loc6.height = loc4;
                    setTextProp(loc6, String(arg1), loc3, "left");
                    loc6.width = loc6.textWidth + 4;
                    loc2 = loc6.textHeight;
                    this.contentList.push(loc6);
                    addChild(loc6);
                    break;
            }
            return;
        }

        internal static function setTextProp(arg1:flash.text.TextField, arg2:String, arg3:flash.text.TextFormat, arg4:String):void
        {
            arg3.align = arg4;
            arg3.leading = 2;
            arg1.wordWrap = true;
            arg1.multiline = true;
            arg1.autoSize = arg4;
            arg1.embedFonts = true;
            var loc1:*;
            if ((loc1 = arg2.toLowerCase().indexOf("face=\"", 0)) > 0) 
                arg3.font = arg2.slice(loc1 + 6, arg2.indexOf("\"", loc1 + 6));
            else 
                arg3.font = "$TextFont";
            if (arg2.slice(0, 1) != "#") 
                arg1.htmlText = "<font color=\"" + COLOR_HEADER + "\" size=\"12\">" + arg2 + "</font>";
            else 
            {
                arg1.htmlText = arg2;
                arg1.textColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(COLOR_HEADER);
            }
            arg1.setTextFormat(arg3);
            return;
        }

        internal static const COLOR_HEADER:String="#fdf4ce";

        internal var _minWidth:Number;

        internal var _maxWidth:Number;

        internal var _leftMargin:Number=10;

        internal var _rightMargin:Number=10;

        internal var _topMargin:Number=6;

        internal var _bottomMargin:Number=11;

        internal var contTopMargin:Number=10;

        internal var contLeftMargin:Number=13;

        internal var contentList:__AS3__.vec.Vector.<flash.text.TextField>;
    }
}
