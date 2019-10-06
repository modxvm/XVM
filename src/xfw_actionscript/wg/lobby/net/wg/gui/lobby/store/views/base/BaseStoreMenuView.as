package net.wg.gui.lobby.store.views.base
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.store.views.base.interfaces.IStoreMenuView;
    import scaleform.clik.controls.ButtonGroup;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import net.wg.data.VO.ShopSubFilterData;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.data.constants.generated.STORE_TYPES;
    import net.wg.data.components.StoreMenuViewData;
    import scaleform.clik.controls.Button;
    import flash.events.Event;
    import net.wg.gui.lobby.store.StoreViewsEvent;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class BaseStoreMenuView extends UIComponentEx implements IStoreMenuView
    {

        private static const UPDATE_ASSERTION_MESSAGE:String = "updateData must be StoreMenuViewData";

        private static const DEFAULT_FITS_NAME:String = "fits";

        private static const DEFAULT_TAGS_NAME:String = "tags";

        private static const FITTING_TYPE_WARNING_MESSAGE:String = "fitting type accessor invoked before field has been initialized.";

        private static const NAME_LABEL_SUFFIX:String = "/name";

        private static const SLASH_DELIMITER:String = "/";

        private var _fittingType:String = null;

        private var _filterData:ShopSubFilterData = null;

        private var _nation:int = -1;

        private var _tagsArr:Vector.<ViewUIElementVO> = null;

        private var _fitsArr:Vector.<ViewUIElementVO> = null;

        private var _uiName:String = null;

        private var _localizator:Function = null;

        private var _filtersDataHash:Object = null;

        private var _asserter:IAssertable;

        public function BaseStoreMenuView()
        {
            super();
            this._asserter = App.utils.asserter;
        }

        protected static function assertGroupSelection(param1:ButtonGroup, param2:String, param3:Boolean = false) : void
        {
            var _loc4_:IAssertable = null;
            if(App.instance)
            {
                _loc4_ = App.utils.asserter;
                _loc4_.assertNotNull(param1,param2 + ".group" + Errors.CANT_NULL,NullPointerException);
                if(param3)
                {
                    _loc4_.assertNotNull(param1.selectedButton,param2 + ".group.selectedButton" + Errors.CANT_NULL);
                }
            }
        }

        private static function initializeControlsByHashLocalized(param1:String, param2:Vector.<ViewUIElementVO>, param3:String, param4:Function) : void
        {
            var _loc5_:ViewUIElementVO = null;
            if(App.instance)
            {
                for each(_loc5_ in param2)
                {
                    _loc5_.instance.data = _loc5_.name;
                    _loc5_.instance.label = param4(param1 + SLASH_DELIMITER + param3 + SLASH_DELIMITER + _loc5_.name + NAME_LABEL_SUFFIX,_loc5_.htmlIcon);
                }
            }
        }

        override protected function onDispose() : void
        {
            if(this._tagsArr != null)
            {
                this.disposeUIElementVOs(this._tagsArr);
                this._tagsArr = null;
            }
            if(this._fitsArr != null)
            {
                this.disposeUIElementVOs(this._fitsArr);
                this._fitsArr = null;
            }
            this._filterData = null;
            if(this._filtersDataHash != null)
            {
                App.utils.data.cleanupDynamicObject(this._filtersDataHash);
                this._filtersDataHash = null;
            }
            this._localizator = null;
            this._asserter = null;
            super.onDispose();
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }

        public function getFiltersData() : FiltersVO
        {
            throw this.abstractInvoke("getFiltersData");
        }

        public function resetTemporaryHandlers() : void
        {
        }

        public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            this._filtersDataHash = param1.toHash();
        }

        public function setSubFilterData(param1:int, param2:ShopSubFilterData) : void
        {
            throw this.abstractInvoke("setSubFilterData",param1,param2);
        }

        public function setUIName(param1:String, param2:Function) : void
        {
            this._asserter.assert(param1 == STORE_TYPES.SHOP || param1 == STORE_TYPES.INVENTORY,"incorrect uiName: \'" + param1 + "\'");
            this._uiName = param1;
            gotoAndStop(this._uiName);
            this._localizator = param2;
            if(this._fitsArr != null)
            {
                this.disposeUIElementVOs(this._fitsArr);
                this._fitsArr = null;
            }
        }

        public final function update(param1:Object) : void
        {
            var _loc2_:StoreMenuViewData = null;
            if(App.instance)
            {
                this._asserter.assert(param1 is StoreMenuViewData,UPDATE_ASSERTION_MESSAGE);
                _loc2_ = StoreMenuViewData(param1);
                if(this._fittingType != _loc2_.fittingType)
                {
                    this._fittingType = _loc2_.fittingType;
                    this.onKindChanged();
                }
            }
        }

        public function updateSubFilter(param1:int) : void
        {
            throw this.abstractInvoke("updateSubFilter",param1);
        }

        protected function getSelectedFilters(param1:Vector.<ViewUIElementVO>) : Vector.<String>
        {
            var _loc3_:ViewUIElementVO = null;
            var _loc2_:Vector.<String> = new Vector.<String>(0);
            for each(_loc3_ in param1)
            {
                if(_loc3_.instance.selected)
                {
                    this._asserter.assertNotNull(_loc3_.instance.data,_loc3_.instance.name + ".data" + Errors.CANT_NULL);
                    _loc2_.push(_loc3_.instance.data);
                }
            }
            return _loc2_;
        }

        protected function getUIName() : String
        {
            return this._uiName;
        }

        protected final function selectFilter(param1:Vector.<ViewUIElementVO>, param2:Vector.<String>, param3:Boolean, param4:Boolean) : void
        {
            var _loc5_:ViewUIElementVO = null;
            var _loc6_:Button = null;
            var _loc7_:String = null;
            for each(_loc5_ in param1)
            {
                _loc6_ = _loc5_.instance;
                this._asserter.assertNotNull(_loc6_.data,"data of filter control" + Errors.CANT_NULL);
                for each(_loc7_ in param2)
                {
                    if(_loc7_ == _loc6_.data)
                    {
                        _loc6_.selected = true;
                        break;
                    }
                }
                if(param3)
                {
                    if(!_loc6_.hasEventListener(Event.SELECT))
                    {
                        _loc6_.addEventListener(Event.SELECT,this.onItemSelectHandler);
                    }
                }
            }
            if(param4)
            {
                this.addHandlerToGroup(_loc6_);
            }
        }

        protected final function addHandlerToGroup(param1:Button) : void
        {
            var _loc2_:ButtonGroup = param1.group;
            if(App.instance)
            {
                this._asserter.assertNotNull(param1,"instance" + Errors.CANT_NULL,NullPointerException);
            }
            assertGroupSelection(_loc2_,param1.name);
            _loc2_.addEventListener(Event.CHANGE,this.onGroupChangeHandler);
        }

        protected final function selectFilterSimple(param1:Vector.<ViewUIElementVO>, param2:Object, param3:Boolean) : void
        {
            var _loc4_:ViewUIElementVO = null;
            var _loc5_:Button = null;
            var _loc6_:ButtonGroup = null;
            for each(_loc4_ in param1)
            {
                _loc5_ = _loc4_.instance;
                if(param2 == _loc5_.data)
                {
                    _loc5_.selected = true;
                    break;
                }
            }
            if(param3)
            {
                _loc6_ = _loc5_.group;
                assertGroupSelection(_loc6_,_loc5_.name);
                _loc6_.addEventListener(Event.CHANGE,this.onGroupChangeHandler);
            }
        }

        protected final function resetHandlers(param1:Vector.<ViewUIElementVO>, param2:Button) : void
        {
            var _loc3_:ViewUIElementVO = null;
            for each(_loc3_ in param1)
            {
                _loc3_.instance.removeEventListener(Event.SELECT,this.onItemSelectHandler);
            }
            if(param2 != null)
            {
                param2.group.removeEventListener(Event.CHANGE,this.onGroupChangeHandler);
            }
        }

        protected function getNation() : int
        {
            return this._nation;
        }

        protected function getFilterData() : ShopSubFilterData
        {
            return this._filterData;
        }

        protected function setFilterData(param1:ShopSubFilterData) : void
        {
            if(App.instance)
            {
                this._asserter.assertNotNull(param1,"shopVehicleFilterData" + Errors.CANT_NULL);
                this._asserter.assert(param1.current != 0,"incorrect current id from python!");
                this._asserter.assertNotNull(param1.dataProvider,"shopVehicleFilterData.dataProvider" + Errors.CANT_NULL);
            }
            this._filterData = param1;
        }

        protected final function dispatchViewChange() : void
        {
            dispatchEvent(this.getStoreViewEvent(StoreViewsEvent.VIEW_CHANGE));
        }

        protected function onKindChanged() : void
        {
            this.initializeControlsByHash(this.specialKindForTags(),this.getTagsArray(),this.getTagsName());
            this.initializeControlsByHash(this._fittingType,this.getFitsArray(),this.getFitsName());
            dispatchEvent(this.getStoreViewEvent(StoreViewsEvent.POPULATE_MENU_FILTER));
        }

        protected final function getTagsArray() : Vector.<ViewUIElementVO>
        {
            if(this._tagsArr == null)
            {
                this._tagsArr = this.onTagsArrayRequest();
            }
            return this._tagsArr;
        }

        protected function onTagsArrayRequest() : Vector.<ViewUIElementVO>
        {
            throw this.abstractInvoke("onTagsArrayRequest");
        }

        protected final function getFitsArray() : Vector.<ViewUIElementVO>
        {
            if(this._fitsArr == null)
            {
                this._fitsArr = this.onFitsArrayRequest();
            }
            return this._fitsArr;
        }

        protected function onFitsArrayRequest() : Vector.<ViewUIElementVO>
        {
            throw this.abstractInvoke("onFitsArrayRequest");
        }

        protected function getFitsName() : String
        {
            return DEFAULT_FITS_NAME;
        }

        protected function getTagsName() : String
        {
            return DEFAULT_TAGS_NAME;
        }

        protected function specialKindForTags() : String
        {
            return this.fittingType;
        }

        protected function initializeControlsByHash(param1:String, param2:Vector.<ViewUIElementVO>, param3:String) : void
        {
            this._asserter.assertNotNull(this._localizator,"_localizator" + Errors.CANT_NULL);
            initializeControlsByHashLocalized(param1,param2,param3,this._localizator);
        }

        protected function disposeUIElementVOs(param1:Vector.<ViewUIElementVO>) : void
        {
            var _loc2_:ViewUIElementVO = null;
            for each(_loc2_ in param1)
            {
                _loc2_.dispose();
            }
            param1.splice(0,param1.length);
        }

        protected function getStoreViewEvent(param1:String) : StoreViewsEvent
        {
            return new StoreViewsEvent(param1,this.fittingType);
        }

        private function abstractInvoke(param1:String, ... rest) : Error
        {
            return new AbstractException(this.toString() + "\'::" + param1 + "(" + rest.join(",") + ")\'" + Errors.ABSTRACT_INVOKE);
        }

        public function get fittingType() : String
        {
            if(this._fittingType == null)
            {
                DebugUtils.LOG_WARNING(FITTING_TYPE_WARNING_MESSAGE);
            }
            return this._fittingType;
        }

        protected function get filtersDataHash() : Object
        {
            return this._filtersDataHash;
        }

        private function onItemSelectHandler(param1:Event) : void
        {
            this.dispatchViewChange();
        }

        private function onGroupChangeHandler(param1:Event) : void
        {
            this.dispatchViewChange();
        }
    }
}
