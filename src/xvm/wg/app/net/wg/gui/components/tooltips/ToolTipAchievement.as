package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.ICounterComponent;
   import __AS3__.vec.Vector;
   import net.wg.data.managers.ITooltipProps;
   import flash.display.DisplayObject;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.tooltips.VO.AchievementVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.achievements.GreyRibbonCounter;
   import net.wg.gui.components.controls.achievements.YellowRibbonCounter;
   import net.wg.gui.components.controls.achievements.BeigeCounter;
   import net.wg.gui.components.controls.achievements.RedCounter;


   public class ToolTipAchievement extends ToolTipSpecial
   {
          
      public function ToolTipAchievement() {
         super();
         this.headerTF = content.headerTF;
         this.descrTF = content.descrTF;
         this.historyTF = content.historyTF;
         this.addInfoTF = content.addInfoTF;
         this.vLeftTF = content.vLeftTF;
         this.notEnoughTF = content.notEnoughTF;
         this.isInDossierTF = content.isInDossierTF;
         this.whiteBg = content.whiteBg;
         this.whiteBg1 = content.whiteBg1;
         this.icon = content.icon;
         this.icon.autoSize = false;
         this.whiteBg.width = 10;
         this.whiteBg.visible = false;
         this.whiteBg1.width = 10;
         this.whiteBg1.visible = false;
         this.defaultBottomPadding = contentMargin.bottom;
      }

      private var headerTF:TextField = null;

      private var descrTF:TextField = null;

      private var historyTF:TextField = null;

      private var historyHeaderTF:TextField = null;

      private var vLeftTF:TextField = null;

      private var notEnoughTF:TextField = null;

      private var isInDossierTF:TextField = null;

      private var addInfoTF:TextField = null;

      private var whiteBg:Sprite = null;

      private var whiteBg1:Sprite = null;

      private var icon:UILoaderAlt = null;

      private var counter:ICounterComponent = null;

      private var flagsBlocks:Vector.<AchievementsCustomBlockItem> = null;

      private const TYPE_CLASS:String = "class";

      private const TYPE_SERIES:String = "series";

      private const TYPE_CUSTOM:String = "custom";

      private const TYPE_REPEATABLE:String = "repeatable";

      private var defaultBottomPadding:Number = 0;

      private const ICO_DIMENSION:Number = 180;

      private const ICO_SHADOW:Number = 16;

      private var isSeparateLast:Boolean = false;

      override public function build(param1:Object, param2:ITooltipProps) : void {
         super.build(param1,param2);
      }

      override protected function onDispose() : void {
         var _loc1_:AchievementsCustomBlockItem = null;
         if(content)
         {
            if(this.counter)
            {
               content.removeChild(DisplayObject(this.counter));
               this.counter = null;
            }
            if(this.historyHeaderTF)
            {
               content.removeChild(this.historyHeaderTF);
               this.historyHeaderTF = null;
            }
         }
         super.onDispose();
         if(this.flagsBlocks)
         {
            while(this.flagsBlocks.length > 0)
            {
               _loc1_ = this.flagsBlocks.pop();
               _loc1_.dispose();
               content.removeChild(_loc1_);
               _loc1_ = null;
            }
         }
      }

      override public function toString() : String {
         return "[WG ToolTipAchievement " + name + "]";
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function redraw() : void {
         var _loc1_:ILocale = null;
         var _loc4_:* = NaN;
         var _loc5_:AchievementVO = null;
         var _loc7_:* = NaN;
         var _loc10_:ToolTipBlockVO = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         _loc1_ = App.utils.locale;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc4_ = 300;
         _loc5_ = new AchievementVO(_data);
         var _loc6_:ToolTipBlockResultVO = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         this.flagsBlocks = new Vector.<AchievementsCustomBlockItem>();
         topPosition = bgShadowMargin.top + contentMargin.top;
         _loc7_ = bgShadowMargin.left + contentMargin.left;
         var _loc8_:Separator = null;
         separators = new Vector.<Separator>();
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc5_.aName,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = _loc7_;
         this.headerTF.y = topPosition;
         topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
         _loc4_ = Math.max(_loc4_,this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
         if(_loc5_.icon)
         {
            this.icon.source = _loc5_.icon;
            this.icon.sourceAlt = "../maps/icons/achievement/big/noImage.png";
            this.icon.y = topPosition - this.ICO_SHADOW;
            topPosition = topPosition + (this.ICO_DIMENSION + Utils.instance.MARGIN_AFTER_BLOCK - this.ICO_SHADOW * 2);
            _loc8_ = Utils.instance.createSeparate(content);
            _loc8_.y = topPosition;
            separators.push(_loc8_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this.icon.width = this.icon.height = 10;
            this.icon.visible = false;
         }
         if(_loc5_.description)
         {
            this.descrTF.autoSize = TextFieldAutoSize.LEFT;
            this.descrTF.htmlText = _loc5_.description;
            this.descrTF.width = _loc4_ != 0?_loc4_ - _loc7_:this.descrTF.textWidth + 5;
            this.descrTF.x = _loc7_;
            this.descrTF.y = topPosition;
            topPosition = topPosition + (this.descrTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
         }
         else
         {
            this.descrTF.x = 0;
            this.descrTF.y = 0;
            this.descrTF.width = 10;
            this.descrTF.visible = false;
         }
         if(_loc5_.classParams)
         {
            _loc10_ = new ToolTipBlockVO();
            _loc10_.leftText = "";
            _loc10_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc10_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc10_.contener = content;
            _loc10_.startYPos = topPosition;
            _loc10_.childrenNamePrefix = "classParams";
            _loc10_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc3_ = _loc5_.classParams.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc10_.leftText = _loc10_.leftText + (Utils.instance.htmlWrapper(_loc1_.integer(_loc5_.classParams[_loc2_]),Utils.instance.COLOR_NUMBER,12,"$TextFont") + "<br/>");
               _loc11_ = ACHIEVEMENTS.achievement("rank" + (_loc3_ - _loc2_).toString());
               _loc10_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc11_));
               _loc2_++;
            }
            _loc6_ = Utils.instance.createBlock(_loc10_,_loc7_);
            blockResults.push(_loc6_);
            topPosition = _loc6_.startYPos;
            hasIcon = _loc6_.hasIcons?true:hasIcon;
            leftPartMaxW = _loc6_.leftPartMaxW > leftPartMaxW?_loc6_.leftPartMaxW:leftPartMaxW;
         }
         if((_loc5_.type == this.TYPE_CUSTOM) && (_loc5_.vehicleToKill) && _loc5_.vehicleToKill.length > 0)
         {
            _loc8_ = Utils.instance.createSeparate(content);
            _loc8_.y = topPosition;
            separators.push(_loc8_);
            this.whiteBg.y = topPosition;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            _loc3_ = _loc5_.params.length;
            _loc12_ = "";
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc12_ = _loc12_ + Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.achievement_params(_loc5_.params[_loc2_].id)),Utils.instance.COLOR_ADD_INFO,14,"$TitleFont");
               _loc2_++;
            }
            this.vLeftTF.htmlText = _loc12_;
            this.vLeftTF.width = this.vLeftTF.textWidth + 5;
            this.vLeftTF.x = _loc7_;
            this.vLeftTF.y = topPosition;
            topPosition = topPosition + (this.vLeftTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
            _loc3_ = _loc5_.vehicleToKill?_loc5_.vehicleToKill.length:0;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               topPosition = this.addCustomBlock(content,_loc5_.vehicleToKill[_loc2_],topPosition);
               _loc2_++;
            }
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_BLOCK;
            if(_loc5_.vehicleToKillLeft)
            {
               _loc12_ = Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.SUITABLEVEHICLE_MORE),Utils.instance.COLOR_ADD_INFO,14,"$TitleFont") + " " + Utils.instance.htmlWrapper(_loc5_.vehicleToKillLeft.toString(),Utils.instance.COLOR_NUMBER,14,"$TitleFont");
               this.notEnoughTF.htmlText = _loc12_;
               this.notEnoughTF.width = this.notEnoughTF.textWidth + 5;
               this.notEnoughTF.x = _loc7_;
               this.notEnoughTF.y = topPosition;
               topPosition = topPosition + (this.notEnoughTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
            }
            else
            {
               this.notEnoughTF.x = 0;
               this.notEnoughTF.y = 0;
               this.notEnoughTF.width = 10;
               this.notEnoughTF.visible = false;
            }
            this.whiteBg.height = topPosition - this.whiteBg.y;
            this.whiteBg.visible = true;
            contentMargin.bottom = 0;
         }
         else
         {
            this.vLeftTF.x = 0;
            this.vLeftTF.y = 0;
            this.vLeftTF.width = 10;
            this.vLeftTF.visible = false;
            this.notEnoughTF.x = 0;
            this.notEnoughTF.y = 0;
            this.notEnoughTF.width = 10;
            this.notEnoughTF.visible = false;
         }
         var _loc9_:String = this.getInfoText(_loc5_.type,_loc5_.params,_loc5_.value,_loc5_.achievedOn,_loc5_.closeToRecord);
         if(_loc9_ != "")
         {
            this.counter = this.getInfoCounter(_loc5_.type,_loc5_.value,_component);
            _loc8_ = Utils.instance.createSeparate(content);
            _loc8_.y = topPosition;
            separators.push(_loc8_);
            this.whiteBg.y = topPosition;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            if(this.counter)
            {
               this.counter.x = _loc7_;
               this.counter.y = topPosition + 10 - (this.counter.height >> 1);
               content.addChild(DisplayObject(this.counter));
               this.addInfoTF.x = this.counter.x + this.counter.width + 10 | 0;
            }
            else
            {
               this.addInfoTF.x = _loc7_;
            }
            this.addInfoTF.y = topPosition;
            this.addInfoTF.multiline = true;
            this.addInfoTF.wordWrap = true;
            this.addInfoTF.htmlText = _loc9_;
            this.addInfoTF.width = this.addInfoTF.textWidth + 5;
            this.addInfoTF.height = this.addInfoTF.textHeight + 5;
            if(this.counter)
            {
               topPosition = Math.max(this.addInfoTF.y + this.addInfoTF.textHeight,this.counter.y + this.counter.height - 5) + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            }
            else
            {
               topPosition = this.addInfoTF.y + this.addInfoTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            }
            this.whiteBg.height = topPosition - this.whiteBg.y;
            _loc8_ = Utils.instance.createSeparate(content);
            _loc8_.y = topPosition;
            separators.push(_loc8_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            this.whiteBg.visible = true;
            contentMargin.bottom = 0;
            this.isSeparateLast = true;
         }
         else
         {
            this.addInfoTF.x = 0;
            this.addInfoTF.y = 0;
            this.addInfoTF.width = 10;
            this.addInfoTF.visible = false;
         }
         if(_loc5_.historyDescr)
         {
            this.isSeparateLast = false;
            _loc13_ = _loc1_.makeString(TOOLTIPS.ACHIEVEMENT_HISTORYDESCRIPTIONHEADER);
            this.historyHeaderTF = Utils.instance.addHeader("historyHeader",_loc7_,topPosition,_loc13_);
            content.addChild(this.historyHeaderTF);
            topPosition = this.historyHeaderTF.y + this.historyHeaderTF.textHeight + Utils.instance.MARGIN_AFTER_SUBHEADER | 0;
            this.historyTF.autoSize = TextFieldAutoSize.LEFT;
            this.historyTF.htmlText = Utils.instance.htmlWrapper(_loc5_.historyDescr,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont");
            this.historyTF.width = _loc4_ != 0?_loc4_ - _loc7_:this.historyTF.textWidth + 5;
            this.historyTF.x = _loc7_;
            this.historyTF.y = topPosition;
            topPosition = topPosition + (this.historyTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
            contentMargin.bottom = this.defaultBottomPadding;
         }
         else
         {
            this.historyTF.x = 0;
            this.historyTF.y = 0;
            this.historyTF.width = 10;
            this.historyTF.visible = false;
         }
         if(!_loc5_.isInDossier)
         {
            if(this.isSeparateLast)
            {
               _loc8_ = separators.pop();
               content.removeChild(_loc8_);
               _loc8_ = null;
            }
            else
            {
               this.whiteBg1.y = topPosition;
               this.whiteBg1.visible = true;
            }
            _loc8_ = Utils.instance.createSeparate(content);
            _loc8_.y = topPosition;
            separators.push(_loc8_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            this.isInDossierTF.y = topPosition;
            this.isInDossierTF.x = _loc7_;
            this.isInDossierTF.text = TOOLTIPS.ACHIEVEMENT_ISNOTINDOSSIER;
            this.isInDossierTF.width = this.isInDossierTF.textWidth + 5 | 0;
            topPosition = topPosition + (this.isInDossierTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0);
            if(this.whiteBg1.visible)
            {
               this.whiteBg1.height = topPosition - _loc8_.y;
            }
            else
            {
               this.whiteBg.height = topPosition - this.whiteBg.y;
            }
            contentMargin.bottom = 0;
            this.isSeparateLast = false;
         }
         else
         {
            this.isInDossierTF.x = 0;
            this.isInDossierTF.y = 0;
            this.isInDossierTF.width = 10;
            this.isInDossierTF.visible = false;
         }
         if(this.isSeparateLast)
         {
            _loc8_ = separators.pop();
            content.removeChild(_loc8_);
            _loc8_ = null;
         }
         _loc5_ = null;
         updatePositions();
         super.redraw();
      }

      override protected function updateSize() : void {
         super.updateSize();
         if(this.icon.visible)
         {
            this.icon.x = content.width + contentMargin.right + bgShadowMargin.right - this.ICO_DIMENSION >> 1;
         }
         var _loc1_:Number = content.width + contentMargin.right - bgShadowMargin.left;
         if(this.whiteBg.visible)
         {
            this.whiteBg.x = bgShadowMargin.left;
            this.whiteBg.width = _loc1_;
         }
         if(this.whiteBg1.visible)
         {
            this.whiteBg1.x = bgShadowMargin.left;
            this.whiteBg1.width = _loc1_;
         }
      }

      private function addCustomBlock(param1:MovieClip, param2:Object, param3:Number) : Number {
         var _loc4_:AchievementsCustomBlockItem = App.utils.classFactory.getComponent("AchievementsCustomBlockItem",AchievementsCustomBlockItem);
         _loc4_.setData(param2);
         _loc4_.x = bgShadowMargin.left + contentMargin.left;
         _loc4_.y = param3;
         param1.addChild(_loc4_);
         this.flagsBlocks.push(_loc4_);
         var param3:Number = param3 + 34;
         return param3;
      }

      private function getInfoText(param1:String, param2:Array, param3:Number, param4:String=null, param5:Array=null) : String {
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc6_:* = "";
         var _loc7_:ILocale = App.utils.locale;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         if(param2)
         {
            _loc8_ = param2.length;
            _loc10_ = "";
            switch(param1)
            {
               case this.TYPE_SERIES:
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_)
                  {
                     _loc10_ = _loc7_.makeString(TOOLTIPS.achievement_params(param2[_loc9_].id)) + " " + param2[_loc9_].val;
                     _loc6_ = _loc6_ + Utils.instance.htmlWrapper(_loc10_,Utils.instance.COLOR_NORMAL,12,"$TextFont");
                     _loc9_++;
                  }
                  break;
               case this.TYPE_CLASS:
                  if(param3 < 5)
                  {
                     _loc6_ = Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.ACHIEVEMENT_CURRENTDEGREE) + " " + this.getDEGREE(param3),Utils.instance.COLOR_NORMAL,12,"$TextFont");
                  }
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_)
                  {
                     if(_loc6_ != "")
                     {
                        _loc6_ = _loc6_ + "<br/><font size=\"7\"></font><br/>";
                     }
                     _loc6_ = _loc6_ + (Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.achievement_params("left" + (param3-1))) + " " + _loc7_.makeString(TOOLTIPS.achievement_params(param2[_loc9_].id)),Utils.instance.COLOR_ADD_INFO,12,"$TextFont") + ": " + Utils.instance.htmlWrapper(_loc7_.numberWithoutZeros(param2[_loc9_].val),Utils.instance.COLOR_NUMBER,12,"$TextFont"));
                     _loc9_++;
                  }
                  break;
               case this.TYPE_REPEATABLE:
                  if(param3 > 0)
                  {
                     _loc6_ = Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.ACHIEVEMENT_ALLACHIEVEMENTS),Utils.instance.COLOR_NORMAL,12,"$TextFont") + " " + Utils.instance.htmlWrapper(param3.toString(),Utils.instance.COLOR_NUMBER,12,"$TextFont");
                  }
                  break;
            }
         }
         if(param4)
         {
            _loc6_ = _loc6_ + ("<br/>" + Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.ACHIEVEMENT_ACHIEVEDON) + param4,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont"));
         }
         if(param5)
         {
            _loc6_ = _loc6_ + ("<br/><font size=\"7\"></font><br/>" + Utils.instance.htmlWrapper(_loc7_.makeString(TOOLTIPS.ACHIEVEMENT_CLOSETORECORD),Utils.instance.COLOR_ADD_INFO,12,"$TextFont"));
            _loc8_ = param5.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc11_ = param5[_loc9_][0] + ": ";
               _loc12_ = param5[_loc9_][1].toString();
               _loc6_ = _loc6_ + ("<br/>" + Utils.instance.htmlWrapper(_loc11_,Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont"));
               _loc6_ = _loc6_ + Utils.instance.htmlWrapper(_loc12_,Utils.instance.COLOR_NUMBER,12,"$TextFont");
               _loc9_++;
            }
         }
         return _loc6_;
      }

      private function getDEGREE(param1:Number) : String {
         var _loc2_:* = "";
         switch(param1)
         {
            case 4:
               _loc2_ = "IV";
               break;
            case 3:
               _loc2_ = "III";
               break;
            case 2:
               _loc2_ = "II";
               break;
            case 1:
               _loc2_ = "I";
               break;
         }
         return _loc2_;
      }

      private function getInfoCounter(param1:String, param2:Number, param3:String) : ICounterComponent {
         var _loc4_:ICounterComponent = null;
         switch(param1)
         {
            case this.TYPE_SERIES:
               if(param3 == COMPONENT_PROFILE_VEHICLE)
               {
                  _loc4_ = App.utils.classFactory.getComponent("GreyCounter_UI",GreyRibbonCounter);
               }
               else
               {
                  _loc4_ = App.utils.classFactory.getComponent("YellowCounter_UI",YellowRibbonCounter);
               }
               break;
            case this.TYPE_CLASS:
               if(param2 < 5)
               {
                  _loc4_ = App.utils.classFactory.getComponent("BeigeCounter_UI",BeigeCounter);
               }
               break;
            case this.TYPE_REPEATABLE:
               _loc4_ = App.utils.classFactory.getComponent("RedCounter_UI",RedCounter);
               break;
         }
         if(_loc4_)
         {
            _loc4_.text = param2.toString();
            _loc4_.validateNow();
         }
         return _loc4_;
      }
   }

}