package net.wg.gui.lobby.hangar.maintenance
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.utils.IEventCollector;
   import scaleform.clik.events.SliderEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.events.ShellRendererEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Currencies;
   import net.wg.gui.lobby.hangar.maintenance.data.ShellVO;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.Tooltips;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.events.ModuleInfoEvent;
   
   public class ShellItemRenderer extends SoundListItemRenderer
   {
      
      public function ShellItemRenderer() {
         super();
         this.select.handleScroll = false;
         soundType = "shellItemRenderer";
         this.initCounterBgWidth = this.countSliderBg.width;
         this.select.focusIndicator = this.emptyFocusIndicator;
      }
      
      private static const RENDERER_HEIGHT:Number = 45;
      
      private static const MULTY_CHARS:String = " x ";
      
      private static const TO_BUY_POS:int = 775;
      
      public var initCounterBgWidth:int = 0;
      
      public var select:MaintenanceDropDown;
      
      public var countLabel:TextField;
      
      public var toBuy:IconText;
      
      public var price:IconText;
      
      public var toBuyTf:TextField;
      
      public var toBuyDropdown:DropdownMenu;
      
      public var countSliderBg:MovieClip;
      
      public var countSlider:Slider;
      
      public var countStepper:NumericStepper;
      
      public var nameLbl:TextField;
      
      public var descrLbl:TextField;
      
      public var icon:UILoaderAlt;
      
      public var emptyFocusIndicator:MovieClip;
      
      public var actionPrice:ActionPrice;
      
      override protected function onDispose() : void {
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.removeEvent(this.countSlider,SliderEvent.VALUE_CHANGE,this.onSliderValueChange);
         _loc1_.removeEvent(this.countSlider,MouseEvent.ROLL_OVER,this.onRollOut);
         _loc1_.removeEvent(this.countStepper,IndexEvent.INDEX_CHANGE,this.onStepperValueChange);
         _loc1_.removeEvent(this.toBuyDropdown,ListEvent.INDEX_CHANGE,this.onShellCurrencyChanged);
         _loc1_.removeEvent(this.select,ListEvent.INDEX_CHANGE,this.onShellOrderChange);
         _loc1_.removeEvent(this,MouseEvent.ROLL_OVER,this.onRollOver);
         _loc1_.removeEvent(this,MouseEvent.ROLL_OUT,this.onRollOut);
         _loc1_.removeEvent(this,MouseEvent.CLICK,this.onClick);
         this.select.dispose();
         this.select = null;
         this.countLabel = null;
         this.toBuy.dispose();
         this.toBuy = null;
         this.price.dispose();
         this.price = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.toBuyTf = null;
         this.toBuyDropdown.dispose();
         this.toBuyDropdown = null;
         this.countSliderBg = null;
         this.countSlider.dispose();
         this.countSlider = null;
         this.countStepper.dispose();
         this.countStepper = null;
         this.nameLbl = null;
         this.descrLbl = null;
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void {
         var _loc2_:IEventCollector = App.utils.events;
         if(this.shell)
         {
            _loc2_.removeEvent(this.shell,ShellRendererEvent.USER_COUNT_CHANGED,this.onUserCountChange,false);
         }
         super.setData(param1);
         if(this.shell)
         {
            _loc2_.addEvent(this.shell,ShellRendererEvent.USER_COUNT_CHANGED,this.onUserCountChange,false,0,true);
         }
         invalidate(InvalidationType.DATA);
      }
      
      override protected function configUI() : void {
         super.configUI();
         focusTarget = this.select;
         _focusable = tabEnabled = tabChildren = mouseChildren = true;
         this.countSliderBg.mouseEnabled = this.countSliderBg.mouseChildren = false;
         this.icon.mouseEnabled = this.icon.mouseChildren = false;
         this.nameLbl.mouseEnabled = false;
         this.descrLbl.mouseEnabled = false;
         this.countLabel.mouseEnabled = false;
         this.toBuy.mouseEnabled = this.toBuy.mouseChildren = false;
         this.toBuyTf.mouseEnabled = false;
         this.price.mouseEnabled = this.price.mouseChildren = false;
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.addEvent(this.countSlider,SliderEvent.VALUE_CHANGE,this.onSliderValueChange);
         _loc1_.addEvent(this.countSlider,MouseEvent.ROLL_OVER,this.onRollOut);
         _loc1_.addEvent(this.countStepper,IndexEvent.INDEX_CHANGE,this.onStepperValueChange);
         _loc1_.addEvent(this.toBuyDropdown,ListEvent.INDEX_CHANGE,this.onShellCurrencyChanged);
         _loc1_.addEvent(this.select,ListEvent.INDEX_CHANGE,this.onShellOrderChange);
         _loc1_.addEvent(this,MouseEvent.ROLL_OVER,this.onRollOver);
         _loc1_.addEvent(this,MouseEvent.ROLL_OUT,this.onRollOut);
         _loc1_.addEvent(this,MouseEvent.CLICK,this.onClick);
      }
      
      override protected function draw() : void {
         var _loc1_:ILocale = null;
         var _loc2_:ActionPriceVO = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            mouseChildren = true;
            this.icon.mouseEnabled = false;
            this.nameLbl.mouseEnabled = false;
            this.descrLbl.mouseEnabled = false;
            focusable = true;
            if(this.shell)
            {
               this.icon.source = this.shell.icon;
               if(this.actionPrice)
               {
                  this.actionPrice.visible = false;
               }
               if(this.shell.prices[1] > 0 && this.shell.prices[0] > 0 && (this.shell.goldShellsForCredits))
               {
                  this.toBuyDropdown.visible = this.shell.goldShellsForCredits;
                  this.toBuyTf.visible = this.shell.goldShellsForCredits;
                  this.toBuy.visible = !this.shell.goldShellsForCredits;
                  _loc1_ = App.utils.locale;
                  this.toBuyDropdown.dataProvider = new DataProvider([_loc1_.htmlTextWithIcon(_loc1_.integer(this.shell.prices[0]),Currencies.CREDITS),_loc1_.htmlTextWithIcon(_loc1_.gold(this.shell.prices[1]),Currencies.GOLD)]);
                  this.toBuyDropdown.selectedIndex = this.shell.currency == Currencies.CREDITS?0:1;
                  this.price.icon = this.shell.currency;
                  _loc2_ = null;
                  if(this.shell.actionPriceData)
                  {
                     _loc2_ = new ActionPriceVO(this.shell.actionPriceData);
                     _loc2_.forCredits = this.shell.currency == Currencies.CREDITS;
                  }
                  this.actionPrice.setData(_loc2_);
                  this.actionPrice.setup(this);
                  this.price.visible = !this.actionPrice.visible;
               }
               else
               {
                  this.toBuyDropdown.visible = false;
                  this.toBuyTf.visible = false;
                  this.toBuy.visible = true;
               }
               this.nameLbl.text = this.shell.ammoName;
               this.descrLbl.text = this.shell.tableName;
               this.onUserCountChange();
               this.select.menuRowCount = data.list.length;
               this.select.dataProvider = new DataProvider(data.list);
               this.select.menuOffset.top = -RENDERER_HEIGHT - Math.round((data.list.length - 1) * RENDERER_HEIGHT / 2);
               this.select.selectedIndex = -1;
               visible = true;
               if(this.select.isOpen())
               {
                  this.select.close();
                  this.select.open();
               }
               if(this.select.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
               {
                  this.onRollOver();
               }
            }
            else
            {
               visible = false;
            }
         }
      }
      
      private function updateShellsPrice() : void {
         var _loc1_:int = this.shell.buyShellsCount;
         var _loc2_:* = 0;
         var _loc3_:* = "";
         var _loc4_:ILocale = App.utils.locale;
         if(this.toBuyDropdown.visible)
         {
            _loc2_ = this.shell.prices[this.toBuyDropdown.selectedIndex];
         }
         else
         {
            _loc2_ = this.shell.prices[this.shell.currency == Currencies.CREDITS?0:1];
            _loc3_ = this.shell.currency == Currencies.CREDITS?_loc4_.integer(_loc2_):_loc4_.gold(_loc2_);
         }
         var _loc5_:Number = _loc2_ * _loc1_;
         this.toBuy.icon = this.shell.currency;
         this.price.icon = this.shell.currency;
         this.toBuy.textColor = Currencies.TEXT_COLORS[this.shell.currency];
         this.price.textColor = Currencies.TEXT_COLORS[_loc5_ > this.shell.userCredits[this.shell.currency]?Currencies.ERROR:this.shell.currency];
         this.toBuyTf.text = _loc1_ + MULTY_CHARS;
         this.toBuy.text = _loc1_ + MULTY_CHARS + _loc3_;
         this.price.text = this.shell.currency == Currencies.CREDITS?_loc4_.integer(_loc5_):_loc4_.gold(_loc5_);
         var _loc6_:ActionPriceVO = null;
         if(this.shell.actionPriceData)
         {
            _loc6_ = new ActionPriceVO(this.shell.actionPriceData);
            _loc6_.forCredits = this.shell.currency == Currencies.CREDITS;
            if(_loc6_.forCredits)
            {
               _loc6_.newPrice = _loc1_ * _loc6_.newPrices[0];
               _loc6_.oldPrice = _loc1_ * _loc6_.oldPrices[0];
            }
            else
            {
               _loc6_.newPrice = _loc1_ * _loc6_.newPrices[1];
               _loc6_.oldPrice = _loc1_ * _loc6_.oldPrices[1];
            }
            this.actionPrice.textColorType = _loc5_ > this.shell.userCredits[this.shell.currency]?ActionPrice.TEXT_COLOR_TYPE_ERROR:ActionPrice.TEXT_COLOR_TYPE_ICON;
         }
         this.actionPrice.setData(_loc6_);
         this.price.visible = !this.actionPrice.visible;
         this.toBuy.enabled = this.price.enabled = !(_loc1_ == 0);
         this.toBuy.mouseEnabled = this.price.mouseEnabled = false;
         this.toBuyTf.alpha = _loc1_ == 0?0.3:1;
         this.toBuy.validateNow();
         this.toBuy.x = Math.round(TO_BUY_POS - this.toBuy.width + this.toBuy.textField.textWidth / 2 + 10);
         dispatchEvent(new ShellRendererEvent(ShellRendererEvent.TOTAL_PRICE_CHANGED));
      }
      
      private function get shell() : ShellVO {
         return data as ShellVO;
      }
      
      private function onSliderValueChange(param1:SliderEvent) : void {
         App.toolTipMgr.hide();
         if(this.countStepper.value != this.countSlider.value)
         {
            this.shell.userCount = this.countStepper.value = this.countSlider.value;
         }
      }
      
      private function onStepperValueChange(param1:IndexEvent) : void {
         if(this.countStepper.value != this.countSlider.value)
         {
            this.shell.userCount = this.countSlider.value = this.countStepper.value;
         }
      }
      
      private function onShellCurrencyChanged(param1:ListEvent) : void {
         this.price.icon = this.toBuyDropdown.selectedIndex == 0?Currencies.CREDITS:Currencies.GOLD;
         this.actionPrice.ico = this.toBuyDropdown.selectedIndex == 0?IconsTypes.CREDITS:IconsTypes.GOLD;
         this.shell.currency = this.toBuyDropdown.selectedIndex == 0?Currencies.CREDITS:Currencies.GOLD;
         this.onUserCountChange();
      }
      
      private function onShellOrderChange(param1:ListEvent) : void {
         if(this.select.selectedIndex == -1 || this.shell.id == this.shell.list[this.select.selectedIndex].id)
         {
            return;
         }
         dispatchEvent(new ShellRendererEvent(ShellRendererEvent.CHANGE_ORDER,this.shell,this.shell.list[this.select.selectedIndex]));
      }
      
      private function onUserCountChange(param1:ShellRendererEvent = null) : void {
         this.countSlider.maximum = this.countStepper.maximum = this.shell.maxAmmo;
         this.countSlider.snapInterval = this.countStepper.stepSize = this.shell.step;
         this.countSlider.value = this.shell.userCount;
         this.countSliderBg.width = this.initCounterBgWidth * this.shell.possibleMax / this.shell.maxAmmo;
         var _loc2_:Number = data.count - this.countSlider.value + data.inventoryCount;
         this.countLabel.text = App.utils.locale.integer(_loc2_ > 0?_loc2_:0);
         this.countLabel.alpha = _loc2_ > 0?1:0.3;
         this.updateShellsPrice();
      }
      
      private function onRollOver(param1:MouseEvent = null) : void {
         App.toolTipMgr.showSpecial(Tooltips.TECH_MAIN_SHELL,null,data.id,data.prices,data.inventoryCount,data.count);
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      private function onClick(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = null;
         App.toolTipMgr.hide();
         if(param1 is MouseEventEx)
         {
            _loc2_ = param1 as MouseEventEx;
            if(App.utils.commons.isRightButton(param1))
            {
               dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,ShellVO(data).id));
            }
         }
      }
   }
}
