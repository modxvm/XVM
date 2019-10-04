package net.wg.gui.lobby.store.views
{
    import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.views.data.TargetTypeFiltersVO;
    import flash.events.Event;
    import net.wg.data.VO.ShopSubFilterData;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.gui.lobby.store.StoreViewsEvent;
    import scaleform.clik.controls.ButtonGroup;

    public class BattleBoosterView extends BaseStoreMenuView
    {

        private static const TARGET_TYPE_NAME:String = "targetType";

        public var targetTypeAllKindBtn:RadioButton = null;

        public var targetTypeForCrewBtn:RadioButton = null;

        public var targetTypeForEquipmentBtn:RadioButton = null;

        private var _obtainingTypeArr:Vector.<ViewUIElementVO> = null;

        public function BattleBoosterView()
        {
            super();
        }

        override public function getFiltersData() : FiltersVO
        {
            var _loc1_:TargetTypeFiltersVO = new TargetTypeFiltersVO(filtersDataHash);
            var _loc2_:String = fittingType;
            _loc1_.targetType = this.getTargetType();
            return _loc1_;
        }

        override public function resetTemporaryHandlers() : void
        {
            resetHandlers(this.getTargetTypeArray(),this.targetTypeAllKindBtn);
            super.resetTemporaryHandlers();
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            super.setFiltersData(param1,param2);
            var _loc3_:TargetTypeFiltersVO = TargetTypeFiltersVO(param1);
            this.targetTypeAllKindBtn.group.removeEventListener(Event.CHANGE,this.onTargetTypeAllKindBtnChangeHandler);
            selectFilterSimple(this.getTargetTypeArray(),_loc3_.targetType,false);
            this.targetTypeAllKindBtn.group.addEventListener(Event.CHANGE,this.onTargetTypeAllKindBtnChangeHandler);
            dispatchViewChange();
        }

        override public function setSubFilterData(param1:int, param2:ShopSubFilterData) : void
        {
        }

        override public function updateSubFilter(param1:int) : void
        {
        }

        override protected function onDispose() : void
        {
            this.targetTypeAllKindBtn.group.removeEventListener(Event.CHANGE,this.onTargetTypeAllKindBtnChangeHandler);
            this.targetTypeAllKindBtn.dispose();
            this.targetTypeAllKindBtn = null;
            this.targetTypeForCrewBtn.dispose();
            this.targetTypeForCrewBtn = null;
            this.targetTypeForEquipmentBtn.dispose();
            this.targetTypeForEquipmentBtn = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.targetTypeAllKindBtn.label = MENU.SHOP_MENU_BATTLEBOOSTER_TARGETTYPE_ALLKIND_NAME;
            this.targetTypeForCrewBtn.label = MENU.SHOP_MENU_BATTLEBOOSTER_TARGETTYPE_FORCREW_NAME;
            this.targetTypeForEquipmentBtn.label = MENU.SHOP_MENU_BATTLEBOOSTER_TARGETTYPE_FOREQUIPMENT_NAME;
        }

        override protected function onKindChanged() : void
        {
            initializeControlsByHash(STORE_CONSTANTS.BATTLE_BOOSTER,this.getTargetTypeArray(),TARGET_TYPE_NAME);
            dispatchEvent(getStoreViewEvent(StoreViewsEvent.POPULATE_MENU_FILTER));
        }

        private function getTargetTypeArray() : Vector.<ViewUIElementVO>
        {
            if(this._obtainingTypeArr == null)
            {
                this._obtainingTypeArr = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.ALL_KIND_FIT,this.targetTypeAllKindBtn),new ViewUIElementVO(STORE_CONSTANTS.FOR_CREW_FIT,this.targetTypeForCrewBtn),new ViewUIElementVO(STORE_CONSTANTS.FOR_EQUIPMENT_FIT,this.targetTypeForEquipmentBtn)];
            }
            return this._obtainingTypeArr;
        }

        private function getTargetType() : String
        {
            var _loc1_:ButtonGroup = this.targetTypeAllKindBtn.group;
            return String(_loc1_.selectedButton != null?_loc1_.data:this.targetTypeAllKindBtn.data);
        }

        private function onTargetTypeAllKindBtnChangeHandler(param1:Event) : void
        {
            dispatchViewChange();
        }
    }
}
