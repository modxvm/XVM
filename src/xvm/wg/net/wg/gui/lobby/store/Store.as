package net.wg.gui.lobby.store 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import net.wg.data.*;
    import net.wg.data.VO.*;
    import net.wg.data.VO.generated.*;
    import net.wg.data.components.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class Store extends net.wg.infrastructure.base.meta.impl.StoreMeta implements net.wg.infrastructure.base.meta.IStoreMeta
    {
        public function Store()
        {
            super();
            this._viewsHash = new flash.utils.Dictionary(false);
            return;
        }

        protected function onMenuChange():void
        {
            return;
        }

        protected function onViewNeedUpdate(arg1:net.wg.infrastructure.interfaces.IStoreMenuView, arg2:String):void
        {
            this.setCurrentView(arg1);
            return;
        }

        protected function getCurrentView():net.wg.infrastructure.interfaces.IStoreMenuView
        {
            return this._currentView;
        }

        protected function setCurrentView(arg1:net.wg.infrastructure.interfaces.IStoreMenuView):void
        {
            if (this._currentView != arg1) 
            {
                if (this._currentView) 
                {
                    this._currentView.removeEventListener(net.wg.gui.lobby.store.StoreViewsEvent.POPULATE_MENU_FILTER, this.onPopulateMenuFilterNeedHandler);
                    this._currentView.removeEventListener(net.wg.gui.lobby.store.StoreViewsEvent.VIEW_CHANGE, this.onMenuChangeHandler);
                    this._currentView.resetTemporaryHandlers();
                }
                this._currentView = arg1;
                if (this._currentView) 
                {
                    this._currentView.setUIName(getNameS(), this.getLocalizator());
                    this._currentView.addEventListener(net.wg.gui.lobby.store.StoreViewsEvent.POPULATE_MENU_FILTER, this.onPopulateMenuFilterNeedHandler);
                    this._currentView.addEventListener(net.wg.gui.lobby.store.StoreViewsEvent.VIEW_CHANGE, this.onMenuChangeHandler);
                }
            }
            return;
        }

        protected function onPopulateMenuFilterNeed(arg1:String):void
        {
            if (!this.initializing) 
                requestFilterDataS(arg1);
            return;
        }

        public function get subFilterData():net.wg.data.VO.ShopSubFilterData
        {
            return this._subFilterData;
        }

        protected function initMenu(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            assertNotNull(arg1, "localeEnumProcessor", net.wg.infrastructure.exceptions.NullPointerException);
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc5:*=0;
            var loc6:*=net.wg.data.constants.FittingTypes.STORE_SLOTS;
            for each (loc4 in loc6) 
            {
                loc3 = this.getLinkageFromFittingType(loc4);
                loc2 = new net.wg.data.components.StoreMenuViewData({"label":arg1(loc4 + "/name"), "linkage":loc3, "fittingType":loc4, "enabled":true});
                this._viewsHash[loc3] = loc2;
                loc1.push(loc2);
            }
            this.menu.dataProvider = loc1;
            return;
        }

        internal function onViewNeedUpdateHandler(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            this._programUpdating = true;
            this.onViewNeedUpdate(net.wg.infrastructure.interfaces.IStoreMenuView(arg1.view), arg1.linkage);
            this._programUpdating = false;
            return;
        }

        internal function onNationMenuChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            this.onMenuChange();
            return;
        }

        internal function onMenuChangeHandler(arg1:flash.events.Event):void
        {
            this.onMenuChange();
            return;
        }

        internal function onMenuChangeTypeHandler(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.onMenuChangeType();
            return;
        }

        internal function onPopulateMenuFilterNeedHandler(arg1:net.wg.gui.lobby.store.StoreViewsEvent):void
        {
            this.onPopulateMenuFilterNeed(arg1.viewType);
            return;
        }

        internal function onCloseButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onCloseButtonClickS();
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            onCloseButtonClickS();
            return;
        }

        public function get nation():Number
        {
            return this._nation;
        }

        public function set nation(arg1:Number):void
        {
            this._nation = arg1;
            return;
        }

        internal function onInfoItemHandler(arg1:net.wg.gui.lobby.store.StoreEvent):void
        {
            onShowInfoS(arg1.data);
            return;
        }

        protected function get initializing():Boolean
        {
            return this._initializing;
        }

        public final override function setViewSize(arg1:Number, arg2:Number):void
        {
            this._myWidth = arg1;
            this._myHeight = arg2;
            invalidateSize();
            return;
        }

        public final override function updateStage(arg1:Number, arg2:Number):void
        {
            this.setViewSize(arg1, arg2);
            return;
        }

        protected final override function preInitialize():void
        {
            super.preInitialize();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        protected override function configUI():void
        {
            assert(this.storeTable is flash.display.DisplayObject, "storeTable must extends a DisplayObject class");
            constraints.addElement(this.nationFilter.name, this.nationFilter, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.storeTable.name, flash.display.DisplayObject(this.storeTable), scaleform.clik.utils.Constraints.ALL);
            this.updateStage(parent.width, parent.height);
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCloseButtonClickHandler);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            super.configUI();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.storeTable, net.wg.data.Aliases.SHOP_TABLE);
            this.storeTable.addEventListener(net.wg.gui.lobby.store.StoreEvent.INFO, this.onInfoItemHandler);
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            this.setCurrentView(null);
            this._subFilterData.dispose();
            this._subFilterData = null;
            this.nationFilter.nation.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onNationMenuChangeHandler);
            this.menu.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onMenuChangeTypeHandler);
            this.menu.view.removeEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
            this.menu.dispose();
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCloseButtonClickHandler);
            var loc2:*=0;
            var loc3:*=this._viewsHash;
            for each (loc1 in loc3) 
                delete this._viewsHash[loc1];
            this._viewsHash = null;
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            super.onDispose();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                x = this._myWidth - _originalWidth >> 1;
                y = this._myHeight - _originalHeight >> 1;
            }
            return;
        }

        protected override function setFilterType(arg1:net.wg.data.VO.generated.ShopNationFilterData):void
        {
            var loc2:*=null;
            this.nationFilter.nation.selectedIndex = arg1.language + 1;
            var loc1:*=net.wg.data.constants.FittingTypes.STORE_SLOTS.indexOf(arg1.type);
            if (loc1 != -1) 
            {
                this.menu.selectedIndex = loc1;
                if (this.initializing) 
                {
                    this.menu.validateNow();
                    loc2 = net.wg.infrastructure.interfaces.IStoreMenuView(this.menu.view.currentView);
                    this.onViewNeedUpdate(loc2, this.getLinkageFromFittingType(arg1.type));
                }
            }
            return;
        }

        public function as_setNations(arg1:Array):void
        {
            assert(arg1.length > 0, net.wg.data.constants.Errors.CANT_EMPTY);
            this.nationFilter.nation.menuRowCount = arg1.length;
            this.nationFilter.nation.createNationFilter(arg1);
            if (this.initializing) 
                this.initMenu(this.getLocalizator());
            return;
        }

        public function as_setSubFilter(arg1:Object):void
        {
            this._subFilterData = new net.wg.data.VO.ShopSubFilterData(arg1);
            assertNotNull(this.getCurrentView(), "currentView", net.wg.infrastructure.exceptions.NullPointerException);
            this.getCurrentView().setSubFilterData((this.nationFilter.nation.selectedIndex - 1), this._subFilterData);
            return;
        }

        public function as_setFilterOptions(arg1:Array):void
        {
            assertNotNull(this.getCurrentView(), "current view must be selected!", net.wg.infrastructure.exceptions.NullPointerException);
            this.getCurrentView().setViewData(arg1);
            return;
        }

        public function as_completeInit():void
        {
            this.menu.view.addEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
            this.menu.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onMenuChangeTypeHandler);
            this.nationFilter.nation.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onNationMenuChangeHandler);
            this._initializing = false;
            return;
        }

        public function as_update():void
        {
            this.updateTable();
            return;
        }

        protected function getLocalizator():Function
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("\'getLocalizator\'" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected final function updateTable():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.nation != (this.nationFilter.nation.selectedIndex - 1)) 
                if (this._currentView) 
                {
                    this.nation = (this.nationFilter.nation.selectedIndex - 1);
                    this._currentView.updateSubFilter(this.nation);
                }
            if (this.menu.enabled && this._currentView && !this._programUpdating) 
            {
                loc1 = this._currentView.getFilter();
                loc2 = this._currentView.fittingType;
                assertNotNull(loc2, "fittingType");
                requestTableDataS(this.nation, loc2, loc1);
            }
            return;
        }

        protected function getLinkageFromFittingType(arg1:String):String
        {
            assertNotNull(arg1, "fittingType", net.wg.infrastructure.exceptions.NullPointerException);
            return arg1 + "ViewUI";
        }

        protected function getViewData(arg1:String):net.wg.data.components.StoreMenuViewData
        {
            assert(this._viewsHash.hasOwnProperty(arg1), "unknown view linkage:" + arg1);
            return this._viewsHash[arg1];
        }

        protected function onMenuChangeType():void
        {
            this.onMenuChange();
            return;
        }

        public var storeTable:net.wg.infrastructure.interfaces.IStoreTable=null;

        public var menu:net.wg.gui.components.advanced.Accordion=null;

        public var title:net.wg.gui.components.controls.TextFieldShort=null;

        public var nationFilter:net.wg.gui.lobby.store.NationFilter=null;

        public var closeButton:net.wg.gui.components.controls.CloseButton=null;

        internal var _currentView:net.wg.infrastructure.interfaces.IStoreMenuView=null;

        internal var _myWidth:Number=0;

        internal var _myHeight:Number=0;

        internal var _programUpdating:Boolean=false;

        internal var _subFilterData:net.wg.data.VO.ShopSubFilterData=null;

        internal var _viewsHash:flash.utils.Dictionary=null;

        internal var _nation:Number=-1;

        internal var _initializing:Boolean=true;
    }
}
