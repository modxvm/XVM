package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.helpers.TankTypeIco;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.VehicleVO;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import flash.text.TextFormat;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import flash.text.StyleSheet;


   public class ToolTipVehicle extends ToolTipSpecial
   {
          
      public function ToolTipVehicle() {
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
         var _loc2_:ToolTipBlockResultVO = null;
         var _loc5_:VehicleVO = null;
         var _loc6_:ILocale = null;
         var _loc11_:ToolTipBlockVO = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:* = NaN;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:* = NaN;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:ToolTipBlockVO = null;
         var _loc24_:String = null;
         var _loc25_:ToolTipBlockVO = null;
         var _loc26_:* = NaN;
         var _loc27_:* = NaN;
         var _loc28_:String = null;
         var _loc29_:TextFormat = null;
         var _loc30_:ToolTipStatusColorsVO = null;
         var _loc1_:Separator = null;
         separators = new Vector.<Separator>();
         _loc2_ = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc5_ = new VehicleVO(_data);
         this.vehicleFavorite.visible = _loc5_.isFavorite;
         this.eliteGlow.gotoAndStop(_loc5_.isElite?"elite":"normal");
         this.tankTypeIco.type = _loc5_.isElite?_loc5_.vType + "_elite":_loc5_.vType;
         _loc6_ = App.utils.locale;
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
            _loc3_ = _loc5_.stats.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc15_ = _loc5_.stats[_loc4_][0];
               _loc16_ = Number(_loc5_.stats[_loc4_][1]);
               if(_loc15_ == this.DAILY_XP_FACTOR)
               {
                  if(_loc16_ > 2)
                  {
                     _loc14_ = Utils.instance.getIcont(this.ACTION_XP_FACTOR);
                  }
                  else
                  {
                     if(_loc16_ == 2)
                     {
                        _loc14_ = Utils.instance.getIcont(this.DOUBLE_XP_FACTOR);
                     }
                     else
                     {
                        _loc14_ = Utils.instance.getIcont("");
                     }
                  }
               }
               else
               {
                  _loc14_ = Utils.instance.getIcont(_loc15_,_component,_loc5_.isPremium,_loc5_.isElite);
               }
               _loc17_ = "";
               if(_loc15_ == this.BUY_PRICE || _loc15_ == this.SELL_PRICE)
               {
                  if(_loc6_)
                  {
                     _loc17_ = _loc6_?_loc14_ == "gold"?_loc6_.gold(_loc16_):_loc6_.integer(_loc16_):_loc16_.toString();
                  }
               }
               else
               {
                  _loc17_ = _loc6_?_loc6_.integer(_loc16_):_loc16_.toString();
               }
               _loc17_ = _loc15_ == this.DAILY_XP_FACTOR?"x" + _loc17_:_loc17_;
               _loc18_ = _loc5_.stats[_loc4_][2]?_loc6_?_loc14_ == "gold"?_loc6_.gold(Number(_loc5_.stats[_loc4_][2])):_loc6_.integer(Number(_loc5_.stats[_loc4_][2])):_loc5_.stats[_loc4_][2]:"";
               _loc19_ = Utils.instance.COLOR_NUMBER;
               _loc20_ = 0;
               if(_component == COMPONENT_SHOP)
               {
                  _loc22_ = "";
                  if(_loc15_ == this.BUY_PRICE)
                  {
                     if(_loc18_ != "")
                     {
                        _loc19_ = Utils.instance.COLOR_ALERT;
                        if(_loc14_ == "gold")
                        {
                           _loc22_ = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/GoldIcon-2.png\" />";
                        }
                        else
                        {
                           _loc22_ = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/CreditsIcon-2.png\" />";
                        }
                        _loc12_ = " ( <font color=\"#8c0000\">" + _loc13_ + "</font> " + _loc18_ + _loc22_ + ")";
                        _loc20_ = -1;
                     }
                     else
                     {
                        _loc12_ = "";
                     }
                  }
                  if(_loc15_ == this.UNLOCK_PRICE)
                  {
                     if(_loc18_ != "")
                     {
                        _loc19_ = Utils.instance.COLOR_ALERT;
                        _loc22_ = " <img vspace=\"-4\" src=\"img://gui/maps/icons/library/UnlockPrice.png\" />";
                        _loc12_ = " ( <font color=\"#8c0000\">" + _loc13_ + "</font> " + _loc18_ + _loc22_ + ")";
                        _loc20_ = -1;
                     }
                     else
                     {
                        _loc12_ = "";
                     }
                  }
               }
               _loc11_.leftText = _loc11_.leftText + (Utils.instance.htmlWrapper(_loc17_,_loc19_,12,"$TextFont",false) + "<br/>");
               _loc21_ = _loc6_?_loc6_.makeString(TOOLTIPS.vehicle(_loc15_),{}):TOOLTIPS.vehicle(_loc15_);
               _loc11_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO("<h1>" + _loc21_ + _loc12_ + "</h1>",_loc14_,_loc20_);
               _loc4_++;
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
            _loc23_ = new ToolTipBlockVO();
            _loc23_.header = _loc6_?_loc6_.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY):TOOLTIPS.TANKCARUSEL_MAINPROPERTY;
            _loc23_.leftText = "";
            _loc23_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc23_.contener = content;
            _loc23_.startYPos = topPosition;
            _loc23_.childrenNamePrefix = "characteristics";
            _loc23_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc23_.rightTextCSS = new StyleSheet();
            _loc23_.rightTextCSS.setStyle("h1",
               {
                  "color":Utils.instance.COLOR_NORMAL,
                  "fontSize":"11px",
                  "fontFamily":"$TextFont",
                  "leading":"2px"
               }
            );
            _loc23_.rightTextCSS.setStyle("p",
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
               _loc23_.leftText = _loc23_.leftText + (Utils.instance.htmlWrapper(_loc5_.characteristics[_loc4_][1],Utils.instance.COLOR_NUMBER,12,"$TextFont",false) + "<br/>");
               _loc24_ = _loc6_?_loc6_.makeString(MENU.tank_params(_loc5_.characteristics[_loc4_][0]),{}):MENU.tank_params(_loc5_.characteristics[_loc4_][0]);
               _loc23_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO(_loc24_);
               _loc4_++;
            }
            _loc2_ = Utils.instance.createBlock(_loc23_,contentMargin.left + bgShadowMargin.left);
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
            _loc25_ = new ToolTipBlockVO();
            _loc25_.leftText = "";
            _loc25_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc25_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc25_.contener = content;
            _loc25_.startYPos = topPosition;
            _loc25_.childrenNamePrefix = "equipments";
            _loc25_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc3_ = _loc5_.equipments.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc26_ = _loc5_.equipments[_loc4_].current;
               _loc27_ = _loc5_.equipments[_loc4_].total;
               _loc28_ = _loc5_.equipments[_loc4_].label;
               if(_loc26_ < _loc27_ && _loc28_ == "crew" && (_component == COMPONENT_CAROUSEL || _component == COMPONENT_INVENTORY))
               {
                  _loc25_.leftText = _loc25_.leftText + (Utils.instance.htmlWrapper(_loc26_.toString(),Utils.instance.COLOR_ALERT) + Utils.instance.htmlWrapper("/" + _loc27_.toString(),Utils.instance.COLOR_NUMBER) + "<br/>");
               }
               else
               {
                  if(_loc28_ == "crew" && _component == COMPONENT_SHOP)
                  {
                     _loc25_.leftText = _loc25_.leftText + Utils.instance.htmlWrapper(_loc27_.toString(),Utils.instance.COLOR_NUMBER);
                  }
                  else
                  {
                     _loc25_.leftText = _loc25_.leftText + (Utils.instance.htmlWrapper(_loc26_.toString(),Utils.instance.COLOR_NUMBER) + Utils.instance.htmlWrapper("/" + _loc27_.toString(),Utils.instance.COLOR_NUMBER) + "<br/>");
                  }
               }
               _loc25_.rightTextList[_loc4_] = new ToolTipBlockRightListItemVO(TOOLTIPS.vehicle(_loc28_));
               _loc4_++;
            }
            _loc2_ = Utils.instance.createBlock(_loc25_,contentMargin.left + bgShadowMargin.left);
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
            _loc29_ = new TextFormat();
            _loc29_.leading = -1;
            this.vehicleLockText.autoSize = TextFieldAutoSize.LEFT;
            this.vehicleLockText.htmlText = _loc5_.clanLockHeader;
            this.vehicleLockText.setTextFormat(_loc29_);
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
            _loc30_ = Utils.instance.getStatusColor(_loc5_.statusLevel);
            this.tooltipStatus.y = topPosition;
            this.tooltipStatus.x = contentMargin.left + bgShadowMargin.left;
            this.tooltipStatus.updateWidth(content.width - contentMargin.right - bgShadowMargin.right);
            this.tooltipStatus.setData(_loc5_.statusHeader,_loc5_.statusText,_loc30_);
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
   }

}