package net.wg.gui.lobby.hangar.maintenance
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.IResettable;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.utils.IEventCollector;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.events.EquipmentEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.utils.ILocale;
   import net.wg.data.constants.Currencies;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.events.ContextMenuEvent;
   import net.wg.gui.events.ModuleInfoEvent;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Tooltips;
   import scaleform.gfx.MouseEventEx;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.components.UserContextItem;
   
   public class EquipmentItem extends SoundButtonEx implements IResettable
   {
      
      public function EquipmentItem() {
         super();
         this.select.handleScroll = false;
         this.select.focusIndicator = this.emptyFocusIndicator;
      }
      
      private static const MODULE_INFO:String = "moduleInfo";
      
      private static const CANCEL_BUY:String = "cancelBuy";
      
      private static const UNLOAD:String = "unload";
      
      private static const SLOTS_MIN_COUNT:int = 9;
      
      private static const EMPTY_ICON:String = "../maps/icons/artefact/empty.png";
      
      private static const MULTY_CHARS:String = " x ";
      
      private static const TO_BUY_POS:int = 775;
      
      public var slotBg:MovieClip;
      
      public var icon:UILoaderAlt;
      
      public var select:DropdownMenu;
      
      public var title:TextField;
      
      public var descr:TextField;
      
      public var countLabel:TextField;
      
      public var emptyFocusIndicator:MovieClip;
      
      public var toBuy:IconText;
      
      public var price:IconText;
      
      public var actionPrice:ActionPrice;
      
      public var toBuyTf:TextField;
      
      public var toBuyDropdown:DropdownMenu;
      
      public var index:int;
      
      private var initialId:String;
      
      private var selectedIndexOld:int = -1;
      
      private var default_initialized:Boolean = false;
      
      private var artifactsData:Array;
      
      private var setupData:Array;
      
      private var installedData:Array;
      
      private var credits:Number;
      
      private var gold:Number;
      
      override protected function onDispose() : void {
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.removeEvent(this.toBuyDropdown,ListEvent.INDEX_CHANGE,this.onModuleCurrencyChanged);
         _loc1_.removeEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
         this.cleanupData();
         this.actionPrice.dispose();
         this.actionPrice = null;
         super.onDispose();
      }
      
      public function setData(param1:Array, param2:int, param3:Array, param4:Array, param5:Number, param6:Number) : void {
         var _loc8_:ModuleVO = null;
         var _loc9_:* = 0;
         if(param1)
         {
            this.select.dataProvider.cleanUp();
            this.cleanupData();
         }
         this.index = param2;
         this.artifactsData = param1;
         this.setupData = param3;
         this.installedData = param4;
         this.credits = param5;
         this.gold = param6;
         this.selectedIndexOld = -1;
         var _loc7_:* = -1;
         var _loc10_:int = param1.length;
         _loc9_ = 0;
         while(_loc9_ < _loc10_)
         {
            _loc8_ = param1[_loc9_];
            _loc8_.userCredits = 
               {
                  "credits":param5,
                  "gold":param6
               };
            if(_loc8_.target == 1 && param2 == _loc8_.index)
            {
               this.selectedIndexOld = _loc9_;
            }
            if(_loc8_.compactDescr == param3[param2])
            {
               _loc7_ = _loc9_;
            }
            if(_loc8_.compactDescr == param4[param2])
            {
               this.initialId = _loc8_.id;
            }
            _loc9_++;
         }
         this.select.close();
         var _loc11_:IEventCollector = App.utils.events;
         _loc11_.removeEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
         this.select.dataProvider = new DataProvider(param1);
         this.select.menuRowCount = Math.min(SLOTS_MIN_COUNT,param1.length);
         this.select.selectedIndex = this.selectedIndexOld;
         if(!(_loc7_ == -1) && !this.default_initialized)
         {
            this.default_initialized = true;
            this.select.selectedIndex = _loc7_;
            dispatchEvent(new EquipmentEvent(EquipmentEvent.NEED_UPDATE));
         }
         this.select.scrollBar = param1.length > this.select.menuRowCount?"ScrollBar":null;
         _loc11_.addEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
         if(this.select.selectedIndex != -1)
         {
            this.update();
         }
         else
         {
            this.clear();
         }
      }
      
      public function toggleSelectChange(param1:Boolean) : void {
         if(param1)
         {
            App.utils.events.addEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
         }
         else
         {
            App.utils.events.removeEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
         }
      }
      
      public function reset() : void {
         this.clear();
         this.default_initialized = false;
      }
      
      public function get changed() : Boolean {
         if(this.select.selectedIndex > -1)
         {
            return !(this.initialId == this.artifactsData[this.select.selectedIndex].id);
         }
         return false;
      }
      
      public function get selectedItem() : ModuleVO {
         return this.select.selectedIndex == -1?null:this.artifactsData[this.select.selectedIndex];
      }
      
      override protected function configUI() : void {
         super.configUI();
         focusTarget = this.select;
         _focusable = tabEnabled = tabChildren = mouseChildren = true;
         this.slotBg.mouseEnabled = this.slotBg.mouseChildren = false;
         this.icon.mouseEnabled = this.icon.mouseChildren = false;
         this.title.mouseEnabled = false;
         this.descr.mouseEnabled = false;
         this.countLabel.mouseEnabled = false;
         this.toBuy.mouseEnabled = this.toBuy.mouseChildren = false;
         this.price.mouseEnabled = this.price.mouseChildren = false;
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.addEvent(this.toBuyDropdown,ListEvent.INDEX_CHANGE,this.onModuleCurrencyChanged);
         this.soundType = SoundTypes.ARTEFACT_RENDERER;
      }
      
      private function cleanupData() : void {
         if(this.artifactsData)
         {
            this.artifactsData.splice(0,this.artifactsData.length);
            this.artifactsData = null;
         }
         if(this.setupData)
         {
            this.setupData.splice(0);
            this.setupData = null;
         }
         if(this.installedData)
         {
            this.installedData.splice(0);
            this.installedData = null;
         }
      }
      
      private function update() : void {
         var _loc3_:IEventCollector = null;
         var _loc1_:ModuleVO = this.artifactsData[this.select.selectedIndex];
         this.toBuyDropdown.visible = false;
         this.toBuyTf.visible = false;
         this.icon.source = _loc1_.icon;
         this.title.text = _loc1_.name;
         this.descr.text = _loc1_.desc;
         this.countLabel.visible = this.toBuy.visible = true;
         this.actionPrice.setup(this);
         this.price.visible = !this.actionPrice.visible;
         this.countLabel.alpha = _loc1_.count > 0?1:0.3;
         var _loc2_:ILocale = App.utils.locale;
         this.countLabel.text = _loc2_.integer(_loc1_.count);
         if(_loc1_.prices[1] > 0 && _loc1_.prices[0] > 0 && (_loc1_.goldEqsForCredits))
         {
            this.toBuyTf.visible = _loc1_.goldEqsForCredits;
            this.toBuy.visible = !_loc1_.goldEqsForCredits;
            _loc3_ = App.utils.events;
            this.toBuyDropdown.visible = _loc1_.goldEqsForCredits;
            _loc3_.removeEvent(this.toBuyDropdown,ListEvent.INDEX_CHANGE,this.onModuleCurrencyChanged);
            this.toBuyDropdown.dataProvider = new DataProvider([_loc2_.htmlTextWithIcon(_loc2_.integer(_loc1_.prices[0]),Currencies.CREDITS),_loc2_.htmlTextWithIcon(_loc2_.gold(_loc1_.prices[1]),Currencies.GOLD)]);
            this.toBuyDropdown.selectedIndex = _loc1_.currency == Currencies.CREDITS?0:1;
            _loc3_.addEvent(this.toBuyDropdown,ListEvent.INDEX_CHANGE,this.onModuleCurrencyChanged);
         }
         else
         {
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            this.toBuy.visible = true;
         }
         this.updateModulePrice();
      }
      
      private function clear() : void {
         this.toBuyDropdown.visible = false;
         this.toBuyTf.visible = false;
         this.icon.source = EMPTY_ICON;
         this.title.text = "";
         this.descr.text = "";
         this.countLabel.visible = this.toBuy.visible = this.price.visible = this.actionPrice.visible = false;
      }
      
      private function updateModulePrice() : void {
         var _loc1_:ModuleVO = this.selectedItem;
         this.price.icon = this.toBuy.icon = _loc1_.currency;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = "";
         if(_loc1_.count == 0 && (this.changed) && this.installedData.indexOf(_loc1_.compactDescr) == -1)
         {
            _loc2_ = 1;
         }
         if(this.toBuyDropdown.visible)
         {
            _loc3_ = _loc1_.prices[this.toBuyDropdown.selectedIndex];
         }
         else
         {
            _loc3_ = _loc1_.prices[_loc1_.currency == Currencies.CREDITS?0:1];
         }
         var _loc6_:ILocale = App.utils.locale;
         var _loc7_:Number = _loc3_ * _loc2_;
         _loc5_ = _loc1_.currency == Currencies.CREDITS?_loc6_.integer(_loc7_):_loc6_.gold(_loc7_);
         this.toBuy.textColor = Currencies.TEXT_COLORS[_loc1_.currency];
         this.price.textColor = Currencies.TEXT_COLORS[_loc7_ > _loc1_.userCredits[_loc1_.currency]?Currencies.ERROR:_loc1_.currency];
         this.price.text = _loc5_;
         var _loc8_:ActionPriceVO = null;
         if(_loc1_.actionPriceData)
         {
            _loc8_ = new ActionPriceVO(_loc1_.actionPriceData);
            _loc8_.forCredits = _loc1_.currency == Currencies.CREDITS;
         }
         this.actionPrice.setData(_loc8_);
         this.price.visible = !this.actionPrice.visible;
         if(this.actionPrice.visible)
         {
            if(_loc1_.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT)
            {
               this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
            }
            else if(_loc1_.price < _loc1_.userCredits[_loc1_.currency])
            {
               this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
            }
            else
            {
               this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
            
         }
         this.toBuy.text = _loc2_ + MULTY_CHARS + this.price.text;
         this.toBuyTf.text = _loc2_ + MULTY_CHARS;
         this.toBuy.enabled = this.price.enabled = !(_loc2_ == 0);
         this.toBuy.mouseEnabled = this.price.mouseEnabled = false;
         this.toBuy.validateNow();
         this.toBuy.x = Math.round(TO_BUY_POS - this.toBuy.width + this.toBuy.textField.textWidth / 2 + 10);
         this.toBuyTf.alpha = _loc2_ != 0?1:0.3;
      }
      
      private function vectorToArray(param1:Vector.<ModuleVO>) : Array {
         var _loc2_:Array = new Array(param1.length);
         var _loc3_:int = param1.length;
         while(_loc3_--)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      private function onModuleCurrencyChanged(param1:ListEvent) : void {
         this.price.icon = this.toBuyDropdown.selectedIndex == 0?Currencies.CREDITS:Currencies.GOLD;
         this.actionPrice.ico = this.toBuyDropdown.selectedIndex == 0?IconsTypes.CREDITS:IconsTypes.GOLD;
         this.selectedItem.currency = this.toBuyDropdown.selectedIndex == 0?Currencies.CREDITS:Currencies.GOLD;
         this.update();
         dispatchEvent(new EquipmentEvent(EquipmentEvent.TOTAL_PRICE_CHANGED,-1,-1,this.selectedItem.currency));
      }
      
      private function onItemRendererClick(param1:ListEvent) : void {
         var _loc2_:EquipmentEvent = null;
         if(this.artifactsData[this.select.selectedIndex].target == 1)
         {
            _loc2_ = new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE,this.selectedItem?this.selectedItem.index:-1,this.selectedIndexOld,this.selectedIndexOld > -1?this.artifactsData[this.selectedIndexOld].currency:Values.EMPTY_STR);
         }
         else
         {
            _loc2_ = new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE);
         }
         if(this.select.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            this.showTooltip(null);
         }
         dispatchEvent(_loc2_);
      }
      
      private function onContextMenuAction(param1:ContextMenuEvent) : void {
         var _loc2_:IEventCollector = null;
         switch(param1.id)
         {
            case MODULE_INFO:
               dispatchEvent(new ModuleInfoEvent(ModuleInfoEvent.SHOW_INFO,this.selectedItem.id));
               break;
            case UNLOAD:
            case CANCEL_BUY:
               _loc2_ = App.utils.events;
               _loc2_.removeEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
               this.selectedIndexOld = -1;
               this.select.selectedIndex = -1;
               _loc2_.addEvent(this.select,ListEvent.INDEX_CHANGE,this.onItemRendererClick);
               dispatchEvent(new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE));
               break;
         }
      }
      
      override public function showTooltip(param1:MouseEvent) : void {
         var _loc2_:ModuleVO = this.selectedItem;
         if(_loc2_)
         {
            App.toolTipMgr.showSpecial(Tooltips.TECH_MAIN_MODULE,null,_loc2_.id,_loc2_.prices,_loc2_.inventoryCount,_loc2_.vehicleCount);
         }
         else
         {
            App.toolTipMgr.showComplex(TOOLTIPS.EQUIPMENT_EMPTY,null);
         }
      }
      
      override public function handleMouseDown(param1:MouseEvent) : void {
         var _loc2_:String = null;
         App.toolTipMgr.hide();
         if((this.selectedItem) && param1 is MouseEventEx)
         {
            if(App.utils.commons.isRightButton(param1))
            {
               _loc2_ = (this.changed) && this.selectedItem.count == 0 && this.installedData.indexOf(this.selectedItem.compactDescr) == -1?CANCEL_BUY:UNLOAD;
               App.contextMenuMgr.show(Vector.<IContextItem>([new UserContextItem(MODULE_INFO),new UserContextItem(_loc2_)]),this,this.onContextMenuAction);
            }
         }
      }
   }
}
