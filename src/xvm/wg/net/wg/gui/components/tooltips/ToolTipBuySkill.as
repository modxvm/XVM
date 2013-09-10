package net.wg.gui.components.tooltips 
{
    import flash.display.*;
    import flash.text.*;
    import flashx.textLayout.formats.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.lobby.tankman.*;
    import net.wg.utils.*;
    
    public class ToolTipBuySkill extends net.wg.gui.components.tooltips.ToolTipBase
    {
        public function ToolTipBuySkill()
        {
            super();
            this._maxWidth = 283 - (this._leftMargin + this._rightMargin);
            this._bottomMargin = 5;
            this.marginAfterSeparate = 15;
            return;
        }

        public override function toString():String
        {
            return "[BuySkillToolTip]";
        }

        protected override function redraw():void
        {
            this.setContent();
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            var loc1:*=null;
            loc1 = this.getContDimension();
            var loc2:*;
            background.y = loc2 = 0;
            background.x = loc2;
            background.width = loc1.width + this._leftMargin + this._rightMargin;
            this.separate_mc.x = background.width - this.separate_mc.width >> 1;
            background.height = loc1.height + this._topMargin + this._bottomMargin;
            return;
        }

        internal function setContent():void
        {
            var loc1:*=NaN;
            loc1 = this._topMargin;
            this.header.x = this._leftMargin;
            this.header.y = loc1;
            this.header.autoSize = flashx.textLayout.formats.TextAlign.LEFT;
            this.header.text = TOOLTIPS.BUYSKILL_HEADER;
            loc1 = loc1 + Math.round(this.header.textHeight + this._topMargin);
            this.separate_mc.y = loc1;
            loc1 = loc1 + this.marginAfterSeparate;
            var loc2:*=Number(_data.count);
            var loc3:*=Number(_data.level);
            if (loc3 == 100) 
            {
                ++loc2;
                loc3 = 0;
            }
            var loc4:*=App.utils.classFactory;
            if (loc3 > 0) 
            {
                this.skillLevel = loc4.getComponent(net.wg.data.constants.Linkages.SKILL_ITEM_VIEW_MINI, flash.display.MovieClip);
                this.skillLevel.x = this._leftMargin;
                addChild(this.skillLevel);
            }
            if (loc2 > 1) 
            {
                this.skillCount = loc4.getComponent(net.wg.data.constants.Linkages.SKILL_ITEM_VIEW_MINI, net.wg.gui.lobby.tankman.SkillItemViewMini);
                addChild(this.skillCount);
                this.skillCount.x = this._leftMargin;
                this.skillCount.y = loc1;
                this.skillCount.type = loc2 > 2 ? net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILLS : net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL;
                this.skillCount.text = "<font size=\"12\" color=\"#7B7969\" face=\"$FieldFont\">" + App.utils.locale.makeString(TOOLTIPS.BUYSKILL_FULLY, {"count":"<font size=\"12\" face=\"$TitleFont\" color=\"#FFAC34\">" + String((loc2 - 1)) + " x 100%</font>"}) + "</font>";
                if (loc3 > 0) 
                    this.skillLevel.y = Math.round(this.skillCount.y + LINE_HEIGHT);
            }
            else if (loc3 > 0) 
                this.skillLevel.y = loc1;
            if (loc3 > 0) 
            {
                this.skillLevel.type = net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_CURRENT_NEW_SKILL;
                this.skillLevel.text = "<font size=\"12\" color=\"#7B7969\" face=\"$FieldFont\">" + App.utils.locale.makeString(TOOLTIPS.BUYSKILL_PARTLY, {"count":"<font size=\"12\" face=\"$TitleFont\" color=\"#F06532\">" + String(loc3) + "%</font>"}) + "</font>";
                this.skillLevel.x = this._leftMargin;
            }
            return;
        }

        internal function getContDimension():net.wg.gui.components.tooltips.VO.Dimension
        {
            var loc1:*=new net.wg.gui.components.tooltips.VO.Dimension();
            loc1.width = this.separate_mc.width - (this._leftMargin + this._rightMargin);
            loc1.width = loc1.width > this.header.textWidth ? loc1.width : this.header.textWidth;
            loc1.height = this.header.x + this.header.textHeight;
            if (this.skillCount) 
                loc1.width = loc1.width > this.skillCount.width ? loc1.width : this.skillCount.width;
            if (this.skillLevel) 
                loc1.width = loc1.width > this.skillLevel.width ? loc1.width : this.skillLevel.width;
            loc1.width = loc1.width < this._maxWidth ? this._maxWidth : loc1.width;
            loc1.width = Math.round(loc1.width);
            loc1.height = this.skillLevel ? Math.round(this.skillLevel.y + this.skillLevel.height - 6) : this.skillCount ? Math.round(this.skillCount.y + this.skillCount.height - 6) : loc1.height;
            return loc1;
        }

        internal static const LINE_HEIGHT:Number=22;

        public var header:flash.text.TextField;

        public var separate_mc:flash.display.Sprite;

        public var skillLevel:net.wg.gui.lobby.tankman.SkillItemViewMini;

        public var skillCount:net.wg.gui.lobby.tankman.SkillItemViewMini;

        internal var _maxWidth:Number=0;

        internal var _bottomMargin:Number=12;

        internal var marginAfterSeparate:Number=8;

        internal var _leftMargin:Number=18;

        internal var _rightMargin:Number=18;

        internal var _topMargin:Number=12;
    }
}
