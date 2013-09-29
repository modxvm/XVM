package net.wg.gui.lobby.store.views.base 
{
    import flash.events.*;
    import net.wg.data.VO.*;
    import net.wg.data.components.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.store.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    
    public class BaseStoreMenuView extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IStoreMenuView
    {
        public function BaseStoreMenuView()
        {
            super();
            return;
        }

        protected function initializeControlsByHash(arg1:String, arg2:Array, arg3:String, arg4:String):void
        {
            App.utils.asserter.assertNotNull(this._localizator, "_localizator" + net.wg.data.constants.Errors.CANT_NULL);
            initializeControlsByHashLocalized(arg1, arg2, arg3, arg4, this._localizator);
            return;
        }

        internal function getStoreViewEvent(arg1:String):net.wg.gui.lobby.store.StoreViewsEvent
        {
            return new net.wg.gui.lobby.store.StoreViewsEvent(arg1, this.fittingType);
        }

        internal function abstractInvoke(arg1:String, ... rest):Error
        {
            return new net.wg.infrastructure.exceptions.AbstractException(this.toString() + "\'::" + arg1 + "(" + rest.join(",") + ")\'" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        internal function onFilterChangeHandler(arg1:flash.events.Event):void
        {
            this.dispatchViewChange();
            return;
        }

        protected static function assertGroupSelection(arg1:scaleform.clik.controls.ButtonGroup, arg2:String, arg3:Boolean=false):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                (loc1 = App.utils.asserter).assertNotNull(arg1, arg2 + ".group" + net.wg.data.constants.Errors.CANT_NULL, net.wg.infrastructure.exceptions.NullPointerException);
                if (arg3) 
                {
                    loc1.assertNotNull(arg1.selectedButton, arg2 + ".group.selectedButton" + net.wg.data.constants.Errors.CANT_NULL);
                }
            }
            return;
        }

        protected static function getSelectedFilters(arg1:Array, arg2:Boolean, arg3:scaleform.clik.controls.Button):Array
        {
            var loc2:*=null;
            var loc1:*=[];
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                if (!(loc2.instance.selected || arg3 && arg3.selected)) 
                {
                    continue;
                }
                App.utils.asserter.assertNotNull(loc2.instance.data, loc2.instance.name + ".data" + net.wg.data.constants.Errors.CANT_NULL);
                loc1.push(loc2.instance.data);
            }
            if (arg2) 
            {
                loc1.unshift(loc1.length);
            }
            return loc1;
        }

        internal static function initializeControlsByHashLocalized(arg1:String, arg2:Array, arg3:String, arg4:String, arg5:Function):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                var loc2:*=0;
                var loc3:*=arg2;
                for each (loc1 in loc3) 
                {
                    if (!loc1.instance.visible) 
                    {
                        continue;
                    }
                    loc1.instance.data = loc1.name;
                    loc1.instance.label = arg5(arg1 + "/" + arg4 + "/" + loc1.name + "/name");
                }
            }
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            super.dispose();
            if (this._tagsArr != null) 
            {
                var loc3:*=0;
                var loc4:*=this._tagsArr;
                for each (loc1 in loc4) 
                {
                    loc1.dispose();
                }
                this._tagsArr.splice(0);
                this._tagsArr = null;
            }
            if (this._fitsArr != null) 
            {
                loc3 = 0;
                loc4 = this._fitsArr;
                for each (loc2 in loc4) 
                {
                    loc2.dispose();
                }
                this._fitsArr.splice(0);
                this._fitsArr = null;
            }
            this._filterData = null;
            return;
        }

        public final function update(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (App.instance) 
            {
                loc1 = "updateData must be StoreMenuViewData";
                App.utils.asserter.assert(arg1 is net.wg.data.components.StoreMenuViewData, loc1);
                loc2 = net.wg.data.components.StoreMenuViewData(arg1);
                if (this._fittingType != loc2.fittingType) 
                {
                    this._fittingType = loc2.fittingType;
                    this.onKindChanged();
                }
            }
            return;
        }

        public function resetTemporaryHandlers():void
        {
            return;
        }

        public function setUIName(arg1:String, arg2:Function):void
        {
            App.utils.asserter.assert(arg1 == net.wg.data.constants.generated.STORE_TYPES.SHOP || arg1 == net.wg.data.constants.generated.STORE_TYPES.INVENTORY, "incorrect uiName: \'" + arg1 + "\'");
            this._uiName = arg1;
            gotoAndStop(this._uiName);
            this._localizator = arg2;
            if (this._fitsArr != null) 
            {
                this._fitsArr.splice();
                this._fitsArr = null;
            }
            return;
        }

        protected function getUIName():String
        {
            return this._uiName;
        }

        public function setSubFilterData(arg1:int, arg2:net.wg.data.VO.ShopSubFilterData):void
        {
            throw this.abstractInvoke("setSubFilterData", arg1, arg2);
        }

        public function updateSubFilter(arg1:int):void
        {
            throw this.abstractInvoke("updateSubFilter", arg1);
        }

        public function getFilter():Array
        {
            throw this.abstractInvoke("getFilter");
        }

        public function setViewData(arg1:Array):void
        {
            throw this.abstractInvoke("setViewData", arg1);
        }

        public function get fittingType():String
        {
            if (this._fittingType == null) 
            {
                DebugUtils.LOG_WARNING("fitting type accessor invoked before field has been initialized.");
            }
            return this._fittingType;
        }

        protected final function selectFilter(arg1:Array, arg2:Array, arg3:Boolean, arg4:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=arg1;
            for each (loc1 in loc5) 
            {
                loc2 = loc1.instance;
                App.utils.asserter.assertNotNull(loc2.data, "data of filter control" + net.wg.data.constants.Errors.CANT_NULL);
                var loc6:*=0;
                var loc7:*=arg2;
                for each (loc3 in loc7) 
                {
                    if (loc3 != loc2.data) 
                    {
                        continue;
                    }
                    loc2.selected = true;
                    break;
                }
                if (!arg3) 
                {
                    continue;
                }
                if (loc2.hasEventListener(flash.events.Event.SELECT)) 
                {
                    continue;
                }
                loc2.addEventListener(flash.events.Event.SELECT, this.onFilterChangeHandler);
            }
            if (arg4) 
            {
                this.addHandlerToGroup(loc2);
            }
            return;
        }

        protected final function addHandlerToGroup(arg1:scaleform.clik.controls.Button):void
        {
            var loc1:*=arg1.group;
            if (App.instance) 
            {
                App.utils.asserter.assertNotNull(arg1, "instance" + net.wg.data.constants.Errors.CANT_NULL, net.wg.infrastructure.exceptions.NullPointerException);
            }
            assertGroupSelection(loc1, arg1.name);
            loc1.addEventListener(flash.events.Event.CHANGE, this.onFilterChangeHandler);
            return;
        }

        protected final function selectFilterSimple(arg1:Array, arg2:Object, arg3:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=arg1;
            for each (loc1 in loc5) 
            {
                loc2 = loc1.instance;
                if (arg2 != loc2.data) 
                {
                    continue;
                }
                loc2.selected = true;
                break;
            }
            if (arg3) 
            {
                loc3 = loc2.group;
                assertGroupSelection(loc3, loc2.name);
                loc3.addEventListener(flash.events.Event.CHANGE, this.onFilterChangeHandler);
            }
            return;
        }

        protected final function resetHandlers(arg1:Array, arg2:scaleform.clik.controls.Button):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for each (loc1 in loc3) 
            {
                loc1.instance.removeEventListener(flash.events.Event.SELECT, this.onFilterChangeHandler);
            }
            if (arg2) 
            {
                arg2.group.removeEventListener(flash.events.Event.CHANGE, this.onFilterChangeHandler);
            }
            return;
        }

        protected function getNation():int
        {
            return this._nation;
        }

        protected function getFilterData():net.wg.data.VO.ShopSubFilterData
        {
            return this._filterData;
        }

        protected function setFilterData(arg1:net.wg.data.VO.ShopSubFilterData):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.asserter;
                loc1.assertNotNull(arg1, "shopVehicleFilterData" + net.wg.data.constants.Errors.CANT_NULL);
                loc1.assert(!(arg1.current == "0"), "incorrect current id from python!");
                loc1.assertNotNull(arg1.dataProvider, "shopVehicleFilterData.dataProvider" + net.wg.data.constants.Errors.CANT_NULL);
            }
            this._filterData = arg1;
            return;
        }

        protected final function dispatchViewChange():void
        {
            dispatchEvent(this.getStoreViewEvent(net.wg.gui.lobby.store.StoreViewsEvent.VIEW_CHANGE));
            return;
        }

        protected function onKindChanged():void
        {
            var loc1:*=" method result";
            this.initializeControlsByHash(this.specialKindForTags(), this.getTagsArray(), "getTagsArray" + loc1, this.getTagsName());
            this.initializeControlsByHash(this._fittingType, this.getFitsArray(), "getFitsArray" + loc1, this.getFitsName());
            dispatchEvent(this.getStoreViewEvent(net.wg.gui.lobby.store.StoreViewsEvent.POPULATE_MENU_FILTER));
            return;
        }

        protected final function getTagsArray():Array
        {
            if (this._tagsArr == null) 
            {
                this._tagsArr = this.onTagsArrayRequest();
            }
            return this._tagsArr;
        }

        protected function onTagsArrayRequest():Array
        {
            throw this.abstractInvoke("onTagsArrayRequest");
        }

        protected final function getFitsArray():Array
        {
            if (this._fitsArr == null) 
            {
                this._fitsArr = this.onFitsArrayRequest();
            }
            return this._fitsArr;
        }

        protected function onFitsArrayRequest():Array
        {
            throw this.abstractInvoke("onFitsArrayRequest");
        }

        protected function getFitsName():String
        {
            return "fits";
        }

        protected function getTagsName():String
        {
            return "tags";
        }

        protected function specialKindForTags():String
        {
            return this.fittingType;
        }

        internal var _fittingType:String=null;

        internal var _filterData:net.wg.data.VO.ShopSubFilterData=null;

        internal var _nation:int=-1;

        internal var _tagsArr:Array=null;

        internal var _fitsArr:Array=null;

        internal var _uiName:String=null;

        internal var _localizator:Function=null;
    }
}
