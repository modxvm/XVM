package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.utils.*;
    
    public class ToolTipAchievement extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipAchievement()
        {
            super();
            this.headerTF = content.headerTF;
            this.discrTF = content.discrTF;
            this.notEnoughTF = content.notEnoughTF;
            this.infoTF = content.infoTF;
            this.heroTF = content.heroTF;
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
            var loc1:*=null;
            super.dispose();
            if (this.flagsBlocks) 
            {
                while (this.flagsBlocks.length > 0) 
                {
                    loc1 = this.flagsBlocks.pop();
                    loc1.dispose();
                    content.removeChild(loc1);
                    loc1 = null;
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[WG ToolTipAchievement " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function redraw():void
        {
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=null;
            var loc16:*=null;
            var loc17:*=NaN;
            var loc18:*=false;
            var loc19:*=null;
            var loc20:*=0;
            var loc21:*=0;
            var loc22:*=NaN;
            var loc1:*=App.utils.locale;
            var loc2:*=0;
            loc3 = 0;
            loc4 = 300;
            loc5 = new net.wg.gui.components.tooltips.VO.AchievementVO(_data);
            var loc6:*=null;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            this.flagsBlocks = new Vector.<net.wg.gui.components.tooltips.AchievmentsCustomBlock>();
            contentMargin.bottom = 2;
            var loc7:*=null;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            this.whiteBg.width = 10;
            topPosition = bgShadowMargin.top + contentMargin.top;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.aName, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER, 18, "$TitleFont");
            this.headerTF.width = this.headerTF.textWidth + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
            loc4 = Math.max(loc4, this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
            (loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
            seaprators.push(loc6);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            if (loc5.discription) 
            {
                this.whiteBg.y = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.discrTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.discrTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.discription, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 11, "$TextFont");
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
            if (loc5.classParams) 
            {
                (loc9 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).leftText = "";
                loc9.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
                loc9.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
                loc9.contener = content;
                loc9.startYPos = topPosition;
                loc9.childrenNamePrefix = "classParams";
                loc9.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
                loc3 = loc5.classParams.length;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc9.leftText = loc9.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc1.integer(loc5.classParams[loc2]), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 12, "$TextFont") + "<br/>");
                    loc10 = ACHIEVEMENTS.achievement("rank" + (loc3 - loc2).toString());
                    loc9.rightTextList.push(new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(loc10));
                    ++loc2;
                }
                loc7 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc9, contentMargin.left + bgShadowMargin.left);
                blockResults.push(loc7);
                topPosition = loc7.startYPos | 0;
                hasIcon = loc7.hasIcons ? true : hasIcon;
                leftPartMaxW = loc7.leftPartMaxW > leftPartMaxW ? loc7.leftPartMaxW : leftPartMaxW;
                this.whiteBg.height = topPosition - this.whiteBg.y;
            }
            if (loc5.heroInfo) 
            {
                this.heroTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.heroTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.heroInfo, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 11, "$TextFont");
                this.heroTF.width = loc4 == 0 ? this.heroTF.textWidth + 5 : loc4 - bgShadowMargin.left - contentMargin.left;
                this.heroTF.x = bgShadowMargin.left + contentMargin.left;
                this.heroTF.y = topPosition;
                topPosition = topPosition + (this.heroTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK | 0);
                this.whiteBg.height = topPosition - this.whiteBg.y;
            }
            else 
            {
                this.heroTF.x = 0;
                this.heroTF.y = 0;
                this.heroTF.width = 10;
                this.heroTF.visible = false;
            }
            var loc8:*;
            if ((loc8 = this.getInfoText(loc5.type, loc5.params, loc5.value)) == "") 
            {
                this.infoTF.x = 0;
                this.infoTF.y = 0;
                this.infoTF.width = 10;
                this.infoTF.visible = false;
            }
            else 
            {
                this.whiteBg.height = topPosition - this.whiteBg.y;
                (loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition;
                seaprators.push(loc6);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                loc11 = new flash.text.TextFormat();
                this.infoTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.infoTF.htmlText = loc8;
                loc11.bold = true;
                this.infoTF.setTextFormat(loc11);
                this.infoTF.x = bgShadowMargin.left + contentMargin.left;
                this.infoTF.y = topPosition;
                this.infoTF.width = this.infoTF.textWidth + 5;
                topPosition = topPosition + (this.infoTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                contentMargin.bottom = 12;
            }
            if (loc5.type != this.TYPE_CUSTOM) 
            {
                this.notEnoughTF.x = 0;
                this.notEnoughTF.y = 0;
                this.notEnoughTF.width = 10;
                this.notEnoughTF.visible = false;
            }
            else 
            {
                loc12 = [];
                loc3 = loc5.vehicleToKill ? loc5.vehicleToKill.length : 0;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc14 = (loc13 = loc5.vehicleToKill[loc2]).level;
                    loc15 = loc13.name;
                    loc16 = loc13.type;
                    loc17 = loc13.nation;
                    loc18 = false;
                    loc19 = {"name":loc15, "nation":loc17, "type":loc16};
                    loc20 = loc12.length;
                    loc21 = 0;
                    while (loc21 < loc20) 
                    {
                        if (loc12[loc21].level == loc14) 
                        {
                            loc12[loc21].data.push(loc19);
                            loc18 = true;
                            break;
                        }
                        ++loc21;
                    }
                    if (!loc18) 
                    {
                        loc12.push({"level":loc14, "data":[loc19]});
                    }
                    ++loc2;
                }
                if (loc12.length > 0) 
                {
                    (loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition;
                    seaprators.push(loc6);
                    topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                    loc12.sortOn("level", [Array.NUMERIC]);
                    loc3 = loc12.length;
                    loc22 = 0;
                    while (loc22 < loc3) 
                    {
                        topPosition = this.addCustomBlock(content, loc12[loc22], topPosition);
                        loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                        if (loc22 == (loc3 - 1)) 
                        {
                            topPosition = topPosition + 5;
                        }
                        loc6.y = topPosition;
                        seaprators.push(loc6);
                        topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                        ++loc22;
                    }
                }
                if (loc5.vehicleToKillLeft > 0) 
                {
                    this.notEnoughTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc1.makeString(TOOLTIPS.ACHIEVEMENT_CUSTOM_NOTENOUGH), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 13, "$TitleFont") + " " + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.vehicleToKillLeft.toString(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 13, "$TitleFont");
                    this.notEnoughTF.width = this.discrTF.width;
                    this.notEnoughTF.height = this.notEnoughTF.textHeight + 5;
                    this.notEnoughTF.y = topPosition;
                    this.notEnoughTF.x = bgShadowMargin.left + contentMargin.left;
                    this.notEnoughTF.visible = true;
                }
                else 
                {
                    this.notEnoughTF.x = 0;
                    this.notEnoughTF.y = 0;
                    this.notEnoughTF.width = 10;
                    this.notEnoughTF.visible = false;
                    loc6 = seaprators.pop();
                    content.removeChild(loc6);
                    loc6 = null;
                }
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

        internal function addCustomBlock(arg1:flash.display.MovieClip, arg2:Object, arg3:Number):Number
        {
            var loc1:*=net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.level(arg2.level)), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$FieldFont") + " " + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.VEHICLE_LEVEL).toLowerCase(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_SUB_NORMAL, 12, "$FieldFont");
            var loc2:*=App.utils.classFactory.getComponent("AchievmentsCustomBlock", net.wg.gui.components.tooltips.AchievmentsCustomBlock);
            arg1.addChild(loc2);
            loc2.setData(loc1, arg2.data);
            loc2.x = bgShadowMargin.left + contentMargin.left + 10;
            loc2.y = arg3;
            this.flagsBlocks.push(loc2);
            arg3 = arg3 + (arg2.data.length * 23 + 5);
            return arg3;
        }

        internal function getInfoText(arg1:String, arg2:Array, arg3:Number):String
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*="";
            if (arg2) 
            {
                loc2 = 0;
                loc3 = arg2.length;
                var loc4:*=arg1;
                switch (loc4) 
                {
                    case this.TYPE_SERIES:
                    {
                        loc2 = 0;
                        while (loc2 < loc3) 
                        {
                            loc1 = loc1 + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.achievement_params(arg2[loc2].id)), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 14, "$TitleFont") + " " + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(arg2[loc2].val, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 14, "$TitleFont"));
                            ++loc2;
                        }
                        break;
                    }
                    case this.TYPE_CLASS:
                    {
                        loc2 = 0;
                        while (loc2 < loc3) 
                        {
                            loc1 = loc1 + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.achievement_params("left" + (arg3 - 1))), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 14, "$TitleFont") + " " + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.niceNumber(arg2[loc2].val) + " " + App.utils.locale.makeString(TOOLTIPS.achievement_params(arg2[loc2].id)), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 14, "$TitleFont"));
                            ++loc2;
                        }
                        break;
                    }
                    case this.TYPE_CUSTOM:
                    {
                        loc2 = 0;
                        while (loc2 < loc3) 
                        {
                            loc1 = loc1 + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.achievement_params(arg2[loc2].id)), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 14, "$TitleFont");
                            ++loc2;
                        }
                        break;
                    }
                }
            }
            return loc1;
        }

        internal const TYPE_CLASS:String="class";

        internal const TYPE_SERIES:String="series";

        internal const TYPE_CUSTOM:String="custom";

        internal var headerTF:flash.text.TextField=null;

        internal var discrTF:flash.text.TextField=null;

        internal var notEnoughTF:flash.text.TextField=null;

        internal var infoTF:flash.text.TextField=null;

        internal var heroTF:flash.text.TextField=null;

        internal var whiteBg:flash.display.Sprite=null;

        internal var flagsBlocks:__AS3__.vec.Vector.<net.wg.gui.components.tooltips.AchievmentsCustomBlock>=null;
    }
}
