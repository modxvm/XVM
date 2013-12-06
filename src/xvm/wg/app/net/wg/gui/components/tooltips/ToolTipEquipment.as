package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.EquipmentVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.utils.ILocale;
   import flash.text.TextFormat;
   import flash.text.StyleSheet;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;


   public class ToolTipEquipment extends ToolTipSpecial
   {
          
      public function ToolTipEquipment() {
         this.skipFields = [this.DEF_BUY_PRICE,this.DEF_SELL_PRICE,this.ACTION_PRC];
         super();
         this.headerTF = content.headerTF;
         this.discrTF = content.discrTF;
         this.whiteBg = content.whiteBg;
         this.tooltipStatus = content.tooltipStatus;
         this.complexStatus = content.complexStatus;
         this.complexHeader = content.complexStatus.complexHeader;
         this.complexNote = content.complexStatus.complexNote;
      }

      public var headerTF:TextField = null;

      public var discrTF:TextField = null;

      public var whiteBg:Sprite = null;

      public var tooltipStatus:Status = null;

      public var complexStatus:Sprite = null;

      public var complexHeader:TextField = null;

      public var complexNote:TextField = null;

      private var _defContentMarginBottom:Number = 0;

      private var _defBGShadowMarginBottom:Number = 0;

      private var maxWidth:Number = 250;

      private const TYPE_SHELL:String = "shell";

      private const TYPE_MODULE:String = "module";

      private const DEF_BUY_PRICE:String = "def_buy_price";

      private const DEF_SELL_PRICE:String = "def_sell_price";

      private const ACTION_PRC:String = "action_prc";

      private var skipFields:Array;

      override public function build(param1:Object, param2:ITooltipProps) : void {
         super.build(param1,param2);
      }

      override public function dispose() : void {
         super.dispose();
      }

      override public function toString() : String {
         return "[WG ToolTipEquipment " + name + "]";
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function redraw() : void {
         var _loc3_:EquipmentVO = null;
         var _loc5_:ToolTipBlockResultVO = null;
         var _loc7_:ILocale = null;
         var _loc17_:String = null;
         var _loc18_:TextFormat = null;
         var _loc19_:StyleSheet = null;
         var _loc20_:ExtraModuleInfo = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:* = NaN;
         var _loc30_:* = false;
         var _loc31_:String = null;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc35_:* = NaN;
         var _loc36_:TextFormat = null;
         var _loc37_:ToolTipStatusColorsVO = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc3_ = new EquipmentVO(_data);
         var _loc4_:Separator = null;
         separators = new Vector.<Separator>();
         _loc5_ = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         this._defContentMarginBottom = contentMargin.bottom;
         this._defBGShadowMarginBottom = bgShadowMargin.bottom;
         topPosition = bgShadowMargin.top + contentMargin.top;
         var _loc6_:* = "";
         _loc7_ = App.utils.locale;
         switch(_type)
         {
            case this.TYPE_SHELL:
               _loc17_ = _loc7_.makeString(ITEM_TYPES.shell_kinds(_loc3_.type));
               _loc17_ = _loc17_.slice(0,1).toUpperCase() + _loc17_.slice(1);
               _loc6_ = _loc6_ + (Utils.instance.htmlWrapper(_loc17_,Utils.instance.COLOR_NORMAL,12,"$TextFont") + "<br/>");
               break;
            case this.TYPE_MODULE:
               if(_loc3_.level > 0)
               {
                  _loc6_ = Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.level(_loc3_.level.toString())) + " " + _loc7_.makeString(TOOLTIPS.VEHICLE_LEVEL),Utils.instance.COLOR_NORMAL,12,"$TextFont") + "<br/>";
               }
               break;
         }
         var _loc8_:String = Utils.instance.htmlWrapper(_loc3_.eName,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         var _loc9_:TextFormat = new TextFormat();
         _loc9_.leading = 0;
         _loc9_.align = TextFormatAlign.LEFT;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.multiline = true;
         this.headerTF.wordWrap = true;
         this.headerTF.htmlText = _loc6_ == ""?_loc8_:_loc8_ + "<br/>" + _loc6_;
         this.headerTF.setTextFormat(_loc9_);
         this.headerTF.width = this.headerTF.textWidth + 5;
         var _loc10_:Number = bgShadowMargin.left + contentMargin.left;
         this.headerTF.x = _loc10_;
         this.headerTF.y = topPosition | 0;
         topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_SEPARATE);
         this.maxWidth = Math.max(this.maxWidth,this.headerTF.width);
         if(_loc3_.extraModuleInfo)
         {
            _loc18_ = new TextFormat();
            _loc18_.leading = 2;
            _loc18_.align = TextFormatAlign.RIGHT;
            _loc18_.size = 11;
            _loc18_.font = "$TextFont";
            _loc19_ = new StyleSheet();
            _loc19_.setStyle("h",
               {
                  "color":Utils.instance.COLOR_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc19_.setStyle("p",
               {
                  "color":Utils.instance.COLOR_SUB_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc20_ = new ExtraModuleInfo(_loc18_,_loc19_);
            _loc20_.y = topPosition;
            _loc20_.x = _loc10_;
            _loc20_.setData(_loc3_.extraModuleInfo.source,Utils.instance.htmlWrapper(_loc3_.extraModuleInfo.text,Utils.instance.COLOR_NUMBER,13,"$TitleFont"));
            addChild(_loc20_);
            this.maxWidth = Math.max(this.maxWidth,_loc20_.width);
            topPosition = topPosition + (Math.round(_loc20_.height) + Utils.instance.MARGIN_AFTER_SEPARATE);
         }
         _loc4_ = Utils.instance.createSeparate(content);
         _loc4_.y = topPosition | 0;
         separators.push(_loc4_);
         topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         var _loc11_:String = " " + _loc7_.makeString(TOOLTIPS.MODULE_COUNT);
         var _loc12_:ToolTipBlockVO = new ToolTipBlockVO();
         _loc12_.contener = content;
         _loc12_.childrenNamePrefix = "stats";
         _loc12_.leftText = "";
         _loc12_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
         _loc12_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
         _loc12_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
         var _loc13_:ToolTipBlockVO = new ToolTipBlockVO();
         _loc13_.contener = content;
         _loc13_.childrenNamePrefix = "price";
         _loc13_.leftText = "";
         _loc13_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
         _loc13_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
         _loc13_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
         if(_loc3_.stats)
         {
            _loc21_ = _loc7_.makeString(TOOLTIPS.ITEMSTATUS_NOTENOUGH);
            _loc2_ = _loc3_.stats.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc22_ = _loc3_.stats[_loc1_][0];
               _loc23_ = isNaN(_loc3_.stats[_loc1_][1])?_loc3_.stats[_loc1_][1]:_loc7_.integer(_loc3_.stats[_loc1_][1]);
               _loc24_ = _loc3_.stats[_loc1_][2]?String(_loc3_.stats[_loc1_][2]):null;
               _loc25_ = Utils.instance.getIcon(_loc22_,_component,_loc3_.gold);
               _loc26_ = Utils.instance.COLOR_NUMBER;
               _loc27_ = "";
               _loc28_ = "";
               _loc29_ = 0;
               if(_component == "shop" || _component == "hangar" || _component == "inventory")
               {
                  if(_loc24_)
                  {
                     switch(_loc22_)
                     {
                        case "buy_price_action":
                        case "buy_price":
                           if(_loc25_ == "gold")
                           {
                              _loc28_ = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/GoldIcon-2.png\" />";
                           }
                           else
                           {
                              _loc28_ = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/CreditsIcon-2.png\" />";
                           }
                           break;
                        case "unlock_price":
                           _loc28_ = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/UnlockPrice.png\" />";
                           break;
                     }
                     _loc26_ = Utils.instance.COLOR_ALERT;
                     _loc27_ = " ( <font color=\"" + Utils.instance.COLOR_ALERT + "\">" + _loc21_ + "</font> " + _loc7_.integer(_loc24_) + _loc28_ + ")";
                     _loc29_ = -1;
                  }
                  else
                  {
                     _loc27_ = "";
                  }
                  _loc30_ = _loc22_ == "textDelimiter/or";
                  if(_loc30_)
                  {
                     _loc13_.leftText = _loc13_.leftText + (Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.vehicle(_loc22_)),Utils.instance.COLOR_NORMAL,10,"$TextFont") + "<br/>");
                     _loc13_.rightTextList.push(new ToolTipBlockRightListItemVO());
                  }
                  else
                  {
                     _loc13_.leftText = _loc13_.leftText + (Utils.instance.htmlWrapper(_loc23_,_loc26_,12,"$TitleFont") + "<br/>");
                     _loc31_ = "<h1>" + _loc7_.makeString(TOOLTIPS.vehicle(_loc22_)) + _loc27_ + "</h1>";
                     _loc13_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc31_,_loc25_,_loc29_));
                  }
               }
               else
               {
                  _loc12_.leftText = _loc12_.leftText + (Utils.instance.htmlWrapper(_loc23_ + _loc11_,Utils.instance.COLOR_NUMBER,12,"$TextFont") + "<br/>");
                  _loc12_.rightTextList.push(new ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(_loc22_)));
               }
               _loc1_++;
            }
         }
         if((_loc3_.paramsAdd) && _type == "shell")
         {
            _loc2_ = _loc3_.paramsAdd.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc32_ = _loc3_.paramsAdd[_loc1_].label;
               _loc33_ = _loc3_.paramsAdd[_loc1_].current;
               _loc34_ = _loc3_.paramsAdd[_loc1_].total;
               _loc12_.leftText = _loc12_.leftText + (Utils.instance.htmlWrapper(_loc33_ + "/" + _loc34_,Utils.instance.COLOR_NUMBER,12,"$TitleFont") + "<br/>");
               _loc12_.rightTextList.push(new ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(_loc32_)));
               _loc1_++;
            }
         }
         if(_loc13_.rightTextList.length > 0)
         {
            _loc13_.startYPos = topPosition;
            _loc13_.rightTextCSS = new StyleSheet();
            _loc13_.rightTextCSS.setStyle("h1",
               {
                  "color":Utils.instance.COLOR_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc13_.rightTextCSS.setStyle("p",
               {
                  "color":Utils.instance.COLOR_ALERT,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc5_ = Utils.instance.createBlock(_loc13_,contentMargin.left + bgShadowMargin.left);
            this.maxWidth = Math.max(this.maxWidth,_loc5_.blockWidth);
            blockResults.push(_loc5_);
            topPosition = _loc5_.startYPos;
            hasIcon = _loc5_.hasIcons?true:hasIcon;
            _loc4_ = Utils.instance.createSeparate(content);
            _loc4_.y = topPosition | 0;
            separators.push(_loc4_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc5_.leftPartMaxW > leftPartMaxW?_loc5_.leftPartMaxW:leftPartMaxW;
         }
         var _loc14_:* = false;
         var _loc15_:* = "";
         var _loc16_:Number = 0;
         if(!(_loc3_.effectOnUse == "") || !(_loc3_.effectAlways == ""))
         {
            _loc14_ = true;
            _loc15_ = Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.EQUIPMENT_EFFECT),Utils.instance.COLOR_BLOCK_HEADER,14,"$TitleFont",true);
            _loc35_ = 23;
            _loc16_ = -1;
            if(_loc3_.effectOnUse != "")
            {
               _loc15_ = _loc15_ + this.getEquipmentUsageBlock(_loc7_.makeString(TOOLTIPS.EQUIPMENT_ONUSE),_loc7_.makeString(_loc3_.effectOnUse),_loc35_);
            }
            if(_loc3_.effectAlways != "")
            {
               _loc15_ = _loc15_ + this.getEquipmentUsageBlock(_loc7_.makeString(TOOLTIPS.EQUIPMENT_ALWAYS),_loc7_.makeString(_loc3_.effectAlways),_loc35_);
            }
            if(_loc3_.effectRestriction != "")
            {
               _loc15_ = _loc15_ + ("<br/>" + Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.EQUIPMENT_RESTRICTION),Utils.instance.COLOR_BLOCK_HEADER,14,"$TitleFont",true) + Utils.instance.htmlWrapper(" ",Utils.instance.COLOR_ADD_INFO,24,"$TextFont"));
               _loc15_ = _loc15_ + this.getEquipmentUsageBlock("",_loc7_.makeString(_loc3_.effectRestriction),_loc35_);
            }
         }
         else
         {
            if(_loc3_.descr)
            {
               _loc14_ = true;
               _loc15_ = Utils.instance.htmlWrapper(_loc3_.descr,Utils.instance.COLOR_NORMAL,11,"$TextFont");
            }
         }
         if(_loc14_)
         {
            _loc36_ = new TextFormat();
            _loc36_.leading = _loc16_;
            topPosition = topPosition - Utils.instance.MARGIN_AFTER_SEPARATE;
            this.whiteBg.y = topPosition | 0;
            this.whiteBg.x = bgShadowMargin.left + 1;
            this.whiteBg.width = 10;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            this.discrTF.wordWrap = true;
            this.discrTF.autoSize = TextFieldAutoSize.LEFT;
            this.discrTF.htmlText = _loc15_;
            this.discrTF.setTextFormat(_loc36_);
            this.discrTF.width = this.discrTF.textWidth + 5;
            this.discrTF.y = topPosition | 0;
            this.discrTF.x = _loc10_;
            topPosition = topPosition + (this.discrTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            this.whiteBg.height = topPosition - this.whiteBg.y-1 | 0;
            _loc4_ = Utils.instance.createSeparate(content);
            _loc4_.y = this.whiteBg.y + this.whiteBg.height;
            separators.push(_loc4_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            contentMargin.bottom = 2;
         }
         else
         {
            this.whiteBg.visible = false;
            this.discrTF.width = 10;
            this.discrTF.visible = false;
         }
         if(_loc3_.params)
         {
            _loc5_ = Utils.instance.createBlock(this.formParamsBlockData(_loc3_.params,_loc7_.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY),_loc3_.tooHeavy),contentMargin.left + bgShadowMargin.left);
            this.maxWidth = Math.max(this.maxWidth,_loc5_.blockWidth);
            blockResults.push(_loc5_);
            topPosition = _loc5_.startYPos;
            hasIcon = _loc5_.hasIcons?true:hasIcon;
            _loc4_ = Utils.instance.createSeparate(content);
            _loc4_.y = topPosition | 0;
            separators.push(_loc4_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc5_.leftPartMaxW > leftPartMaxW?_loc5_.leftPartMaxW:leftPartMaxW;
            contentMargin.bottom = this._defContentMarginBottom;
         }
         if(_loc3_.paramsEx)
         {
            _loc5_ = Utils.instance.createBlock(this.formParamsBlockData(_loc3_.paramsEx.params,_loc3_.paramsEx.headerText,_loc3_.tooHeavy),contentMargin.left + bgShadowMargin.left);
            this.maxWidth = Math.max(this.maxWidth,_loc5_.blockWidth);
            blockResults.push(_loc5_);
            topPosition = _loc5_.startYPos;
            hasIcon = _loc5_.hasIcons?true:hasIcon;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc5_.leftPartMaxW > leftPartMaxW?_loc5_.leftPartMaxW:leftPartMaxW;
            contentMargin.bottom = this._defContentMarginBottom;
         }
         if(_loc12_.rightTextList.length > 0)
         {
            _loc12_.startYPos = topPosition;
            _loc5_ = Utils.instance.createBlock(_loc12_,contentMargin.left + bgShadowMargin.left);
            this.maxWidth = Math.max(this.maxWidth,_loc5_.blockWidth);
            blockResults.push(_loc5_);
            topPosition = _loc5_.startYPos;
            hasIcon = _loc5_.hasIcons?true:hasIcon;
            _loc4_ = Utils.instance.createSeparate(content);
            _loc4_.y = topPosition | 0;
            separators.push(_loc4_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc5_.leftPartMaxW > leftPartMaxW?_loc5_.leftPartMaxW:leftPartMaxW;
            contentMargin.bottom = this._defContentMarginBottom;
         }
         if(_loc3_.complex)
         {
            _loc4_ = separators.pop();
            content.removeChild(_loc4_);
            _loc4_ = null;
            topPosition = topPosition - Utils.instance.MARGIN_AFTER_SEPARATE;
            this.complexStatus.x = bgShadowMargin.left + 1;
            this.complexStatus.y = topPosition | 0;
            this.complexHeader.htmlText = _loc3_.complexHeader;
            this.complexNote.htmlText = _loc3_.complexNote;
            topPosition = topPosition + (this.complexStatus.height + Utils.instance.MARGIN_AFTER_BLOCK);
            contentMargin.bottom = 2;
            this.maxWidth = Math.max(this.maxWidth,this.complexStatus.width - contentMargin.horizontal);
         }
         else
         {
            this.complexStatus.y = 0;
            this.complexStatus.width = 10;
            this.complexStatus.visible = false;
         }
         if(separators.length > 1 && !_loc3_.status || separators.length > 0 && (_loc3_.status))
         {
            _loc4_ = separators[0];
            this.maxWidth = Math.max(this.maxWidth,_loc4_.width);
         }
         this.updateContentWidth();
         if(_loc3_.status)
         {
            _loc37_ = Utils.instance.getStatusColor(_loc3_.statusLevel);
            this.tooltipStatus.y = topPosition | 0;
            this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
            this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatus.setData(_loc3_.statusHeader,_loc3_.statusText,_loc37_);
            topPosition = topPosition + this.tooltipStatus.height;
            contentMargin.bottom = this._defContentMarginBottom;
         }
         else
         {
            this.tooltipStatus.y = 0;
            this.tooltipStatus.width = 10;
            this.tooltipStatus.visible = false;
            if(!_loc3_.complex)
            {
               _loc4_ = separators.pop();
               content.removeChild(_loc4_);
               _loc4_ = null;
               topPosition = topPosition - Utils.instance.MARGIN_AFTER_SEPARATE;
            }
         }
         _loc3_ = null;
         updatePositions();
         super.redraw();
      }

      override protected function updateSize() : void {
         background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
         this.whiteBg.width = content.width + bgShadowMargin.horizontal;
      }

      private function formParamsBlockData(param1:Array, param2:String, param3:Boolean) : ToolTipBlockVO {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc4_:ToolTipBlockVO = new ToolTipBlockVO();
         _loc4_.header = param2;
         _loc4_.startYPos = topPosition;
         _loc4_.contener = content;
         _loc4_.childrenNamePrefix = "params";
         _loc4_.leftText = "";
         _loc4_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
         _loc4_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
         _loc4_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
         _loc4_.rightTextCSS = new StyleSheet();
         _loc4_.rightTextCSS.setStyle("h",
            {
               "color":Utils.instance.COLOR_NORMAL,
               "fontSize":"11px",
               "fontFamily":"$TextFont",
               "leading":"2px"
            }
         );
         _loc4_.rightTextCSS.setStyle("p",
            {
               "color":Utils.instance.COLOR_SUB_NORMAL,
               "fontSize":"11px",
               "fontFamily":"$TextFont",
               "leading":"2px"
            }
         );
         var _loc5_:* = "";
         var _loc6_:int = param1.length;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = param1[_loc7_][0];
            _loc9_ = param1[_loc7_][1];
            if(_loc8_ == "weight" && (param3))
            {
               _loc5_ = Utils.instance.COLOR_ALERT;
            }
            else
            {
               _loc5_ = Utils.instance.COLOR_NUMBER;
            }
            _loc4_.leftText = _loc4_.leftText + (Utils.instance.htmlWrapper(_loc9_,_loc5_,12,"$TextFont") + "<br/>");
            _loc4_.rightTextList[_loc7_] = new ToolTipBlockRightListItemVO(App.utils.locale.makeString(MENU.moduleinfo_params(_loc8_)));
            _loc7_++;
         }
         return _loc4_;
      }

      private function getEquipmentUsageBlock(param1:String, param2:String, param3:int=18) : String {
         var param1:String = param1 == ""?"":Utils.instance.htmlWrapper(param1,Utils.instance.COLOR_ADD_INFO,13,"$TitleFont",true) + Utils.instance.htmlWrapper(" ",Utils.instance.COLOR_ADD_INFO,param3,"$TextFont");
         var param2:String = param2 == ""?"":Utils.instance.htmlWrapper(param2,Utils.instance.COLOR_NORMAL,12,"$FieldFont");
         var _loc4_:String = "<br/>" + param1 + param2;
         return _loc4_;
      }

      private function updateContentWidth() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Separator = null;
         var _loc6_:ToolTipBlockResultVO = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         if(this.discrTF.visible)
         {
            _loc1_ = this.discrTF.height;
            _loc2_ = this.discrTF.y;
            this.discrTF.width = this.maxWidth;
            _loc1_ = this.discrTF.textHeight + 5 - _loc1_ | 0;
            this.whiteBg.height = this.whiteBg.height + _loc1_;
            _loc3_ = 0;
            _loc4_ = 0;
            if(separators)
            {
               _loc4_ = separators.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc5_ = separators[_loc3_];
                  if(_loc5_.y > _loc2_)
                  {
                     _loc5_.y = _loc5_.y + _loc1_;
                  }
                  _loc3_++;
               }
            }
            if(blockResults)
            {
               _loc4_ = blockResults.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc6_ = ToolTipBlockResultVO(blockResults[_loc3_]);
                  if(_loc6_.leftTextField.y > _loc2_)
                  {
                     if(_loc6_.headerTextField)
                     {
                        _loc6_.headerTextField.y = _loc6_.headerTextField.y + _loc1_;
                     }
                     _loc6_.leftTextField.y = _loc6_.leftTextField.y + _loc1_;
                     _loc7_ = _loc6_.elRightList.length;
                     _loc8_ = 0;
                     while(_loc8_ < _loc7_)
                     {
                        _loc6_.elRightList[_loc8_].y = _loc6_.elRightList[_loc8_].y + _loc1_;
                        _loc8_++;
                     }
                  }
                  _loc3_++;
               }
            }
            if(this.complexStatus.visible)
            {
               this.complexStatus.y = this.complexStatus.y + _loc1_;
            }
            topPosition = topPosition + _loc1_;
         }
      }
   }

}