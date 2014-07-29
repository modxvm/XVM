package net.wg.gui.lobby.customization
{
    import net.wg.gui.lobby.customization.renderers.CamoDemoRenderer;
    import net.wg.gui.lobby.customization.data.CamouflagesDataProvider;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
    import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
    import scaleform.clik.controls.Button;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer;
    
    public class CamouflageSectionView extends BaseTimedCustomizationSectionView
    {
        
        public function CamouflageSectionView()
        {
            this.currentData = [null,null,null];
            this.newData = [null,null,null];
            super();
        }
        
        public var currentItemRenderer0:CamoDemoRenderer = null;
        
        public var currentItemRenderer1:CamoDemoRenderer = null;
        
        public var currentItemRenderer2:CamoDemoRenderer = null;
        
        public var dropButton0:CamoDropButton = null;
        
        public var dropButton1:CamoDropButton = null;
        
        public var dropButton2:CamoDropButton = null;
        
        private var _selectedKind:int = -1;
        
        private var _droppingKind:int = -1;
        
        public var currentData:Array;
        
        public var newData:Array;
        
        private var currentDataDirty:Boolean = false;
        
        override public function getEmptyDataItem() : Object
        {
            return CamouflagesDataProvider.getEmptyItem();
        }
        
        override public function getGroupsDP() : DAAPIDataProvider
        {
            return form.camouflageGroupsDataProvider;
        }
        
        override public function getItemsDP() : DAAPIItemsDataProvider
        {
            return form.camouflageDP;
        }
        
        override public function getRentalPackagesDP() : RentalPackageDAAPIDataProvider
        {
            return form.camouflageRentalPackageDP;
        }
        
        override public function getViewLinkage() : String
        {
            return BaseTimedCustomizationSectionView.CAMOUFLAGE_GROUP_VIEW;
        }
        
        override public function getTimeSectionLabel() : String
        {
            return MENU.CUSTOMIZATION_LABELS_CAMOUFLAGE_PERIOD;
        }
        
        override public function getDropButtonTooltip() : String
        {
            return TOOLTIPS.CUSTOMIZATION_CAMOUFLAGE_CURRENT_DROP;
        }
        
        override public function getSectionName() : String
        {
            return BaseTimedCustomizationSectionView.CAMOUFLAGE;
        }
        
        override public function get currentItemData() : Object
        {
            return this.currentData[this._selectedKind];
        }
        
        override public function set currentItemData(param1:Object) : void
        {
            this.currentData[this._selectedKind] = param1;
        }
        
        override public function get newItemData() : Object
        {
            return this.newData[this._selectedKind];
        }
        
        override public function set newItemData(param1:Object) : void
        {
            this.newData[this._selectedKind] = param1;
        }
        
        override public function onChangeSuccess() : void
        {
            var _loc2_:* = NaN;
            var _loc3_:CamoDemoRenderer = null;
            var _loc4_:Button = null;
            var _loc1_:Number = this.currentData.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
                if((this.newData[_loc2_]) && (this.newData[_loc2_].id))
                {
                    this.currentData[_loc2_] = this.newData[_loc2_];
                    _loc3_ = this.getCurrRenderer(_loc2_);
                    _loc3_.setData(this.currentData[_loc2_]);
                    _loc4_ = this.getDropButton(_loc2_);
                    if(_loc4_ != null)
                    {
                        _loc4_.visible = true;
                    }
                    this.newData[_loc2_] = this.getEmptyDataItem();
                }
                _loc2_++;
            }
            this.updateTimeLeftVisibility();
            if(view != null)
            {
                view.invalidateListData(true);
            }
        }
        
        override public function onDropSuccess() : void
        {
            var _loc1_:Object = this.getEmptyDataItem();
            var _loc2_:String = CamouflagesDataProvider(this.getItemsDP()).getDefaultDescription(this._droppingKind);
            if(_loc2_.length > 0)
            {
                _loc1_.description = _loc2_;
            }
            this.currentData[this._droppingKind] = _loc1_;
            var _loc3_:CamoDemoRenderer = this.getCurrRenderer(this._droppingKind);
            _loc3_.setData(this.currentData[this._droppingKind]);
            var _loc4_:Button = this.getDropButton(this._droppingKind);
            if(_loc4_ != null)
            {
                _loc4_.visible = false;
            }
            this._droppingKind = -1;
            this.updateTimeLeftVisibility();
            if(view != null)
            {
                view.invalidateListData(true);
            }
            this.requestCurrentItem();
        }
        
        override public function requestCurrentItem() : void
        {
            var _loc3_:* = NaN;
            var _loc4_:Object = null;
            var _loc1_:Array = form.getCurrentItemS(this.getSectionName()) as Array;
            var _loc2_:Number = _loc1_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = _loc1_[_loc3_];
                this.currentData[_loc3_] = _loc4_;
                _loc3_++;
            }
            this.currentDataDirty = true;
            invalidate();
        }
        
        override public function requestItemAt(param1:int) : void
        {
            var _loc3_:CamouflagesDataProvider = null;
            var _loc4_:Object = null;
            var _loc5_:Object = null;
            var _loc6_:Object = null;
            var _loc7_:* = NaN;
            var _loc2_:Object = _groupsDataProvider.requestItemAt(param1);
            if((view) && (_loc2_))
            {
                view.selectedGroupName = _loc2_.name;
                _loc3_ = CamouflagesDataProvider(this.getItemsDP());
                _loc4_ = this.currentData[this._selectedKind];
                _loc3_.setGroupCurrentItemId(_loc4_?this.currentData[this._selectedKind].id:null);
                CamouflageGroupView(view).setDefaultLabel(_loc3_.getDefaultHintText(param1));
                _loc5_ = form.getSectionData(this.getSectionName());
                _loc6_ = null;
                if((_loc5_) && (_loc5_.selectedItems))
                {
                    _loc6_ = _loc5_.selectedItems[this._selectedKind];
                    view.setListSelectedIndex(_loc2_.name,false,_loc6_);
                }
                else
                {
                    view.setListSelectedIndex(_loc2_.name,false,null);
                }
                view.invalidateListData(false);
                if((_loc6_ == null || _loc6_.id == null) && (this.currentData[this._selectedKind].id))
                {
                    form.setNewItemIdS(this.getSectionName(),this.currentData[this._selectedKind].id,this._selectedKind,view.selectedPriceIdx);
                }
                _loc7_ = 0;
                while(_loc7_ < 3)
                {
                    this.getCurrRenderer(_loc7_).selected = _loc7_ == param1;
                    _loc7_++;
                }
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc2_:CamoDemoRenderer = null;
            var _loc3_:CamoDropButton = null;
            var _loc4_:* = NaN;
            if(form != null)
            {
                form.removeEventListener(CustomizationEvent.CHANGE_ACTIONS_LOCK,this.onChangeActionLock);
                form.removeEventListener(CustomizationEvent.RESET_NEW_ITEM,this.onResetNewItem);
                form = null;
            }
            if(view != null)
            {
                view.removeEventListener(CustomizationEvent.SELECT_NEW,this.onSelectNewItem);
                view = null;
            }
            if(list != null)
            {
                list.removeEventListener(ListEvent.INDEX_CHANGE,this.handleChangeGroupSelectedIndex);
                list.dataProvider = null;
                list.dispose();
                list = null;
            }
            var _loc1_:Number = 3;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
                _loc2_ = this.getCurrRenderer(_loc4_);
                if(_loc2_)
                {
                    _loc2_.removeEventListener(ButtonEvent.CLICK,this.onClickRenderer);
                    _loc2_.setData(null);
                    _loc2_.dispose();
                }
                _loc3_ = this.getDropButton(_loc4_);
                if(_loc3_ != null)
                {
                    _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverDropButton);
                    _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutDropButton);
                    _loc3_.removeEventListener(CustomizationEvent.DROP_ITEM,this.onClickDropButton);
                    _loc3_.dispose();
                }
                _loc4_++;
            }
            this.currentData.splice(0);
            this.currentData = null;
            this.newData.splice(0);
            this.newData = null;
            super.onDispose();
        }
        
        override protected function handleChangeGroupSelectedIndex(param1:ListEvent) : void
        {
            this._selectedKind = param1.index;
            super.handleChangeGroupSelectedIndex(param1);
        }
        
        override protected function configUI() : void
        {
            var _loc3_:CamoDemoRenderer = null;
            var _loc4_:CamoDropButton = null;
            var _loc5_:* = NaN;
            var _loc6_:Object = null;
            var _loc7_:String = null;
            mouseChildren = true;
            mouseEnabled = true;
            var _loc1_:Number = 0;
            if(form != null)
            {
                _loc6_ = form.getSectionData(this.getSectionName());
                if(_loc6_ != null)
                {
                    if(_loc6_._new.id != null)
                    {
                        this.newItemData = _loc6_._new;
                    }
                    if(_loc6_.selectedGroupIdx != null)
                    {
                        _loc1_ = _loc6_.selectedGroupIdx;
                    }
                }
                form.addEventListener(CustomizationEvent.CHANGE_ACTIONS_LOCK,this.onChangeActionLock);
                form.addEventListener(CustomizationEvent.RESET_NEW_ITEM,this.onResetNewItem);
                _loc7_ = this.getViewLinkage();
                view = BaseTimedCustomizationGroupView(form.showView(_loc7_));
                view.timeLabel = this.getTimeSectionLabel();
                view.itemsDP = this.getItemsDP();
                view.rentalPackageDP = this.getRentalPackagesDP();
                view.rentalPackageDP.triggerInvalidation();
                view.addEventListener(CustomizationEvent.SELECT_NEW,this.onSelectNewItem);
                view.initData();
            }
            if(list != null)
            {
                list.labelField = getListLabelFieldName();
                list.selectedIndex = _loc1_;
                list.dataProvider = _groupsDataProvider;
                list.addEventListener(ListEvent.INDEX_CHANGE,this.handleChangeGroupSelectedIndex);
            }
            var _loc2_:Number = 3;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
                _loc3_ = this.getCurrRenderer(_loc5_);
                if(_loc3_)
                {
                    _loc3_.addEventListener(ButtonEvent.CLICK,this.onClickRenderer);
                    _loc3_.setData(this.currentData[_loc5_]);
                    _loc3_.mouseEnabled = true;
                    _loc3_.validateNow();
                }
                _loc4_ = this.getDropButton(_loc5_);
                if(_loc4_ != null)
                {
                    _loc4_.visible = false;
                    _loc4_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverDropButton);
                    _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutDropButton);
                    _loc4_.addEventListener(CustomizationEvent.DROP_ITEM,this.onClickDropButton);
                    _loc4_.kind = _loc5_;
                }
                _loc5_++;
            }
            this._selectedKind = list.selectedIndex;
            this.requestCurrentItem();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:CamoDemoRenderer = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:Object = null;
            var _loc6_:Object = null;
            var _loc7_:Object = null;
            var _loc8_:Button = null;
            super.draw();
            if(this.currentDataDirty)
            {
                _loc1_ = true;
                _loc3_ = 3;
                _loc7_ = form.getSectionData(this.getSectionName());
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    _loc2_ = this.getCurrRenderer(_loc4_);
                    _loc5_ = this.currentData[_loc4_];
                    if(_loc7_ != null)
                    {
                        _loc6_ = _loc7_.selectedItems[_loc4_];
                    }
                    else
                    {
                        _loc6_ = null;
                    }
                    this.newData[_loc4_] = _loc6_;
                    _loc1_ = !(_loc2_ == null);
                    if(!_loc1_)
                    {
                        break;
                    }
                    _loc8_ = this.getDropButton(_loc4_);
                    if((_loc6_) && !(_loc6_.id == null))
                    {
                        _loc2_.demoMode = CustomizationItemRenderer.DEMO_NEW;
                        _loc2_.setData(_loc6_);
                        _loc8_.visible = false;
                    }
                    else
                    {
                        _loc2_.demoMode = CustomizationItemRenderer.DEMO_CURRENT;
                        _loc2_.setData(_loc5_);
                        _loc8_.visible = !(_loc2_.data.id == null);
                    }
                    _loc8_.enabled = !(form == null) && !form.isActionsLocked();
                    _loc4_++;
                }
                if(_loc1_)
                {
                    this.currentDataDirty = false;
                }
                else
                {
                    invalidate();
                }
                this.updateTimeLeftVisibility();
            }
        }
        
        private function getCurrRenderer(param1:Number) : CamoDemoRenderer
        {
            var _loc2_:Array = [this.currentItemRenderer0,this.currentItemRenderer1,this.currentItemRenderer2];
            return _loc2_[param1];
        }
        
        private function getDropButton(param1:Number) : CamoDropButton
        {
            var _loc2_:Array = [this.dropButton0,this.dropButton1,this.dropButton2];
            return _loc2_[param1];
        }
        
        private function onRollOverDropButton(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this.getDropButtonTooltip());
        }
        
        private function onRollOutDropButton(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onSelectNewItem(param1:CustomizationEvent) : void
        {
            var _loc3_:* = 0;
            var _loc4_:Object = null;
            var _loc2_:Object = form.getSectionData(this.getSectionName());
            if(_loc2_)
            {
                _loc3_ = 0;
                while(_loc3_ < _loc2_.selectedItems.length)
                {
                    _loc4_ = _loc2_.selectedItems[_loc3_];
                    if((_loc4_) && !(_loc3_ == this._selectedKind))
                    {
                        if(_loc4_.id)
                        {
                            form.setNewItemIdS(this.getSectionName(),_loc4_.id,_loc3_,_loc4_.priceIndex);
                        }
                    }
                    _loc3_++;
                }
            }
            this.setNewItemView(param1.index,param1.data,this._selectedKind);
        }
        
        private function onResetNewItem(param1:CustomizationEvent) : void
        {
            this.newData = [null,null,null];
            this.newItemData = this.getEmptyDataItem();
            if(view != null)
            {
                view.list.selectedIndex = -1;
            }
            this.currentDataDirty = true;
            invalidate();
        }
        
        private function onChangeActionLock(param1:CustomizationEvent) : void
        {
            var _loc3_:Button = null;
            var _loc4_:* = 0;
            var _loc2_:* = 3;
            _loc4_ = 0;
            while(true)
            {
                _loc2_;
                _loc4_;
                _loc3_ = this.getDropButton(_loc4_);
                if(_loc3_ != null)
                {
                    _loc3_.enabled = !param1.locked;
                }
                _loc4_++;
            }
        }
        
        private function onClickDropButton(param1:CustomizationEvent) : void
        {
            App.toolTipMgr.hide();
            this._droppingKind = param1.kind;
            if(form)
            {
                form.dropCurrentItemInSection(this.getSectionName(),this._droppingKind);
            }
        }
        
        private function onClickRenderer(param1:ButtonEvent) : void
        {
            var _loc2_:* = NaN;
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
                if(CamoDemoRenderer.KINDS[_loc2_] == param1.target.kind)
                {
                    list.selectedIndex = _loc2_;
                    break;
                }
                _loc2_++;
            }
        }
        
        private function updateTimeLeftVisibility() : void
        {
            var _loc2_:* = NaN;
            var _loc1_:* = false;
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
                if((this.currentData[_loc2_]) && (this.currentData[_loc2_].timeLeft) && this.currentData[_loc2_].timeLeft.length > 0)
                {
                    _loc1_ = true;
                    break;
                }
                _loc2_++;
            }
            if(timeLeftField)
            {
                timeLeftField.visible = _loc1_;
            }
        }
        
        private function setNewItemView(param1:int, param2:Object, param3:int) : void
        {
            var _loc6_:Array = null;
            var _loc11_:* = NaN;
            var _loc4_:int = param2.id;
            if(this.currentItemData.id == _loc4_)
            {
                this.newItemData = this.getEmptyDataItem();
                param1 = -1;
            }
            else
            {
                this.newItemData = param2;
            }
            this.newItemData.index = param1;
            this.newItemData.priceIndex = view.selectedPriceIdx;
            var _loc5_:Object = form.getSectionData(this.getSectionName());
            if(_loc5_ == null)
            {
                _loc6_ = [null,null,null];
            }
            else
            {
                _loc6_ = _loc5_.selectedItems;
            }
            _loc6_[param3] = this.newItemData;
            var _loc7_:* = false;
            var _loc8_:Array = [];
            var _loc9_:Number = _loc6_.length;
            var _loc10_:Object = null;
            _loc11_ = 0;
            while(_loc11_ < _loc9_)
            {
                _loc10_ = _loc6_[_loc11_];
                if(_loc10_)
                {
                    if(!_loc7_)
                    {
                        _loc7_ = !(_loc10_.index == -1);
                    }
                    if(_loc10_.id)
                    {
                        _loc8_.push(form.getItemCost(this.getSectionName(),_loc10_.id,_loc10_.priceIndex));
                    }
                }
                _loc11_++;
            }
            var _loc12_:CamoDemoRenderer = this.getCurrRenderer(param3);
            var _loc13_:Button = this.getDropButton(param3);
            if(this.newItemData.id != null)
            {
                _loc12_.demoMode = CustomizationItemRenderer.DEMO_NEW;
                _loc12_.setData(this.newItemData);
                _loc13_.visible = false;
            }
            else
            {
                _loc12_.demoMode = CustomizationItemRenderer.DEMO_CURRENT;
                _loc12_.setData(this.currentData[param3]);
                _loc13_.visible = !(this.currentData[param3].id == -1);
            }
            form.setNewItemIdS(this.getSectionName(),_loc4_,param3,view.selectedPriceIdx);
            form.setSectionData(this.getSectionName(),_loc7_,{"selectedIdx":param1,
            "selectedItems":_loc6_,
            "selectedGroupIdx":list.selectedIndex,
            "groupName":view.selectedGroupName,
            "price":_loc8_,
            "_new":this.newItemData
        });
    }
}
}
