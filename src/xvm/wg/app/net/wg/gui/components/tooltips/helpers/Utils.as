package net.wg.gui.components.tooltips.helpers
{
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import __AS3__.vec.Vector;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.components.tooltips.Separator;
   import flash.display.MovieClip;


   public class Utils extends Object
   {
          
      public function Utils() {
         super();
         if(__allowInstantiation)
         {
         }
      }

      private static var __instance:Utils;

      private static var __allowInstantiation:Boolean = false;

      public static function get instance() : Utils {
         if(!__instance)
         {
            __allowInstantiation = true;
            __instance = new Utils();
            __allowInstantiation = false;
         }
         return __instance;
      }

      public const COLOR_HEADER:String = "#fdf4ce";

      public const COLOR_BLOCK_HEADER:String = "#4c4b41";

      public const COLOR_NUMBER:String = "#d3d3ca";

      public const COLOR_ALERT:String = "#ff0000";

      public const COLOR_NORMAL:String = "#8c8c7c";

      public const COLOR_SUB_NORMAL:String = "#4a4a3f";

      public const COLOR_ADD_INFO:String = "#ccad77";

      public const STATUS_ADDITIONAL:String = "additional";

      public const STATUS_CRITICAL:String = "critical";

      public const STATUS_WARNING:String = "warning";

      public const STATUS_INFO:String = "info";

      public const MARGIN_AFTER_BLOCK:Number = 15;

      public const MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS:Number = 3;

      public const MARGIN_AFTER_SEPARATE:Number = 11;

      public const MARGIN_AFTER_SUBHEADER:Number = 12;

      private const LEFT_TEXTFIELD_MIN_WIDTH:Number = 54;

      public function getIcon(param1:String, param2:String="", param3:Boolean=false, param4:Boolean=false) : String {
         var _loc5_:String = IconsTypes.EMPTY;
         switch(param1)
         {
            case "xp":
               _loc5_ = param4?IconsTypes.ELITE_XP:IconsTypes.XP;
               break;
            case "doubleXPFactor":
               _loc5_ = IconsTypes.DOUBLE_XP_FACTOR;
               break;
            case "actionXPFactor":
               _loc5_ = IconsTypes.ACTION_XP_FACTOR;
               break;
            case "unlock_price":
               _loc5_ = IconsTypes.XP_PRICE;
               break;
            case "buy_price_action":
               _loc5_ = param3?IconsTypes.CREDITS:IconsTypes.GOLD;
               break;
            case "buy_price":
            case "sell_price":
               if(param3)
               {
                  _loc5_ = IconsTypes.GOLD;
               }
               else
               {
                  _loc5_ = IconsTypes.CREDITS;
               }
               break;
            default:
               _loc5_ = IconsTypes.EMPTY;
         }
         return _loc5_;
      }

      public function htmlWrapper(param1:String, param2:String="#ffffff", param3:Number=12, param4:String="$TextFont", param5:Boolean=false, param6:String="") : String {
         var _loc7_:* = "";
         _loc7_ = _loc7_ + (param4 == ""?"":" face=\"" + param4 + "\"");
         _loc7_ = _loc7_ + (param2 == ""?"":" color=\"" + param2 + "\"");
         _loc7_ = _loc7_ + (!param3?"":" size=\"" + param3 + "\"");
         var param1:* = "<font" + _loc7_ + ">" + param1 + "</font>";
         if(param5)
         {
            param1 = "<b>" + param1 + "</b>";
         }
         return param1 + param6;
      }

      public function convertStringColorToNumber(param1:String) : Number {
         return Number("0x" + param1.slice(1));
      }

      public function createBlock(param1:ToolTipBlockVO, param2:Number) : ToolTipBlockResultVO {
         var _loc4_:TextFormat = null;
         var _loc6_:String = null;
         var _loc16_:IconText = null;
         var _loc17_:ToolTipBlockRightListItemVO = null;
         var _loc18_:IconText = null;
         var _loc3_:Number = 0;
         _loc4_ = new TextFormat();
         var _loc5_:uint = 0;
         _loc6_ = "$TextFont";
         var _loc7_:* = false;
         var _loc8_:Number = 0;
         var _loc9_:Vector.<IconText> = new Vector.<IconText>();
         var _loc10_:Array = [];
         var _loc11_:TextField = null;
         var _loc12_:TextField = null;
         if(param1.header)
         {
            _loc12_ = this.addHeader(param1.childrenNamePrefix + "_header",param2,param1.startYPos,param1.header);
            _loc12_.width = _loc12_.textWidth;
            _loc8_ = Math.max(_loc8_,_loc12_.width);
            param1.contener.addChild(_loc12_);
            param1.startYPos = param1.startYPos + (_loc12_.textHeight + this.MARGIN_AFTER_SUBHEADER ^ 0);
         }
         _loc4_.leading = 2;
         _loc4_.align = TextFormatAlign.RIGHT;
         _loc4_.size = 11;
         _loc4_.font = _loc6_;
         var _loc13_:Number = param1.startYPos;
         _loc11_ = new TextField();
         _loc11_.name = param1.childrenNamePrefix + "_left";
         _loc11_.x = param2;
         _loc11_.y = _loc13_;
         _loc11_.width = 300;
         _loc11_.height = 10;
         _loc11_.autoSize = TextFormatAlign.RIGHT;
         _loc11_.multiline = true;
         _loc11_.wordWrap = true;
         _loc11_.htmlText = param1.leftText;
         _loc11_.setTextFormat(_loc4_);
         _loc11_.height = _loc11_.textHeight + 6;
         _loc11_.width = _loc11_.textWidth + 5 > this.LEFT_TEXTFIELD_MIN_WIDTH?_loc11_.textWidth + 5:this.LEFT_TEXTFIELD_MIN_WIDTH;
         _loc3_ = Math.max(_loc11_.width,_loc3_);
         _loc8_ = Math.max(_loc8_,_loc3_);
         param1.contener.addChild(_loc11_);
         var _loc14_:uint = param1.rightTextList.length;
         var _loc15_:Number = _loc11_.getLineMetrics(0).height + _loc4_.leading + 0.333;
         _loc5_ = 0;
         while(_loc5_ < _loc14_)
         {
            _loc16_ = App.utils.classFactory.getComponent("IconText",IconText);
            _loc16_.name = param1.childrenNamePrefix + "_iconText_" + _loc5_;
            _loc16_.x = param2 + this.LEFT_TEXTFIELD_MIN_WIDTH + this.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS;
            _loc16_.y = Math.round(_loc13_);
            _loc16_.textAlign = TextFormatAlign.LEFT;
            _loc16_.textColor = param1.rightTextColor;
            _loc16_.iconPosition = TextFormatAlign.LEFT;
            _loc16_.textFont = _loc6_;
            _loc16_.textSize = 11;
            _loc16_.textFieldYOffset = 0;
            if(param1.rightTextCSS)
            {
               _loc16_.css = param1.rightTextCSS;
            }
            _loc17_ = ToolTipBlockRightListItemVO(param1.rightTextList[_loc5_]);
            _loc16_.xCorrect = _loc17_.textXOffset;
            _loc16_.icon = _loc17_.icon;
            _loc16_.text = _loc17_.text;
            _loc16_.textField.htmlText = _loc17_.text;
            _loc16_.textField.width = _loc16_.textField.textWidth + 2;
            _loc16_.iconClip.y = _loc17_.textYOffset;
            _loc16_.validateNow();
            if(!(_loc16_.iconClip.currentFrame == 1) && !_loc7_)
            {
               _loc7_ = true;
            }
            _loc13_ = _loc13_ + _loc15_;
            param1.contener.addChild(_loc16_);
            _loc9_.push(_loc16_);
            _loc5_++;
         }
         if(!_loc7_)
         {
            _loc14_ = _loc9_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc14_)
            {
               _loc18_ = _loc9_[_loc5_];
               _loc18_.xCorrect = -17;
               _loc18_.validateNow();
               _loc8_ = Math.max(_loc8_,_loc18_.x + _loc18_.textField.x + _loc18_.textField.width);
               _loc5_++;
            }
         }
         param1.startYPos = Math.round(_loc13_) + this.MARGIN_AFTER_BLOCK;
         return new ToolTipBlockResultVO(param1.startYPos,_loc11_,_loc9_,_loc10_,_loc12_,_loc7_,_loc3_,_loc8_);
      }

      public function addHeader(param1:String, param2:Number, param3:Number, param4:String) : TextField {
         var _loc5_:TextField = null;
         var _loc6_:TextFormat = new TextFormat();
         _loc5_ = new TextField();
         _loc6_.leading = -3;
         _loc6_.align = TextFormatAlign.LEFT;
         _loc5_ = new TextField();
         _loc5_.name = param1;
         _loc5_.x = param2;
         _loc5_.y = param3;
         _loc5_.width = 800;
         _loc5_.height = 10;
         _loc5_.autoSize = TextFormatAlign.LEFT;
         _loc5_.multiline = true;
         _loc5_.htmlText = this.htmlWrapper(param4,this.COLOR_BLOCK_HEADER,14,"$TitleFont",true);
         _loc5_.setTextFormat(_loc6_);
         return _loc5_;
      }

      public function getStatusColor(param1:String) : ToolTipStatusColorsVO {
         var _loc2_:ToolTipStatusColorsVO = new ToolTipStatusColorsVO();
         var _loc3_:uint = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         switch(param1)
         {
            case this.STATUS_ADDITIONAL:
               _loc2_.textColor = 16761699;
               _loc2_.filters = [];
               return _loc2_;
            case this.STATUS_CRITICAL:
               _loc2_.textColor = 16721687;
               _loc3_ = 16711680;
               _loc4_ = 0.5;
               _loc5_ = 0.27;
               _loc6_ = 11;
               break;
            case this.STATUS_WARNING:
               _loc2_.textColor = 16117989;
               _loc3_ = 15521204;
               _loc4_ = 0.3;
               _loc5_ = 0.11;
               _loc6_ = 11;
               break;
            case this.STATUS_INFO:
            default:
               _loc2_.textColor = 8041216;
               _loc3_ = 3997440;
               _loc4_ = 0.5;
               _loc5_ = 0.24;
               _loc6_ = 11;
         }
         _loc2_.filters = [];
         var _loc7_:DropShadowFilter = new DropShadowFilter();
         _loc7_.distance = 0;
         _loc7_.angle = 0;
         _loc7_.color = _loc3_;
         _loc7_.alpha = _loc5_;
         _loc7_.blurX = _loc6_;
         _loc7_.blurY = _loc6_;
         _loc7_.strength = _loc4_;
         _loc7_.quality = 3;
         _loc7_.inner = false;
         _loc7_.knockout = false;
         _loc7_.hideObject = false;
         _loc2_.filters.push(_loc7_);
         return _loc2_;
      }

      public function createSeparate(param1:MovieClip) : Separator {
         var _loc2_:Separator = App.utils.classFactory.getComponent("SeparatorUI",Separator);
         param1.addChild(_loc2_);
         return _loc2_;
      }
   }

}