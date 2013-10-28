package net.wg.gui.lobby.hangar.maintenance
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.utils.IEventCollector;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Currencies;
   import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.events.ModuleInfoEvent;
   import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;


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

      public var targetMC:MovieClip;

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
      }

      override protected function draw() : void {
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
               if(this.module.target == 3)
               {
                  this.priceMC.visible = true;
                  if(this.module.currency == Currencies.GOLD)
                  {
                     this.priceMC.text = App.utils.locale.gold(this.module.price);
                     this.priceMC.textColor = Currencies.TEXT_COLORS[Currencies.GOLD];
                  }
                  else
                  {
                     this.priceMC.text = App.utils.locale.integer(this.module.price);
                     this.priceMC.textColor = Currencies.TEXT_COLORS[Currencies.CREDITS];
                  }
                  if(this.module.status == MENU.MODULEFITS_CREDIT_ERROR || this.module.status == MENU.MODULEFITS_GOLD_ERROR)
                  {
                     this.priceMC.textColor = Currencies.TEXT_COLORS[Currencies.ERROR];
                  }
                  else
                  {
                     if(this.module.status != "")
                     {
                        this.priceMC.textColor = 6710886;
                     }
                  }
                  this.priceMC.icon = this.module.currency;
                  this.priceMC.validateNow();
                  this.targetMC.gotoAndStop("shop");
               }
               else
               {
                  if(this.module.target == 2)
                  {
                     if(this.module.status == "")
                     {
                        this.targetMC.gotoAndPlay("hangar");
                     }
                     else
                     {
                        if(!(this.module.status == MENU.MODULEFITS_CREDIT_ERROR) && this.module.status == MENU.MODULEFITS_GOLD_ERROR)
                        {
                           this.targetMC.gotoAndPlay("hangarCantInstall");
                        }
                     }
                  }
                  else
                  {
                     if(this.module.target == 1)
                     {
                        this.targetMC.gotoAndPlay("vehicle");
                        this.targetMC.textField.text = this.module.status == ""?"":MENU.FITTINGLISTITEMRENDERER_REPLACE;
                     }
                  }
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
      }

      private function onRollOver(param1:MouseEvent) : void {
         owner.dispatchEvent(new OnEquipmentRendererOver(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.module.id,this.module.prices,this.module.inventoryCount,this.module.vehicleCount,this.module.slotIndex));
      }

      private function onRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onClick(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = null;
         App.toolTipMgr.hide();
         if(param1  is  MouseEventEx)
         {
            _loc2_ = param1 as MouseEventEx;
            if(_loc2_.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
               dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,this.module.id));
            }
         }
      }

      private function get module() : ModuleVO {
         return data as ModuleVO;
      }
   }

}