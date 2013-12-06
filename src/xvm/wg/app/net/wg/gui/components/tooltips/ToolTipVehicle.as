package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.helpers.TankTypeIco;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.VehicleVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import flash.text.TextFormat;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.utils.ILocale;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import flash.text.StyleSheet;
   import net.wg.gui.components.controls.IconText;


   public class ToolTipVehicle extends ToolTipSpecial
   {
          
      public function ToolTipVehicle() {
         this.skipFields = [this.DEF_BUY_PRICE,this.DEF_SELL_PRICE,this.ACTION_PRC];
         super();
         this.favoriteTextField = this.vehicleFavorite.textFied;
         this.headerTF = content.headerTF;
         this.tankTypeIco = content.tankTypeIco;
         this.eliteGlow = content.eliteGlow;
         this.vehicleLock = content.vehicleLock;
         this.tooltipStatus = content.tooltipStatus;
         this.vehicleLockText = this.vehicleLock.textField;
      }

      public var vehicleFavorite:MovieClip = null;

      public var favoriteTextField:TextField = null;

      public var headerTF:TextField = null;

      public var tankTypeIco:TankTypeIco = null;

      public var eliteGlow:MovieClip = null;

      public var vehicleLock:MovieClip = null;

      public var vehicleLockText:TextField = null;

      public var tooltipStatus:Status = null;

      private const DAILY_XP_FACTOR:String = "dailyXPFactor";

      private const ACTION_XP_FACTOR:String = "actionXPFactor";

      private const DOUBLE_XP_FACTOR:String = "doubleXPFactor";

      private const BUY_PRICE:String = "buy_price";

      private const SELL_PRICE:String = "sell_price";

      private const DEF_BUY_PRICE:String = "def_buy_price";

      private const DEF_SELL_PRICE:String = "def_sell_price";

      private const ACTION_PRC:String = "action_prc";

      private var skipFields:Array;

      private const UNLOCK_PRICE:String = "unlock_price";

      override public function build(param1:Object, param2:ITooltipProps) : void {
         super.build(param1,param2);
      }

      override public function dispose() : void {
         super.dispose();
      }

      override public function toString() : String {
         return "[WG ToolTipVehicle " + name + "]";
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function redraw() : void {
         var _loc5_:VehicleVO = null;
         var _loc11_:ToolTipBlockVO = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc17_:* = NaN;
         var _loc18_:String = null;
         var _loc19_:* = NaN;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:ToolTipBlockVO = null;
         var _loc25_:String = null;
         var _loc26_:ToolTipBlockVO = null;
         var _loc27_:* = NaN;
         var _loc28_:* = NaN;
         var _loc29_:String = null;
         var _loc30_:TextFormat = null;
         var _loc31_:ToolTipStatusColorsVO = null;
         var _loc1_:Separator = null;
         separators = new Vector.<Separator>();
         var _loc2_:ToolTipBlockResultVO = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc5_ = new VehicleVO(_data);
         this.vehicleFavorite.visible = _loc5_.isFavorite;
         this.eliteGlow.gotoAndStop(_loc5_.isElite?"elite":"normal");
         this.tankTypeIco.type = _loc5_.isElite?_loc5_.vType + "_elite":_loc5_.vType;
         var _loc6_:ILocale = App.utils.locale;
         if(!_loc6_)
         {
            trace("WARNING: locale is undefined" + this);
            return;
         }
         var _loc7_:* = "";
         if(_loc5_.isElite)
         {
            _loc7_ = _loc6_.makeString(TOOLTIPS.tankcaruseltooltip_vehicletype_elite(_loc5_.vType));
         }
         else
         {
            _loc7_ = _loc6_.makeString(MENU.tankmen(_data.type));
            _loc7_ = _loc7_.slice(0,1).toUpperCase() + _loc7_.slice(1,_loc7_.length);
         }
         var _loc8_:String = _loc6_.makeString(TOOLTIPS.level(_data.level));
         var _loc9_:String = _loc6_.makeString(TOOLTIPS.VEHICLE_LEVEL);
         var _loc10_:TextFormat = new TextFormat();
         _loc10_.leading = -1;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = "<font face=\"$TitleFont\" color=\"" + Utils.instance.COLOR_HEADER + "\" size=\"18\">" + _loc5_.vName + "</font><br/><font  face=\"$FieldFont\" color=\"#998f7c\" size=\"14\">" + _loc7_ + "</font><br><font face=\"$TextFont\" color=\"" + Utils.instance.COLOR_HEADER + "\" size=\"12\">" + _loc8_ + "</font> <font face=\"$TextFont\" color=\"" + Utils.instance.COLOR_NORMAL + "\" size=\"11\">" + _loc9_ + "</font><font face=\"$TextFont\" size=\"19\">&nbsp;</font>";
         this.headerTF.setTextFormat(_loc10_);
         this.headerTF.width = this.headerTF.textWidth + 5;
         topPosition = this.vehicleFavorite.y + this.vehicleFavorite.height;
         _loc1_ = Utils.instance.createSeparate(content);
         _loc1_.y = topPosition;
         separators.push(_loc1_);
         topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         if(_loc5_.stats)
         {
            _loc11_ = new ToolTipBlockVO();
            _loc11_.startYPos = topPosition;
            _loc11_.contener = content;
            _loc11_.childrenNamePrefix = "vehicle";
            _loc11_.leftText = "";
            _loc11_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc11_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc11_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc11_.rightTextCSS = new StyleSheet();
            _loc11_.rightTextCSS.setStyle("h1",
               {
                  "color":Utils.instance.COLOR_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc11_.rightTextCSS.setStyle("p",
               {
                  "color":Utils.instance.COLOR_ALERT,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc12_ = "";
            _loc13_ = _loc6_?_loc6_.makeString(TOOLTIPS.ITEMSTATUS_NOTENOUGH,{}):TOOLTIPS.ITEMSTATUS_NOTENOUGH;
            _loc14_ = "";
            _loc15_ = -1;
            _loc16_ = -1;
            _loc17_ = 0;
            _loc18_ = "";
            _loc19_ = 0;
            _loc20_ = "";
            _loc21_ = "";
            for (_loc22_ in _loc5_.stats)
            {
               if(this.skipFields.indexOf(_loc22_) == -1)
               {
                  _loc21_ = Utils.instance.COLOR_NUMBER;
                  _loc20_ = _loc6_.makeString(TOOLTIPS.vehicle(_loc22_),{});
                  if(_loc22_ == this.BUY_PRICE || _loc22_ == this.SELL_PRICE)
                  {
                     _loc23_ = "";
                     if((_loc5_.useCredits) && (_loc5_.useGold))
                     {
                        _loc16_++;
                        _loc14_ = Utils.instance.getIcon(_loc22_,_component,false);
                        _loc17_ = _loc22_ == this.BUY_PRICE?_loc5_.stats[_loc22_][0][0]:_loc5_.stats[_loc22_][0];
                        _loc18_ = _loc6_.integer(_loc17_);
                        _loc19_ = _loc22_ == this.BUY_PRICE?_loc5_.stats[_loc22_][1][0]:0;
                        _loc12_ = this.getAlertInfo(_loc6_,_loc19_,_loc13_,IconText.CREDITS);
                        _loc21_ = _loc19_ != 0?Utils.instance.COLOR_ALERT:Utils.instance.COLOR_NUMBER;
                        _loc11_.leftText = _loc11_.leftText + (Utils.instance.htmlWrapper(_loc18_,_loc21_,12,"$TextFont",false) + "<br/>");
                        _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc20_ + _loc12_ + "</h1>",_loc14_,_loc15_);
                        if((_loc5_.isAction) && _loc22_ == this.BUY_PRICE && (_loc5_.stats.hasOwnProperty(this.DEF_BUY_PRICE)) && !(_loc5_.stats[this.DEF_BUY_PRICE][0] == 0))
                        {
                           _loc16_++;
                           _loc23_ = this.getActionInfo(_loc6_,_loc5_.stats[this.ACTION_PRC],_loc5_.stats[this.DEF_BUY_PRICE][0],IconText.CREDITS);
                           _loc11_.leftText = _loc11_.leftText + "<br/>";
                           _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc23_ + "</h1>");
                        }
                        _loc16_++;
                        _loc18_ = _loc6_.makeString(TOOLTIPS.VEHICLE_TEXTDELIMITER_OR,{});
                        _loc11_.leftText = _loc11_.leftText + (Utils.instance.htmlWrapper(_loc18_,Utils.instance.COLOR_NORMAL,12,"$TextFont",false) + "<br/>");
                        _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO(" ");
                        _loc16_++;
                        _loc14_ = Utils.instance.getIcon(_loc22_,_component,true);
                        _loc17_ = _loc22_ == this.BUY_PRICE?_loc5_.stats[_loc22_][0][1]:_loc5_.stats[_loc22_][1];
                        _loc18_ = _loc6_.gold(_loc17_);
                        _loc19_ = _loc22_ == this.BUY_PRICE?_loc5_.stats[_loc22_][1][1]:0;
                        _loc12_ = this.getAlertInfo(_loc6_,_loc19_,_loc13_,IconText.GOLD);
                        _loc21_ = _loc19_ != 0?Utils.instance.COLOR_ALERT:Utils.instance.COLOR_NUMBER;
                        _loc11_.leftText = _loc11_.leftText + (Utils.instance.htmlWrapper(_loc18_,_loc21_,12,"$TextFont",false) + "<br/>");
                        _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc20_ + _loc12_ + "</h1>",_loc14_,_loc15_);
                        if((_loc5_.isAction) && _loc22_ == this.BUY_PRICE && (_loc5_.stats.hasOwnProperty(this.DEF_BUY_PRICE)) && !(_loc5_.stats[this.DEF_BUY_PRICE][1] == 0))
                        {
                           _loc16_++;
                           _loc23_ = this.getActionInfo(_loc6_,_loc5_.stats[this.ACTION_PRC],_loc5_.stats[this.DEF_BUY_PRICE][1],IconText.GOLD);
                           _loc11_.leftText = _loc11_.leftText + "<br/>";
                           _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc23_ + "</h1>");
                        }
                     }
                     else
                     {
                        _loc16_++;
                        _loc14_ = _loc22_ == this.BUY_PRICE?Utils.instance.getIcon(_loc22_,_component,_loc5_.useGold):Utils.instance.getIcon(_loc22_,_component,_loc5_.useGold);
                        _loc17_ = _loc22_ == this.BUY_PRICE?_loc5_.useCredits?_loc5_.stats[_loc22_][0][0]:_loc5_.stats[_loc22_][0][1]:_loc5_.useCredits?_loc5_.stats[_loc22_][0]:_loc5_.stats[_loc22_][1];
                        _loc18_ = _loc5_.useCredits?_loc6_.integer(_loc17_):_loc6_.gold(_loc17_);
                        _loc19_ = _loc22_ == this.BUY_PRICE?_loc5_.useCredits?_loc5_.stats[_loc22_][1][0]:_loc5_.stats[_loc22_][1][1]:0;
                        _loc12_ = this.getAlertInfo(_loc6_,_loc19_,_loc13_,_loc5_.useCredits?IconText.CREDITS:IconText.GOLD);
                        _loc21_ = _loc19_ != 0?Utils.instance.COLOR_ALERT:Utils.instance.COLOR_NUMBER;
                        _loc11_.leftText = _loc11_.leftText + (Utils.instance.htmlWrapper(_loc18_,_loc21_,12,"$TextFont",false) + "<br/>");
                        _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc20_ + _loc12_ + "</h1>",_loc14_,_loc15_);
                        if((_loc5_.isAction) && _loc22_ == this.BUY_PRICE && (_loc5_.stats.hasOwnProperty(this.DEF_BUY_PRICE)) && (!(_loc5_.stats[this.DEF_BUY_PRICE][0] == 0) || !(_loc5_.stats[this.DEF_BUY_PRICE][1] == 0)))
                        {
                           _loc16_++;
                           _loc23_ = this.getActionInfo(_loc6_,_loc5_.stats[this.ACTION_PRC],_loc5_.useCredits?_loc5_.stats[this.DEF_BUY_PRICE][0]:_loc5_.stats[this.DEF_BUY_PRICE][1],_loc5_.useCredits?IconText.CREDITS:IconText.GOLD);
                           _loc11_.leftText = _loc11_.leftText + "<br/>";
                           _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc23_ + "</h1>");
                        }
                     }
                  }
                  else
                  {
                     _loc12_ = "";
                     if(_loc22_ == this.UNLOCK_PRICE)
                     {
                        _loc17_ = Number(_loc5_.stats[_loc22_][0]);
                        _loc19_ = _loc5_.stats[_loc22_][1]?_loc5_.stats[_loc22_][1]:0;
                        _loc12_ = this.getAlertInfo(_loc6_,_loc19_,_loc13_,IconText.XP_PRICE);
                        _loc21_ = _loc19_ != 0?Utils.instance.COLOR_ALERT:Utils.instance.COLOR_NUMBER;
                     }
                     else
                     {
                        _loc17_ = Number(_loc5_.stats[_loc22_]);
                     }
                     if(_loc17_ >= 0)
                     {
                        _loc16_++;
                        _loc18_ = _loc6_.integer(_loc17_);
                        if(_loc22_ == this.DAILY_XP_FACTOR)
                        {
                           _loc14_ = Utils.instance.getIcon(_loc17_ > 2?this.ACTION_XP_FACTOR:this.DOUBLE_XP_FACTOR);
                           _loc18_ = "x" + _loc18_;
                        }
                        else
                        {
                           _loc14_ = Utils.instance.getIcon(_loc22_,_component,_loc5_.isPremium,_loc5_.isElite);
                        }
                        _loc11_.leftText = _loc11_.leftText + (Utils.instance.htmlWrapper(_loc18_,_loc21_,12,"$TextFont",false) + "<br/>");
                        _loc11_.rightTextList[_loc16_] = new ToolTipBlockRightListItemVO("<h1>" + _loc20_ + _loc12_ + "</h1>",_loc14_,_loc15_);
                     }
                  }
               }
            }
            _loc2_ = Utils.instance.createBlock(_loc11_,contentMargin.left + bgShadowMargin.left);
            blockResults.push(_loc2_);
            topPosition = _loc2_.startYPos;
            hasIcon = _loc2_.hasIcons?true:hasIcon;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc2_.leftPartMaxW > leftPartMaxW?_loc2_.leftPartMaxW:leftPartMaxW;
         }
         if((_loc5_.characteristics) && _loc5_.characteristics.length > 0)
         {
            _loc24_ = new ToolTipBlockVO();
            _loc24_.header = _loc6_?_loc6_.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY):TOOLTIPS.TANKCARUSEL_MAINPROPERTY;
            _loc24_.leftText = "";
            _loc24_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc24_.contener = content;
            _loc24_.startYPos = topPosition;
            _loc24_.childrenNamePrefix = "characteristics";
            _loc24_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc24_.rightTextCSS = new StyleSheet();
            _loc24_.rightTextCSS.setStyle("h1",
               {
                  "color":Utils.instance.COLOR_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc24_.rightTextCSS.setStyle("p",
               {
                  "color":Utils.instance.COLOR_SUB_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc3_ = _loc5_.characteristics.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc24_.leftText = _loc24_.leftText + (Utils.instance.htmlWrapper(_loc5_.characteristics[_loc4_][1],Utils.instance.COLOR_NUMBER,12,"$TextFont",false) + "<br/>");
               _loc25_ = _loc6_?_loc6_.makeString(MENU.tank_params(_loc5_.characteristics[_loc4_][0]),{}):MENU.tank_params(_loc5_.characteristics[_loc4_][0]);
               _loc24_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO(_loc25_);
               _loc4_++;
            }
            _loc2_ = Utils.instance.createBlock(_loc24_,contentMargin.left + bgShadowMargin.left);
            blockResults.push(_loc2_);
            topPosition = _loc2_.startYPos;
            hasIcon = _loc2_.hasIcons?true:hasIcon;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc2_.leftPartMaxW > leftPartMaxW?_loc2_.leftPartMaxW:leftPartMaxW;
         }
         if((_loc5_.equipments) && _loc5_.equipments.length > 0)
         {
            _loc26_ = new ToolTipBlockVO();
            _loc26_.leftText = "";
            _loc26_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc26_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc26_.contener = content;
            _loc26_.startYPos = topPosition;
            _loc26_.childrenNamePrefix = "equipments";
            _loc26_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc3_ = _loc5_.equipments.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc27_ = _loc5_.equipments[_loc4_].current;
               _loc28_ = _loc5_.equipments[_loc4_].total;
               _loc29_ = _loc5_.equipments[_loc4_].label;
               if(_loc27_ < _loc28_ && _loc29_ == "crew" && (_component == COMPONENT_CAROUSEL || _component == COMPONENT_INVENTORY))
               {
                  _loc26_.leftText = _loc26_.leftText + (Utils.instance.htmlWrapper(_loc27_.toString(),Utils.instance.COLOR_ALERT) + Utils.instance.htmlWrapper("/" + _loc28_.toString(),Utils.instance.COLOR_NUMBER) + "<br/>");
               }
               else
               {
                  if(_loc29_ == "crew" && _component == COMPONENT_SHOP)
                  {
                     _loc26_.leftText = _loc26_.leftText + Utils.instance.htmlWrapper(_loc28_.toString(),Utils.instance.COLOR_NUMBER);
                  }
                  else
                  {
                     _loc26_.leftText = _loc26_.leftText + (Utils.instance.htmlWrapper(_loc27_.toString(),Utils.instance.COLOR_NUMBER) + Utils.instance.htmlWrapper("/" + _loc28_.toString(),Utils.instance.COLOR_NUMBER) + "<br/>");
                  }
               }
               _loc26_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(_loc29_));
               _loc4_++;
            }
            _loc2_ = Utils.instance.createBlock(_loc26_,contentMargin.left + bgShadowMargin.left);
            blockResults.push(_loc2_);
            topPosition = _loc2_.startYPos;
            hasIcon = _loc2_.hasIcons?true:hasIcon;
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            leftPartMaxW = _loc2_.leftPartMaxW > leftPartMaxW?_loc2_.leftPartMaxW:leftPartMaxW;
         }
         if(_loc5_.clanLockHeader != "")
         {
            topPosition = topPosition - Utils.instance.MARGIN_AFTER_SEPARATE;
            _loc30_ = new TextFormat();
            _loc30_.leading = -1;
            this.vehicleLockText.autoSize = TextFieldAutoSize.LEFT;
            this.vehicleLockText.htmlText = _loc5_.clanLockHeader;
            this.vehicleLockText.setTextFormat(_loc30_);
            this.vehicleLockText.width = this.vehicleLockText.textWidth + 5;
            this.vehicleLock.alpha = 1;
            this.vehicleLock.visible = true;
            this.vehicleLock.y = topPosition;
            this.vehicleLock.x = bgShadowMargin.left;
            topPosition = topPosition + this.vehicleLock.height;
            _loc1_.y = topPosition;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.vehicleLock.width = 1;
            this.vehicleLock.visible = false;
         }
         if(_loc5_.status)
         {
            _loc31_ = Utils.instance.getStatusColor(_loc5_.statusLevel);
            this.tooltipStatus.y = topPosition;
            this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
            this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatus.setData(_loc5_.statusHeader,_loc5_.statusText,_loc31_);
            topPosition = topPosition + this.tooltipStatus.height;
            contentMargin.bottom = 14;
         }
         else
         {
            this.tooltipStatus.visible = false;
            this.tooltipStatus.y = 0;
            if(_loc5_.clanLockHeader != "")
            {
               contentMargin.bottom = 2;
            }
            _loc1_ = separators.pop();
            content.removeChild(_loc1_);
            _loc1_ = null;
         }
         _loc5_ = null;
         updatePositions();
         super.redraw();
      }

      override protected function updateSize() : void {
         background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
         background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
         this.vehicleFavorite.x = background.width - bgShadowMargin.right;
      }

      private function getAlertInfo(param1:ILocale, param2:Number, param3:String, param4:String) : String {
         if(param2 == 0)
         {
            return "";
         }
         var _loc5_:* = " ( <font color=\"#8c0000\">" + param3 + "</font> ";
         _loc5_ = _loc5_ + (param4 == IconText.GOLD?param1.gold(param2):param1.integer(param2));
         _loc5_ = _loc5_ + (this.getIcoForText(param4) + ")");
         return _loc5_;
      }

      private function getIcoForText(param1:String) : String {
         var _loc2_:* = "";
         switch(param1)
         {
            case IconText.GOLD:
               _loc2_ = _loc2_ + " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/GoldIcon-2.png\" />";
               break;
            case IconText.CREDITS:
               _loc2_ = _loc2_ + " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/CreditsIcon-2.png\" />";
               break;
            case IconText.ELITE_XP:
            case IconText.XP:
               _loc2_ = _loc2_ + " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/UnlockPrice.png\" />";
               break;
            default:
               _loc2_ = _loc2_ + "";
         }
         return _loc2_;
      }

      private function getActionInfo(param1:ILocale, param2:Number, param3:Number, param4:String) : String {
         var _loc5_:String = Utils.instance.htmlWrapper(param2.toString() + "%",Utils.instance.COLOR_HEADER);
         var _loc6_:String = param4 == IconText.GOLD?param1.gold(param3):param1.integer(param3);
         var _loc7_:String = param1.makeString(TOOLTIPS.VEHICLE_ACTION_PRC,
            {
               "actionPrc":_loc5_,
               "oldPrice":_loc6_
            }
         ) + this.getIcoForText(param4);
         return _loc7_;
      }
   }

}