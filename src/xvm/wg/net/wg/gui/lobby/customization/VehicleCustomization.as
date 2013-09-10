package net.wg.gui.lobby.customization 
{
    import flash.display.*;
    import flash.ui.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.customization.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    
    public class VehicleCustomization extends net.wg.infrastructure.base.meta.impl.VehicleCustomizationMeta implements net.wg.infrastructure.base.meta.IVehicleCustomizationMeta
    {
        public function VehicleCustomization()
        {
            super();
            _instance = this;
            this._sectionsDataProvider = new scaleform.clik.data.DataProvider();
            this._priceDataProvider = new scaleform.clik.data.DataProvider();
            this.camouflageDP = new net.wg.gui.lobby.customization.data.CamouflagesDataProvider([]);
            this.emblemLeftDP = new net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider([]);
            this.emblemRightDP = new net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider([]);
            this.inscriptionLeftDP = new net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider([]);
            this.inscriptionRightDP = new net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider([]);
            this.camouflageGroupsDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.camouflageRentalPackageDP = new net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider();
            this.emblemLeftGroupsDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.emblemRightGroupsDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.emblemLeftRentalPackageDP = new net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider();
            this.emblemRightRentalPackageDP = new net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider();
            this.inscriptionLeftGroupsDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.inscriptionRightGroupsDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.inscriptionLeftRentalPackageDP = new net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider();
            this.inscriptionRightRentalPackageDP = new net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider();
            this._sectionsData = {};
            return;
        }

        public function showView(arg1:String):flash.display.MovieClip
        {
            return this.currentView.show(arg1);
        }

        internal function onWindowClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            closeWindowS();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=arg1.details;
            if (arg1.details.code == flash.ui.Keyboard.ESCAPE && loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                arg1.handled = true;
                closeWindowS();
            }
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            y = arg2 - this.background.height + 13;
            return;
        }

        public function as_onServerResponsesReceived():void
        {
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < this._priceDataProvider.length) 
            {
                loc1 = this._priceDataProvider[loc2];
                loc1.price = null;
                loc1.selected = false;
                loc1.enabled = false;
                ++loc2;
            }
            this._priceDataProvider.invalidate();
            this.totalCreditsField.textColor = this.textColor;
            this.totalCreditsField.text = App.utils.locale.integer(0);
            this.totalGoldField.textColor = this.textColor;
            this.totalGoldField.text = App.utils.locale.gold(0);
            this._sectionsData = {};
            this.applyButton.enabled = false;
            return;
        }

        public function as_onInit(arg1:Array):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1.length > 0) 
            {
                loc2 = arg1.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    loc4 = (loc3 = arg1[loc1]).sectionName;
                    this._sectionsDataProvider.push({"label":loc3.sectionLabel, "section":loc4, "data":loc4 + this.SECTION_VIEW, "linkage":loc3.linkage, "enabled":loc3.enabled});
                    this._priceDataProvider.push({"label":loc3.priceLabel, "section":loc4, "price":{"isGold":false, "cost":0}, "selected":false, "enabled":false});
                    ++loc1;
                }
                this.accordion.invalidate();
                this._priceDataProvider.invalidate();
            }
            return;
        }

        public function as_setActionsLocked(arg1:Boolean):void
        {
            if (this._actionsLocked == arg1) 
            {
                return;
            }
            this._actionsLocked = arg1;
            this.calculateTotalPrice();
            var loc1:*=new net.wg.gui.lobby.customization.CustomizationEvent(net.wg.gui.lobby.customization.CustomizationEvent.CHANGE_ACTIONS_LOCK);
            loc1.locked = arg1;
            dispatchEvent(loc1);
            return;
        }

        public function as_onChangeSuccess():void
        {
            this.accordion.view.currentView.onChangeSuccess();
            return;
        }

        public function as_onCurrentChanged(arg1:String):void
        {
            if (arg1 == this._sectionsDataProvider[this.accordion.selectedIndex].section) 
            {
                this.accordion.view.currentView.onCurrentChanged();
            }
            return;
        }

        public function as_onDropSuccess():void
        {
            this.accordion.view.currentView.onDropSuccess();
            return;
        }

        public function as_onResetNewItem():void
        {
            this.as_onServerResponsesReceived();
            dispatchEvent(new net.wg.gui.lobby.customization.CustomizationEvent(net.wg.gui.lobby.customization.CustomizationEvent.RESET_NEW_ITEM));
            return;
        }

        public function as_setCredits(arg1:Number):void
        {
            this._accountCredits = arg1;
            this.calculateTotalPrice();
            return;
        }

        public function as_setGold(arg1:Number):void
        {
            this._accountGold = arg1;
            this.calculateTotalPrice();
            return;
        }

        public function isActionsLocked():Boolean
        {
            return this._actionsLocked;
        }

        public function getSectionData(arg1:String):Object
        {
            return this._sectionsData[arg1];
        }

        public function resetSectionData(arg1:String):void
        {
            this._sectionsData[arg1] = null;
            return;
        }

        public function setSectionData(arg1:String, arg2:Boolean, arg3:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=false;
            this._sectionsData[arg1] = arg3;
            var loc3:*=[];
            var loc4:*=[];
            loc5 = 0;
            while (loc5 < this._priceDataProvider.length) 
            {
                if ((loc7 = this._priceDataProvider[loc5]).hasOwnProperty("fake") && loc7.section == arg1) 
                {
                    loc2 = loc7;
                    break;
                }
                ++loc5;
            }
            if (loc2 != null) 
            {
                this._priceDataProvider.splice(loc5, 1);
                loc2 = null;
            }
            loc5 = 0;
            while (loc5 < this._priceDataProvider.length) 
            {
                if ((loc7 = this._priceDataProvider[loc5]).section == arg1) 
                {
                    if (arg3.price is Array && arg3.price.length > 0) 
                    {
                        loc6 = 0;
                        while (loc6 < arg3.price.length) 
                        {
                            if ((loc1 = arg3.price[loc6]).isGold) 
                            {
                                loc3.push(loc1);
                            }
                            else 
                            {
                                loc4.push(loc1);
                            }
                            ++loc6;
                        }
                        if (loc3.length > 0 && loc4.length > 0) 
                        {
                            loc2 = {"label":loc7.label, "section":loc7.section, "price":this.getSummCost(loc4), "selected":true, "enabled":true, "fake":true};
                            loc7.price = this.getSummCost(loc3);
                        }
                        else 
                        {
                            loc7.price = this.getSummCost(arg3.price);
                        }
                    }
                    else 
                    {
                        loc7.price = arg3.price;
                    }
                    loc7.selected = arg2;
                    if (arg3.hasOwnProperty("selectedItems")) 
                    {
                        loc9 = false;
                        var loc10:*=0;
                        var loc11:*=arg3.selectedItems;
                        for each (loc8 in loc11) 
                        {
                            if (loc8) 
                            {
                                loc9 = loc8.id > 0;
                            }
                            if (!loc9) 
                            {
                                continue;
                            }
                            break;
                        }
                        loc7.enabled = loc9;
                    }
                    else 
                    {
                        loc7.enabled = arg3._new.id > 0;
                    }
                }
                ++loc5;
            }
            if (loc2 != null) 
            {
                this._priceDataProvider.splice(0, 0, loc2);
            }
            this._priceDataProvider.invalidate();
            this.calculateTotalPrice();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            App.stage.dispatchEvent(new net.wg.gui.events.LobbyEvent(net.wg.gui.events.LobbyEvent.REGISTER_DRAGGING));
            this.windowCloseButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onWindowClose);
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onWindowClose);
            this.accordion.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onViewChange, false, -100);
            this.accordion.view.cache = true;
            this.accordion.buttonWidth = this.accordion.width;
            this.accordion.dataProvider = this._sectionsDataProvider;
            this.accordion.selectedIndex = 0;
            this.priceList.dataProvider = this._priceDataProvider;
            this.priceList.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.handleClickPriceItem);
            this.applyButton.enabled = false;
            this.applyButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClickApplyButton);
            App.utils.focusHandler.setFocus(this.closeButton);
            return;
        }

        protected override function onDispose():void
        {
            App.stage.dispatchEvent(new net.wg.gui.events.LobbyEvent(net.wg.gui.events.LobbyEvent.UNREGISTER_DRAGGING));
            this.windowCloseButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onWindowClose);
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onWindowClose);
            this.applyButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClickApplyButton);
            this.accordion.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onViewChange);
            this.priceList.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.handleClickPriceItem);
            this.accordion.dispose();
            this.currentView.dispose();
            this.priceList.dataProvider = null;
            this.priceList.invalidateRenderers();
            _instance = null;
            this._sectionsDataProvider.cleanUp();
            this._sectionsDataProvider = null;
            this._priceDataProvider.cleanUp();
            this._priceDataProvider = null;
            this.camouflageDP = null;
            this.emblemLeftDP = null;
            this.emblemRightDP = null;
            this.inscriptionLeftDP = null;
            this.inscriptionRightDP = null;
            this.camouflageGroupsDataProvider = null;
            this.camouflageRentalPackageDP = null;
            this.emblemLeftGroupsDataProvider = null;
            this.emblemRightGroupsDataProvider = null;
            this.emblemLeftRentalPackageDP = null;
            this.emblemRightRentalPackageDP = null;
            this.inscriptionLeftGroupsDataProvider = null;
            this.inscriptionRightGroupsDataProvider = null;
            this.inscriptionLeftRentalPackageDP = null;
            this.inscriptionRightRentalPackageDP = null;
            this._sectionsData = null;
            this._selectedSections.splice(0);
            this._selectedSections = null;
            super.onDispose();
            return;
        }

        internal function onViewChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            if (this.accordion.view.currentView && this.accordion.view.currentView.initialized) 
            {
                this.showView(this.accordion.view.currentView.getViewLinkage());
                this.accordion.view.currentView.requestCurrentItem();
            }
            return;
        }

        internal function handleClickPriceItem(arg1:Object):void
        {
            this.calculateTotalPrice();
            return;
        }

        internal function onClickApplyButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            applyCustomizationS(this._selectedSections);
            return;
        }

        internal function getSummCost(arg1:Array):Object
        {
            var loc3:*=null;
            var loc1:*={"isGold":false, "cost":0};
            var loc2:*=0;
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                loc3 = arg1[loc2];
                loc1.isGold = loc3.isGold;
                loc1.cost = loc1.cost + loc3.cost;
                ++loc2;
            }
            return loc1;
        }

        internal function calculateTotalPrice():void
        {
            var loc6:*=null;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=null;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=false;
            var loc4:*=true;
            var loc5:*=true;
            this._selectedSections = [];
            var loc7:*=0;
            while (loc7 < this._priceDataProvider.length) 
            {
                if ((loc8 = this._priceDataProvider[loc7]).selected) 
                {
                    loc3 = false;
                    if ((loc6 = loc8.price) != null) 
                    {
                        if (loc6 is Array) 
                        {
                            loc9 = 0;
                            while (loc9 < loc6.lengh) 
                            {
                                if ((loc10 = loc6[loc9]) != null) 
                                {
                                    if (loc6.isGold) 
                                    {
                                        loc3 = true;
                                        loc2 = loc2 + loc10.cost;
                                    }
                                    else 
                                    {
                                        loc1 = loc1 + loc10.cost;
                                    }
                                }
                                ++loc9;
                            }
                        }
                        else if (loc6.isGold) 
                        {
                            loc3 = true;
                            loc2 = loc2 + loc6.cost;
                        }
                        else 
                        {
                            loc1 = loc1 + loc6.cost;
                        }
                    }
                    this._selectedSections.push({"sectionName":loc8.section, "isGold":loc3});
                }
                ++loc7;
            }
            if (loc1 <= this._accountCredits) 
            {
                this.totalCreditsField.textColor = this.textColor;
            }
            else 
            {
                this.totalCreditsField.textColor = this.errorColor;
                loc4 = false;
            }
            if (loc2 <= this._accountGold) 
            {
                this.totalGoldField.textColor = this.textColor;
            }
            else 
            {
                this.totalGoldField.textColor = this.errorColor;
                loc5 = false;
            }
            this.totalCreditsField.text = App.utils.locale.integer(loc1);
            this.totalGoldField.text = App.utils.locale.gold(loc2);
            this.applyButton.enabled = !this._actionsLocked && loc5 && loc4 && loc1 >= 0 && loc2 >= 0 && this._selectedSections.length > 0;
            return;
        }

        public static function get instance():net.wg.gui.lobby.customization.VehicleCustomization
        {
            return _instance;
        }

        
        {
            _instance = null;
        }

        internal const SECTION_VIEW:String="SectionView";

        public var inscriptionRightGroupsDataProvider:net.wg.data.daapi.base.DAAPIDataProvider=null;

        internal var _sectionsDataProvider:scaleform.clik.data.DataProvider=null;

        internal var _priceDataProvider:scaleform.clik.data.DataProvider=null;

        public var accordion:net.wg.gui.components.advanced.Accordion=null;

        internal var _sectionsData:Object=null;

        internal var _actionsLocked:Boolean=false;

        internal var _accountCredits:Number;

        internal var _accountGold:Number;

        public var textColor:Number=16777215;

        public var errorColor:Number=16711680;

        internal var _selectedSections:Array=null;

        public var background:flash.display.MovieClip=null;

        public var titleBtn:net.wg.gui.components.controls.TextFieldShort=null;

        public var windowCloseButton:net.wg.gui.components.controls.CloseButton=null;

        public var currentView:net.wg.gui.components.advanced.ViewStack=null;

        public var priceList:net.wg.gui.components.controls.TileList=null;

        public var totalCreditsField:net.wg.gui.components.controls.IconText=null;

        public var totalGoldField:net.wg.gui.components.controls.IconText=null;

        public var applyButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var closeButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var camouflageDP:net.wg.gui.lobby.customization.data.CamouflagesDataProvider=null;

        public var emblemLeftDP:net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider=null;

        public var emblemRightDP:net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider=null;

        public var inscriptionLeftDP:net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider=null;

        public var inscriptionRightDP:net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider=null;

        public var camouflageRentalPackageDP:net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider=null;

        public var emblemLeftRentalPackageDP:net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider=null;

        public var camouflageGroupsDataProvider:net.wg.data.daapi.base.DAAPIDataProvider=null;

        public var emblemRightRentalPackageDP:net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider=null;

        public var inscriptionLeftRentalPackageDP:net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider=null;

        public var inscriptionRightRentalPackageDP:net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider=null;

        public var emblemLeftGroupsDataProvider:net.wg.data.daapi.base.DAAPIDataProvider=null;

        internal static var _instance:net.wg.gui.lobby.customization.VehicleCustomization=null;

        public var emblemRightGroupsDataProvider:net.wg.data.daapi.base.DAAPIDataProvider=null;

        public var inscriptionLeftGroupsDataProvider:net.wg.data.daapi.base.DAAPIDataProvider=null;
    }
}
