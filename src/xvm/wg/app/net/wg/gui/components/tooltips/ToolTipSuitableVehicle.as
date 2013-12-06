package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.tooltips.VO.SuitableVehicleVO;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.data.constants.Tooltips;
   import flash.display.MovieClip;
   import net.wg.gui.cyberSport.vo.VehicleVO;
   import net.wg.gui.cyberSport.controls.SettingRosterVO;


   public class ToolTipSuitableVehicle extends ToolTipSpecial
   {
          
      public function ToolTipSuitableVehicle() {
         super();
         this.headerTF = content.headerTF;
         this.notEnoughTF = content.notEnoughTF;
         this.whiteBg = content.whiteBg;
         this.alertSuitable = content.alertSuitable;
         this.conditionCSVehicleButtonList = new Vector.<CSVehicleButton>();
         this.addVehicleButtons();
      }

      public var headerTF:TextField = null;

      public var notEnoughTF:TextField = null;

      public var whiteBg:Sprite = null;

      public var alertSuitable:TextField = null;

      private const MARGIN_BEETWEEN_BLOCKS:Number = 3;

      private const MARGIN_AFTER_SUBHEADER:Number = 20;

      private var i:uint = 0;

      private const MIN_CONTENT_WIDTH:Number = 275;

      private var conditionCSVehicleButtonList:Vector.<CSVehicleButton> = null;

      private const MAX_CONDITIONS_CS_VEHICLES_BUTTONS:Number = 2;

      private function addVehicleButtons() : void {
         this.i = 0;
         while(this.i < this.MAX_CONDITIONS_CS_VEHICLES_BUTTONS)
         {
            this.conditionCSVehicleButtonList[this.i] = App.utils.classFactory.getComponent("CSVehicleButtonUI",CSVehicleButton);
            this.conditionCSVehicleButtonList[this.i].visible = false;
            content.addChild(this.conditionCSVehicleButtonList[this.i]);
            this.i++;
         }
      }

      override public function dispose() : void {
         var _loc1_:CSVehicleButton = null;
         if(this.conditionCSVehicleButtonList)
         {
            while(this.conditionCSVehicleButtonList.length > 0)
            {
               _loc1_ = this.conditionCSVehicleButtonList.pop();
               _loc1_.dispose();
               content.removeChild(_loc1_);
               _loc1_ = null;
            }
         }
         super.dispose();
      }

      override public function build(param1:Object, param2:ITooltipProps) : void {
         super.build(param1,param2);
      }

      override public function toString() : String {
         return "[WG ToolTipSuitableVehicle " + name + "]";
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function redraw() : void {
         var _loc1_:ILocale = null;
         var _loc2_:SuitableVehicleVO = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         _loc1_ = App.utils.locale;
         _loc2_ = new SuitableVehicleVO(_data);
         var _loc3_:Number = 300;
         var _loc4_:Separator = null;
         separators = new Vector.<Separator>();
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         if(!_loc2_.isCreator)
         {
            this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(_loc2_.toolTipType == Tooltips.CYBER_SPORT_SLOT?TOOLTIPS.SUITABLEVEHICLE_HEADER:TOOLTIPS.CSAUTOSEARCHVEHICLE_HEADER),Utils.instance.COLOR_HEADER,18,"$TitleFont");
         }
         else
         {
            this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(_loc2_.toolTipType == Tooltips.CYBER_SPORT_SLOT?TOOLTIPS.SUITABLEVEHICLE_CONDITIONSTITLE:TOOLTIPS.CSAUTOSEARCHVEHICLE_CONDITIONSTITLE),Utils.instance.COLOR_HEADER,18,"$TitleFont");
         }
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
         if(_loc2_.conditions)
         {
            _loc4_ = Utils.instance.createSeparate(content);
            _loc4_.y = topPosition ^ 0;
            separators.push(_loc4_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            if(!_loc2_.isCreator)
            {
               _loc5_ = Utils.instance.addHeader("conditionsHeader",contentMargin.left + bgShadowMargin.left,topPosition,_loc1_.makeString(_loc2_.toolTipType == Tooltips.CYBER_SPORT_SLOT?TOOLTIPS.SUITABLEVEHICLE_CONDITIONSTITLE:TOOLTIPS.CSAUTOSEARCHVEHICLE_CONDITIONSTITLE));
               content.addChild(_loc5_);
               topPosition = topPosition + (_loc5_.textHeight + this.MARGIN_AFTER_SUBHEADER ^ 0);
            }
            this.i = 0;
            while(this.i < _loc2_.conditions.length && this.i < this.conditionCSVehicleButtonList.length)
            {
               if(_loc2_.conditions[this.i])
               {
                  topPosition = this.addCondition(content,_loc2_.conditions[this.i],topPosition,this.conditionCSVehicleButtonList[this.i]);
               }
               this.i++;
            }
         }
         if((!_loc2_.isCreator) && (_loc2_.vehiclesList) && _loc2_.vehiclesList.length > 0)
         {
            _loc4_ = Utils.instance.createSeparate(content);
            _loc4_.y = topPosition ^ 0;
            separators.push(_loc4_);
            this.whiteBg.y = _loc4_.y;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            _loc6_ = Utils.instance.addHeader("suitableHeader",contentMargin.left + bgShadowMargin.left,topPosition,_loc1_.makeString(_loc2_.toolTipType == Tooltips.CYBER_SPORT_SLOT?TOOLTIPS.SUITABLEVEHICLE_SUITABLETITLE:TOOLTIPS.CSAUTOSEARCHVEHICLE_SUITABLETITLE));
            content.addChild(_loc6_);
            topPosition = topPosition + (_loc6_.textHeight + this.MARGIN_AFTER_SUBHEADER ^ 0);
            this.i = 0;
            while(this.i < _loc2_.vehiclesList.length)
            {
               topPosition = this.addSuitableVehicleBlockItem(content,_loc2_.vehiclesList[this.i],topPosition);
               this.i++;
            }
            this.alertSuitable.x = this.alertSuitable.y = 0;
            this.alertSuitable.width = this.alertSuitable.height = 1;
            this.alertSuitable.visible = false;
         }
         else
         {
            if(!_loc2_.isCreator)
            {
               _loc4_ = Utils.instance.createSeparate(content);
               _loc4_.y = topPosition ^ 0;
               separators.push(_loc4_);
               this.whiteBg.y = _loc4_.y;
               topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
               this.alertSuitable.multiline = true;
               this.alertSuitable.wordWrap = true;
               this.alertSuitable.autoSize = TextFieldAutoSize.CENTER;
               this.alertSuitable.text = _loc2_.toolTipType == Tooltips.CYBER_SPORT_SLOT?TOOLTIPS.SUITABLEVEHICLE_UNSUITABLE:TOOLTIPS.CSAUTOSEARCHVEHICLE_UNSUITABLE;
               this.alertSuitable.textColor = 16719904;
               this.alertSuitable.visible = true;
               this.alertSuitable.x = contentMargin.left + bgShadowMargin.left;
               this.alertSuitable.y = topPosition ^ 0;
               topPosition = topPosition + (this.alertSuitable.textHeight + this.MARGIN_AFTER_SUBHEADER);
            }
            else
            {
               this.alertSuitable.x = this.alertSuitable.y = 0;
               this.alertSuitable.width = this.alertSuitable.height = 1;
               this.alertSuitable.visible = false;
               this.whiteBg.visible = false;
            }
         }
         if(!_loc2_.isCreator && _loc2_.leftCount > 0)
         {
            this.notEnoughTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(_loc2_.toolTipType == Tooltips.CYBER_SPORT_SLOT?TOOLTIPS.SUITABLEVEHICLE_MORE:TOOLTIPS.CSAUTOSEARCHVEHICLE_MORE),Utils.instance.COLOR_ADD_INFO,13,"$TitleFont") + " " + Utils.instance.htmlWrapper(_loc2_.leftCount.toString(),Utils.instance.COLOR_NUMBER,13,"$TitleFont");
            this.notEnoughTF.width = this.notEnoughTF.textWidth + 5;
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
         }
         _loc2_.dispose();
         _loc2_ = null;
         updatePositions();
         super.redraw();
      }

      override protected function updateSize() : void {
         var _loc1_:Separator = null;
         if(content.width < this.MIN_CONTENT_WIDTH)
         {
            contentWidth = this.MIN_CONTENT_WIDTH;
         }
         super.updateSize();
         if(this.whiteBg.visible)
         {
            _loc1_ = separators[separators.length-1];
            this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
            this.whiteBg.height = content.height + contentMargin.bottom - _loc1_.y;
         }
      }

      private function addCondition(param1:MovieClip, param2:Object, param3:Number, param4:CSVehicleButton) : Number {
         var _loc5_:* = false;
         var _loc6_:* = false;
         if((param2.hasOwnProperty("vehicle")) && (param2["vehicle"]))
         {
            _loc5_ = true;
            _loc6_ = true;
         }
         else
         {
            if((param2.hasOwnProperty("nationIDRange")) && (param2["nationIDRange"]) || (param2.hasOwnProperty("vLevelRange")) && (param2["vLevelRange"]) || (param2.hasOwnProperty("vTypeRange")) && (param2["vTypeRange"]))
            {
               _loc5_ = true;
            }
         }
         if(_loc5_)
         {
            param4.x = contentMargin.left + bgShadowMargin.left;
            param4.y = param3 ^ 0;
            param1.addChild(param4);
            param4.showRangeRosterBg = false;
            if(_loc6_)
            {
               param4.setVehicle(new VehicleVO(param2["vehicle"]));
            }
            else
            {
               param4.setRangeData(new SettingRosterVO(param2));
            }
            param4.validateNow();
            param3 = param3 + (param4.height - 10);
            param4.visible = true;
         }
         return param3;
      }

      private function addSuitableVehicleBlockItem(param1:MovieClip, param2:VehicleVO, param3:Number) : Number {
         var _loc4_:SuitableVehicleBlockItem = App.utils.classFactory.getComponent("SuitableVehicleBlockItemUI",SuitableVehicleBlockItem);
         _loc4_.setData(App.utils.nations.getNationIcon(param2.nationID),param2.level,param2.smallIconPath,"../maps/icons/filters/tanks/" + param2.type + ".png",param2.shortUserName);
         _loc4_.x = contentMargin.left + bgShadowMargin.left;
         _loc4_.y = param3 ^ 0;
         param1.addChild(_loc4_);
         var param3:Number = param3 + (_loc4_.height + this.MARGIN_BEETWEEN_BLOCKS);
         return param3;
      }
   }

}