package net.wg.gui.lobby.hangar.maintenance 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.maintenance.data.*;
    import net.wg.gui.lobby.hangar.maintenance.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class TechnicalMaintenance extends net.wg.infrastructure.base.meta.impl.TechnicalMaintenanceMeta implements net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta
    {
        public function TechnicalMaintenance()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.btnGroup = new scaleform.clik.controls.ButtonGroup("buttonGroup", this);
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
            var loc1:*=App.utils.events;
            loc1.addEvent(this.shells, net.wg.gui.events.ShellRendererEvent.TOTAL_PRICE_CHANGED, this.onAmmoPriceChanged);
            this.autoChBListeners();
            this.subscribeModules();
            loc1.addEvent(this.repairBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onRepairClick);
            loc1.addEvent(this.applyBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onApplyClick);
            loc1.addEvent(this.closeBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            return;
        }

        internal function updatePriceLabels(arg1:net.wg.gui.components.controls.IconText, arg2:net.wg.gui.components.controls.IconText, arg3:Prices):void
        {
            arg1.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[arg3.credits > this.maintenanceData.credits ? net.wg.data.constants.Currencies.ERROR : net.wg.data.constants.Currencies.CREDITS];
            var loc1:*=App.utils.locale;
            arg1.text = loc1.integer(arg3.credits || 0);
            arg2.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[arg3.gold > this.maintenanceData.gold ? net.wg.data.constants.Currencies.ERROR : net.wg.data.constants.Currencies.GOLD];
            arg2.text = loc1.gold(arg3.gold || 0);
            return;
        }

        public function isResetWindow():Boolean
        {
            var loc1:*=true;
            if (this.vehicleIdOld && this.maintenanceData) 
            {
                loc1 = !(this.vehicleIdOld == this.maintenanceData.vehicleId);
            }
            return loc1;
        }

        public function as_setData(arg1:Object):void
        {
            var loc1:*=null;
            if (this.maintenanceData) 
            {
                this.vehicleIdOld = this.maintenanceData.vehicleId;
                loc1 = this.maintenanceData;
            }
            this.maintenanceData = new net.wg.gui.lobby.hangar.maintenance.data.MaintenanceVO(arg1);
            this.updateRepairBlock();
            this.updateShellsBlock();
            this.updateTotalPrice();
            if (loc1) 
            {
                loc1.dispose();
            }
            return;
        }

        public function as_setEquipment(arg1:Array, arg2:Array, arg3:Array):void
        {
            var loc1:*=null;
            if (this.equipmentList) 
            {
                this.equipmentList.splice(0);
            }
            if (this.equipmentSetup) 
            {
                this.equipmentSetup.splice(0);
            }
            if (this.equipmentInstalled) 
            {
                this.equipmentInstalled.splice(0);
            }
            this.equipmentList = [];
            var loc2:*=0;
            var loc3:*=arg3;
            for each (loc1 in loc3) 
            {
                this.equipmentList.push(new net.wg.gui.lobby.hangar.maintenance.data.ModuleVO(loc1));
            }
            this.equipmentSetup = arg2;
            this.equipmentInstalled = arg1;
            invalidate(EQUIPMENT);
            return;
        }

        public function as_onAmmoInstall():void
        {
            return;
        }

        public function as_setCredits(arg1:Number):void
        {
            if (this.maintenanceData) 
            {
                this.maintenanceData.credits = arg1;
                invalidate(MONEY, EQUIPMENT);
            }
            return;
        }

        public function as_setGold(arg1:Number):void
        {
            if (this.maintenanceData) 
            {
                this.maintenanceData.gold = arg1;
                invalidate(MONEY, EQUIPMENT);
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(MONEY)) 
            {
                this.updateRepairBlock();
                this.updateShellsBlock();
            }
            if (isInvalid(EQUIPMENT)) 
            {
                this.updateEquipmentBlock(this.equipmentInstalled, this.equipmentSetup, this.equipmentList);
            }
            if (isInvalid(net.wg.gui.events.ShellRendererEvent.TOTAL_PRICE_CHANGED, MONEY, EQUIPMENT)) 
            {
                this.updateTotalPrice();
            }
            if (invalidate(EQUIPMENT_CHANGED)) 
            {
                getEquipmentS(this.eqItem1.selectedItem ? this.eqItem1.selectedItem.id : undefined, this.eqItem1.selectedItem ? this.eqItem1.selectedItem.currency : undefined, this.eqItem2.selectedItem ? this.eqItem2.selectedItem.id : undefined, this.eqItem2.selectedItem ? this.eqItem2.selectedItem.currency : undefined, this.eqItem3.selectedItem ? this.eqItem3.selectedItem.id : undefined, this.eqItem3.selectedItem ? this.eqItem3.selectedItem.currency : undefined, undefined);
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.title = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_TITLE;
            window.useBottomBtns = true;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.top = loc1.top + 1;
            window.contentPadding = loc1;
            loc1 = window.formBgPadding;
            loc1.top = loc1.top + 585;
            window.formBgPadding = loc1;
            var loc2:*=App.utils.events;
            loc2.addEvent(App.stage, net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, this.onShowModuleInfo);
            loc2.addEvent(App.stage, net.wg.gui.events.ShellRendererEvent.CHANGE_ORDER, this.onChangeOrder);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.maintenanceData.dispose();
            this.maintenanceData = null;
            var loc1:*=App.utils.events;
            loc1.removeEvent(App.stage, net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, this.onShowModuleInfo);
            loc1.removeEvent(App.stage, net.wg.gui.events.ShellRendererEvent.CHANGE_ORDER, this.onChangeOrder);
            loc1.removeEvent(this.shells, net.wg.gui.events.ShellRendererEvent.TOTAL_PRICE_CHANGED, this.onAmmoPriceChanged);
            loc1.removeEvent(this.repairBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onRepairClick);
            loc1.removeEvent(this.applyBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onApplyClick);
            loc1.removeEvent(this.closeBtn, scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.subscribeModules(false);
            this.btnGroup = null;
            this.autoChBListeners(false);
            return;
        }

        internal function subscribeModules(arg1:Boolean=true):void
        {
            var loc2:*=null;
            var loc1:*=[this.eqItem1, this.eqItem2, this.eqItem3];
            var loc3:*=App.utils.events;
            var loc4:*=0;
            var loc5:*=loc1;
            for each (loc2 in loc5) 
            {
                if (arg1) 
                {
                    this.btnGroup.addButton(loc2);
                    loc3.addEvent(loc2, net.wg.gui.events.EquipmentEvent.NEED_UPDATE, this.onEquipmentUpdate);
                    loc3.addEvent(loc2, net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                    loc3.addEvent(loc2, net.wg.gui.events.EquipmentEvent.TOTAL_PRICE_CHANGED, this.onEquipmentPriceChanged);
                    loc3.addEvent(loc2, net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.onEquipmentItemOver);
                    continue;
                }
                this.btnGroup.removeButton(loc2);
                loc3.removeEvent(loc2, net.wg.gui.events.EquipmentEvent.NEED_UPDATE, this.onEquipmentUpdate);
                loc3.removeEvent(loc2, net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                loc3.removeEvent(loc2, net.wg.gui.events.EquipmentEvent.TOTAL_PRICE_CHANGED, this.onEquipmentPriceChanged);
                loc3.removeEvent(loc2, net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.onEquipmentItemOver);
                loc2.dispose();
            }
            return;
        }

        internal function onEquipmentItemOver(arg1:net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=[];
            var loc2:*=[this.eqItem1, this.eqItem2, this.eqItem3];
            var loc5:*=0;
            var loc6:*=loc2;
            for each (loc3 in loc6) 
            {
                loc4 = loc3.selectedItem ? loc3.selectedItem.id : null;
                loc1.push(loc4);
            }
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TECH_MAIN_MODULE, null, arg1.moduleID, arg1.modulePrices, arg1.inventoryCount, arg1.vehicleCount, arg1.moduleIndex, loc1);
            return;
        }

        internal function autoChBListeners(arg1:Boolean=true):void
        {
            var loc2:*=null;
            var loc1:*=[this.repairAuto, this.shellsAuto, this.eqAuto];
            var loc3:*=App.utils.events;
            var loc4:*=0;
            var loc5:*=loc1;
            for each (loc2 in loc5) 
            {
                if (arg1) 
                {
                    loc3.addEvent(loc2, flash.events.Event.SELECT, this.updateRefillSettings);
                    loc3.addEvent(loc2, flash.events.MouseEvent.ROLL_OVER, this.onAutoRollOver);
                    loc3.addEvent(loc2, flash.events.MouseEvent.ROLL_OUT, this.onAutoRollOut);
                    loc3.addEvent(loc2, flash.events.MouseEvent.CLICK, this.onAutoRollOut);
                    continue;
                }
                loc3.removeEvent(loc2, flash.events.Event.SELECT, this.updateRefillSettings);
                loc3.removeEvent(loc2, flash.events.MouseEvent.ROLL_OVER, this.onAutoRollOver);
                loc3.removeEvent(loc2, flash.events.MouseEvent.ROLL_OUT, this.onAutoRollOut);
                loc3.removeEvent(loc2, flash.events.MouseEvent.CLICK, this.onAutoRollOut);
            }
            return;
        }

        internal function onAutoRollOver(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (arg1.target != this.repairAuto) 
            {
                if (arg1.target != this.shellsAuto) 
                {
                    if (arg1.target == this.eqAuto) 
                    {
                        loc1 = TOOLTIPS.EQUIPMENT_AUTO;
                    }
                }
                else 
                {
                    loc1 = TOOLTIPS.AMMO_AUTO;
                }
            }
            else 
            {
                loc1 = TOOLTIPS.REPAIR_AUTO;
            }
            if (loc1) 
            {
                App.toolTipMgr.showComplex(loc1, null);
            }
            return;
        }

        internal function onAutoRollOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function onEquipmentUpdate(arg1:net.wg.gui.events.EquipmentEvent):void
        {
            invalidate(EQUIPMENT_CHANGED);
            return;
        }

        internal function onEquipmentChange(arg1:net.wg.gui.events.EquipmentEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1.changeIndex != -1) 
            {
                loc1 = [this.eqItem1, this.eqItem2, this.eqItem3];
                loc2 = arg1.target as net.wg.gui.lobby.hangar.maintenance.EquipmentItem;
                loc3 = loc1[arg1.changeIndex] as net.wg.gui.lobby.hangar.maintenance.EquipmentItem;
                (loc4 = App.utils.events).removeEvent(loc3, net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                loc4.removeEvent(loc2, net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                loc3.toggleSelectChange(false);
                if (loc2.selectedItem) 
                {
                    loc2.selectedItem.currency = loc3.selectedItem ? loc3.selectedItem.currency : net.wg.data.constants.Values.EMPTY_STR;
                }
                loc3.select.selectedIndex = arg1.changePos;
                if (loc3.selectedItem) 
                {
                    loc3.selectedItem.currency = arg1.changeCurrency;
                }
                loc3.toggleSelectChange(true);
                loc4.addEvent(loc3, net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                loc4.addEvent(loc2, net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                this.eqOrderChanged = true;
            }
            getEquipmentS(this.eqItem1.selectedItem ? this.eqItem1.selectedItem.id : undefined, this.eqItem1.selectedItem ? this.eqItem1.selectedItem.currency : undefined, this.eqItem2.selectedItem ? this.eqItem2.selectedItem.id : undefined, this.eqItem2.selectedItem ? this.eqItem2.selectedItem.currency : undefined, this.eqItem3.selectedItem ? this.eqItem3.selectedItem.id : undefined, this.eqItem3.selectedItem ? this.eqItem3.selectedItem.currency : undefined, (arg1.target as net.wg.gui.lobby.hangar.maintenance.EquipmentItem).index);
            if (!this.eqChanged) 
            {
                !(this.eqChanged == this.eqOrderChanged);
            }
            return;
        }

        internal function updateRepairBlock():void
        {
            var loc2:*=NaN;
            var loc1:*=App.utils.events;
            loc1.removeEvent(this.repairAuto, flash.events.Event.SELECT, this.updateRefillSettings);
            this.repairAuto.selected = this.maintenanceData.autoRepair;
            loc1.addEvent(this.repairAuto, flash.events.Event.SELECT, this.updateRefillSettings);
            this.repairPrice.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[this.maintenanceData.repairCost > this.maintenanceData.credits ? net.wg.data.constants.Currencies.ERROR : net.wg.data.constants.Currencies.CREDITS];
            this.repairPrice.text = App.utils.locale.integer(this.maintenanceData.repairCost);
            this.repairIndicator.maximum = this.maintenanceData.maxRepairCost;
            this.repairIndicator.value = this.maintenanceData.maxRepairCost - this.maintenanceData.repairCost;
            if (this.maintenanceData.maxRepairCost == 0) 
            {
                this.repairIndicator.label = "";
            }
            else 
            {
                loc2 = Math.round((this.maintenanceData.maxRepairCost - this.maintenanceData.repairCost) * 100 / this.maintenanceData.maxRepairCost);
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
                this.repairIndicator.label = loc2 + PERCENT_CHAR;
            }
            return;
        }

        internal function updateShellsBlock(arg1:Boolean=false):void
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (this.isResetWindow()) 
            {
                this.shellsOrderChanged = false;
            }
            else if (!arg1) 
            {
                loc6 = [];
                var loc7:*=0;
                var loc8:*=this.shells.dataProvider;
                for each (loc4 in loc8) 
                {
                    var loc9:*=0;
                    var loc10:*=this.maintenanceData.shells;
                    for each (loc5 in loc10) 
                    {
                        if (loc4.compactDescr != loc5.compactDescr) 
                        {
                            continue;
                        }
                        loc5.setUserCount(loc4.userCount);
                        loc5.possibleMax = loc4.possibleMax;
                        loc5.currency = loc4.currency;
                        loc6.push(loc5);
                    }
                }
                loc7 = 0;
                loc8 = loc6;
                for each (loc5 in loc8) 
                {
                    loc5.list = loc6.slice();
                    loc5.list.splice(loc6.indexOf(loc5), 1);
                }
                this.maintenanceData.shells = loc6;
            }
            if (this.shells.dataProvider != this.maintenanceData.shells) 
            {
                if (this.shells.dataProvider) 
                {
                    this.shells.dataProvider.cleanUp();
                }
                this.shells.dataProvider = new scaleform.clik.data.DataProvider(this.maintenanceData.shells);
            }
            var loc1:*=App.utils.events;
            loc1.removeEvent(this.shellsAuto, flash.events.Event.SELECT, this.updateRefillSettings);
            this.shellsAuto.selected = this.maintenanceData.autoShells;
            loc1.addEvent(this.shellsAuto, flash.events.Event.SELECT, this.updateRefillSettings);
            this.casseteField.text = this.maintenanceData.casseteFieldText;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < this.maintenanceData.shells.length) 
            {
                loc2 = loc2 + this.maintenanceData.shells[loc3].count;
                ++loc3;
            }
            this.shellsIndicator.maximum = this.maintenanceData.maxAmmo;
            this.shellsIndicator.value = this.maintenanceData.maxAmmo - loc2;
            this.shellsIndicator.setDivisor(loc2, this.maintenanceData.maxAmmo);
            this.shellsIndicator.textField.text = loc2 + SPLITTER_CHAR + this.maintenanceData.maxAmmo;
            return;
        }

        internal function updateEquipmentBlock(arg1:Array, arg2:Array, arg3:Array):void
        {
            var loc5:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*;
            (loc1 = App.utils.events).removeEvent(this.eqAuto, flash.events.Event.SELECT, this.updateRefillSettings);
            this.eqAuto.selected = this.maintenanceData.autoEqip;
            loc1.addEvent(this.eqAuto, flash.events.Event.SELECT, this.updateRefillSettings);
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*;
            var loc6:*=(loc4 = [this.eqItem1, this.eqItem2, this.eqItem3]).length;
            var loc9:*=arg3.length;
            var loc10:*=0;
            loc2 = 0;
            while (loc2 < loc6) 
            {
                loc7 = [];
                loc5 = loc4[loc2] as net.wg.gui.lobby.hangar.maintenance.EquipmentItem;
                if (loc2 > 0) 
                {
                    loc3 = 0;
                    while (loc3 < loc9) 
                    {
                        loc8 = arg3[loc3];
                        loc7.push(loc8.clone(loc2));
                        ++loc3;
                    }
                }
                else 
                {
                    loc7 = arg3.slice(0);
                }
                loc5.setData(loc7, loc2, arg2, arg1, this.maintenanceData.credits, this.maintenanceData.gold);
                if (arg1[loc2] != 0) 
                {
                    loc10 = loc10 + 1;
                }
                ++loc2;
            }
            this.eqIndicator.maximum = loc4.length;
            this.eqIndicator.value = loc10;
            this.eqIndicator.setDivisor(loc10, loc4.length);
            this.eqIndicator.textField.text = loc10 + SPLITTER_CHAR + loc4.length;
            return;
        }

        internal function onShowModuleInfo(arg1:net.wg.gui.events.ModuleInfoEvent):void
        {
            showModuleInfoS(arg1.id);
            return;
        }

        internal function onChangeOrder(arg1:net.wg.gui.events.ShellRendererEvent):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=arg1.shell;
            var loc2:*=arg1.shellToReplace;
            if (loc1 && loc2) 
            {
                loc3 = 0;
                loc4 = this.maintenanceData.shells;
                loc5 = [];
                var loc7:*=0;
                var loc8:*=loc4;
                for each (loc6 in loc8) 
                {
                    if (loc6 == loc1) 
                    {
                        loc5.push(loc2);
                        continue;
                    }
                    if (loc6 == loc2) 
                    {
                        loc5.push(loc1);
                        continue;
                    }
                    loc5.push(loc6);
                }
                loc7 = 0;
                loc8 = loc5;
                for each (loc6 in loc8) 
                {
                    loc6.list = loc5.slice();
                    loc6.list.splice(loc5.indexOf(loc6), 1);
                }
                this.maintenanceData.shells = loc5;
                this.updateShellsBlock(true);
                this.shellsOrderChanged = true;
            }
            return;
        }

        internal function updateTotalPrice():void
        {
            var loc1:*=this.__getAmmoPrice();
            this.updatePriceLabels(this.shellsTotalCredits, this.shellsTotalGold, loc1);
            var loc2:*=this.__getEquipmentsPrice();
            this.updatePriceLabels(this.eqTotalCredits, this.eqTotalGold, loc2);
            this.totalPrice = new Prices(loc1.credits + loc2.credits + this.maintenanceData.repairCost, loc1.gold + loc2.gold);
            this.updatePriceLabels(this.totalCredits, this.totalGold, this.totalPrice);
            this.updateButtonStates();
            return;
        }

        internal function updateButtonStates():void
        {
            var loc3:*=null;
            var loc7:*=null;
            this.repairBtn.enabled = !(this.maintenanceData.repairCost == 0) && this.maintenanceData.repairCost <= this.maintenanceData.credits;
            this.buy_ammo = true;
            var loc1:*=0;
            var loc2:*=this.__getAmmoPrice();
            this.shellsCountChanged = false;
            var loc8:*=0;
            var loc9:*=this.maintenanceData.shells;
            for each (loc3 in loc9) 
            {
                loc1 = loc1 + loc3.userCount;
                if (loc3.userCount == loc3.count) 
                {
                    continue;
                }
                this.shellsCountChanged = true;
            }
            if (this.shellsOrderChanged && this.maintenanceData.gold >= loc2.gold && this.maintenanceData.credits >= loc2.credits) 
            {
                this.buy_ammo = false;
            }
            this.shellsIndicator.maximum = this.maintenanceData.maxAmmo;
            this.shellsIndicator.value = loc1;
            this.shellsIndicator.label = loc1 + SPLITTER_CHAR + this.maintenanceData.maxAmmo;
            var loc4:*=this.__getEquipmentsPrice();
            var loc5:*=0;
            var loc6:*=[this.eqItem1, this.eqItem2, this.eqItem3];
            loc8 = 0;
            loc9 = loc6;
            for each (loc7 in loc9) 
            {
                if (!loc7.selectedItem) 
                {
                    continue;
                }
                loc5 = loc5 + 1;
            }
            this.eqIndicator.value = loc5;
            this.eqIndicator.label = loc5 + SPLITTER_CHAR + 3;
            this.applyBtn.enabled = this.maintenanceData.credits >= this.totalPrice.credits && this.maintenanceData.gold >= this.totalPrice.gold;
            return;
        }

        internal function __getAmmoPrice():Prices
        {
            var loc2:*=null;
            var loc1:*=new Prices();
            var loc3:*=0;
            var loc4:*=this.maintenanceData.shells;
            for each (loc2 in loc4) 
            {
                loc1[loc2.currency] = loc1[loc2.currency] + loc2.buyShellsCount * loc2.price;
            }
            return loc1;
        }

        internal function __getEquipmentsPrice():Prices
        {
            var loc3:*=null;
            var loc1:*=new Prices();
            var loc2:*=[this.eqItem1, this.eqItem2, this.eqItem3];
            var loc4:*=0;
            var loc5:*=loc2;
            for each (loc3 in loc5) 
            {
                if (!(loc3.selectedItem && loc3.selectedItem.count == 0 && this.equipmentInstalled.indexOf(loc3.selectedItem.compactDescr) == -1)) 
                {
                    continue;
                }
                loc1[loc3.selectedItem.currency] = loc1[loc3.selectedItem.currency] + loc3.selectedItem.price;
            }
            return loc1;
        }

        internal function updateRefillSettings(arg1:flash.events.Event):void
        {
            if (this.maintenanceData) 
            {
                setRefillSettingsS(this.maintenanceData.vehicleId, this.repairAuto.selected, this.shellsAuto.selected, this.eqAuto.selected);
            }
            return;
        }

        internal function onAmmoPriceChanged(arg1:net.wg.gui.events.ShellRendererEvent):void
        {
            invalidate(net.wg.gui.events.ShellRendererEvent.TOTAL_PRICE_CHANGED);
            return;
        }

        internal function onEquipmentPriceChanged(arg1:net.wg.gui.events.EquipmentEvent):void
        {
            invalidate(net.wg.gui.events.ShellRendererEvent.TOTAL_PRICE_CHANGED);
            return;
        }

        internal function onRepairClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            repairS();
            return;
        }

        internal function onApplyClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=false;
            var loc7:*=null;
            var loc8:*=false;
            var loc1:*=false;
            var loc9:*=0;
            var loc10:*=this.maintenanceData.shells;
            for each (loc2 in loc10) 
            {
                if (!(loc2.userCount - loc2.count)) 
                {
                    continue;
                }
                loc1 = true;
                break;
            }
            loc1 = loc1 || this.totalPrice.credits - this.maintenanceData.repairCost > 0 || this.totalPrice.gold > 0 || this.eqItem1.changed && this.eqItem1.selectedItem && this.equipmentInstalled.indexOf(this.eqItem1.selectedItem.compactDescr) == -1 || this.eqItem2.changed && this.eqItem2.selectedItem && this.equipmentInstalled.indexOf(this.eqItem2.selectedItem.compactDescr) == -1 || this.eqItem3.changed && this.eqItem3.selectedItem && this.equipmentInstalled.indexOf(this.eqItem3.selectedItem.compactDescr) == -1;
            loc3 = !loc1 && (this.shellsCountChanged || this.eqChanged);
            loc4 = this.shellsOrderChanged || this.eqOrderChanged;
            loc6 = (loc5 = this.__getAmmoPrice()).credits > 0 || loc5.gold > 0;
            loc8 = (loc7 = this.__getEquipmentsPrice()).credits > 0 || loc7.gold > 0;
            fillVehicleS(this.repairBtn.enabled, loc6, loc8, loc1, loc3, loc4, this.maintenanceData.shells, [this.eqItem1.selectedItem, this.eqItem2.selectedItem, this.eqItem3.selectedItem]);
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal static const PERCENT_CHAR:String="%";

        internal static const SPLITTER_CHAR:String="/";

        internal static const MONEY:String="money";

        internal static const EQUIPMENT:String="equipment";

        internal static const EQUIPMENT_CHANGED:String="equipmentChanged";

        internal var buy_equips:Boolean=false;

        internal var equipmentList:Array;

        public var shellsHeaderInventory:flash.text.TextField;

        internal var equipmentInstalled:Array;

        internal var eqChanged:Boolean=false;

        internal var eqOrderChanged:Boolean=false;

        public var repairTextfield:flash.text.TextField;

        public var repairIndicator:net.wg.gui.lobby.hangar.maintenance.MaintenanceStatusIndicator;

        public var repairAuto:net.wg.gui.components.controls.CheckBox;

        public var repairPrice:net.wg.gui.components.controls.IconText;

        public var repairBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var shellsTextfield:flash.text.TextField;

        internal var equipmentSetup:Array;

        public var casseteField:flash.text.TextField;

        public var shellsIndicator:net.wg.gui.lobby.hangar.maintenance.MaintenanceStatusIndicator;

        public var shellsAuto:net.wg.gui.components.controls.CheckBox;

        public var shellsHeaderBuy:flash.text.TextField;

        public var shellsHeaderPrice:flash.text.TextField;

        public var shellsTotalGold:net.wg.gui.components.controls.IconText;

        public var shellsTotalCredits:net.wg.gui.components.controls.IconText;

        public var shells:net.wg.gui.components.controls.ScrollingListEx;

        public var eqTextfield:flash.text.TextField;

        public var eqIndicator:net.wg.gui.lobby.hangar.maintenance.MaintenanceStatusIndicator;

        public var eqAuto:net.wg.gui.components.controls.CheckBox;

        public var eqHeaderInventory:flash.text.TextField;

        public var eqHeaderBuy:flash.text.TextField;

        public var eqHeaderPrice:flash.text.TextField;

        public var eqTotalGold:net.wg.gui.components.controls.IconText;

        public var eqTotalCredits:net.wg.gui.components.controls.IconText;

        public var eqItem1:net.wg.gui.lobby.hangar.maintenance.EquipmentItem;

        public var eqItem2:net.wg.gui.lobby.hangar.maintenance.EquipmentItem;

        public var eqItem3:net.wg.gui.lobby.hangar.maintenance.EquipmentItem;

        protected var btnGroup:scaleform.clik.controls.ButtonGroup;

        public var totalGold:net.wg.gui.components.controls.IconText;

        public var applyBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var totalCredits:net.wg.gui.components.controls.IconText;

        public var labelTotal:flash.text.TextField;

        internal var maintenanceData:net.wg.gui.lobby.hangar.maintenance.data.MaintenanceVO;

        internal var vehicleIdOld:String;

        internal var totalPrice:Prices;

        internal var shellsCountChanged:Boolean=false;

        internal var shellsOrderChanged:Boolean=false;

        internal var buy_ammo:Boolean=false;
    }
}


class Prices extends Object
{
    public function Prices(arg1:Number=0, arg2:Number=0)
    {
        super();
        this.credits = arg1;
        this.gold = arg2;
        return;
    }

    public var credits:Number=0;

    public var gold:Number=0;
}