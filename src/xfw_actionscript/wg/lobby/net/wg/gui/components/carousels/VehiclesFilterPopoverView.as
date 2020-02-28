package net.wg.gui.components.carousels
{
    import net.wg.infrastructure.base.meta.impl.TankCarouselFilterPopoverMeta;
    import net.wg.infrastructure.base.meta.ITankCarouselFilterPopoverMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SimpleTileList;
    import net.wg.gui.components.advanced.interfaces.ISearchInput;
    import flash.display.DisplayObject;
    import net.wg.gui.components.carousels.data.FilterCarouseInitVO;
    import net.wg.gui.components.carousels.data.FiltersStateVO;
    import net.wg.utils.IClassFactory;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.DirectionMode;
    import net.wg.gui.components.controls.events.RendererEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.gui.components.popovers.PopOver;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.popovers.PopOverConst;

    public class VehiclesFilterPopoverView extends TankCarouselFilterPopoverMeta implements ITankCarouselFilterPopoverMeta
    {

        protected static const PADDING:Number = 17;

        protected static const DEFAULT_PADDING_BOTTOM:Number = 1;

        private static const INVALIDATE_STATE_DATA:String = "invStateData";

        private static const TOGGLE_TILE_WIDTH:uint = 45;

        private static const TOGGLE_TILE_HEIGHT:uint = 34;

        private static const CHECKBOX_TILE_WIDTH:uint = 110;

        private static const CHECKBOX_TILE_HEIGHT:uint = 25;

        private static const LABEL_OFFSET:uint = 7;

        private static const SEPARATOR_OFFSET:int = -21;

        private static const LINKAGE_TOGGLE_RENDERER_IMG_ALPHA:String = "ToggleRendererImageAlphaUI";

        private static const LINKAGE_CHECKBOX_RENDERER:String = "CheckBoxRendererUI";

        private static const SEARCH_INPUT_OFFSET:int = 17;

        public var lblTitle:TextField = null;

        public var countVehicles:TextField = null;

        public var lblNationType:TextField = null;

        public var lblVehicleType:TextField = null;

        public var lblVehicleLevel:TextField = null;

        public var lblHidden:TextField = null;

        public var lblSpecials:TextField = null;

        public var lblProgressions:TextField = null;

        public var listNationType:SimpleTileList = null;

        public var listVehicleType:SimpleTileList = null;

        public var listVehicleLevels:SimpleTileList = null;

        public var listSpecials:SimpleTileList = null;

        public var listHidden:SimpleTileList = null;

        public var listProgressions:SimpleTileList = null;

        public var searchInput:ISearchInput = null;

        public var separatorTop:DisplayObject = null;

        public var separatorBottom:DisplayObject = null;

        protected var initData:FilterCarouseInitVO = null;

        protected var currentPopoverHeight:int = 0;

        private var _stateData:FiltersStateVO = null;

        private var _vehicleName:String = null;

        private var _caller:DisplayObject = null;

        public function VehiclesFilterPopoverView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:IClassFactory = App.utils.classFactory;
            this.listNationType.itemRenderer = _loc1_.getClass(LINKAGE_TOGGLE_RENDERER_IMG_ALPHA);
            this.listVehicleType.itemRenderer = this.listVehicleLevels.itemRenderer = this.listSpecials.itemRenderer = this.listProgressions.itemRenderer = _loc1_.getClass(Linkages.TOGGLE_RENDERER_UI);
            this.listHidden.itemRenderer = _loc1_.getClass(LINKAGE_CHECKBOX_RENDERER);
            this.listNationType.tileWidth = this.listVehicleType.tileWidth = this.listVehicleLevels.tileWidth = this.listProgressions.tileWidth = this.listSpecials.tileWidth = TOGGLE_TILE_WIDTH;
            this.listNationType.tileHeight = this.listVehicleType.tileHeight = this.listVehicleLevels.tileHeight = this.listProgressions.tileHeight = this.listSpecials.tileHeight = TOGGLE_TILE_HEIGHT;
            this.listHidden.tileWidth = CHECKBOX_TILE_WIDTH;
            this.listHidden.tileHeight = CHECKBOX_TILE_HEIGHT;
            this.listSpecials.directionMode = this.listHidden.directionMode = this.listNationType.directionMode = this.listVehicleType.directionMode = this.listVehicleLevels.directionMode = this.listProgressions.directionMode = DirectionMode.HORIZONTAL;
            this.listNationType.addEventListener(RendererEvent.ITEM_CLICK,this.onNationTypeItemClickHandler);
            this.listVehicleType.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
            this.listSpecials.addEventListener(RendererEvent.ITEM_CLICK,this.onSpecialItemClickHandler);
            this.listHidden.addEventListener(RendererEvent.ITEM_CLICK,this.onHiddenItemClickHandler);
            this.listProgressions.addEventListener(RendererEvent.ITEM_CLICK,this.onProgressionsItemClickHandler);
            this.listSpecials.addEventListener(Event.RESIZE,this.onListsResizeHandler);
            this.listHidden.addEventListener(Event.RESIZE,this.onListsResizeHandler);
            this.listVehicleLevels.addEventListener(RendererEvent.ITEM_CLICK,this.onLevelsTypeItemClickHandler);
            this.searchInput.addEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
            this.searchInput.addEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
            this.searchInput.addEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
            this._caller = App.popoverMgr.popoverCaller as DisplayObject;
            this._caller.addEventListener(Event.RESIZE,this.onCallerResizeHandler);
        }

        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = this.getPreferredLayout();
            PopOver(wrapper).isCloseBtnVisible = true;
            super.initLayout();
        }

        override protected function onDispose() : void
        {
            this.listNationType.removeEventListener(RendererEvent.ITEM_CLICK,this.onNationTypeItemClickHandler);
            this.listVehicleType.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
            this.listSpecials.removeEventListener(RendererEvent.ITEM_CLICK,this.onSpecialItemClickHandler);
            this.listHidden.removeEventListener(RendererEvent.ITEM_CLICK,this.onHiddenItemClickHandler);
            this.listProgressions.removeEventListener(RendererEvent.ITEM_CLICK,this.onProgressionsItemClickHandler);
            this.listSpecials.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
            this.listHidden.removeEventListener(Event.RESIZE,this.onListsResizeHandler);
            this.listVehicleLevels.removeEventListener(RendererEvent.ITEM_CLICK,this.onLevelsTypeItemClickHandler);
            this.lblTitle = null;
            this.lblNationType = null;
            this.lblVehicleType = null;
            this.lblVehicleLevel = null;
            this.lblSpecials = null;
            this.lblHidden = null;
            this.lblProgressions = null;
            this.countVehicles = null;
            this.listNationType.dispose();
            this.listNationType = null;
            this.listVehicleType.dispose();
            this.listVehicleType = null;
            this.listSpecials.dispose();
            this.listSpecials = null;
            this.listHidden.dispose();
            this.listHidden = null;
            this.listVehicleLevels.dispose();
            this.listVehicleLevels = null;
            this.listProgressions.dispose();
            this.listProgressions = null;
            this.searchInput.removeEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
            this.searchInput.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
            this.searchInput.removeEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
            this.searchInput.dispose();
            this.searchInput = null;
            this.initData = null;
            this._stateData = null;
            this.separatorBottom = null;
            this.separatorTop = null;
            if(this._caller)
            {
                this._caller.removeEventListener(Event.RESIZE,this.onCallerResizeHandler);
                this._caller = null;
            }
            super.onDispose();
        }

        override protected function setInitData(param1:FilterCarouseInitVO) : void
        {
            App.utils.asserter.assertNull(this.initData,"Reinitialization TanksFilterPopover");
            this.initData = param1;
            this.lblTitle.htmlText = this.initData.titleLabel;
            this.lblNationType.htmlText = this.initData.nationsLabel;
            this.lblVehicleType.htmlText = this.initData.vehicleTypesLabel;
            this.lblVehicleLevel.htmlText = this.initData.levelsLabel;
            this.lblSpecials.htmlText = this.initData.specialsLabel;
            this.lblHidden.htmlText = this.initData.hiddenLabel;
            this.lblProgressions.htmlText = this.initData.progressionsLabel;
            this.listNationType.dataProvider = this.initData.nations;
            this.listVehicleType.dataProvider = this.initData.vehicleTypes;
            this.listSpecials.dataProvider = this.initData.specials;
            this.listVehicleLevels.dataProvider = this.initData.levels;
            this.listHidden.dataProvider = this.initData.hidden;
            this.listProgressions.dataProvider = this.initData.progressions;
            this.lblHidden.visible = this.initData.hiddenSectionVisible;
            this.listHidden.visible = this.initData.hiddenSectionVisible;
            this.lblSpecials.visible = this.initData.specialSectionVisible;
            this.listSpecials.visible = this.initData.specialSectionVisible;
            this.lblVehicleLevel.visible = this.initData.tankTierSectionVisible;
            this.listVehicleLevels.visible = this.initData.tankTierSectionVisible;
            this.lblProgressions.visible = this.initData.progressionsSectionVisible;
            this.listProgressions.visible = this.initData.progressionsSectionVisible;
            this.separatorBottom.visible = this.initData.searchSectionVisible;
            this.searchInput.visible = this.initData.searchSectionVisible;
            this.searchInput.defaultText = this.initData.searchInputLabel;
            this.searchInput.text = this.initData.searchInputName;
            this.searchInput.maxChars = this.initData.searchInputMaxChars;
            popoverLayout.changeableArrowDirection = this.initData.changeableArrowDirection;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._stateData != null && isInvalid(INVALIDATE_STATE_DATA))
            {
                this.listSetState(this.listNationType,this._stateData.nationsSelected);
                this.listSetState(this.listVehicleType,this._stateData.vehicleTypesSelected);
                this.listSetState(this.listSpecials,this._stateData.specialsSelected);
                this.listSetState(this.listHidden,this._stateData.hiddenSelected);
                this.listSetState(this.listVehicleLevels,this._stateData.levelsSelected);
                this.listSetState(this.listProgressions,this._stateData.progressionsSelected);
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
                updateCallerGlobalPosition();
                popoverLayout.invokeLayout();
            }
        }

        override protected function setState(param1:FiltersStateVO) : void
        {
            this._stateData = param1;
            invalidate(INVALIDATE_STATE_DATA);
        }

        public function as_showCounter(param1:String) : void
        {
            this.countVehicles.htmlText = param1;
        }

        protected function getPreferredLayout() : int
        {
            return PopOverConst.ARROW_TOP;
        }

        protected function updateSize() : void
        {
            this.listNationType.validateNow();
            var _loc1_:* = this.listNationType.y + this.listNationType.height + DEFAULT_PADDING_BOTTOM ^ 0;
            if(this.initData != null && this.initData.tankTierSectionVisible)
            {
                this.listVehicleLevels.validateNow();
                _loc1_ = this.listVehicleLevels.y + this.listVehicleLevels.height + DEFAULT_PADDING_BOTTOM ^ 0;
            }
            if(this.initData != null && this.initData.specialSectionVisible)
            {
                this.lblSpecials.y = _loc1_;
                this.listSpecials.validateNow();
                this.listSpecials.y = this.lblSpecials.y + this.lblSpecials.height + LABEL_OFFSET ^ 0;
                _loc1_ = this.listSpecials.y + this.listSpecials.height + DEFAULT_PADDING_BOTTOM ^ 0;
            }
            if(this.initData != null && this.initData.hiddenSectionVisible)
            {
                this.lblHidden.y = _loc1_;
                this.listHidden.validateNow();
                this.listHidden.y = this.lblHidden.y + this.lblHidden.height + LABEL_OFFSET ^ 0;
                _loc1_ = this.listHidden.y + this.listHidden.height + DEFAULT_PADDING_BOTTOM ^ 0;
            }
            if(this.initData != null && this.initData.progressionsSectionVisible)
            {
                this.lblProgressions.y = _loc1_;
                this.listProgressions.validateNow();
                this.listProgressions.y = this.lblProgressions.y + this.lblProgressions.height + LABEL_OFFSET ^ 0;
                _loc1_ = this.listProgressions.y + this.listProgressions.height + DEFAULT_PADDING_BOTTOM ^ 0;
            }
            this.currentPopoverHeight = _loc1_;
            if(this.initData != null && this.initData.searchSectionVisible)
            {
                this.separatorBottom.y = _loc1_ + SEPARATOR_OFFSET;
                this.searchInput.y = this.separatorBottom.y + this.separatorBottom.height + SEARCH_INPUT_OFFSET;
                this.currentPopoverHeight = this.searchInput.y + this.searchInput.height + PADDING;
            }
            setViewSize(width,this.currentPopoverHeight);
        }

        private function listSetState(param1:SimpleTileList, param2:Vector.<Boolean>) : void
        {
            var _loc3_:int = param2.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                param1.getRendererAt(_loc4_).selectable = param2[_loc4_];
                _loc4_++;
            }
        }

        private function onSearchInputRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onSearchInputRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this.initData.searchInputTooltip);
        }

        private function onCallerResizeHandler(param1:Event) : void
        {
            invalidateLayout();
        }

        private function onSearchInputChangeHandler(param1:Event) : void
        {
            var _loc2_:String = this.searchInput.text;
            if(this._vehicleName != _loc2_)
            {
                this._vehicleName = _loc2_;
                changeSearchNameVehicleS(this._vehicleName);
            }
        }

        private function onListsResizeHandler(param1:Event) : void
        {
            this.updateSize();
            param1.stopPropagation();
        }

        private function onNationTypeItemClickHandler(param1:RendererEvent) : void
        {
            changeFilterS(this.initData.nationsSectionId,param1.index);
            param1.stopPropagation();
        }

        private function onLevelsTypeItemClickHandler(param1:RendererEvent) : void
        {
            changeFilterS(this.initData.levelsSectionId,param1.index);
            param1.stopPropagation();
        }

        private function onSpecialItemClickHandler(param1:RendererEvent) : void
        {
            changeFilterS(this.initData.specialSectionId,param1.index);
            param1.stopPropagation();
        }

        private function onHiddenItemClickHandler(param1:RendererEvent) : void
        {
            changeFilterS(this.initData.hiddenSectionId,param1.index);
            param1.stopPropagation();
        }

        private function onVehicleTypeItemClickHandler(param1:RendererEvent) : void
        {
            changeFilterS(this.initData.vehicleTypesSectionId,param1.index);
            param1.stopPropagation();
        }

        private function onProgressionsItemClickHandler(param1:RendererEvent) : void
        {
            changeFilterS(this.initData.progressionsSectionId,param1.index);
            param1.stopPropagation();
        }
    }
}
