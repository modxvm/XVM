package net.wg.gui.lobby.store.views
{
    import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.data.constants.generated.STORE_TYPES;
    import net.wg.data.VO.ShopSubFilterData;
    
    public class VehicleView extends BaseStoreMenuView
    {
        
        public function VehicleView()
        {
            super();
        }
        
        public var allRadioBtn:RadioButton = null;
        
        public var lightTankRadioBtn:RadioButton = null;
        
        public var mediumTankRadioBtn:RadioButton = null;
        
        public var heavyTankRadioBtn:RadioButton = null;
        
        public var at_spgRadioBtn:RadioButton = null;
        
        public var spgRadioBtn:RadioButton = null;
        
        public var lockedChkBx:CheckBox = null;
        
        public var inHangarChkBx:CheckBox = null;
        
        public var brockenChckBx:CheckBox = null;
        
        public var rentalsChckBx:CheckBox = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.inHangarChkBx.enableDynamicFrameUpdating();
            this.brockenChckBx.enableDynamicFrameUpdating();
            if(App.globalVarsMgr.isRentalsEnabledS())
            {
                this.rentalsChckBx.enableDynamicFrameUpdating();
            }
            else
            {
                this.rentalsChckBx.visible = false;
            }
        }
        
        override public function resetTemporaryHandlers() : void
        {
            resetHandlers(getFitsArray(),this.allRadioBtn);
        }
        
        override protected function onTagsArrayRequest() : Array
        {
            return [new ViewUIElementVO("lightTank",this.lightTankRadioBtn),new ViewUIElementVO("mediumTank",this.mediumTankRadioBtn),new ViewUIElementVO("heavyTank",this.heavyTankRadioBtn),new ViewUIElementVO("at-spg",this.at_spgRadioBtn),new ViewUIElementVO("spg",this.spgRadioBtn),new ViewUIElementVO("all",this.allRadioBtn)];
        }
        
        override protected function onFitsArrayRequest() : Array
        {
            App.globalVarsMgr.isRentalsEnabledS();
            var _loc1_:Array = null;
            if(getUIName() == STORE_TYPES.SHOP)
            {
                _loc1_ = [new ViewUIElementVO("locked",this.lockedChkBx),new ViewUIElementVO("inHangar",this.inHangarChkBx)];
                if(App.globalVarsMgr.isRentalsEnabledS())
                {
                    _loc1_.push(new ViewUIElementVO("rentals",this.rentalsChckBx));
                }
            }
            else
            {
                _loc1_ = [new ViewUIElementVO("locked",this.lockedChkBx),new ViewUIElementVO("brocken",this.brockenChckBx)];
                if(App.globalVarsMgr.isRentalsEnabledS())
                {
                    _loc1_.push(new ViewUIElementVO("rentals",this.rentalsChckBx));
                }
            }
            return _loc1_;
        }
        
        override protected function getFitsName() : String
        {
            return "extra";
        }
        
        override public function setViewData(param1:Array) : void
        {
            var _loc2_:Number = Number(param1.shift());
            var _loc3_:Array = param1.splice(0,_loc2_);
            if(_loc3_.length > 4)
            {
                this.allRadioBtn.selected = true;
                addHandlerToGroup(this.allRadioBtn);
            }
            else
            {
                selectFilter(getTagsArray(),_loc3_,false,true);
            }
            selectFilter(getFitsArray(),param1,true,false);
        }
        
        override public function getFilter() : Array
        {
            var _loc1_:Array = getSelectedFilters(getTagsArray(),true,this.allRadioBtn);
            _loc1_ = _loc1_.concat(getSelectedFilters(getFitsArray(),false,null));
            return _loc1_;
        }
        
        override public function setSubFilterData(param1:int, param2:ShopSubFilterData) : void
        {
        }
        
        override public function updateSubFilter(param1:int) : void
        {
        }
    }
}
