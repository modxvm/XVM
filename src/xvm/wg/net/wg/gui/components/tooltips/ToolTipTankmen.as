package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.gui.events.*;
    import net.wg.utils.*;
    
    public class ToolTipTankmen extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipTankmen()
        {
            super();
            this.headerTF = content.headerTF;
            this.tooltipStatus = content.tooltipStatus;
            this.tooltipStatusNewSkill = content.tooltipStatusNewSkill;
            this.tankInfoHeaderTF = content.tankInfoHeaderTF;
            this.tankInfoTF = content.tankInfoTF;
            this.vehicleIco = content.vehicleIco;
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
            if (this.vehicleIco.hasEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE)) 
                this.vehicleIco.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIcoLoaded);
            super.dispose();
            return;
        }

        public override function toString():String
        {
            return "[WG ToolTipTankmen " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function redraw():void
        {
            var loc1:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            loc1 = null;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            this.dataVO = new net.wg.gui.components.tooltips.VO.TankmenVO(_data);
            var loc2:*=null;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            var loc3:*=0;
            var loc4:*=0;
            this.whiteBg.width = 10;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(this.dataVO.vName, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER, 18, "$TitleFont") + "<br/>" + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(this.dataVO.rank, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$FieldFont");
            this.headerTF.x = contentMargin.left + bgShadowMargin.left;
            this.headerTF.y = topPosition;
            this.headerTF.width = this.headerTF.textWidth + 5;
            topPosition = topPosition + (this.headerTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
            loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
            loc1.y = topPosition;
            seaprators.push(loc1);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            var loc5:*=App.utils.locale;
            if (this.dataVO.vehicleContour == "") 
            {
                var loc15:*;
                this.vehicleIco.visible = loc15 = false;
                this.tankInfoTF.visible = loc15 = loc15;
                this.whiteBg.visible = loc15 = loc15;
                this.tankInfoHeaderTF.visible = loc15;
                this.tankInfoHeaderTF.width = 10;
                this.tankInfoTF.width = 10;
            }
            else 
            {
                topPosition = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.whiteBg.x = bgShadowMargin.left + 1;
                this.whiteBg.y = topPosition;
                this.whiteBg.height = 81;
                this.tankInfoHeaderTF.y = topPosition + 9;
                this.tankInfoHeaderTF.x = contentMargin.left + bgShadowMargin.left;
                this.tankInfoHeaderTF.text = TOOLTIPS.HANGAR_CREW_ASSIGNEDTO;
                this.tankInfoHeaderTF.width = this.tankInfoHeaderTF.textWidth + 5;
                this.vehicleIco.y = topPosition + 35;
                this.vehicleIco.x = contentMargin.left + bgShadowMargin.left;
                loc6 = (loc6 = loc5.makeString(MENU.tankmen(this.dataVO.currentVehicleType))).slice(0, 1).toUpperCase() + loc6.slice(1);
                loc6 = this.dataVO.currentVehicleName + "<br/>" + loc6;
                (loc7 = new flash.text.TextFormat()).leading = -2;
                this.tankInfoTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.tankInfoTF.htmlText = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 12, "$FieldFont");
                this.tankInfoTF.setTextFormat(loc7);
                this.tankInfoTF.width = this.tankInfoTF.textWidth + 5;
                this.tankInfoTF.y = this.vehicleIco.y + 1;
                this.tankInfoTF.x = this.vehicleIco.x;
                this.vehicleIco.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIcoLoaded);
                this.vehicleIco.source = this.dataVO.vehicleContour;
                topPosition = topPosition + this.whiteBg.height;
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            }
            if (this.dataVO.params) 
            {
                (loc8 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).startYPos = topPosition;
                loc8.header = loc5.makeString(TOOLTIPS.HANGAR_CREW_SPECIALTY_SKILLS);
                loc8.contener = content;
                loc8.childrenNamePrefix = "params";
                loc8.leftText = "";
                loc8.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
                loc8.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
                loc8.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
                loc8.rightTextCSS = new flash.text.StyleSheet();
                loc8.rightTextCSS.setStyle("h1", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc8.rightTextCSS.setStyle("h2", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc8.rightTextCSS.setStyle("p", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc3 = this.dataVO.params.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc9 = this.dataVO.params[loc4][2] ? net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER : net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT;
                    loc8.leftText = loc8.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(this.dataVO.params[loc4][1], loc9, 12, "$TextFont") + "<br/>");
                    loc10 = "";
                    if (loc4 != 0) 
                        loc10 = "<h1>" + loc5.makeString(this.dataVO.params[loc4][0]) + "</h1>";
                    else if (this.dataVO.vehicleName == this.dataVO.currentVehicleName || this.dataVO.currentVehicleName == "") 
                        loc10 = "<h1>" + loc5.makeString(this.dataVO.params[loc4][0]) + " " + this.dataVO.vehicleName + "</h1>";
                    else 
                        loc10 = "<h1>" + loc5.makeString(this.dataVO.params[loc4][0]) + " <p>" + this.dataVO.vehicleName + "</p></h1>";
                    loc8.rightTextList[loc4] = new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(loc10);
                    ++loc4;
                }
                loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc8, contentMargin.left + bgShadowMargin.left);
                blockResults.push(loc2);
                topPosition = loc2.startYPos;
                hasIcon = loc2.hasIcons ? true : hasIcon;
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc2.leftPartMaxW > leftPartMaxW ? loc2.leftPartMaxW : leftPartMaxW;
            }
            if (this.dataVO.newSkillsCount > 0) 
            {
                loc11 = loc5.makeString(TOOLTIPS.HANGAR_CREW_NEW_SKILL_AVAILABLE_HEADER);
                loc12 = loc5.makeString(TOOLTIPS.HANGAR_CREW_NEW_SKILL_AVAILABLE_TEXT);
                loc13 = net.wg.gui.components.tooltips.helpers.Utils.instance.getStatusColor(net.wg.gui.components.tooltips.helpers.Utils.instance.STATUS_ADDITIONAL);
                this.tooltipStatusNewSkill.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
                this.tooltipStatusNewSkill.setData(loc11, loc12, loc13, net.wg.gui.components.tooltips.Status.ICO_NEWSKILL);
                this.tooltipStatusNewSkill.x = contentMargin.left + bgShadowMargin.left;
                this.tooltipStatusNewSkill.y = topPosition;
                topPosition = topPosition + (this.tooltipStatusNewSkill.actualHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            }
            else 
            {
                this.tooltipStatusNewSkill.y = 0;
                this.tooltipStatusNewSkill.width = 10;
                this.tooltipStatusNewSkill.visible = false;
            }
            if (this.dataVO.status) 
            {
                loc14 = net.wg.gui.components.tooltips.helpers.Utils.instance.getStatusColor(this.dataVO.statusLevel);
                this.tooltipStatus.y = topPosition;
                this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
                this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
                this.tooltipStatus.setData(this.dataVO.statusHeader, this.dataVO.statusText, loc14);
                topPosition = topPosition + this.tooltipStatus.height;
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK;
            }
            else 
            {
                this.tooltipStatus.visible = false;
                this.tooltipStatus.y = 0;
            }
            loc1 = seaprators.pop();
            content.removeChild(loc1);
            loc1 = null;
            this.dataVO = null;
            updatePositions();
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            this.whiteBg.width = content.width + bgShadowMargin.horizontal;
            return;
        }

        internal function getSign(arg1:Number):String
        {
            return arg1 >= 0 ? "+" : "";
        }

        internal function onIcoLoaded(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            if (this.vehicleIco.hasEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE)) 
                this.vehicleIco.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIcoLoaded);
            this.vehicleIco.scaleX = -1;
            this.vehicleIco.x = contentMargin.left + bgShadowMargin.left + this.vehicleIco.width;
            this.tankInfoTF.x = this.vehicleIco.x + 5;
            return;
        }

        public var headerTF:flash.text.TextField=null;

        public var tooltipStatus:net.wg.gui.components.tooltips.Status=null;

        public var tooltipStatusNewSkill:net.wg.gui.components.tooltips.Status=null;

        public var tankInfoHeaderTF:flash.text.TextField=null;

        public var tankInfoTF:flash.text.TextField=null;

        public var vehicleIco:net.wg.gui.components.controls.UILoaderAlt=null;

        public var whiteBg:flash.display.Sprite=null;

        internal var dataVO:net.wg.gui.components.tooltips.VO.TankmenVO=null;
    }
}
