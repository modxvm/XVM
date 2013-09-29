package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.utils.*;
    
    public class ToolTipTankClass extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipTankClass()
        {
            super();
            this.initControls();
            return;
        }

        public function get utils():net.wg.gui.components.tooltips.helpers.Utils
        {
            return net.wg.gui.components.tooltips.helpers.Utils.instance;
        }

        protected override function redraw():void
        {
            var loc1:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            contentMargin.left = 19;
            topPosition = bgShadowMargin.top + contentMargin.top;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            loc1 = _data.value;
            var loc2:*=new flash.text.TextFormat();
            loc2.leading = -2;
            loc2.align = flash.text.TextFormatAlign.LEFT;
            var loc3:*="<img src=\"img://gui/maps/icons/library/proficiency/class_icons_" + loc1 + ".png\" WIDTH=\"32\" HEIGHT=\"32\" VSPACE=\"-10\"/>&nbsp;&nbsp;" + this.utils.htmlWrapper(_data.name, this.utils.COLOR_HEADER, 18, "$TitleFont", false);
            this.headerTF.htmlText = loc3;
            this.headerTF.setTextFormat(loc2);
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + 12);
            this.separator = this.utils.createSeparate(content);
            this.separator.y = topPosition;
            this.whiteBg.y = topPosition;
            topPosition = topPosition + this.utils.MARGIN_AFTER_BLOCK;
            var loc4:*=App.utils.locale;
            var loc5:*="<font face=\"$TextFont\" size=\"11\" color=\"" + this.utils.COLOR_NUMBER + "\">" + loc4.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT + "/" + loc1) + "%</font>";
            var loc6:*="<font face=\"$TextFont\" size=\"11\" color=\"" + this.utils.COLOR_NORMAL + "\">" + loc4.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT, {"val":loc5}) + "</font>";
            this.descriptionTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.descriptionTF.htmlText = loc6;
            this.descriptionTF.width = this.descriptionTF.textWidth + 5;
            this.descriptionTF.height = this.descriptionTF.textHeight + 5;
            this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
            this.descriptionTF.y = topPosition;
            topPosition = topPosition + (this.descriptionTF.height + 5);
            var loc7:*;
            (loc7 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).contener = content;
            loc7.startYPos = topPosition;
            loc7.leftTextColor = this.utils.convertStringColorToNumber(this.utils.COLOR_NUMBER);
            loc7.leftText = "";
            loc7.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
            loc7.rightTextColor = this.utils.convertStringColorToNumber(this.utils.COLOR_NORMAL);
            var loc8:*=4;
            while (loc8 > 0) 
            {
                loc10 = loc4.makeString(ACHIEVEMENTS.MARKOFMASTERYCONTENT + "/" + loc8) + "%";
                loc7.leftText = loc7.leftText + (this.utils.htmlWrapper(loc10, this.utils.COLOR_NUMBER, 11, "$TextFont", false) + "<br>");
                loc11 = ACHIEVEMENTS.achievement("master" + loc8);
                loc12 = "class" + loc8;
                loc7.rightTextList.push(new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(loc11, loc12, -1, 4));
                --loc8;
            }
            var loc9:*=net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc7, contentMargin.left + bgShadowMargin.left);
            blockResults.push(loc9);
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            this.whiteBg.width = content.width + bgShadowMargin.horizontal;
            this.whiteBg.height = content.height - this.whiteBg.y + contentMargin.bottom;
            return;
        }

        internal function initControls():void
        {
            this.headerTF = content.headerTF;
            this.descriptionTF = content.descriptionTF;
            this.whiteBg = content.whiteBg;
            return;
        }

        internal var headerTF:flash.text.TextField;

        internal var descriptionTF:flash.text.TextField;

        internal var whiteBg:flash.display.Sprite;

        internal var separator:net.wg.gui.components.tooltips.Separator;
    }
}
