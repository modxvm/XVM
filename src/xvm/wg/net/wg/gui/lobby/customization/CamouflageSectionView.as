package net.wg.gui.lobby.customization 
{
    import flash.events.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    import net.wg.gui.lobby.customization.renderers.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class CamouflageSectionView extends net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView
    {
        public function CamouflageSectionView()
        {
            this.currentData = [null, null, null];
            this.newData = [null, null, null];
            super();
            return;
        }

        internal function getCurrRenderer(arg1:Number):net.wg.gui.lobby.customization.renderers.CamoDemoRenderer
        {
            var loc1:*=[this.currentItemRenderer0, this.currentItemRenderer1, this.currentItemRenderer2];
            return loc1[arg1];
        }

        internal function getDropButton(arg1:Number):net.wg.gui.lobby.customization.CamoDropButton
        {
            var loc1:*=[this.dropButton0, this.dropButton1, this.dropButton2];
            return loc1[arg1];
        }

        internal function hadleRollOverDropButton(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(this.getDropButtonTooltip());
            return;
        }

        internal function hadleRollOutDropButton(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public override function set currentItemData(arg1:Object):void
        {
            this.currentData[this._selectedKind] = arg1;
            return;
        }

        internal function handleSelectNewItem(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            this.setNewItemView(arg1.index, arg1.data, this._selectedKind);
            return;
        }

        internal function handleChangeActionLock(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            var loc2:*=null;
            var loc1:*=3;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc2 = this.getDropButton(loc3);
                if (loc2 != null) 
                    loc2.enabled = !arg1.locked;
                ++loc3;
            }
            return;
        }

        internal function handleClickDropButton(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            App.toolTipMgr.hide();
            this._droppingKind = arg1.kind;
            if (form) 
                form.dropCurrentItemInSection(this.getSectionName(), this._droppingKind);
            return;
        }

        internal function hadleClickRenderer(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < 3) 
            {
                if (net.wg.gui.lobby.customization.renderers.CamoDemoRenderer.KINDS[loc1] == arg1.target.kind) 
                {
                    list.selectedIndex = loc1;
                    break;
                }
                ++loc1;
            }
            return;
        }

        internal function updateTimeLeftVisibility():void
        {
            var loc1:*=false;
            var loc2:*=0;
            loc2 = 0;
            while (loc2 < 3) 
            {
                if (this.currentData[loc2] && this.currentData[loc2].timeLeft && this.currentData[loc2].timeLeft.length > 0) 
                {
                    loc1 = true;
                    break;
                }
                ++loc2;
            }
            if (timeLeftField) 
                timeLeftField.visible = loc1;
            return;
        }

        internal function setNewItemView(arg1:int, arg2:Object, arg3:int):void
        {
            var loc3:*=null;
            var loc6:*=null;
            var loc1:*=arg2.id;
            if (this.currentItemData.id != loc1) 
                this.newItemData = arg2;
            else 
            {
                this.newItemData = this.getEmptyDataItem();
                arg1 = -1;
            }
            this.newItemData.index = arg1;
            this.newItemData.priceIndex = view.selectedPriceIdx;
            var loc2:*;
            if ((loc2 = form.getSectionData(this.getSectionName())) != null) 
                loc3 = loc2.selectedItems;
            else 
                loc3 = [null, null, null];
            loc3[arg3] = this.newItemData;
            var loc4:*=false;
            var loc5:*=[];
            var loc7:*=loc3.length;
            var loc8:*=null;
            var loc9:*=0;
            loc9 = 0;
            while (loc9 < loc7) 
            {
                if (loc8 = loc3[loc9]) 
                {
                    if (!loc4) 
                        loc4 = !(loc8.index == -1);
                    if (loc8.id) 
                        loc5.push(form.getItemCost(this.getSectionName(), loc8.id, loc8.priceIndex));
                }
                ++loc9;
            }
            var loc10:*=this.getCurrRenderer(arg3);
            var loc11:*=this.getDropButton(arg3);
            if (this.newItemData.id == null) 
            {
                loc10.demoMode = net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer.DEMO_CURRENT;
                loc10.setData(this.currentData[arg3]);
                loc11.visible = !(this.currentData[arg3].id == -1);
            }
            else 
            {
                loc10.demoMode = net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer.DEMO_NEW;
                loc10.setData(this.newItemData);
                loc11.visible = false;
            }
            form.setNewItemId(this.getSectionName(), loc1, arg3, view.selectedPriceIdx);
            form.setSectionData(this.getSectionName(), loc4, {"selectedIdx":arg1, "selectedItems":loc3, "selectedGroupIdx":list.selectedIndex, "groupName":view.selectedGroupName, "price":loc5, "_new":this.newItemData});
            return;
        }

        public override function getEmptyDataItem():Object
        {
            return net.wg.gui.lobby.customization.data.CamouflagesDataProvider.getEmptyItem();
        }

        public override function getGroupsDP():net.wg.data.daapi.base.DAAPIDataProvider
        {
            return form.camouflageGroupsDataProvider;
        }

        public override function getItemsDP():net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider
        {
            return form.camouflageDP;
        }

        public override function getRentalPackagesDP():net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider
        {
            return form.camouflageRentalPackageDP;
        }

        public override function getViewLinkage():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.CAMOUFLAGE_GROUP_VIEW;
        }

        public override function getTimeSectionLabel():String
        {
            return MENU.CUSTOMIZATION_LABELS_CAMOUFLAGE_PERIOD;
        }

        public override function getDropButtonTooltip():String
        {
            return TOOLTIPS.CUSTOMIZATION_CAMOUFLAGE_CURRENT_DROP;
        }

        public override function getSectionName():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.CAMOUFLAGE;
        }

        public override function get currentItemData():Object
        {
            return this.currentData[this._selectedKind];
        }

        internal function handleResetNewItem(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            this.newItemData = this.getEmptyDataItem();
            if (view != null) 
                view.list.selectedIndex = -1;
            return;
        }

        public override function get newItemData():Object
        {
            return this.newData[this._selectedKind];
        }

        public override function set newItemData(arg1:Object):void
        {
            this.newData[this._selectedKind] = arg1;
            return;
        }

        public override function onChangeSuccess():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=this.currentData.length;
            var loc2:*=0;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                this.currentData[loc2] = this.newData[loc2];
                loc3 = this.getCurrRenderer(loc2);
                loc3.setData(this.currentData[loc2]);
                if ((loc4 = this.getDropButton(loc2)) != null) 
                    loc4.visible = true;
                this.newData[loc2] = this.getEmptyDataItem();
                ++loc2;
            }
            this.updateTimeLeftVisibility();
            if (view != null) 
                view.invalidateListData(true);
            return;
        }

        public override function onDropSuccess():void
        {
            var loc1:*=this.getEmptyDataItem();
            var loc2:*=net.wg.gui.lobby.customization.data.CamouflagesDataProvider(this.getItemsDP()).getDefaultDescription(this._droppingKind);
            if (loc2.length > 0) 
                loc1.description = loc2;
            this.currentData[this._droppingKind] = loc1;
            var loc3:*=this.getCurrRenderer(this._droppingKind);
            loc3.setData(this.currentData[this._droppingKind]);
            var loc4:*;
            if ((loc4 = this.getDropButton(this._droppingKind)) != null) 
                loc4.visible = false;
            this._droppingKind = -1;
            this.updateTimeLeftVisibility();
            if (view != null) 
                view.invalidateListData(true);
            return;
        }

        public override function requestCurrentItem():void
        {
            var loc4:*=null;
            var loc1:*=form.getCurrentItemS(this.getSectionName()) as Array;
            var loc2:*=loc1.length;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                this.currentData[loc3] = loc4;
                ++loc3;
            }
            this.currentDataDirty = true;
            invalidate();
            return;
        }

        public override function requestItemAt(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc1:*=_groupsDataProvider.requestItemAt(arg1);
            if (view && loc1) 
            {
                view.selectedGroupName = loc1.name;
                loc2 = net.wg.gui.lobby.customization.data.CamouflagesDataProvider(this.getItemsDP());
                loc3 = this.currentData[this._selectedKind];
                loc2.setGroupCurrentItemId(loc3 ? this.currentData[this._selectedKind].id : null);
                net.wg.gui.lobby.customization.CamouflageGroupView(view).setDefaultLabel(loc2.getDefaultHintText(arg1));
                loc4 = form.getSectionData(this.getSectionName());
                loc5 = null;
                if (loc4 && loc4.selectedItems) 
                {
                    loc5 = loc4.selectedItems[this._selectedKind];
                    view.setListSelectedIndex(loc1.name, loc5);
                }
                else 
                    view.setListSelectedIndex(loc1.name, null);
                view.invalidateListData(false);
                if ((loc5 == null || loc5.id == null) && this.currentData[this._selectedKind].id) 
                    form.setNewItemId(this.getSectionName(), this.currentData[this._selectedKind].id, this._selectedKind, view.selectedPriceIdx);
                loc6 = 0;
                loc6 = 0;
                while (loc6 < 3) 
                {
                    this.getCurrRenderer(loc6).selected = loc6 == arg1;
                    ++loc6;
                }
            }
            return;
        }

        public override function dispose():void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (form != null) 
            {
                form.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.CHANGE_ACTIONS_LOCK, this.handleChangeActionLock);
                form.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.RESET_NEW_ITEM, this.handleResetNewItem);
            }
            if (view != null) 
                view.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.SELECT_NEW, this.handleSelectNewItem);
            if (list != null) 
            {
                list.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleChangeGroupSelectedIndex);
                list.dataProvider = null;
            }
            var loc1:*=3;
            var loc4:*=0;
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc2 = this.getCurrRenderer(loc4);
                if (loc2) 
                {
                    loc2.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.hadleClickRenderer);
                    loc2.setData(null);
                }
                loc3 = this.getDropButton(loc4);
                if (loc3 != null) 
                {
                    loc3.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.hadleRollOverDropButton);
                    loc3.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hadleRollOutDropButton);
                    loc3.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.DROP_ITEM, this.handleClickDropButton);
                }
                ++loc4;
            }
            this.currentData.splice(0);
            this.currentData = null;
            this.newData.splice(0);
            this.newData = null;
            return;
        }

        protected override function handleChangeGroupSelectedIndex(arg1:scaleform.clik.events.ListEvent):void
        {
            this._selectedKind = arg1.index;
            super.handleChangeGroupSelectedIndex(arg1);
            return;
        }

        protected override function configUI():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=null;
            var loc7:*=null;
            mouseChildren = true;
            mouseEnabled = true;
            var loc1:*=0;
            if (form != null) 
            {
                if ((loc6 = form.getSectionData(this.getSectionName())) != null) 
                {
                    if (loc6._new.id != null) 
                        this.newItemData = loc6._new;
                    if (loc6.selectedGroupIdx != null) 
                        loc1 = loc6.selectedGroupIdx;
                }
                form.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.CHANGE_ACTIONS_LOCK, this.handleChangeActionLock);
                form.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.RESET_NEW_ITEM, this.handleResetNewItem);
                loc7 = this.getViewLinkage();
                view = net.wg.gui.lobby.customization.BaseTimedCustomizationGroupView(form.showView(loc7));
                view.timeLabel = this.getTimeSectionLabel();
                view.itemsDP = this.getItemsDP();
                view.rentalPackageDP = this.getRentalPackagesDP();
                view.rentalPackageDP.triggerInvalidation();
                view.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.SELECT_NEW, this.handleSelectNewItem);
                view.initData();
            }
            if (list != null) 
            {
                list.labelField = getListLabelFieldName();
                list.selectedIndex = loc1;
                list.dataProvider = _groupsDataProvider;
                list.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleChangeGroupSelectedIndex);
            }
            var loc2:*=3;
            var loc5:*=0;
            loc5 = 0;
            while (loc5 < loc2) 
            {
                loc3 = this.getCurrRenderer(loc5);
                if (loc3) 
                {
                    loc3.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.hadleClickRenderer);
                    loc3.setData(this.currentData[loc5]);
                    loc3.mouseEnabled = true;
                    loc3.validateNow();
                }
                if ((loc4 = this.getDropButton(loc5)) != null) 
                {
                    loc4.visible = false;
                    loc4.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.hadleRollOverDropButton);
                    loc4.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hadleRollOutDropButton);
                    loc4.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.DROP_ITEM, this.handleClickDropButton);
                    loc4.kind = loc5;
                }
                ++loc5;
            }
            this._selectedKind = list.selectedIndex;
            this.requestCurrentItem();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            super.draw();
            if (this.currentDataDirty) 
            {
                loc1 = true;
                loc3 = 3;
                loc4 = 0;
                loc7 = form.getSectionData(this.getSectionName());
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc2 = this.getCurrRenderer(loc4);
                    loc5 = this.currentData[loc4];
                    if (loc7 == null) 
                        loc6 = null;
                    else 
                        loc6 = loc7.selectedItems[loc4];
                    this.newData[loc4] = loc6;
                    loc1 = !(loc2 == null);
                    if (loc1) 
                    {
                        loc8 = this.getDropButton(loc4);
                        if (loc6 && !(loc6.id == null)) 
                        {
                            loc2.demoMode = net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer.DEMO_NEW;
                            loc2.setData(loc6);
                            loc8.visible = false;
                        }
                        else 
                        {
                            loc2.demoMode = net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer.DEMO_CURRENT;
                            loc2.setData(loc5);
                            loc8.visible = !(loc2.data.id == null);
                        }
                        loc8.enabled = !(form == null) && !form.isActionsLocked();
                    }
                    else 
                        break;
                    ++loc4;
                }
                if (loc1) 
                    this.currentDataDirty = false;
                else 
                    invalidate();
                this.updateTimeLeftVisibility();
            }
            return;
        }

        public var currentItemRenderer0:net.wg.gui.lobby.customization.renderers.CamoDemoRenderer=null;

        public var currentItemRenderer1:net.wg.gui.lobby.customization.renderers.CamoDemoRenderer=null;

        public var currentItemRenderer2:net.wg.gui.lobby.customization.renderers.CamoDemoRenderer=null;

        public var dropButton0:net.wg.gui.lobby.customization.CamoDropButton=null;

        public var dropButton2:net.wg.gui.lobby.customization.CamoDropButton=null;

        internal var _selectedKind:int=-1;

        internal var _droppingKind:int=-1;

        internal var currentData:Array;

        internal var newData:Array;

        internal var currentDataDirty:Boolean=false;

        public var dropButton1:net.wg.gui.lobby.customization.CamoDropButton=null;
    }
}
