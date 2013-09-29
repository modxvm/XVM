package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.utils.*;
    
    public class ToolTipEquipment extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipEquipment()
        {
            super();
            this.headerTF = content.headerTF;
            this.discrTF = content.discrTF;
            this.whiteBg = content.whiteBg;
            this.tooltipStatus = content.tooltipStatus;
            this.complexStatus = content.complexStatus;
            this.complexHeader = content.complexStatus.complexHeader;
            this.complexNote = content.complexStatus.complexNote;
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
            return "[WG ToolTipEquipment " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function redraw():void
        {
            var loc3:*=null;
            var loc5:*=null;
            var loc7:*=null;
            var loc10:*=NaN;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=null;
            var loc21:*=null;
            var loc22:*=null;
            var loc23:*=null;
            var loc24:*=null;
            var loc25:*=null;
            var loc26:*=null;
            var loc27:*=null;
            var loc28:*=null;
            var loc29:*=NaN;
            var loc30:*=false;
            var loc31:*=null;
            var loc32:*=null;
            var loc33:*=null;
            var loc34:*=null;
            var loc35:*=NaN;
            var loc36:*=null;
            var loc37:*=null;
            var loc1:*=0;
            var loc2:*=0;
            loc3 = new net.wg.gui.components.tooltips.VO.EquipmentVO(_data);
            var loc4:*=null;
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            loc5 = null;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            this._defContentMarginBottom = contentMargin.bottom;
            this._defBGShadowMarginBottom = bgShadowMargin.bottom;
            topPosition = bgShadowMargin.top + contentMargin.top;
            var loc6:*="";
            loc7 = App.utils.locale;
            var loc38:*=_type;
            switch (loc38) 
            {
                case this.TYPE_SHELL:
                {
                    loc17 = (loc17 = loc7.makeString(ITEM_TYPES.shell_kinds(loc3.type))).slice(0, 1).toUpperCase() + loc17.slice(1);
                    loc6 = loc6 + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc17, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$TextFont") + "<br/>");
                    break;
                }
                case this.TYPE_MODULE:
                {
                    if (loc3.level > 0) 
                    {
                        loc6 = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc7.makeString(TOOLTIPS.level(loc3.level.toString())) + " " + loc7.makeString(TOOLTIPS.VEHICLE_LEVEL), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$TextFont") + "<br/>";
                    }
                    break;
                }
            }
            var loc8:*=net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc3.eName, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_HEADER, 18, "$TitleFont");
            var loc9:*;
            (loc9 = new flash.text.TextFormat()).leading = 0;
            loc9.align = flash.text.TextFormatAlign.LEFT;
            this.headerTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.headerTF.multiline = true;
            this.headerTF.wordWrap = true;
            this.headerTF.htmlText = loc6 != "" ? loc8 + "<br/>" + loc6 : loc8;
            this.headerTF.setTextFormat(loc9);
            this.headerTF.width = this.headerTF.textWidth + 5;
            loc10 = bgShadowMargin.left + contentMargin.left;
            this.headerTF.x = loc10;
            this.headerTF.y = topPosition | 0;
            topPosition = topPosition + (this.headerTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE);
            this.maxWidth = Math.max(this.maxWidth, this.headerTF.width);
            if (loc3.extraModuleInfo) 
            {
                (loc18 = new flash.text.TextFormat()).leading = 2;
                loc18.align = flash.text.TextFormatAlign.RIGHT;
                loc18.size = 11;
                loc18.font = "$TextFont";
                (loc19 = new flash.text.StyleSheet()).setStyle("h", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc19.setStyle("p", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_SUB_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                (loc20 = new net.wg.gui.components.tooltips.ExtraModuleInfo(loc18, loc19)).y = topPosition;
                loc20.x = loc10;
                loc20.setData(loc3.extraModuleInfo.source, net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc3.extraModuleInfo.text, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 13, "$TitleFont"));
                addChild(loc20);
                this.maxWidth = Math.max(this.maxWidth, loc20.width);
                topPosition = topPosition + (Math.round(loc20.height) + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE);
            }
            (loc4 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
            seaprators.push(loc4);
            topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
            var loc11:*=" " + loc7.makeString(TOOLTIPS.MODULE_COUNT);
            var loc12:*;
            (loc12 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).contener = content;
            loc12.childrenNamePrefix = "stats";
            loc12.leftText = "";
            loc12.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
            loc12.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
            loc12.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
            var loc13:*;
            (loc13 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).contener = content;
            loc13.childrenNamePrefix = "price";
            loc13.leftText = "";
            loc13.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
            loc13.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
            loc13.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
            if (loc3.stats) 
            {
                loc21 = loc7.makeString(TOOLTIPS.ITEMSTATUS_NOTENOUGH);
                loc2 = loc3.stats.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    loc22 = loc3.stats[loc1][0];
                    loc23 = isNaN(loc3.stats[loc1][1]) ? loc3.stats[loc1][1] : loc7.integer(loc3.stats[loc1][1]);
                    loc24 = loc3.stats[loc1][2] ? String(loc3.stats[loc1][2]) : null;
                    loc25 = net.wg.gui.components.tooltips.helpers.Utils.instance.getIcont(loc22, _component, loc3.gold);
                    loc26 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER;
                    loc27 = "";
                    loc28 = "";
                    loc29 = 0;
                    if (_component == "shop" || _component == "hangar" || _component == "inventory") 
                    {
                        if (loc24) 
                        {
                            loc38 = loc22;
                            switch (loc38) 
                            {
                                case "buy_price_action":
                                case "buy_price":
                                {
                                    if (loc25 != "gold") 
                                    {
                                        loc28 = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/CreditsIcon-2.png\" />";
                                    }
                                    else 
                                    {
                                        loc28 = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/GoldIcon-2.png\" />";
                                    }
                                    break;
                                }
                                case "unlock_price":
                                {
                                    loc28 = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/UnlockPrice.png\" />";
                                    break;
                                }
                            }
                            loc26 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT;
                            loc27 = " ( <font color=\"" + net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT + "\">" + loc21 + "</font> " + loc7.integer(loc24) + loc28 + ")";
                            loc29 = -1;
                        }
                        else 
                        {
                            loc27 = "";
                        }
                        if (loc30 = loc22 == "textDelimiter/or") 
                        {
                            loc13.leftText = loc13.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc7.makeString(TOOLTIPS.vehicle(loc22)), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 10, "$TextFont") + "<br/>");
                            loc13.rightTextList.push(new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO());
                        }
                        else 
                        {
                            loc13.leftText = loc13.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc23, loc26, 12, "$TitleFont") + "<br/>");
                            loc31 = "<h1>" + loc7.makeString(TOOLTIPS.vehicle(loc22)) + loc27 + "</h1>";
                            loc13.rightTextList.push(new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(loc31, loc25, loc29));
                        }
                    }
                    else 
                    {
                        loc12.leftText = loc12.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc23 + loc11, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 12, "$TextFont") + "<br/>");
                        loc12.rightTextList.push(new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(loc22)));
                    }
                    ++loc1;
                }
            }
            if (loc3.paramsAdd && _type == "shell") 
            {
                loc2 = loc3.paramsAdd.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    loc32 = loc3.paramsAdd[loc1].label;
                    loc33 = loc3.paramsAdd[loc1].current;
                    loc34 = loc3.paramsAdd[loc1].total;
                    loc12.leftText = loc12.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc33 + "/" + loc34, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER, 12, "$TitleFont") + "<br/>");
                    loc12.rightTextList.push(new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(loc32)));
                    ++loc1;
                }
            }
            if (loc13.rightTextList.length > 0) 
            {
                loc13.startYPos = topPosition;
                loc13.rightTextCSS = new flash.text.StyleSheet();
                loc13.rightTextCSS.setStyle("h1", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc13.rightTextCSS.setStyle("p", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
                loc5 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc13, contentMargin.left + bgShadowMargin.left);
                this.maxWidth = Math.max(this.maxWidth, loc5.blockWidth);
                blockResults.push(loc5);
                topPosition = loc5.startYPos;
                hasIcon = loc5.hasIcons ? true : hasIcon;
                (loc4 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
                seaprators.push(loc4);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc5.leftPartMaxW > leftPartMaxW ? loc5.leftPartMaxW : leftPartMaxW;
            }
            var loc14:*=false;
            var loc15:*="";
            var loc16:*=0;
            if (!(loc3.effectOnUse == "") || !(loc3.effectAlways == "")) 
            {
                loc14 = true;
                loc15 = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc7.makeString(TOOLTIPS.EQUIPMENT_EFFECT), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_BLOCK_HEADER, 14, "$TitleFont", true);
                loc35 = 23;
                loc16 = -1;
                if (loc3.effectOnUse != "") 
                {
                    loc15 = loc15 + this.getEquipmentUsageBlock(loc7.makeString(TOOLTIPS.EQUIPMENT_ONUSE), loc7.makeString(loc3.effectOnUse), loc35);
                    loc35 + 18;
                }
                if (loc3.effectAlways != "") 
                {
                    loc15 = loc15 + this.getEquipmentUsageBlock(loc7.makeString(TOOLTIPS.EQUIPMENT_ALWAYS), loc7.makeString(loc3.effectAlways), loc35);
                    loc35 + 18;
                }
                if (loc3.effectRestriction != "") 
                {
                    loc15 = (loc15 = loc15 + ("<br/>" + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc7.makeString(TOOLTIPS.EQUIPMENT_RESTRICTION), net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_BLOCK_HEADER, 14, "$TitleFont", true) + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(" ", net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 24, "$TextFont"))) + this.getEquipmentUsageBlock("", loc7.makeString(loc3.effectRestriction), loc35);
                    loc35 + 18;
                }
            }
            else if (loc3.descr) 
            {
                loc14 = true;
                loc15 = net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc3.descr, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 11, "$TextFont");
            }
            if (loc14) 
            {
                (loc36 = new flash.text.TextFormat()).leading = loc16;
                topPosition = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.whiteBg.y = topPosition | 0;
                this.whiteBg.x = bgShadowMargin.left + 1;
                this.whiteBg.width = 10;
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.discrTF.wordWrap = true;
                this.discrTF.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.discrTF.htmlText = loc15;
                this.discrTF.setTextFormat(loc36);
                this.discrTF.width = this.discrTF.textWidth + 5;
                this.discrTF.y = topPosition | 0;
                this.discrTF.x = loc10;
                topPosition = topPosition + (this.discrTF.textHeight + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                this.whiteBg.height = (topPosition - this.whiteBg.y - 1) | 0;
                (loc4 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = this.whiteBg.y + this.whiteBg.height;
                seaprators.push(loc4);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                contentMargin.bottom = 2;
            }
            else 
            {
                this.whiteBg.visible = false;
                this.discrTF.width = 10;
                this.discrTF.visible = false;
            }
            if (loc3.params) 
            {
                loc5 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(this.formParamsBlockData(loc3.params, loc7.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY), loc3.tooHeavy), contentMargin.left + bgShadowMargin.left);
                this.maxWidth = Math.max(this.maxWidth, loc5.blockWidth);
                blockResults.push(loc5);
                topPosition = loc5.startYPos;
                hasIcon = loc5.hasIcons ? true : hasIcon;
                (loc4 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
                seaprators.push(loc4);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc5.leftPartMaxW > leftPartMaxW ? loc5.leftPartMaxW : leftPartMaxW;
                contentMargin.bottom = this._defContentMarginBottom;
            }
            if (loc3.paramsEx) 
            {
                loc5 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(this.formParamsBlockData(loc3.paramsEx.params, loc3.paramsEx.headerText, loc3.tooHeavy), contentMargin.left + bgShadowMargin.left);
                this.maxWidth = Math.max(this.maxWidth, loc5.blockWidth);
                blockResults.push(loc5);
                topPosition = loc5.startYPos;
                hasIcon = loc5.hasIcons ? true : hasIcon;
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc5.leftPartMaxW > leftPartMaxW ? loc5.leftPartMaxW : leftPartMaxW;
                contentMargin.bottom = this._defContentMarginBottom;
            }
            if (loc12.rightTextList.length > 0) 
            {
                loc12.startYPos = topPosition;
                loc5 = net.wg.gui.components.tooltips.helpers.Utils.instance.createBlock(loc12, contentMargin.left + bgShadowMargin.left);
                this.maxWidth = Math.max(this.maxWidth, loc5.blockWidth);
                blockResults.push(loc5);
                topPosition = loc5.startYPos;
                hasIcon = loc5.hasIcons ? true : hasIcon;
                (loc4 = net.wg.gui.components.tooltips.helpers.Utils.instance.createSeparate(content)).y = topPosition | 0;
                seaprators.push(loc4);
                topPosition = topPosition + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                leftPartMaxW = loc5.leftPartMaxW > leftPartMaxW ? loc5.leftPartMaxW : leftPartMaxW;
                contentMargin.bottom = this._defContentMarginBottom;
            }
            if (loc3.complex) 
            {
                loc4 = seaprators.pop();
                content.removeChild(loc4);
                loc4 = null;
                topPosition = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                this.complexStatus.x = bgShadowMargin.left + 1;
                this.complexStatus.y = topPosition | 0;
                this.complexHeader.htmlText = loc3.complexHeader;
                this.complexNote.htmlText = loc3.complexNote;
                topPosition = topPosition + (this.complexStatus.height + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_BLOCK);
                contentMargin.bottom = 2;
                this.maxWidth = Math.max(this.maxWidth, this.complexStatus.width - contentMargin.horizontal);
            }
            else 
            {
                this.complexStatus.y = 0;
                this.complexStatus.width = 10;
                this.complexStatus.visible = false;
            }
            if (seaprators.length > 1 && !loc3.status || seaprators.length > 0 && loc3.status) 
            {
                loc4 = seaprators[0];
                this.maxWidth = Math.max(this.maxWidth, loc4.width);
            }
            this.updateContentWidth();
            if (loc3.status) 
            {
                loc37 = net.wg.gui.components.tooltips.helpers.Utils.instance.getStatusColor(loc3.statusLevel);
                this.tooltipStatus.y = topPosition | 0;
                this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
                this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
                this.tooltipStatus.setData(loc3.statusHeader, loc3.statusText, loc37);
                topPosition = topPosition + this.tooltipStatus.height;
                contentMargin.bottom = this._defContentMarginBottom;
            }
            else 
            {
                this.tooltipStatus.y = 0;
                this.tooltipStatus.width = 10;
                this.tooltipStatus.visible = false;
                if (!loc3.complex) 
                {
                    loc4 = seaprators.pop();
                    content.removeChild(loc4);
                    loc4 = null;
                    topPosition = topPosition - net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_AFTER_SEPARATE;
                }
            }
            loc3 = null;
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

        internal function formParamsBlockData(arg1:Array, arg2:String, arg3:Boolean):net.wg.gui.components.tooltips.VO.ToolTipBlockVO
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*;
            (loc1 = new net.wg.gui.components.tooltips.VO.ToolTipBlockVO()).header = arg2;
            loc1.startYPos = topPosition;
            loc1.contener = content;
            loc1.childrenNamePrefix = "params";
            loc1.leftText = "";
            loc1.leftTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER);
            loc1.rightTextList = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO>();
            loc1.rightTextColor = net.wg.gui.components.tooltips.helpers.Utils.instance.convertStringColorToNumber(net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL);
            loc1.rightTextCSS = new flash.text.StyleSheet();
            loc1.rightTextCSS.setStyle("h", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
            loc1.rightTextCSS.setStyle("p", {"color":net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_SUB_NORMAL, "fontSize":"11px", "fontFamily":"$TextFont", "leading":"2px"});
            var loc2:*="";
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = arg1[loc4][0];
                loc6 = arg1[loc4][1];
                if (loc5 == "weight" && arg3) 
                {
                    loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT;
                }
                else 
                {
                    loc2 = net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NUMBER;
                }
                loc1.leftText = loc1.leftText + (net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(loc6, loc2, 12, "$TextFont") + "<br/>");
                loc1.rightTextList[loc4] = new net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(App.utils.locale.makeString(MENU.moduleinfo_params(loc5)));
                ++loc4;
            }
            return loc1;
        }

        internal function getEquipmentUsageBlock(arg1:String, arg2:String, arg3:int=18):String
        {
            arg1 = arg1 != "" ? net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(arg1, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, 13, "$TitleFont", true) + net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(" ", net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ADD_INFO, arg3, "$TextFont") : "";
            arg2 = arg2 != "" ? net.wg.gui.components.tooltips.helpers.Utils.instance.htmlWrapper(arg2, net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_NORMAL, 12, "$FieldFont") : "";
            var loc1:*;
            return loc1 = "<br/>" + arg1 + arg2;
        }

        internal function updateContentWidth():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            if (this.discrTF.visible) 
            {
                loc1 = this.discrTF.height;
                loc2 = this.discrTF.y;
                this.discrTF.width = this.maxWidth;
                loc1 = this.discrTF.textHeight + 5 - loc1 | 0;
                this.whiteBg.height = this.whiteBg.height + loc1;
                loc3 = 0;
                loc4 = 0;
                if (seaprators) 
                {
                    loc4 = seaprators.length;
                    loc3 = 0;
                    while (loc3 < loc4) 
                    {
                        if ((loc5 = seaprators[loc3]).y > loc2) 
                        {
                            loc5.y = loc5.y + loc1;
                        }
                        ++loc3;
                    }
                }
                if (blockResults) 
                {
                    loc4 = blockResults.length;
                    loc3 = 0;
                    while (loc3 < loc4) 
                    {
                        if ((loc6 = net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO(blockResults[loc3])).leftTextField.y > loc2) 
                        {
                            if (loc6.headerTextField) 
                            {
                                loc6.headerTextField.y = loc6.headerTextField.y + loc1;
                            }
                            loc6.leftTextField.y = loc6.leftTextField.y + loc1;
                            loc7 = loc6.elRightList.length;
                            loc8 = 0;
                            while (loc8 < loc7) 
                            {
                                loc6.elRightList[loc8].y = loc6.elRightList[loc8].y + loc1;
                                ++loc8;
                            }
                        }
                        ++loc3;
                    }
                }
                if (this.complexStatus.visible) 
                {
                    this.complexStatus.y = this.complexStatus.y + loc1;
                }
                topPosition = topPosition + loc1;
            }
            return;
        }

        internal const TYPE_SHELL:String="shell";

        internal const TYPE_MODULE:String="module";

        public var headerTF:flash.text.TextField=null;

        public var discrTF:flash.text.TextField=null;

        public var whiteBg:flash.display.Sprite=null;

        public var tooltipStatus:net.wg.gui.components.tooltips.Status=null;

        public var complexStatus:flash.display.Sprite=null;

        public var complexHeader:flash.text.TextField=null;

        public var complexNote:flash.text.TextField=null;

        internal var _defContentMarginBottom:Number=0;

        internal var _defBGShadowMarginBottom:Number=0;

        internal var maxWidth:Number=250;
    }
}
