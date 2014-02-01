package net.wg.gui.lobby.hangar.maintenance
{
   import net.wg.infrastructure.base.meta.impl.TechnicalMaintenanceMeta;
   import net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.DynamicScrollingListEx;
   import scaleform.clik.controls.ButtonGroup;
   import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceVO;
   import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
   import net.wg.utils.IEventCollector;
   import net.wg.gui.events.ShellRendererEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.events.ModuleInfoEvent;
   import net.wg.gui.events.EquipmentEvent;
   import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
   import net.wg.data.constants.Tooltips;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.Currencies;
   import net.wg.gui.lobby.hangar.maintenance.data.ShellVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.utils.ILocale;


   public class TechnicalMaintenance extends TechnicalMaintenanceMeta implements ITechnicalMaintenanceMeta
   {
          
      public function TechnicalMaintenance() {
         super();
      }

      private static const PERCENT_CHAR:String = "%";

      private static const SPLITTER_CHAR:String = "/";

      private static const MONEY:String = "money";

      private static const EQUIPMENT:String = "equipment";

      private static const EQUIPMENT_CHANGED:String = "equipmentChanged";

      public var repairTextfield:TextField;

      public var repairIndicator:MaintenanceStatusIndicator;

      public var repairAuto:CheckBox;

      public var repairPrice:IconText;

      public var repairBtn:SoundButtonEx;

      public var shellsTextfield:TextField;

      public var casseteField:TextField;

      public var shellsIndicator:MaintenanceStatusIndicator;

      public var shellsAuto:CheckBox;

      public var shellsHeaderInventory:TextField;

      public var shellsHeaderBuy:TextField;

      public var shellsHeaderPrice:TextField;

      public var shellsTotalGold:IconText;

      public var shellsTotalCredits:IconText;

      public var shells:DynamicScrollingListEx;

      public var eqTextfield:TextField;

      public var eqIndicator:MaintenanceStatusIndicator;

      public var eqAuto:CheckBox;

      public var eqHeaderInventory:TextField;

      public var eqHeaderBuy:TextField;

      public var eqHeaderPrice:TextField;

      public var eqTotalGold:IconText;

      public var eqTotalCredits:IconText;

      public var eqItem1:EquipmentItem;

      public var eqItem2:EquipmentItem;

      public var eqItem3:EquipmentItem;

      protected var btnGroup:ButtonGroup;

      public var applyBtn:SoundButtonEx;

      public var closeBtn:SoundButtonEx;

      public var totalCredits:IconText;

      public var totalGold:IconText;

      public var labelTotal:TextField;

      private var maintenanceData:MaintenanceVO;

      private var oldMD:MaintenanceVO;

      private var totalPrice:Prices;

      private var shellsCountChanged:Boolean = false;

      private var shellsOrderChanged:Boolean = false;

      private var buy_ammo:Boolean = false;

      private var buy_equips:Boolean = false;

      private var equipmentList:Array;

      private var equipmentSetup:Array;

      private var equipmentInstalled:Array;

      private var eqChanged:Boolean = false;

      private var eqOrderChanged:Boolean = false;

      public function isResetWindow() : Boolean {
         var _loc1_:* = true;
         if((this.oldMD) && (this.maintenanceData))
         {
            _loc1_ = !(this.oldMD.vehicleId == this.maintenanceData.vehicleId) || !(this.oldMD.gunIntCD == this.maintenanceData.gunIntCD);
         }
         return _loc1_;
      }

      public function as_setData(param1:Object) : void {
         this.oldMD = this.maintenanceData;
         this.maintenanceData = new MaintenanceVO(param1);
         this.updateRepairBlock();
         this.updateShellsBlock();
         this.updateTotalPrice();
      }

      public function as_setEquipment(param1:Array, param2:Array, param3:Array) : void {
         var _loc4_:Object = null;
         if(this.equipmentList)
         {
            this.equipmentList.splice(0);
         }
         if(this.equipmentSetup)
         {
            this.equipmentSetup.splice(0);
         }
         if(this.equipmentInstalled)
         {
            this.equipmentInstalled.splice(0);
         }
         this.equipmentList = [];
         for each (_loc4_ in param3)
         {
            this.equipmentList.push(new ModuleVO(_loc4_));
         }
         this.equipmentSetup = param2;
         this.equipmentInstalled = param1;
         invalidate(EQUIPMENT);
      }

      public function as_onAmmoInstall() : void {
          
      }

      public function as_setCredits(param1:Number) : void {
         if(this.maintenanceData)
         {
            this.maintenanceData.credits = param1;
            invalidate(MONEY,EQUIPMENT);
         }
      }

      public function as_setGold(param1:Number) : void {
         if(this.maintenanceData)
         {
            this.maintenanceData.gold = param1;
            invalidate(MONEY,EQUIPMENT);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.btnGroup = new ButtonGroup("buttonGroup",this);
         this.repairTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_REPAIR_LABEL;
         this.shellsTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LABEL;
         this.shellsHeaderBuy.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_BUY;
         this.shellsHeaderInventory.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_INVENTORY;
         this.shellsHeaderPrice.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_PRICE;
         this.eqTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LABEL;
         this.eqHeaderBuy.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_BUY;
         this.eqHeaderInventory.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_INVENTORY;
         this.eqHeaderPrice.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_PRICE;
         this.labelTotal.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_LABELTOTAL;
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.addEvent(this.shells,ShellRendererEvent.TOTAL_PRICE_CHANGED,this.onAmmoPriceChanged);
         this.autoChBListeners();
         this.subscribeModules();
         _loc1_.addEvent(this.repairBtn,ButtonEvent.CLICK,this.onRepairClick);
         _loc1_.addEvent(this.applyBtn,ButtonEvent.CLICK,this.onApplyClick);
         _loc1_.addEvent(this.closeBtn,ButtonEvent.CLICK,this.onClose);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(MONEY))
         {
            this.updateRepairBlock();
            this.updateShellsBlock();
         }
         if(isInvalid(EQUIPMENT))
         {
            this.updateEquipmentBlock(this.equipmentInstalled,this.equipmentSetup,this.equipmentList);
         }
         if(isInvalid(ShellRendererEvent.TOTAL_PRICE_CHANGED,MONEY,EQUIPMENT))
         {
            this.updateTotalPrice();
         }
         if(invalidate(EQUIPMENT_CHANGED))
         {
            getEquipmentS(this.eqItem1.selectedItem?this.eqItem1.selectedItem.id:undefined,this.eqItem1.selectedItem?this.eqItem1.selectedItem.currency:undefined,this.eqItem2.selectedItem?this.eqItem2.selectedItem.id:undefined,this.eqItem2.selectedItem?this.eqItem2.selectedItem.currency:undefined,this.eqItem3.selectedItem?this.eqItem3.selectedItem.id:undefined,this.eqItem3.selectedItem?this.eqItem3.selectedItem.currency:undefined,undefined);
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_TITLE;
         window.useBottomBtns = true;
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.top = _loc1_.top + 1;
         window.contentPadding = _loc1_;
         _loc1_ = window.formBgPadding;
         _loc1_.top = _loc1_.top + 585;
         window.formBgPadding = _loc1_;
         var _loc2_:IEventCollector = App.utils.events;
         _loc2_.addEvent(App.stage,ModuleInfoEvent.SHOW_INFO,this.onShowModuleInfo);
         _loc2_.addEvent(App.stage,ShellRendererEvent.CHANGE_ORDER,this.onChangeOrder);
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.maintenanceData)
         {
            this.maintenanceData.dispose();
            this.maintenanceData = null;
         }
         if(this.oldMD)
         {
            this.oldMD.dispose();
            this.oldMD = null;
         }
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.removeEvent(App.stage,ModuleInfoEvent.SHOW_INFO,this.onShowModuleInfo);
         _loc1_.removeEvent(App.stage,ShellRendererEvent.CHANGE_ORDER,this.onChangeOrder);
         _loc1_.removeEvent(this.shells,ShellRendererEvent.TOTAL_PRICE_CHANGED,this.onAmmoPriceChanged);
         _loc1_.removeEvent(this.repairBtn,ButtonEvent.CLICK,this.onRepairClick);
         _loc1_.removeEvent(this.applyBtn,ButtonEvent.CLICK,this.onApplyClick);
         _loc1_.removeEvent(this.closeBtn,ButtonEvent.CLICK,this.onClose);
         this.subscribeModules(false);
         this.btnGroup = null;
         this.autoChBListeners(false);
      }

      private function subscribeModules(param1:Boolean=true) : void {
         var _loc3_:EquipmentItem = null;
         var _loc2_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
         var _loc4_:IEventCollector = App.utils.events;
         for each (_loc3_ in _loc2_)
         {
            if(param1)
            {
               this.btnGroup.addButton(_loc3_);
               _loc4_.addEvent(_loc3_,EquipmentEvent.NEED_UPDATE,this.onEquipmentUpdate);
               _loc4_.addEvent(_loc3_,EquipmentEvent.EQUIPMENT_CHANGE,this.onEquipmentChange);
               _loc4_.addEvent(_loc3_,EquipmentEvent.TOTAL_PRICE_CHANGED,this.onEquipmentPriceChanged);
               _loc4_.addEvent(_loc3_,OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.onEquipmentItemOver);
            }
            else
            {
               this.btnGroup.removeButton(_loc3_);
               _loc4_.removeEvent(_loc3_,EquipmentEvent.NEED_UPDATE,this.onEquipmentUpdate);
               _loc4_.removeEvent(_loc3_,EquipmentEvent.EQUIPMENT_CHANGE,this.onEquipmentChange);
               _loc4_.removeEvent(_loc3_,EquipmentEvent.TOTAL_PRICE_CHANGED,this.onEquipmentPriceChanged);
               _loc4_.removeEvent(_loc3_,OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.onEquipmentItemOver);
               _loc3_.dispose();
            }
         }
      }

      private function onEquipmentItemOver(param1:OnEquipmentRendererOver) : void {
         var _loc4_:EquipmentItem = null;
         var _loc5_:String = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
         for each (_loc4_ in _loc3_)
         {
            _loc5_ = _loc4_.selectedItem?_loc4_.selectedItem.id:null;
            _loc2_.push(_loc5_);
         }
         App.toolTipMgr.showSpecial(Tooltips.TECH_MAIN_MODULE,null,param1.moduleID,param1.modulePrices,param1.inventoryCount,param1.vehicleCount,param1.moduleIndex,_loc2_);
      }

      private function autoChBListeners(param1:Boolean=true) : void {
         var _loc3_:CheckBox = null;
         var _loc2_:Array = [this.repairAuto,this.shellsAuto,this.eqAuto];
         var _loc4_:IEventCollector = App.utils.events;
         for each (_loc3_ in _loc2_)
         {
            if(param1)
            {
               _loc4_.addEvent(_loc3_,Event.SELECT,this.updateRefillSettings);
               _loc4_.addEvent(_loc3_,MouseEvent.ROLL_OVER,this.onAutoRollOver);
               _loc4_.addEvent(_loc3_,MouseEvent.ROLL_OUT,this.onAutoRollOut);
               _loc4_.addEvent(_loc3_,MouseEvent.CLICK,this.onAutoRollOut);
            }
            else
            {
               _loc4_.removeEvent(_loc3_,Event.SELECT,this.updateRefillSettings);
               _loc4_.removeEvent(_loc3_,MouseEvent.ROLL_OVER,this.onAutoRollOver);
               _loc4_.removeEvent(_loc3_,MouseEvent.ROLL_OUT,this.onAutoRollOut);
               _loc4_.removeEvent(_loc3_,MouseEvent.CLICK,this.onAutoRollOut);
            }
         }
      }

      private function onAutoRollOver(param1:MouseEvent) : void {
         var _loc2_:String = null;
         if(param1.target == this.repairAuto)
         {
            _loc2_ = TOOLTIPS.REPAIR_AUTO;
         }
         else
         {
            if(param1.target == this.shellsAuto)
            {
               _loc2_ = TOOLTIPS.AMMO_AUTO;
            }
            else
            {
               if(param1.target == this.eqAuto)
               {
                  _loc2_ = TOOLTIPS.EQUIPMENT_AUTO;
               }
            }
         }
         if(_loc2_)
         {
            App.toolTipMgr.showComplex(_loc2_,null);
         }
      }

      private function onAutoRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onEquipmentUpdate(param1:EquipmentEvent) : void {
         invalidate(EQUIPMENT_CHANGED);
      }

      private function onEquipmentChange(param1:EquipmentEvent) : void {
         var _loc2_:Array = null;
         var _loc3_:EquipmentItem = null;
         var _loc4_:EquipmentItem = null;
         var _loc5_:IEventCollector = null;
         if(param1.changeIndex != -1)
         {
            _loc2_ = [this.eqItem1,this.eqItem2,this.eqItem3];
            _loc3_ = param1.target as EquipmentItem;
            _loc4_ = _loc2_[param1.changeIndex] as EquipmentItem;
            _loc5_ = App.utils.events;
            _loc5_.removeEvent(_loc4_,EquipmentEvent.EQUIPMENT_CHANGE,this.onEquipmentChange);
            _loc5_.removeEvent(_loc3_,EquipmentEvent.EQUIPMENT_CHANGE,this.onEquipmentChange);
            _loc4_.toggleSelectChange(false);
            if(_loc3_.selectedItem)
            {
               _loc3_.selectedItem.currency = _loc4_.selectedItem?_loc4_.selectedItem.currency:Values.EMPTY_STR;
            }
            _loc4_.select.selectedIndex = param1.changePos;
            if(_loc4_.selectedItem)
            {
               _loc4_.selectedItem.currency = param1.changeCurrency;
            }
            _loc4_.toggleSelectChange(true);
            _loc5_.addEvent(_loc4_,EquipmentEvent.EQUIPMENT_CHANGE,this.onEquipmentChange);
            _loc5_.addEvent(_loc3_,EquipmentEvent.EQUIPMENT_CHANGE,this.onEquipmentChange);
            this.eqOrderChanged = true;
         }
         getEquipmentS(this.eqItem1.selectedItem?this.eqItem1.selectedItem.id:undefined,this.eqItem1.selectedItem?this.eqItem1.selectedItem.currency:undefined,this.eqItem2.selectedItem?this.eqItem2.selectedItem.id:undefined,this.eqItem2.selectedItem?this.eqItem2.selectedItem.currency:undefined,this.eqItem3.selectedItem?this.eqItem3.selectedItem.id:undefined,this.eqItem3.selectedItem?this.eqItem3.selectedItem.currency:undefined,(param1.target as EquipmentItem).index);
         if(this.eqChanged)
         {
         }
      }

      private function updateRepairBlock() : void {
         var _loc2_:* = NaN;
         var _loc1_:IEventCollector = App.utils.events;
         _loc1_.removeEvent(this.repairAuto,Event.SELECT,this.updateRefillSettings);
         this.repairAuto.selected = this.maintenanceData.autoRepair;
         _loc1_.addEvent(this.repairAuto,Event.SELECT,this.updateRefillSettings);
         this.repairPrice.textColor = Currencies.TEXT_COLORS[this.maintenanceData.repairCost > this.maintenanceData.credits?Currencies.ERROR:Currencies.CREDITS];
         this.repairPrice.text = App.utils.locale.integer(this.maintenanceData.repairCost);
         this.repairIndicator.maximum = this.maintenanceData.maxRepairCost;
         this.repairIndicator.value = this.maintenanceData.maxRepairCost - this.maintenanceData.repairCost;
         if(this.maintenanceData.maxRepairCost != 0)
         {
            _loc2_ = Math.round((this.maintenanceData.maxRepairCost - this.maintenanceData.repairCost) * 100 / this.maintenanceData.maxRepairCost);
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            this.repairIndicator.label = _loc2_ + PERCENT_CHAR;
         }
         else
         {
            this.repairIndicator.label = "";
         }
      }

      private function updateShellsBlock(param1:Boolean=false) : void {
         var _loc2_:ShellVO = null;
         var _loc4_:* = 0;
         var _loc6_:ShellVO = null;
         var _loc7_:ShellVO = null;
         var _loc8_:Array = null;
         if(this.isResetWindow())
         {
            this.shellsOrderChanged = false;
         }
         else
         {
            if(!param1)
            {
               _loc8_ = [];
               for each (_loc6_ in this.shells.dataProvider)
               {
                  for each (_loc7_ in this.maintenanceData.shells)
                  {
                     if(_loc6_.compactDescr == _loc7_.compactDescr)
                     {
                        _loc7_.setUserCount(_loc6_.userCount);
                        _loc7_.possibleMax = _loc6_.possibleMax;
                        _loc7_.currency = _loc6_.currency;
                        _loc8_.push(_loc7_);
                     }
                  }
               }
               for each (_loc7_ in _loc8_)
               {
                  _loc7_.list = _loc8_.slice();
                  _loc7_.list.splice(_loc8_.indexOf(_loc7_),1);
               }
               this.maintenanceData.shells = _loc8_;
            }
         }
         for each (_loc2_ in this.maintenanceData.shells)
         {
            _loc2_.userCredits =
               {
                  "credits":this.maintenanceData.credits,
                  "gold":this.maintenanceData.gold
               }
            ;
         }
         if(this.shells.dataProvider != this.maintenanceData.shells)
         {
            if(this.shells.dataProvider)
            {
               this.shells.dataProvider.cleanUp();
            }
            this.shells.dataProvider = new DataProvider(this.maintenanceData.shells);
         }
         var _loc3_:IEventCollector = App.utils.events;
         _loc3_.removeEvent(this.shellsAuto,Event.SELECT,this.updateRefillSettings);
         this.shellsAuto.selected = this.maintenanceData.autoShells;
         _loc3_.addEvent(this.shellsAuto,Event.SELECT,this.updateRefillSettings);
         this.casseteField.text = this.maintenanceData.casseteFieldText;
         var _loc5_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < this.maintenanceData.shells.length)
         {
            _loc4_ = _loc4_ + this.maintenanceData.shells[_loc5_].count;
            _loc5_++;
         }
         this.shellsIndicator.maximum = this.maintenanceData.maxAmmo;
         this.shellsIndicator.value = this.maintenanceData.maxAmmo - _loc4_;
         this.shellsIndicator.setDivisor(_loc4_,this.maintenanceData.maxAmmo);
         this.shellsIndicator.textField.text = _loc4_ + SPLITTER_CHAR + this.maintenanceData.maxAmmo;
      }

      private function updateEquipmentBlock(param1:Array, param2:Array, param3:Array) : void {
         var _loc8_:EquipmentItem = null;
         var _loc10_:Array = null;
         var _loc11_:ModuleVO = null;
         var _loc4_:IEventCollector = App.utils.events;
         _loc4_.removeEvent(this.eqAuto,Event.SELECT,this.updateRefillSettings);
         this.eqAuto.selected = this.maintenanceData.autoEqip;
         _loc4_.addEvent(this.eqAuto,Event.SELECT,this.updateRefillSettings);
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
         var _loc9_:int = _loc7_.length;
         var _loc12_:int = param3.length;
         var _loc13_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc9_)
         {
            _loc10_ = [];
            _loc8_ = _loc7_[_loc5_] as EquipmentItem;
            if(_loc5_ > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc12_)
               {
                  _loc11_ = param3[_loc6_];
                  _loc10_.push(_loc11_.clone(_loc5_));
                  _loc6_++;
               }
            }
            else
            {
               _loc10_ = param3.slice(0);
            }
            _loc8_.setData(_loc10_,_loc5_,param2,param1.slice(),this.maintenanceData.credits,this.maintenanceData.gold);
            if(!(param1[_loc5_] == undefined) && !(param1[_loc5_] == 0))
            {
               _loc13_ = _loc13_ + 1;
            }
            _loc5_++;
         }
         this.eqIndicator.maximum = _loc7_.length;
         this.eqIndicator.value = _loc13_;
         this.eqIndicator.setDivisor(_loc13_,_loc7_.length);
         this.eqIndicator.textField.text = _loc13_ + SPLITTER_CHAR + _loc7_.length;
      }

      private function onShowModuleInfo(param1:ModuleInfoEvent) : void {
         showModuleInfoS(param1.id);
      }

      private function onChangeOrder(param1:ShellRendererEvent) : void {
         var _loc4_:* = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:ShellVO = null;
         var _loc2_:ShellVO = param1.shell;
         var _loc3_:ShellVO = param1.shellToReplace;
         if((_loc2_) && (_loc3_))
         {
            _loc4_ = 0;
            _loc5_ = this.maintenanceData.shells;
            _loc6_ = [];
            for each (_loc7_ in _loc5_)
            {
               if(_loc7_ == _loc2_)
               {
                  _loc6_.push(_loc3_);
               }
               else
               {
                  if(_loc7_ == _loc3_)
                  {
                     _loc6_.push(_loc2_);
                  }
                  else
                  {
                     _loc6_.push(_loc7_);
                  }
               }
            }
            for each (_loc7_ in _loc6_)
            {
               _loc7_.list = _loc6_.slice();
               _loc7_.list.splice(_loc6_.indexOf(_loc7_),1);
            }
            this.maintenanceData.shells = _loc6_;
            this.updateShellsBlock(true);
            this.shellsOrderChanged = true;
         }
      }

      private function updateTotalPrice() : void {
         var _loc1_:Prices = this.__getAmmoPrice();
         this.updatePriceLabels(this.shellsTotalCredits,this.shellsTotalGold,_loc1_);
         var _loc2_:Prices = this.__getEquipmentsPrice();
         this.updatePriceLabels(this.eqTotalCredits,this.eqTotalGold,_loc2_);
         this.totalPrice = new Prices(_loc1_.credits + _loc2_.credits + this.maintenanceData.repairCost,_loc1_.gold + _loc2_.gold);
         this.updatePriceLabels(this.totalCredits,this.totalGold,this.totalPrice);
         this.updateButtonStates();
      }

      private function updateButtonStates() : void {
         var _loc3_:ShellVO = null;
         var _loc7_:EquipmentItem = null;
         this.repairBtn.enabled = !(this.maintenanceData.repairCost == 0) && this.maintenanceData.repairCost <= this.maintenanceData.credits;
         this.buy_ammo = true;
         var _loc1_:Number = 0;
         var _loc2_:Prices = this.__getAmmoPrice();
         this.shellsCountChanged = false;
         for each (_loc3_ in this.maintenanceData.shells)
         {
            _loc1_ = _loc1_ + _loc3_.userCount;
            if(_loc3_.userCount != _loc3_.count)
            {
               this.shellsCountChanged = true;
            }
         }
         if((this.shellsOrderChanged) && this.maintenanceData.gold >= _loc2_.gold && this.maintenanceData.credits >= _loc2_.credits)
         {
            this.buy_ammo = false;
         }
         this.shellsIndicator.maximum = this.maintenanceData.maxAmmo;
         this.shellsIndicator.value = _loc1_;
         this.shellsIndicator.label = _loc1_ + SPLITTER_CHAR + this.maintenanceData.maxAmmo;
         var _loc4_:Prices = this.__getEquipmentsPrice();
         var _loc5_:Number = 0;
         var _loc6_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
         for each (_loc7_ in _loc6_)
         {
            if(_loc7_.selectedItem)
            {
               _loc5_ = _loc5_ + 1;
            }
         }
         this.eqIndicator.value = _loc5_;
         this.eqIndicator.label = _loc5_ + SPLITTER_CHAR + 3;
         this.applyBtn.enabled = this.maintenanceData.credits >= this.totalPrice.credits && this.maintenanceData.gold >= this.totalPrice.gold;
      }

      private function __getAmmoPrice() : Prices {
         var _loc2_:ShellVO = null;
         var _loc1_:Prices = new Prices();
         for each (_loc2_ in this.maintenanceData.shells)
         {
            _loc1_[_loc2_.currency] = _loc1_[_loc2_.currency] + _loc2_.buyShellsCount * _loc2_.price;
         }
         return _loc1_;
      }

      private function __getEquipmentsPrice() : Prices {
         var _loc3_:EquipmentItem = null;
         var _loc1_:Prices = new Prices();
         var _loc2_:Array = [this.eqItem1,this.eqItem2,this.eqItem3];
         for each (_loc3_ in _loc2_)
         {
            if((_loc3_.selectedItem) && (_loc3_.selectedItem.count == 0) && this.equipmentInstalled.indexOf(_loc3_.selectedItem.compactDescr) == -1)
            {
               _loc1_[_loc3_.selectedItem.currency] = _loc1_[_loc3_.selectedItem.currency] + _loc3_.selectedItem.price;
            }
         }
         return _loc1_;
      }

      private function updateRefillSettings(param1:Event) : void {
         if(this.maintenanceData)
         {
            setRefillSettingsS(this.maintenanceData.vehicleId,this.repairAuto.selected,this.shellsAuto.selected,this.eqAuto.selected);
         }
      }

      private function updatePriceLabels(param1:IconText, param2:IconText, param3:Prices) : void {
         param1.textColor = Currencies.TEXT_COLORS[param3.credits > this.maintenanceData.credits?Currencies.ERROR:Currencies.CREDITS];
         var _loc4_:ILocale = App.utils.locale;
         param1.text = _loc4_.integer((param3.credits) || (0));
         param2.textColor = Currencies.TEXT_COLORS[param3.gold > this.maintenanceData.gold?Currencies.ERROR:Currencies.GOLD];
         param2.text = _loc4_.gold((param3.gold) || (0));
      }

      private function onAmmoPriceChanged(param1:ShellRendererEvent) : void {
         invalidate(ShellRendererEvent.TOTAL_PRICE_CHANGED);
      }

      private function onEquipmentPriceChanged(param1:EquipmentEvent) : void {
         invalidate(ShellRendererEvent.TOTAL_PRICE_CHANGED);
      }

      private function onRepairClick(param1:ButtonEvent) : void {
         repairS();
      }

      private function onApplyClick(param1:ButtonEvent) : void {
         var _loc3_:ShellVO = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:Prices = null;
         var _loc7_:* = false;
         var _loc8_:Prices = null;
         var _loc9_:* = false;
         var _loc2_:* = false;
         for each (_loc3_ in this.maintenanceData.shells)
         {
            if(_loc3_.userCount - _loc3_.count > 0)
            {
               _loc2_ = true;
               break;
            }
         }
         _loc4_ = !_loc2_ && ((this.shellsCountChanged) || (this.eqChanged));
         _loc2_ = (_loc2_ || this.totalPrice.credits - this.maintenanceData.repairCost > 0 || this.totalPrice.gold > 0) || (((this.eqItem1.changed) && (this.eqItem1.selectedItem)) && (this.equipmentInstalled.indexOf(this.eqItem1.selectedItem.compactDescr) == -1)) || ((this.eqItem2.changed) && (this.eqItem2.selectedItem)) && this.equipmentInstalled.indexOf(this.eqItem2.selectedItem.compactDescr) == -1 || ((this.eqItem3.changed) && (this.eqItem3.selectedItem)) && this.equipmentInstalled.indexOf(this.eqItem3.selectedItem.compactDescr) == -1;
         _loc5_ = (this.shellsOrderChanged) || (this.eqOrderChanged);
         _loc6_ = this.__getAmmoPrice();
         _loc7_ = _loc6_.credits > 0 || _loc6_.gold > 0;
         _loc8_ = this.__getEquipmentsPrice();
         _loc9_ = _loc8_.credits > 0 || _loc8_.gold > 0;
         fillVehicleS(this.repairBtn.enabled,_loc7_,_loc9_,_loc2_,_loc4_,_loc5_,this.maintenanceData.shells,[this.eqItem1.selectedItem,this.eqItem2.selectedItem,this.eqItem3.selectedItem]);
      }

      private function onClose(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }

}

   class Prices extends Object
   {
          
      function Prices(param1:Number=undefined, param2:Number=undefined) {
         super();
         this.credits = param1;
         this.gold = param2;
      }

      public var credits:Number = 0;

      public var gold:Number = 0;

      public function toString() : Object {
         return "credits: " + this.credits + ", gold: " + this.gold;
      }
   }
