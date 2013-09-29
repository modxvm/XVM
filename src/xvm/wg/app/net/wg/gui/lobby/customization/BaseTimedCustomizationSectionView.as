package net.wg.gui.lobby.customization 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    import net.wg.gui.lobby.customization.renderers.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class BaseTimedCustomizationSectionView extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function BaseTimedCustomizationSectionView()
        {
            super();
            this.form = net.wg.gui.lobby.customization.VehicleCustomization.instance;
            this.currentItemData = this.getEmptyDataItem();
            this.newItemData = this.getEmptyDataItem();
            this._groupsDataProvider = this.getGroupsDP();
            this._groupsDataProvider.triggerInvalidation();
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function lockControls(arg1:Boolean):void
        {
            this.dropButton.enabled = !arg1;
            return;
        }

        protected override function configUI():void
        {
            var loc2:*=null;
            var loc3:*=null;
            mouseChildren = true;
            mouseEnabled = true;
            var loc1:*=0;
            if (this.form != null) 
            {
                loc2 = this.form.getSectionData(this.getSectionName());
                if (loc2 != null) 
                {
                    if (loc2._new.id != null) 
                    {
                        this.newItemData = loc2._new;
                    }
                    if (loc2.selectedGroupIdx != null) 
                    {
                        loc1 = loc2.selectedGroupIdx;
                    }
                }
                this.form.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.CHANGE_ACTIONS_LOCK, this.handleChangeActionLock);
                this.form.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.RESET_NEW_ITEM, this.handleResetNewItem);
                loc3 = this.getViewLinkage();
                this.view = net.wg.gui.lobby.customization.BaseTimedCustomizationGroupView(this.form.showView(loc3));
                this.view.timeLabel = this.getTimeSectionLabel();
                this.view.itemsDP = this.getItemsDP();
                this.view.rentalPackageDP = this.getRentalPackagesDP();
                this.view.rentalPackageDP.triggerInvalidation();
                this.view.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.SELECT_NEW, this.handleSelectNewItem);
                this.view.initData();
            }
            if (this.list != null) 
            {
                this.list.labelField = this.getListLabelFieldName();
                this.list.selectedIndex = loc1;
                this.list.dataProvider = this._groupsDataProvider;
                this.list.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleChangeGroupSelectedIndex);
            }
            if (this.currentItemRenderer != null) 
            {
                this.currentItemRenderer.setData(this.currentItemData);
                this.currentItemRenderer.enabled = false;
            }
            if (this.dropButton != null) 
            {
                this.dropButton.visible = false;
                this.dropButton.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.hadleRollOverDropButton);
                this.dropButton.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hadleRollOutDropButton);
                this.dropButton.addEventListener(net.wg.gui.lobby.customization.CustomizationEvent.DROP_ITEM, this.handleClickDropButton);
            }
            if (this.newItemRenderer != null) 
            {
                this.newItemRenderer.setData(this.newItemData);
                this.newItemRenderer.enabled = this.newItemData && this.newItemData.id;
            }
            super.configUI();
            this.requestCurrentItem();
            return;
        }

        protected function handleChangeGroupSelectedIndex(arg1:scaleform.clik.events.ListEvent):void
        {
            this.requestItemAt(arg1.index);
            return;
        }

        internal function setNewItemView(arg1:int, arg2:Object, arg3:int):void
        {
            var loc1:*=arg2.id;
            if (this.currentItemData.id != loc1) 
            {
                this.newItemData = arg2;
            }
            else 
            {
                this.newItemData = this.getEmptyDataItem();
                arg1 = -1;
            }
            this.newItemData.index = arg1;
            this.newItemData.priceIndex = this.view.selectedPriceIdx;
            this.newItemRenderer.setData(this.newItemData);
            this.newItemRenderer.enabled = !(arg1 == -1);
            this.form.setNewItemIdS(this.getSectionName(), loc1, arg3, this.view.selectedPriceIdx);
            this.form.setSectionData(this.getSectionName(), !(arg1 == -1), {"selectedIdx":arg1, "selectedGroupIdx":this.list.selectedIndex, "groupName":this.view.selectedGroupName, "price":this.newItemData.price, "_new":this.newItemData});
            return;
        }

        public function onCurrentChanged():void
        {
            this.requestCurrentItem();
            if (this.view != null) 
            {
                this.view.invalidateListData();
            }
            return;
        }

        internal function handleSelectNewItem(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            this.setNewItemView(arg1.index, arg1.data, 0);
            return;
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

        internal function handleChangeActionLock(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            this.dropButton.enabled = !arg1.locked;
            return;
        }

        internal function handleResetNewItem(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            this.newItemData = this.getEmptyDataItem();
            this.newItemRenderer.setData(this.newItemData);
            this.newItemRenderer.enabled = false;
            if (this.view != null) 
            {
                this.view.list.selectedIndex = -1;
            }
            return;
        }

        internal function handleClickDropButton(arg1:net.wg.gui.lobby.customization.CustomizationEvent):void
        {
            App.toolTipMgr.hide();
            if (this.form) 
            {
                this.form.dropCurrentItemInSection(this.getSectionName(), arg1.kind);
            }
            return;
        }

        public function onChangeSuccess():void
        {
            this.currentItemData = this.newItemData;
            this.currentItemRenderer.setData(this.currentItemData);
            this.currentItemRenderer.enabled = true;
            if (this.dropButton != null) 
            {
                this.dropButton.visible = true;
            }
            if (this.timeLeftField != null) 
            {
                this.timeLeftField.text = "";
            }
            this.newItemData = this.getEmptyDataItem();
            this.newItemRenderer.setData(this.newItemData);
            this.newItemRenderer.enabled = false;
            if (this.view != null) 
            {
                this.view.invalidateListData(true);
            }
            return;
        }

        public function onDropSuccess():void
        {
            this.currentItemData = this.getEmptyDataItem();
            this.currentItemRenderer.setData(this.currentItemData);
            this.currentItemRenderer.enabled = false;
            if (this.dropButton != null) 
            {
                this.dropButton.visible = false;
            }
            if (this.timeLeftField != null) 
            {
                this.timeLeftField.text = "";
            }
            if (this.view != null) 
            {
                this.view.invalidateListData(true);
            }
            return;
        }

        public function get currentItemData():Object
        {
            return this._currentItemData;
        }

        public function set currentItemData(arg1:Object):void
        {
            this._currentItemData = arg1;
            return;
        }

        public function get newItemData():Object
        {
            return this._newItemData;
        }

        public function set newItemData(arg1:Object):void
        {
            this._newItemData = arg1;
            return;
        }

        public function requestCurrentItem():void
        {
            this.currentItemData = this.form.getCurrentItemS(this.getSectionName());
            if (this.currentItemData && !(this.timeLeftField == null)) 
            {
                this.timeLeftField.text = this.currentItemData.timeLeft;
            }
            this.currentItemRenderer.setData(this.currentItemData);
            var loc1:*=this.currentItemData && this.currentItemData.id == null;
            if (!loc1 && this.currentItemData.hasOwnProperty("canDrop")) 
            {
                loc1 = !Boolean(this.currentItemData.canDrop);
            }
            this.currentItemRenderer.enabled = !loc1;
            if (this.dropButton != null) 
            {
                this.dropButton.visible = !loc1;
                this.dropButton.enabled = !(this.form == null) && !this.form.isActionsLocked();
            }
            return;
        }

        public function requestItemAt(arg1:int):void
        {
            var loc2:*=null;
            var loc1:*=this._groupsDataProvider.requestItemAt(arg1);
            if (this.view && loc1) 
            {
                this.view.selectedGroupName = loc1.name;
                if (this.form != null) 
                {
                    loc2 = this.form.getSectionData(this.getSectionName());
                    if (loc2 == null) 
                    {
                        this.view.setListSelectedIndex(loc1.name, null);
                    }
                    else 
                    {
                        this.view.setListSelectedIndex(loc2.groupName, loc2._new);
                    }
                }
                this.view.invalidateListData(false);
            }
            return;
        }

        public function onGetTimeLeftString(arg1:String):void
        {
            this.timeLeftField.text = arg1;
            return;
        }

        public function getListLabelFieldName():String
        {
            return "userString";
        }

        public function getEmptyDataItem():Object
        {
            return null;
        }

        public function getGroupsDP():net.wg.data.daapi.base.DAAPIDataProvider
        {
            return null;
        }

        public function getItemsDP():net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider
        {
            return null;
        }

        public function getRentalPackagesDP():net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider
        {
            return null;
        }

        public function getViewLinkage():String
        {
            return "";
        }

        public function getTimeSectionLabel():String
        {
            return "";
        }

        public function getDropButtonTooltip():String
        {
            return "";
        }

        public function getSectionName():String
        {
            return "";
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.form != null) 
            {
                this.form.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.CHANGE_ACTIONS_LOCK, this.handleChangeActionLock);
                this.form.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.RESET_NEW_ITEM, this.handleResetNewItem);
                this.form = null;
            }
            if (this.view) 
            {
                this.view.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.SELECT_NEW, this.handleSelectNewItem);
                this.view.dispose();
                this.view = null;
            }
            if (this.list != null) 
            {
                this.list.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleChangeGroupSelectedIndex);
                this.list.dataProvider = null;
            }
            if (this.currentItemRenderer != null) 
            {
                this.currentItemRenderer.setData(null);
            }
            if (this.dropButton != null) 
            {
                this.dropButton.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.hadleRollOverDropButton);
                this.dropButton.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hadleRollOutDropButton);
                this.dropButton.removeEventListener(net.wg.gui.lobby.customization.CustomizationEvent.DROP_ITEM, this.handleClickDropButton);
            }
            if (this.newItemRenderer != null) 
            {
                this.newItemRenderer.setData(null);
            }
            this._currentItemData = null;
            this._newItemData = null;
            this._groupsDataProvider = null;
            this._data = null;
            return;
        }

        public function update(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public static const CAMOUFLAGE:String="camouflage";

        public static const CAMOUFLAGE_GROUP_VIEW:String="CamouflageGroupViewUI";

        public static const EMBLEM_LEFT:String="emblemLeft";

        public static const EMBLEM_RIGHT:String="emblemRight";

        public static const EMBLEM_GROUP_VIEW:String="EmblemGroupViewUI";

        public static const EMBLEM_GROUP_VIEW_COPY:String="EmblemGroupViewUICopy";

        public static const INSCRIPTION_LEFT:String="inscriptionLeft";

        public static const INSCRIPTION_RIGHT:String="inscriptionRight";

        public static const INSCRIPTION_GROUP_VIEW:String="InscriptionGroupViewUI";

        public static const INSCRIPTION_GROUP_VIEW_COPY:String="InscriptionGroupViewUICopy";

        public var form:net.wg.gui.lobby.customization.VehicleCustomization=null;

        public var view:net.wg.gui.lobby.customization.BaseTimedCustomizationGroupView=null;

        public var currentItemRenderer:net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer=null;

        public var newItemRenderer:net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer=null;

        public var dropButton:net.wg.gui.lobby.customization.CamoDropButton=null;

        public var list:scaleform.clik.controls.ScrollingList=null;

        internal var _currentItemData:Object=null;

        internal var _newItemData:Object=null;

        protected var _groupsDataProvider:net.wg.data.daapi.base.DAAPIDataProvider=null;

        internal var _data:Object=null;

        public var timeLeftField:flash.text.TextField=null;
    }
}
