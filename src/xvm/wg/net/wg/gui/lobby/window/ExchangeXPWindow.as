package net.wg.gui.lobby.window 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ExchangeXPWindow extends net.wg.gui.lobby.window.BaseExchangeWindow implements net.wg.infrastructure.base.meta.IExchangeXpWindowMeta
    {
        public function ExchangeXPWindow()
        {
            super();
            isModal = false;
            canResize = false;
            canMinimize = false;
            isCentered = true;
            return;
        }

        protected override function configUI():void
        {
            var loc2:*=NaN;
            super.configUI();
            this.lblTotalAvailableXp.autoSize = flash.text.TextFieldAutoSize.RIGHT;
            this.nsXpExchange.minimum = 0;
            this.nsGoldExchange.minimum = 0;
            this.nsGoldExchange.stepSize = 1;
            this.nsXpExchange.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsXpChangeHandler, false, 0, true);
            this.nsGoldExchange.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsGoldChangeHandler, false, 0, true);
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, cancelBtnClickHandler, false, 0, true);
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler, false, 0, true);
            addEventListener(net.wg.gui.lobby.window.ExchangeXPFromVehicleIR.SELECTION_CHANGED, this.selectionIRChanged, false, 0, true);
            this.scrollList.rowCount = 7;
            this.cbSelectAll.addEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler, false, 0, true);
            this.buttonBar.addEventListener(net.wg.gui.components.advanced.SortingButton.SORT_DIRECTION_CHANGED, this.sortingDirectionChanged, false, 0, true);
            this.buttonBar.selectedIndex = 1;
            this.scrollList.sortByVehicleName(true);
            this.itGoldBefore.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.itGoldBefore.icon);
            this.itGoldResult.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.itGoldResult.icon);
            this.headerMC.rate_part_2.icon = net.wg.gui.components.controls.IconText.ELITE_XP;
            this.headerMC.rate_part_2.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.headerMC.rate_part_2.icon);
            var loc1:*=App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_FREE_XP);
            this.headerMC.rate_part_2.textColor = loc1;
            this.itExperienceResult.textColor = loc1;
            this.itExperienceBefore.textColor = loc1;
            this.nsXpExchange.textColor = loc1;
            loc2 = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_GOLD);
            this.headerMC.rate_part_1.textColor = loc2;
            this.headerMC.rate_part_1.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.headerMC.rate_part_1.icon);
            this.itGoldResult.textColor = loc2;
            this.itGoldBefore.textColor = loc2;
            this.nsGoldExchange.textColor = loc2;
            this.itIconXp.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.itIconXp.icon);
            this.itIconGold.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.itIconGold.icon);
            this.itGoldResult.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.itGoldResult.icon);
            this.itGoldBefore.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(this.itGoldBefore.icon);
            this.itTotalAvailableXp.textColor = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_CREDITS);
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            var loc1:*=null;
            super.window = arg1;
            if (window) 
            {
                window.title = MENU.EXCHANGEXP_TITLE;
                loc1 = new scaleform.clik.utils.Padding();
                loc1.top = 33;
                loc1.bottom = this.cancelBtn.height + 20;
                loc1.right = 11;
                loc1.left = 10;
                window.formBgPadding = loc1;
            }
            return;
        }

        public function as_vehiclesDataChanged(arg1:Boolean, arg2:Array):void
        {
            var isHaveElite:Boolean;
            var data_:Array;
            var vehicleInfo:net.wg.gui.lobby.window.ExchangeXPVehicleVO;
            var object:Object;
            var lng:uint;
            var i:int;

            var loc1:*;
            vehicleInfo = null;
            object = null;
            lng = 0;
            i = 0;
            isHaveElite = arg1;
            data_ = arg2;
            try 
            {
                this.scrollListProvider = [];
                this.isHaveEliteVehicles = isHaveElite;
                if (this.isHaveEliteVehicles) 
                {
                    lng = data_.length;
                    i = 0;
                    while (i < lng) 
                    {
                        object = data_[i];
                        vehicleInfo = new net.wg.gui.lobby.window.ExchangeXPVehicleVO(object);
                        this.scrollListProvider.push(vehicleInfo);
                        ++i;
                    }
                }
                invalidate(VEHICLES_DATA_INVALID);
            }
            catch (e:Error)
            {
                DebugUtils.LOG_DEBUG("Flash \'as_vehiclesDataChanged\' method ERROR:  ", e.message, e.getStackTrace());
            }
            return;
        }

        public function as_totalExperienceChanged(arg1:Number):void
        {
            this.totalXP = arg1;
            var loc1:*=App.utils ? App.utils.locale : null;
            this.itExperienceBefore.text = loc1 ? loc1.gold(this.totalXP) : this.totalXP.toString();
            invalidate(TOTAL_RESULT_INVALID);
            return;
        }

        internal function submitBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc2:*=null;
            var loc1:*=[];
            var loc3:*=0;
            while (loc3 < this.scrollListProvider.length) 
            {
                loc2 = net.wg.gui.lobby.window.ExchangeXPVehicleVO(this.scrollListProvider[loc3]);
                if (loc2.isSelectCandidate) 
                    loc1.push(loc2.id);
                ++loc3;
            }
            App.utils.asserter.assert(loc1.length > 0, "Flash Asserter warning: Exchange XP Window submit method have empty data array");
            var loc4:*={"exchangeXp":this.nsXpExchange.value, "selectedVehicles":loc1};
            exchangeS(loc4);
            return;
        }

        internal function selectionIRChanged(arg1:flash.events.Event):void
        {
            arg1.stopImmediatePropagation();
            invalidate(TOTAL_AVAILABLE_XP_INVALID);
            return;
        }

        internal function nsXpChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.selectedGold = Math.floor(this.nsXpExchange.value / actualRate);
            invalidate(TOTAL_RESULT_INVALID);
            return;
        }

        internal function nsGoldChangeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.selectedGold = this.nsGoldExchange.value;
            invalidate(TOTAL_RESULT_INVALID);
            return;
        }

        internal function sortingDirectionChanged(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            arg1.stopImmediatePropagation();
            var loc1:*=net.wg.gui.components.advanced.SortingButton(arg1.target);
            var loc2:*=loc1.sortDirection == net.wg.gui.components.advanced.SortingButton.ASCENDING_SORT;
            if (loc1.sortDirection != net.wg.gui.components.advanced.SortingButton.WITHOUT_SORT) 
                if ("btnOk" != loc1.id) 
                    if ("btnTank" != loc1.id) 
                        if ("btnStar" != loc1.id) 
                        {
                            loc3 = "FLASH::Unexpected sorting button id! " + this;
                            DebugUtils.LOG_ERROR(loc3);
                            throw new Error(loc3);
                        }
                        else 
                            this.scrollList.sortByExperience(loc2);
                    else 
                        this.scrollList.sortByVehicleName(loc2);
                else 
                    this.scrollList.sortSelection(loc2);
            return;
        }

        internal function checkBoxSelectHandler(arg1:flash.events.Event):void
        {
            this.scrollList.applySelection(this.cbSelectAll.selected);
            invalidate(TOTAL_AVAILABLE_XP_INVALID);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, cancelBtnClickHandler);
            this.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler);
            removeEventListener(net.wg.gui.lobby.window.ExchangeXPFromVehicleIR.SELECTION_CHANGED, this.selectionIRChanged);
            this.nsXpExchange.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsXpChangeHandler);
            this.nsGoldExchange.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.nsGoldChangeHandler);
            this.buttonBar.removeEventListener(net.wg.gui.components.advanced.SortingButton.SORT_DIRECTION_CHANGED, this.sortingDirectionChanged);
            return;
        }

        protected override function applyRatesChanges():void
        {
            this.headerMC.setRates(rate, actionRate);
            invalidate(TOTAL_RESULT_INVALID);
            return;
        }

        protected override function applyPrimaryCurrencyChange():void
        {
            var loc1:*=App.utils ? App.utils.locale : null;
            this.itGoldBefore.text = loc1 ? loc1.gold(totalPrimaryCurrency) : totalPrimaryCurrency.toString();
            invalidate(TOTAL_AVAILABLE_XP_INVALID);
            return;
        }

        protected override function draw():void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=false;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=0;
            var loc9:*=0;
            super.draw();
            if (isInvalid(VEHICLES_DATA_INVALID)) 
            {
                this.scrollList.dataProvider = new scaleform.clik.data.DataProvider(this.scrollListProvider);
                if (this.isHaveEliteVehicles) 
                    if (this.scrollListProvider == null || this.scrollListProvider.length == 0) 
                    {
                        this.warningScreen.text = App.utils.locale.makeString(DIALOGS.EXCHANGEXPWINDOW_ERROR_NOVEHICLESWITHXP);
                        this.warningScreen.visible = true;
                    }
                    else 
                        this.warningScreen.visible = false;
                else 
                {
                    this.warningScreen.text = App.utils.locale.makeString(DIALOGS.EXCHANGEXPWINDOW_ERROR_NOELITEVEHICLEINHANGAR);
                    this.warningScreen.visible = true;
                }
                invalidate(TOTAL_AVAILABLE_XP_INVALID);
            }
            var loc1:*=App.utils ? App.utils.locale : null;
            if (isInvalid(TOTAL_AVAILABLE_XP_INVALID)) 
            {
                loc2 = 0;
                loc3 = 0;
                loc5 = true;
                if (this.scrollListProvider) 
                {
                    loc6 = this.scrollListProvider.length;
                    loc8 = 0;
                    while (loc8 < loc6) 
                    {
                        loc4 = (loc7 = this.scrollListProvider[loc8]).xp;
                        if (loc7.isSelectCandidate) 
                            loc3 = loc3 + loc4;
                        loc5 = loc5 && loc7.isSelectCandidate;
                        loc2 = loc2 + loc4;
                        ++loc8;
                    }
                }
                this.cbSelectAll.removeEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler);
                this.cbSelectAll.selected = loc5;
                this.cbSelectAll.addEventListener(flash.events.Event.SELECT, this.checkBoxSelectHandler, false, 0, true);
                this.itTotalAvailableXp.text = loc1 ? loc1.gold(loc2) : loc2.toString();
                this.itTotalAvailableXp.textField.text = loc1 ? loc1.gold(loc2) : loc2.toString();
                this.selectedGold = Math.min(loc3 / actualRate, totalPrimaryCurrency);
                this.nsGoldExchange.maximum = this.selectedGold;
                this.nsXpExchange.maximum = this.selectedGold * actualRate;
                invalidate(TOTAL_RESULT_INVALID);
            }
            if (isInvalid(TOTAL_RESULT_INVALID)) 
            {
                this.nsXpExchange.stepSize = actualRate;
                this.nsGoldExchange.value = this.selectedGold;
                loc9 = this.selectedGold * actualRate;
                this.nsXpExchange.value = loc9;
                this.itGoldResult.text = loc1 ? loc1.gold(totalPrimaryCurrency - this.selectedGold) : (totalPrimaryCurrency - this.selectedGold).toString();
                this.itExperienceResult.text = loc1 ? loc1.gold(this.totalXP + loc9) : (this.totalXP + loc9).toString();
                this.submitBtn.enabled = !(this.selectedGold == 0);
                this.buttonBar.enabled = this.scrollList.dataProvider.length > 0;
                this.lblTotalAvailableXp.x = this.itTotalAvailableXp.x + this.itTotalAvailableXp.width - this.itTotalAvailableXp.iconClip.width - this.itTotalAvailableXp.textField.textWidth - this.lblTotalAvailableXp.width - 13;
            }
            return;
        }

        internal static const TOTAL_AVAILABLE_XP_INVALID:String="totalAvailXP";

        internal static const TOTAL_RESULT_INVALID:String="resAll";

        internal static const VEHICLES_DATA_INVALID:String="listInv";

        public var buttonBar:net.wg.gui.components.advanced.SortableHeaderButtonBar;

        public var lblTotalAvailableXp:flash.text.TextField;

        public var itTotalAvailableXp:net.wg.gui.components.controls.IconText;

        public var cbSelectAll:net.wg.gui.components.controls.CheckBox;

        internal var scrollListProvider:Array;

        public var headerMC:net.wg.gui.lobby.window.ExchangeHeader;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var scrollList:net.wg.gui.lobby.window.ExchangeXPList;

        public var itExperienceBefore:net.wg.gui.components.controls.IconText;

        public var itGoldBefore:net.wg.gui.components.controls.IconText;

        public var itGoldResult:net.wg.gui.components.controls.IconText;

        public var itExperienceResult:net.wg.gui.components.controls.IconText;

        public var warningScreen:net.wg.gui.lobby.window.ExchangeXPWarningScreen;

        public var itIconGold:net.wg.gui.components.controls.IconText;

        public var itIconXp:net.wg.gui.components.controls.IconText;

        public var nsGoldExchange:net.wg.gui.components.controls.NumericStepper;

        public var nsXpExchange:net.wg.gui.components.controls.NumericStepper;

        internal var totalXP:Number=0;

        internal var selectedGold:uint;

        internal var isHaveEliteVehicles:Boolean;
    }
}
