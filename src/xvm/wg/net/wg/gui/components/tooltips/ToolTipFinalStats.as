package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.finstats.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.gui.events.*;
    import net.wg.utils.*;
    
    public class ToolTipFinalStats extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipFinalStats()
        {
            super();
            this.headerTF = content.headerTF;
            this.infoTF = content.infoTF;
            this.icon = content.icon;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function redraw():void
        {
            this.setData();
            updatePositions();
            super.redraw();
            return;
        }

        internal function setData():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc6:*=null;
            loc1 = new net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO(_data);
            this.disabled = loc1.disabled;
            contentMargin.top = 17;
            contentMargin.bottom = 17;
            topPosition = bgShadowMargin.top + contentMargin.top;
            loc2 = null;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            this.critBlocks = new Vector.<net.wg.gui.components.tooltips.finstats.EfficiencyCritsBlock>();
            var loc3:*=18;
            var loc4:*="<br/>";
            if (loc1.disabled) 
            {
                loc3 = 14;
                loc4 = "<br/><font size=\"4\"> </font><br/>";
            }
            var loc5:*="";
            loc6 = App.utils.locale;
            var loc12:*=loc1.type;
            switch (loc12) 
            {
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_KILL:
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_TEAM_KILL:
                    loc5 = loc6.makeString(BATTLE_RESULTS.common_tooltip(loc1.type + loc1.value + "/description"));
                    break;
                default:
                    loc5 = loc6.makeString(BATTLE_RESULTS.common_tooltip(loc1.type + "/description"));
            }
            loc5 = loc4 + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$FieldFont");
            var loc7:*=net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6.makeString(BATTLE_RESULTS.common_tooltip(loc1.type + "/header")), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER, loc3, "$TitleFont") + loc5;
            var loc8:*;
            (loc8 = new flash.text.TextFormat()).leading = 0;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.multiline = true;
            this.headerTF.wordWrap = true;
            this.headerTF.htmlText = loc7;
            this.headerTF.setTextFormat(loc8);
            this.headerTF.x = bgShadowMargin.left + contentMargin.left * 2 + this.icon.width | 0;
            this.headerTF.y = this.disabled ? topPosition - 3 : topPosition - 5;
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.icon.x = bgShadowMargin.left + contentMargin.left;
            this.icon.y = topPosition | 0;
            this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIcoLoaded);
            this.icon.source = DEF_ICO_PATH + loc1.type + ".png";
            this.headerTF.height = Math.max(this.headerTF.height, this.icon.y - this.headerTF.y + this.icon.height);
            if (this.disabled) 
            {
                this.hideInfo();
                return;
            }
            topPosition = 80;
            loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
            loc2.y = topPosition | 0;
            seaprators.push(loc2);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            var loc9:*=0;
            var loc10:*="";
            var loc11:*="";
            loc12 = loc1.type;
            switch (loc12) 
            {
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_STOTTED:
                    break;
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_ASSIST:
                    loc9 = loc1.value;
                    loc10 = loc1.values;
                    loc11 = loc1.discript;
                    break;
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_CRITS:
                    loc9 = loc1.value;
                    if (loc1.critDamage) 
                        topPosition = this.createCritPart(net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.CRIT_TYPE_DAMAGE, loc1.critDamage, topPosition);
                    if (loc1.critDestruction) 
                        topPosition = this.createCritPart(net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.CRIT_TYPE_DISTRUCTION, loc1.critDestruction, topPosition);
                    if (loc1.critWound) 
                        topPosition = this.createCritPart(net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.CRIT_TYPE_WOUND, loc1.critWound, topPosition);
                    break;
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_DAMAGE:
                    loc10 = loc1.values;
                    loc11 = loc1.discript;
                    break;
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_KILL:
                    break;
                case net.wg.gui.components.tooltips.VO.ToolTipFinalStatsVO.TYPE_TEAM_KILL:
                    break;
            }
            if (!(loc10 == "") && !(loc11 == "")) 
            {
                this.efficiencyBlock = App.utils.classFactory.getComponent("EfficiencyBlockUI", net.wg.gui.components.tooltips.finstats.EfficiencyBlock);
                content.addChild(this.efficiencyBlock);
                this.efficiencyBlock.setData(loc10, loc11);
                this.efficiencyBlock.x = bgShadowMargin.left + contentMargin.left;
                this.efficiencyBlock.y = topPosition;
                topPosition = topPosition + (this.efficiencyBlock.actualHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc2.y = topPosition | 0;
                seaprators.push(loc2);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            }
            if (loc9 == 0) 
            {
                this.hideInfo();
                loc2 = seaprators.pop();
                content.removeChild(loc2);
                loc2 = null;
            }
            else 
            {
                this.infoTF.x = bgShadowMargin.left + contentMargin.left;
                this.infoTF.y = topPosition | 0;
                this.infoTF.multiline = false;
                this.infoTF.wordWrap = false;
                this.infoTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.infoTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6.makeString(BATTLE_RESULTS.common_tooltip(loc1.type + "/total")), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 14, "$TitleFont") + " " + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6.integer(loc1.value), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 14, "$TitleFont");
                this.infoTF.width = this.infoTF.textWidth + 5;
            }
            loc1 = null;
            return;
        }

        internal function hideInfo():void
        {
            if (this.infoTF) 
            {
                this.infoTF.x = 0;
                this.infoTF.y = 0;
                this.infoTF.width = 10;
                this.infoTF.visible = false;
            }
            return;
        }

        internal function createCritPart(arg1:String, arg2:String, arg3:Number):Number
        {
            var loc1:*=App.utils.classFactory.getComponent("EfficiencyCritsBlockUI", net.wg.gui.components.tooltips.finstats.EfficiencyCritsBlock);
            content.addChild(loc1);
            loc1.setData(BATTLE_RESULTS.common_tooltip("crits/" + arg1), arg2);
            loc1.x = bgShadowMargin.left + contentMargin.left;
            loc1.y = arg3;
            arg3 = arg3 + (loc1.actualHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
            var loc2:*;
            (loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = arg3 | 0;
            seaprators.push(loc2);
            arg3 = arg3 + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            this.critBlocks.push(loc1);
            return arg3;
        }

        internal function onIcoLoaded(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIcoLoaded);
            this.headerTF.x = this.icon.x + this.icon.width + contentMargin.left | 0;
            this.icon.alpha = this.disabled ? 0.3 : 1;
            updateSize();
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            if (this.efficiencyBlock) 
            {
                content.removeChild(this.efficiencyBlock);
                this.efficiencyBlock = null;
            }
            if (this.critBlocks) 
                while (this.critBlocks.length > 0) 
                {
                    loc1 = this.critBlocks.pop();
                    content.removeChild(loc1);
                    loc1 = null;
                }
            super.dispose();
            return;
        }

        
        {
            DEF_ICO_PATH = "../maps/icons/tooltip/";
        }

        public var headerTF:flash.text.TextField=null;

        public var icon:net.wg.gui.components.controls.UILoaderAlt=null;

        public var infoTF:flash.text.TextField=null;

        internal var disabled:Boolean=true;

        internal var critBlocks:__AS3__.vec.Vector.<net.wg.gui.components.tooltips.finstats.EfficiencyCritsBlock>=null;

        internal var efficiencyBlock:net.wg.gui.components.tooltips.finstats.EfficiencyBlock=null;

        internal static var DEF_ICO_PATH:String="../maps/icons/tooltip/";
    }
}
