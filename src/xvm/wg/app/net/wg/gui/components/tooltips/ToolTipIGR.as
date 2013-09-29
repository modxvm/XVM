package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.utils.*;
    
    public class ToolTipIGR extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipIGR()
        {
            super();
            this.headerTF = content.headerTF;
            this.discrTF = content.discrTF;
            this.whiteBg = content.whiteBg;
            return;
        }

        public override function build(arg1:Object, arg2:net.wg.data.managers.ITooltipProps):void
        {
            super.build(arg1, arg2);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.progressBlock) 
            {
                content.removeChild(this.progressBlock);
                this.progressBlock = null;
            }
            return;
        }

        public override function toString():String
        {
            return "[WG ToolTipIGR " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function redraw():void
        {
            var loc4:*=NaN;
            var loc9:*=null;
            var loc1:*=App.utils.locale;
            var loc2:*=0;
            var loc3:*=0;
            loc4 = 300;
            var loc5:*=new net.wg.gui.components.tooltips.VO.IgrVO(_data);
            var loc6:*=null;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            contentMargin.bottom = 2;
            var loc7:*=null;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            this.whiteBg.width = 10;
            topPosition = bgShadowMargin.top + contentMargin.top;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.title, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER, 18, "$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
            loc4 = Math.max(loc4, this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
            (loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
            seaprators.push(loc6);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            if (loc5.description) 
            {
                this.whiteBg.y = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.discrTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.discrTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.description, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$FieldFont");
                this.discrTF.width = loc4 == 0 ? this.discrTF.textWidth + 5 : loc4 - bgShadowMargin.left - contentMargin.left;
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
            var loc8:*=loc5.quests.length;
            var loc10:*=App.utils.classFactory.getClass("igrQuestBlockUI");
            if (loc5.quests && loc5.quests.length > 0) 
            {
                loc8 = loc5.quests.length;
                loc2 = 0;
                while (loc2 < loc8) 
                {
                    loc9 = new loc10();
                    content.addChild(loc9);
                    loc9.setText(loc5.quests[loc2]);
                    loc9.questText.width = loc4 == 0 ? loc9.questText.textWidth + 5 : loc4 - bgShadowMargin.left - contentMargin.left;
                    loc9.x = bgShadowMargin.left + contentMargin.left;
                    loc9.y = topPosition;
                    topPosition = topPosition + loc9.height;
                    ++loc2;
                }
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK;
                this.whiteBg.height = topPosition - this.whiteBg.y;
            }
            if (loc5.progress && loc5.progress.length > 0) 
            {
                (loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.progressBlock = App.utils.classFactory.getComponent("igrQuestProgressUI", net.wg.gui.components.tooltips.IgrQuestProgressBlock);
                content.addChild(this.progressBlock);
                this.progressBlock.setData(loc5.progressHeader, loc5.progress);
                this.progressBlock.width = loc4 == 0 ? this.progressBlock.width : loc4 - bgShadowMargin.left - contentMargin.left;
                this.progressBlock.x = bgShadowMargin.left + contentMargin.left;
                this.progressBlock.y = topPosition;
                topPosition = topPosition + (this.progressBlock.height + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                contentMargin.bottom = contentMargin.bottom + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK;
            }
            loc5 = null;
            updatePositions();
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            super.updateSize();
            this.whiteBg.width = content.width + bgShadowMargin.horizontal;
            return;
        }

        public var headerTF:flash.text.TextField=null;

        public var discrTF:flash.text.TextField=null;

        public var whiteBg:flash.display.Sprite=null;

        internal var progressBlock:net.wg.gui.components.tooltips.IgrQuestProgressBlock=null;
    }
}
