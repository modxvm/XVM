package net.wg.gui.lobby.hangar.ammunitionPanel
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.IconTextButton;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.utils.IEventCollector;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.DeviceEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.data.constants.FittingTypes;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.data.constants.Currencies;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.events.ModuleInfoEvent;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.constants.Tooltips;
   import flash.events.Event;
   
   public class FittingListItemRenderer extends SoundListItemRenderer
   {
      
      public function FittingListItemRenderer() {
         super();
      }
      
      private static const DESTROY_IMG:String = "destroy.png";
      
      private static const REMOVE_IMG:String = "remove.png";
      
      private static const REMOVE_GOLD_IMG:String = "removeGold.png";
      
      private static const SHOP_STATE:String = "shop";
      
      private static const HANGAR_STATE:String = "hangar";
      
      private static const HANGAR_CANT_INSTALL_STATE:String = "hangarCantInstall";
      
      private static const VEHICLE_STATE:String = "vehicle";
      
      public var removeButton:IconTextButton;
      
      public var destroyButton:IconTextButton;
      
      public var locked:MovieClip;
      
      public var icon;
      
      public var titleField:TextField;
      
      public var descField:TextField;
      
      public var errorField:TextField;
      
      public var priceMC:IconText;
      
      public var actionPrice:ActionPrice;
      
      public var targetMC:MovieClip;
      
      private var extraIcon:ExtraIcon;
      
      override public function setData(param1:Object) : void {
         this.data = param1;
         invalidateData();
         this.onRollOut();
      }
      
      override protected function onDispose() : void {
         var _loc1_:IEventCollector = App.utils.events;
         if(this.destroyButton)
         {
            _loc1_.removeEvent(this.destroyButton,ButtonEvent.CLICK,this.onRemoveButtonClick);
         }
         if(this.removeButton)
         {
            _loc1_.removeEvent(this.removeButton,ButtonEvent.CLICK,this.onRemoveButtonClick);
         }
         if(this.actionPrice)
         {
            this.actionPrice.dispose();
         }
         super.onDispose();
      }
      
      public function onRemoveButtonClick(param1:Object) : void {
         var _loc2_:Boolean = param1.target == this.removeButton && !data.removable;
         dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE,data,data,_loc2_));
      }
      
      public function processRemove(param1:Boolean) : void {
      }
      
      override public function set enabled(param1:Boolean) : void {
         if(this.actionPrice)
         {
            this.actionPrice.textColorType = param1?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_DISABLE;
         }
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
         buttonMode = enabled;
      }
      
      override protected function configUI() : void {
         super.configUI();
         if(this.actionPrice)
         {
            this.actionPrice.invalidate();
            this.actionPrice.validateNow();
            this.actionPrice.visible = false;
         }
         var _loc1_:IEventCollector = App.utils.events;
         if(this.destroyButton)
         {
            this.destroyButton.focusTarget = this;
            _loc1_.addEvent(this.destroyButton,ButtonEvent.CLICK,this.onRemoveButtonClick);
         }
         if(this.removeButton)
         {
            this.removeButton.focusTarget = this;
            _loc1_.addEvent(this.removeButton,ButtonEvent.CLICK,this.onRemoveButtonClick);
         }
         if(this.locked)
         {
            this.locked.visible = false;
            this.locked.mouseEnabled = this.locked.mouseChildren = false;
         }
         if(this.icon)
         {
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
         }
         if(this.priceMC)
         {
            this.priceMC.mouseEnabled = this.priceMC.mouseChildren = false;
         }
         if(this.targetMC)
         {
            this.targetMC.mouseEnabled = this.targetMC.mouseChildren = false;
         }
         if(this.titleField)
         {
            this.titleField.mouseEnabled = false;
         }
         if(this.descField)
         {
            this.descField.mouseEnabled = false;
         }
         if(this.errorField)
         {
            this.errorField.mouseEnabled = false;
         }
         _loc1_.addEvent(this,MouseEvent.CLICK,this.onClick);
         _loc1_.addEvent(this,MouseEvent.ROLL_OVER,this.onRollOver);
         _loc1_.addEvent(this,MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      override protected function draw() : void {
         if(isInvalid(InvalidationType.DATA))
         {
            this.setup();
         }
         super.draw();
      }
      
      protected function createExtraIcon() : void {
         this.extraIcon = new ExtraIcon();
         App.utils.events.addEvent(this.extraIcon,SimpleLoader.LOADED,this.onExtraIconLoaded,false,0,true);
         this.extraIcon.mouseChildren = false;
         this.extraIcon.mouseEnabled = false;
         addChild(this.extraIcon);
      }
      
      private function setup() : void {
         var _loc1_:* = 0;
         var _loc2_:String = null;
         var _loc3_:* = NaN;
         var _loc4_:ActionPriceVO = null;
         if(!data)
         {
            return;
         }
         this.titleField.text = data.name;
         if(this.descField)
         {
            this.descField.text = data.desc;
            if(this.descField.getLineLength(2) != -1)
            {
               _loc1_ = 0;
               _loc2_ = data.desc.substr(this.descField.getLineLength(0) + this.descField.getLineLength(1) - 1,1);
               if(_loc2_ == "\n")
               {
                  _loc1_ = -1;
               }
               else
               {
                  _loc1_ = -3;
               }
               this.descField.text = this.descField.text.substr(0,this.descField.getLineLength(0) + this.descField.getLineLength(1) + _loc1_) + "...";
            }
         }
         if(FittingTypes.MANDATORY_SLOTS.indexOf(data.type) > -1)
         {
            (this.icon as MovieClip).gotoAndStop(data.icon);
         }
         else
         {
            (this.icon as UILoaderAlt).source = data.icon;
         }
         if(data.hasOwnProperty(ExtraIcon.EXTRA_ICON_PROP_NAME))
         {
            if(!this.extraIcon)
            {
               this.createExtraIcon();
            }
            this.extraIcon.setSource(data[ExtraIcon.EXTRA_ICON_PROP_NAME]);
         }
         else if(this.extraIcon)
         {
            this.extraIcon.clear();
         }
         
         if(this.priceMC)
         {
            this.targetMC.visible = true;
            this.priceMC.visible = false;
            this.actionPrice.visible = false;
            if(data.target == 3)
            {
               this.priceMC.icon = data.currency;
               if(data.currency == Currencies.GOLD)
               {
                  this.priceMC.text = App.utils.locale.gold(data.price[1]);
               }
               else
               {
                  this.priceMC.text = App.utils.locale.integer(data.price[0]);
               }
               if(data.status == MENU.MODULEFITS_CREDIT_ERROR)
               {
                  if(this.actionPrice)
                  {
                     this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
                  }
                  this.priceMC.textColor = 10158594;
               }
               else
               {
                  this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                  if(data.status != "")
                  {
                     this.priceMC.textColor = 6710886;
                  }
                  else
                  {
                     this.priceMC.textColor = 13556185;
                  }
               }
               if(this.actionPrice)
               {
                  _loc3_ = data.hasOwnProperty("actionPrc")?data.actionPrc:0;
                  _loc4_ = null;
                  if(data.actionPriceData)
                  {
                     _loc4_ = new ActionPriceVO(data.actionPriceData);
                  }
                  this.actionPrice.setData(_loc4_);
                  this.actionPrice.setup(this);
               }
               this.targetMC.gotoAndPlay(SHOP_STATE);
               this.priceMC.visible = this.actionPrice?!this.actionPrice.visible:true;
               this.targetMC.visible = false;
               this.priceMC.validateNow();
            }
            else if(data.target == 2)
            {
               if(data.status == "")
               {
                  this.targetMC.gotoAndPlay(HANGAR_STATE);
               }
               else if(data.status != MENU.MODULEFITS_CREDIT_ERROR)
               {
                  this.targetMC.gotoAndPlay(HANGAR_CANT_INSTALL_STATE);
               }
               
            }
            else if(data.target == 1)
            {
               this.targetMC.gotoAndPlay(VEHICLE_STATE);
            }
            
            
         }
         else
         {
            this.targetMC.visible = false;
         }
         if(this.locked)
         {
            this.locked.visible = !data.removable;
         }
         this.errorField.text = data.status;
         this.enabled = !(data.status == MENU.MODULEFITS_CREDIT_ERROR || data.status == MENU.MODULEFITS_UNLOCK_ERROR || data.status == MENU.MODULEFITS_WRONG_SLOT);
         if(this.destroyButton)
         {
            this.destroyButton.label = MENU.MODULEFITS_DESTROYNAME;
            this.destroyButton.icon = DESTROY_IMG;
            this.destroyButton.visible = !data.removable && (data.isSelected);
            this.destroyButton.validateNow();
         }
         if(this.removeButton)
         {
            this.removeButton.label = MENU.MODULEFITS_REMOVENAME;
            this.removeButton.icon = data.removable?REMOVE_IMG:REMOVE_GOLD_IMG;
            this.removeButton.visible = data.isSelected;
            this.descField.visible = !data.isSelected;
            this.removeButton.validateNow();
         }
         this.errorField.visible = !data.isSelected;
      }
      
      private function onClick(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
         if(param1 is MouseEventEx)
         {
            if(App.utils.commons.isRightButton(param1))
            {
               dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,data.id));
            }
         }
      }
      
      private function onRollOver(param1:MouseEvent = null) : void {
         var _loc2_:Array = [0,0];
         _loc2_[data.currency == Currencies.CREDITS?0:1] = data.price;
         var _loc3_:ITooltipProps = new TooltipProps("",stage.mouseX,stage.mouseY);
         App.toolTipMgr.showSpecial(Tooltips.HANGAR_MODULE,null,data.id,_loc2_,data.inventoryCount,data.vehicleCount,data.slotIndex?data.slotIndex:0);
      }
      
      private function onRollOut(param1:MouseEvent = null) : void {
         App.toolTipMgr.hide();
      }
      
      private function onExtraIconLoaded(param1:Event) : void {
         this.extraIcon.x = Math.round(this.icon.x + 3);
         this.extraIcon.y = Math.round(this.icon.y + this.icon.height + 7);
      }
   }
}
