package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    
    public class ToolTipSkill extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipSkill()
        {
            super();
            this.headerTF = content.headerTF;
            this.discrTF = content.discrTF;
            this.infoTF = content.infoTF;
            this.whiteBg = content.whiteBg;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            return;
        }

        protected override function redraw():void
        {
            var loc2:*=null;
            var loc4:*=null;
            var loc1:*=new net.wg.gui.components.tooltips.VO.ToolTipSkillVO(_data);
            contentMargin.bottom = 2;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            this.whiteBg.width = 10;
            topPosition = bgShadowMargin.top + contentMargin.top;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc1.name, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER, 18, "$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
            this.maxWidth = Math.max(this.maxWidth, this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
            loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
            loc2.y = topPosition | 0;
            seaprators.push(loc2);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            if (loc1.descr) 
            {
                this.whiteBg.y = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.discrTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.discrTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc1.descr, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 11, "$TextFont");
                this.discrTF.width = this.maxWidth == 0 ? this.discrTF.textWidth + 5 : this.maxWidth - bgShadowMargin.left - contentMargin.left;
                this.discrTF.x = bgShadowMargin.left + contentMargin.left;
                this.discrTF.y = topPosition;
                topPosition = topPosition + (this.discrTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK | 0);
                this.whiteBg.height = topPosition - this.whiteBg.y;
            }
            else 
            {
                this.discrTF.x = 0;
                this.discrTF.y = 0;
                this.discrTF.width = 10;
                this.discrTF.visible = false;
            }
            var loc3:*=getInfoText(loc1.type);
            if (loc3 == "") 
            {
                this.infoTF.x = 0;
                this.infoTF.y = 0;
                this.infoTF.width = 10;
                this.infoTF.visible = false;
            }
            else 
            {
                this.whiteBg.height = topPosition - this.whiteBg.y;
                loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc2.y = topPosition;
                seaprators.push(loc2);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                loc4 = new flash.text.TextFormat();
                this.infoTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.infoTF.htmlText = loc3;
                loc4.bold = true;
                this.infoTF.setTextFormat(loc4);
                this.infoTF.x = bgShadowMargin.left + contentMargin.left;
                this.infoTF.y = topPosition;
                this.infoTF.width = this.infoTF.textWidth + 5;
                topPosition = topPosition + (this.infoTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                contentMargin.bottom = 12;
            }
            loc1 = null;
            updatePositions();
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            this.whiteBg.width = content.width + contentMargin.bottom + bgShadowMargin.bottom | 0;
            return;
        }

        public override function toString():String
        {
            return "[SkillToolTip]";
        }

        internal static function getInfoText(arg1:String):String
        {
            var loc1:*="";
            loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(ITEM_TYPES.tankman_skills_type(arg1), {}), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 14, "$FieldFont", true);
            return loc1;
        }

        internal var headerTF:flash.text.TextField=null;

        internal var discrTF:flash.text.TextField=null;

        internal var infoTF:flash.text.TextField=null;

        internal var whiteBg:flash.display.Sprite=null;

        internal var maxWidth:Number=270;
    }
}
