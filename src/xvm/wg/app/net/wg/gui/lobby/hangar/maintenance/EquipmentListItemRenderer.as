package net.wg.gui.lobby.hangar.maintenance
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.utils.IEventCollector;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.data.constants.Currencies;
   import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
   import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.events.ModuleInfoEvent;
   
   public class EquipmentListItemRenderer extends SoundListItemRenderer
   {
      
      public function EquipmentListItemRenderer() {
         super();
      }
      
      public var icon:UILoaderAlt;
      
      public var titleField:TextField;
      
      public var descField:TextField;
      
      public var errorField:TextField;
      
      public var priceMC:IconText;
      
      public var actionPrice:ActionPrice;
      
      public var targetMC:MovieClip;
      
      public var hitMc:MovieClip;
      
      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidate(InvalidationType.DATA);
      }
      
      override protected function configUI() : void {
         super.configUI();
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.addEvent(this,MouseEvent.ROLL_OVER,this.onRollOver);
         _loc1_.addEvent(this,MouseEvent.ROLL_OUT,this.onRollOut);
         _loc1_.addEvent(this,MouseEvent.CLICK,this.onClick);
         soundType = SoundTypes.NORMAL_BTN;
         if(this.hitMc)
         {
            hitArea = this.hitMc;
         }
      }
      
      override protected function draw() : void {
         var _loc1_:ActionPriceVO = null;
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               visible = true;
               if(this.module.target == 1 && !(this.module.status == ""))
               {
                  this.titleField.text = this.descField.text = "";
               }
               else
               {
                  this.titleField.text = this.module.name;
                  this.descField.text = this.module.desc;
               }
               this.icon.source = this.module.icon;
               this.priceMC.visible = false;
               this.actionPrice.visible = false;
               if(this.module.target == 3)
               {
                  _loc1_ = null;
                  if(this.module.actionPriceData)
                  {
                     _loc1_ = new ActionPriceVO(this.module.actionPriceData);
                     _loc1_.forCredits = this.module.currency == Currencies.CREDITS;
                  }
                  this.actionPrice.setData(_loc1_);
                  this.priceMC.visible = !this.actionPrice.visible;
                  this.priceMC.text = App.utils.locale.integer(this.module.price);
                  this.priceMC.textColor = this.module.price < this.module.userCredits[this.module.currency]?Currencies.TEXT_COLORS[this.module.currency]:Currencies.TEXT_COLORS[Currencies.ERROR];
                  if(this.module.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT)
                  {
                     this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
                  }
                  else if(this.module.price < this.module.userCredits[this.module.currency])
                  {
                     this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
                  }
                  else
                  {
                     this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
                  }
                  
                  if(this.module.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT)
                  {
                     this.priceMC.textColor = 6710886;
                  }
                  this.priceMC.icon = this.module.currency;
                  this.priceMC.validateNow();
                  this.targetMC.gotoAndStop("shop");
               }
               else if(this.module.target == 2)
               {
                  if(this.module.status == "")
                  {
                     this.targetMC.gotoAndPlay("hangar");
                  }
                  else if(!(this.module.status == MENU.MODULEFITS_CREDIT_ERROR) && this.module.status == MENU.MODULEFITS_GOLD_ERROR)
                  {
                     this.targetMC.gotoAndPlay("hangarCantInstall");
                  }
                  
               }
               else if(this.module.target == 1)
               {
                  this.targetMC.gotoAndPlay("vehicle");
                  this.targetMC.textField.text = this.module.status == ""?"":MENU.FITTINGLISTITEMRENDERER_REPLACE;
               }
               
               
               this.errorField.text = this.module.status;
               enabled = !(this.module.status == MENU.MODULEFITS_UNLOCK_ERROR) && !(this.module.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT);
               mouseEnabled = true;
            }
            else
            {
               visible = false;
            }
         }
         super.draw();
         if(this.actionPrice)
         {
            this.actionPrice.setup(this);
         }
      }
      
      private function get module() : ModuleVO {
         return data as ModuleVO;
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         owner.dispatchEvent(new OnEquipmentRendererOver(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.module.id,this.module.prices,this.module.inventoryCount,this.module.vehicleCount,this.module.slotIndex));
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      private function onClick(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
         if(param1 is MouseEventEx)
         {
            if(App.utils.commons.isRightButton(param1))
            {
               dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,this.module.id));
            }
         }
      }
   }
}
