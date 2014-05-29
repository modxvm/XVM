package net.wg.gui.lobby.fortifications.popovers.impl
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
   import flash.filters.GlowFilter;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.advanced.ButtonDnmIcon;
   import net.wg.gui.lobby.fortifications.data.BuildingPopoverHeaderVO;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;


   public class FortPopoverHeader extends MovieClip implements IDisposable
   {
          
      public function FortPopoverHeader() {
         super();
         this.upgradeBtn.UIID = 75;
         this.destroyBtn.UIID = 79;
      }

      private static function updateTextAlign(param1:Boolean, param2:TextField) : void {
         var _loc3_:String = param1?TextFormatAlign.CENTER:TextFormatAlign.LEFT;
         FortCommonUtils.instance.changeTextAlign(param2,_loc3_);
      }

      private static function getGlowFilter(param1:Number) : Array {
         var _loc2_:Array = [];
         var _loc3_:Number = 1;
         var _loc4_:Number = 10;
         var _loc5_:Number = 10;
         var _loc6_:Number = 1.2;
         var _loc7_:Number = 3;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:GlowFilter = new GlowFilter(param1,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         _loc2_.push(_loc10_);
         return _loc2_;
      }

      public var buildingName:TextField = null;

      public var buildingIcon:MovieClip = null;

      public var titleStatus:TextField = null;

      public var bodyStatus:TextField = null;

      public var upgradeBtn:IconTextButton = null;

      public var destroyBtn:ButtonDnmIcon = null;

      public var buildLevel:TextField = null;

      private var model:BuildingPopoverHeaderVO = null;

      public function dispose() : void {
         this.upgradeBtn.removeEventListener(ButtonEvent.CLICK,this.headerActionHandler);
         this.destroyBtn.removeEventListener(ButtonEvent.CLICK,this.headerActionHandler);
         this.upgradeBtn.dispose();
         this.upgradeBtn = null;
         this.destroyBtn.dispose();
         this.destroyBtn = null;
         this.buildingIcon = null;
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
      }

      public function setData(param1:BuildingPopoverHeaderVO) : void {
         this.model = param1;
         this.buildingName.htmlText = this.model.buildingName;
         this.buildingIcon.gotoAndStop(this.model.buildingIcon);
         this.buildLevel.htmlText = this.model.buildLevel;
         if(this.model.titleStatus == Values.EMPTY_STR && this.model.bodyStatus == Values.EMPTY_STR)
         {
            this.buildingIcon.alpha = 1;
         }
         else
         {
            this.buildingIcon.alpha = 0.2;
            this.titleStatus.htmlText = this.model.titleStatus;
            this.bodyStatus.htmlText = this.model.bodyStatus;
            updateTextAlign(this.model.titleStatus == Values.EMPTY_STR,this.bodyStatus);
         }
         updateTextAlign(this.model.showUpgradeButton,this.buildLevel);
         this.upgradeBtn.visible = this.model.showUpgradeButton;
         this.upgradeBtn.enabled = this.model.enableUpgradeBtn;
         if((this.upgradeBtn.enabled) && (this.upgradeBtn.visible))
         {
            this.upgradeBtn.addEventListener(ButtonEvent.CLICK,this.headerActionHandler);
         }
         if((this.upgradeBtn.visible) && !(this.model.upgradeButtonToolTip == Values.EMPTY_STR))
         {
            this.upgradeBtn.tooltip = this.model.upgradeButtonToolTip;
         }
         this.destroyBtn.visible = this.model.isVisibleDemountBtn;
         this.destroyBtn.enabled = this.model.enableDemountBtn;
         if((this.destroyBtn.visible) && (this.destroyBtn.enabled))
         {
            this.destroyBtn.addEventListener(ButtonEvent.CLICK,this.headerActionHandler);
         }
         if((this.model.isCommander) && (this.destroyBtn.visible) && !(this.model.demountBtnTooltip == Values.EMPTY_STR))
         {
            this.destroyBtn.tooltip = this.model.demountBtnTooltip;
         }
         this.updateFilters();
      }

      private function updateFilters() : void {
         if(this.model.glowColor == Values.DEFAULT_INT)
         {
            return;
         }
         if(this.model.titleStatus != Values.EMPTY_STR)
         {
            this.titleStatus.filters = getGlowFilter(this.model.glowColor);
         }
         if(this.model.titleStatus == Values.EMPTY_STR && !(this.model.bodyStatus == Values.EMPTY_STR) && !this.model.isCommander)
         {
            this.bodyStatus.filters = getGlowFilter(this.model.glowColor);
         }
      }

      private function headerActionHandler(param1:ButtonEvent) : void {
         App.eventLogManager.logUIEvent(param1,0);
         if(param1.target == this.upgradeBtn)
         {
            dispatchEvent(new FortBuildingCardPopoverEvent(FortBuildingCardPopoverEvent.UPGRADE_BUILDING));
         }
         else
         {
            if(param1.target == this.destroyBtn)
            {
               dispatchEvent(new FortBuildingCardPopoverEvent(FortBuildingCardPopoverEvent.DESTROY_BUILDING));
            }
         }
      }
   }

}