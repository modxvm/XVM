package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.utils.*;
    
    public class ToolTipVehicle extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipVehicle()
        {
            super();
            this.favoriteTextField = this.vehicleFavorite.textFied;
            this.headerTF = content.headerTF;
            this.tankTypeIco = content.tankTypeIco;
            this.eliteGlow = content.eliteGlow;
            this.vehicleLock = content.vehicleLock;
            this.tooltipStatus = content.tooltipStatus;
            this.vehicleLockText = this.vehicleLock.textField;
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
            return;
        }

        public override function toString():String
        {
            return "[WG ToolTipVehicle " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function redraw():void
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=NaN;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=NaN;
            var loc21:*=null;
            var loc22:*=null;
            var loc23:*=null;
            var loc24:*=null;
            var loc25:*=null;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=null;
            var loc29:*=null;
            var loc30:*=null;
            var loc31:*=null;
            var loc1:*=null;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            loc2 = null;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            var loc3:*=0;
            var loc4:*=0;
            loc5 = new net.wg.gui.components.tooltips.VO.VehicleVO(_data);
            this.vehicleFavorite.visible = loc5.isFavorite;
            this.eliteGlow.gotoAndStop(loc5.isElite ? "elite" : "normal");
            this.tankTypeIco.type = loc5.isElite ? loc5.vType + "_elite" : loc5.vType;
            loc6 = App.utils.locale;
            var loc7:*="";
            if (loc5.isElite) 
                loc7 = loc6.makeString(TOOLTIPS.tankcaruseltooltip_vehicletype_elite(loc5.vType));
            else 
                loc7 = (loc7 = loc6.makeString(MENU.tankmen(_data.type))).slice(0, 1).toUpperCase() + loc7.slice(1, loc7.length);
            var loc8:*=loc6.makeString(TOOLTIPS.level(_data.level));
            var loc9:*=loc6.makeString(TOOLTIPS.VEHICLE_LEVEL);
            var loc10:*;
            (loc10 = new flash.text.TextFormat()).leading = -1;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = "<font face=\"$TitleFont\" color=\"" + net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER + "\" size=\"18\">" + loc5.vName + "</font><br/><font  face=\"$FieldFont\" color=\"#998f7c\" size=\"14\">" + loc7 + "</font><br><font face=\"$TextFont\" color=\"" + net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER + "\" size=\"12\">" + loc8 + "</font> <font face=\"$TextFont\" color=\"" + net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL + "\" size=\"11\">" + loc9 + "</font><font face=\"$TextFont\" size=\"19\">&nbsp;</font>";
            this.headerTF.setTextFormat(loc10);
            this.headerTF.width = this.headerTF.textWidth + 5;
            topPosition = this.vehicleFavorite.y + this.vehicleFavorite.height;
            loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
            loc1.y = topPosition;
            seaprators.push(loc1);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            if (loc5.stats) 
            {
                (loc11 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).startYPos = topPosition;
                loc11.contener = content;
                loc11.childrenNamePrefix = "vehicle";
                loc11.leftText = "";
                loc11.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
                loc11.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
                loc11.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
                loc11.rightTextCSS = new flash.text.StyleSheet();
                loc11.rightTextCSS.setStyle("h1", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc11.rightTextCSS.setStyle("p", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc12 = "";
                loc13 = loc6 ? loc6.makeString(TOOLTIPS.ITEMSTATUS_NOTENOUGH, {}) : TOOLTIPS.ITEMSTATUS_NOTENOUGH;
                loc14 = "";
                loc3 = loc5.stats.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc15 = loc5.stats[loc4][0];
                    loc16 = Number(loc5.stats[loc4][1]);
                    if (loc15 != this.DAILY_XP_FACTOR) 
                        loc14 = net.wg.gui.components.tooltips.helpers.Utils.instance.getIcont(loc15, _component, loc5.isPremium, loc5.isElite);
                    else if (loc16 > 2) 
                        loc14 = net.wg.gui.components.tooltips.helpers.Utils.instance.getIcont(this.ACTION_XP_FACTOR);
                    else if (loc16 != 2) 
                        loc14 = net.wg.gui.components.tooltips.helpers.Utils.instance.getIcont("");
                    else 
                        loc14 = net.wg.gui.components.tooltips.helpers.Utils.instance.getIcont(this.DOUBLE_XP_FACTOR);
                    loc17 = "";
                    if (loc15 == this.BUY_PRICE || loc15 == this.SELL_PRICE) 
                        if (loc6) 
                            loc17 = loc6 ? loc14 != "gold" ? loc6.integer(loc16) : loc6.gold(loc16) : loc16.toString();
                    else 
                        loc17 = loc6 ? loc6.integer(loc16) : loc16.toString();
                    loc17 = loc15 != this.DAILY_XP_FACTOR ? loc17 : "x" + loc17;
                    loc18 = loc5.stats[loc4][2] ? loc6 ? loc14 != "gold" ? loc6.integer(Number(loc5.stats[loc4][2])) : loc6.gold(Number(loc5.stats[loc4][2])) : loc5.stats[loc4][2] : "";
                    loc19 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER;
                    loc20 = 0;
                    if (_component == COMPONENT_SHOP) 
                    {
                        loc22 = "";
                        if (loc15 == this.BUY_PRICE) 
                            if (loc18 == "") 
                                loc12 = "";
                            else 
                            {
                                loc19 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT;
                                if (loc14 != "gold") 
                                    loc22 = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/CreditsIcon-2.png\" />";
                                else 
                                    loc22 = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/GoldIcon-2.png\" />";
                                loc12 = " ( <font color=\"#8c0000\">" + loc13 + "</font> " + loc18 + loc22 + ")";
                                loc20 = -1;
                            }
                        if (loc15 == this.UNLOCK_PRICE) 
                            if (loc18 == "") 
                                loc12 = "";
                            else 
                            {
                                loc19 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT;
                                loc22 = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/UnlockPrice.png\" />";
                                loc12 = " ( <font color=\"#8c0000\">" + loc13 + "</font> " + loc18 + loc22 + ")";
                                loc20 = -1;
                            }
                    }
                    loc11.leftText = loc11.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc17, loc19, 12, "$TextFont", false) + "<br/>");
                    loc21 = loc6 ? loc6.makeString(TOOLTIPS.vehicle(loc15), {}) : TOOLTIPS.vehicle(loc15);
                    loc11.rightTextList[loc4] = new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO("<h1>" + loc21 + loc12 + "</h1>", loc14, loc20);
                    ++loc4;
                }
                loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc11, contentMargin.left + bgShadowMargin.left);
                blockResults.push(loc2);
                topPosition = loc2.startYPos;
                hasIcon = loc2.hasIcons ? true : hasIcon;
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc2.leftPartMaxW > leftPartMaxW ? loc2.leftPartMaxW : leftPartMaxW;
            }
            if (loc5.characteristics && loc5.characteristics.length > 0) 
            {
                (loc23 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).header = loc6 ? loc6.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY) : TOOLTIPS.TANKCARUSEL_MAINPROPERTY;
                loc23.leftText = "";
                loc23.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
                loc23.contener = content;
                loc23.startYPos = topPosition;
                loc23.childrenNamePrefix = "characteristics";
                loc23.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
                loc23.rightTextCSS = new flash.text.StyleSheet();
                loc23.rightTextCSS.setStyle("h1", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc23.rightTextCSS.setStyle("p", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_SUB_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc3 = loc5.characteristics.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc23.leftText = loc23.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc5.characteristics[loc4][1], net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 12, "$TextFont", false) + "<br/>");
                    loc24 = loc6 ? loc6.makeString(MENU.tank_params(loc5.characteristics[loc4][0]), {}) : MENU.tank_params(loc5.characteristics[loc4][0]);
                    loc23.rightTextList[loc4] = new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(loc24);
                    ++loc4;
                }
                loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc23, contentMargin.left + bgShadowMargin.left);
                blockResults.push(loc2);
                topPosition = loc2.startYPos;
                hasIcon = loc2.hasIcons ? true : hasIcon;
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc2.leftPartMaxW > leftPartMaxW ? loc2.leftPartMaxW : leftPartMaxW;
            }
            if (loc5.equipments && loc5.equipments.length > 0) 
            {
                (loc25 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).leftText = "";
                loc25.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
                loc25.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
                loc25.contener = content;
                loc25.startYPos = topPosition;
                loc25.childrenNamePrefix = "equipments";
                loc25.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
                loc3 = loc5.equipments.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc26 = loc5.equipments[loc4].current;
                    loc27 = loc5.equipments[loc4].total;
                    loc28 = loc5.equipments[loc4].label;
                    if (loc26 < loc27 && loc28 == "crew" && (_component == COMPONENT_CAROUSEL || _component == COMPONENT_INVENTORY)) 
                        loc25.leftText = loc25.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc26.toString(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT) + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper("/" + loc27.toString(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER) + "<br/>");
                    else if (loc28 == "crew" && _component == COMPONENT_SHOP) 
                        loc25.leftText = loc25.leftText + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc27.toString(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
                    else 
                        loc25.leftText = loc25.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc26.toString(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER) + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper("/" + loc27.toString(), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER) + "<br/>");
                    loc25.rightTextList[loc4] = new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(loc28));
                    ++loc4;
                }
                loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc25, contentMargin.left + bgShadowMargin.left);
                blockResults.push(loc2);
                topPosition = loc2.startYPos;
                hasIcon = loc2.hasIcons ? true : hasIcon;
                loc1 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content);
                loc1.y = topPosition;
                seaprators.push(loc1);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc2.leftPartMaxW > leftPartMaxW ? loc2.leftPartMaxW : leftPartMaxW;
            }
            if (loc5.clanLock) 
            {
                loc29 = "";
                topPosition = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                loc29 = (loc29 = (loc29 = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6.makeString(TOOLTIPS.TANKCARUSEL_LOCK_HEADER).toUpperCase(), "#ffffff", 14, "$TitleFont") + "<br/>") + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6.makeString(TOOLTIPS.TANKCARUSEL_LOCK_TO).toLowerCase() + " " + loc5.clanLockTimeStr, "#c2c2c2", 13, "$FieldFont") + "<font face=\"$FieldFont\" size=\"15\">&nbsp;</font><br/><font face=\"$TextFont\" size=\"7\">&nbsp;</font><br/>")) + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6.makeString(TOOLTIPS.tankcarusel_lock(loc5.clanLockType)), this.LOCK_MSG_COLOR, 11, "$TextFont");
                (loc30 = new flash.text.TextFormat()).leading = -4;
                this.vehicleLockText.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.vehicleLockText.htmlText = loc29;
                this.vehicleLockText.setTextFormat(loc30);
                this.vehicleLockText.width = this.vehicleLockText.textWidth + 5;
                this.vehicleLock.alpha = 1;
                this.vehicleLock.visible = true;
                this.vehicleLock.y = topPosition;
                this.vehicleLock.x = bgShadowMargin.left;
                topPosition = topPosition + this.vehicleLock.height;
                loc1.y = topPosition;
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            }
            else 
            {
                this.vehicleLock.width = 1;
                this.vehicleLock.visible = false;
            }
            if (loc5.status) 
            {
                loc31 = net.wg.gui.components.tooltips.helpers.Utils.instance.getStatusColor(loc5.statusLevel);
                this.tooltipStatus.y = topPosition;
                this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
                this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
                this.tooltipStatus.setData(loc5.statusHeader, loc5.statusText, loc31);
                topPosition = topPosition + this.tooltipStatus.height;
            }
            else 
            {
                this.tooltipStatus.visible = false;
                this.tooltipStatus.y = 0;
                if (loc5.clanLock) 
                    contentMargin.bottom = 2;
                loc1 = seaprators.pop();
                content.removeChild(loc1);
                loc1 = null;
            }
            loc5 = null;
            updatePositions();
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            this.vehicleFavorite.x = background.width - bgShadowMargin.right;
            return;
        }

        internal const DAILY_XP_FACTOR:String="dailyXPFactor";

        internal const ACTION_XP_FACTOR:String="actionXPFactor";

        internal const DOUBLE_XP_FACTOR:String="doubleXPFactor";

        internal const BUY_PRICE:String="buy_price";

        internal const SELL_PRICE:String="sell_price";

        internal const UNLOCK_PRICE:String="unlock_price";

        internal const LOCK_MSG_COLOR:String="#ff1515";

        public var vehicleFavorite:flash.display.MovieClip=null;

        public var favoriteTextField:flash.text.TextField=null;

        public var headerTF:flash.text.TextField=null;

        public var tankTypeIco:net.wg.gui.components.tooltips.helpers.TankTypeIco=null;

        public var eliteGlow:flash.display.MovieClip=null;

        public var vehicleLock:flash.display.MovieClip=null;

        public var vehicleLockText:flash.text.TextField=null;

        public var tooltipStatus:net.wg.gui.components.tooltips.Status=null;
    }
}
