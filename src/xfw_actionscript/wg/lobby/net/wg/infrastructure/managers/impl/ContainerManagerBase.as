package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.ContainerManagerMeta;
    import net.wg.infrastructure.managers.IContainerManager;
    import net.wg.infrastructure.base.meta.IContainerManagerMeta;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import net.wg.data.constants.generated.APP_CONTAINERS_NAMES;
    import flash.utils.Dictionary;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.utils.IScheduler;
    import net.wg.infrastructure.managers.ILoaderManager;
    import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
    import flash.events.FocusEvent;
    import net.wg.infrastructure.events.LoaderEvent;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import flash.display.DisplayObjectContainer;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import net.wg.data.daapi.LoadViewVO;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.infrastructure.events.ContainerManagerEvent;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.managers.IWaitingView;
    import net.wg.infrastructure.events.LifeCycleEvent;

    public class ContainerManagerBase extends ContainerManagerMeta implements IContainerManager, IContainerManagerMeta
    {

        private static const FOCUS_ORDER:Array = APP_CONTAINERS_NAMES.FOCUS_ORDER;

        private var _nameToView:Object;

        private var _containersForLoadingViews:Dictionary;

        private var _lastFocusedView:IView;

        private var _containersMap:Dictionary;

        private var _addWrapperInNextFrameDict:Dictionary;

        private var _visibleContainers:Vector.<String>;

        private var _scheduler:IScheduler;

        private var _loader:ILoaderManager;

        public function ContainerManagerBase()
        {
            this._nameToView = {};
            this._addWrapperInNextFrameDict = new Dictionary();
            super();
            this._containersMap = new Dictionary();
            this._containersForLoadingViews = new Dictionary();
            if(App && App.utils)
            {
                this._scheduler = App.utils.scheduler;
            }
        }

        private static function getViewName(param1:IManagedContent) : String
        {
            return param1.sourceView.as_config.name;
        }

        override protected function onDispose() : void
        {
            var container:ISimpleManagedContainer = null;
            var key:String = null;
            var taskKey:Function = null;
            try
            {
                this._nameToView = null;
                if(this._scheduler)
                {
                    this._scheduler.cancelAll();
                    this._scheduler = null;
                }
                for(key in this.containersMap)
                {
                    container = this.getContainer(key);
                    assert(container != null,"ContainerManager.onDispose container is null for type " + key);
                    container.removeEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOutHandler);
                    delete this.containersMap[key];
                }
                this.clearContainersForViewsDict();
                this.containersMap = null;
                this._containersForLoadingViews = null;
                this._lastFocusedView = null;
                for each(taskKey in this._addWrapperInNextFrameDict)
                {
                    delete this._addWrapperInNextFrameDict[taskKey];
                }
                this._addWrapperInNextFrameDict = null;
                if(this._loader)
                {
                    this._loader.removeEventListener(LoaderEvent.VIEW_LOADED,this.onViewLoadedHandler);
                    this._loader.removeEventListener(LoaderEvent.VIEW_LOADING,this.onStartLoadViewHandler);
                    this._loader.removeEventListener(LoaderEvent.VIEW_LOADING_CANCEL,this.onViewLoadingCancelHandler);
                    this._loader = null;
                }
                this._containersMap = null;
                if(this._visibleContainers)
                {
                    this._visibleContainers.splice(0,this._visibleContainers.length);
                    this._visibleContainers = null;
                }
            }
            catch(error:Error)
            {
                DebugUtils.LOG_ERROR("ContainerManager.onDispose",error.getStackTrace());
            }
            super.onDispose();
        }

        public function addGFItemInContainer(param1:String, param2:IManagedContent, param3:Boolean = false) : void
        {
            this.addItemInContainer(param1,param2,param3);
        }

        public function addUssItemInContainer(param1:String, param2:IManagedContent, param3:Boolean = false) : void
        {
            this.addItemInContainer(param1,param2,param3);
        }

        public function as_bringToFront(param1:String, param2:String) : void
        {
            var container:IManagedContainer = null;
            var currentView:IManagedContent = null;
            var childrenCount:int = 0;
            var i:int = 0;
            var cType:String = param1;
            var vName:String = param2;
            try
            {
                container = this.getInteractiveContainer(cType);
                currentView = null;
                childrenCount = DisplayObjectContainer(container).numChildren;
                i = 0;
                while(i < childrenCount)
                {
                    currentView = IManagedContent(DisplayObjectContainer(container).getChildAt(i));
                    if(getViewName(currentView) == vName)
                    {
                        container.setFocusedView(currentView);
                        return;
                    }
                    i++;
                }
                return;
            }
            catch(error:Error)
            {
                DebugUtils.LOG_ERROR(error.message,error.getStackTrace());
                return;
            }
        }

        public function as_closePopUps() : void
        {
            if(App.toolTipMgr)
            {
                App.toolTipMgr.hide();
            }
            if(App.utils && App.utils.popupMgr)
            {
                App.utils.popupMgr.removeAll();
            }
        }

        public function as_getView(param1:String) : Boolean
        {
            var _loc3_:ViewInfo = null;
            var _loc2_:* = false;
            if(this._nameToView.hasOwnProperty(param1))
            {
                _loc3_ = this._nameToView[param1];
                _loc3_.setFocused();
                _loc2_ = true;
            }
            return _loc2_;
        }

        public function as_isContainerShown(param1:String) : Boolean
        {
            throw new AbstractException("ContainerManager.as_isContainerShown" + Errors.ABSTRACT_INVOKE);
        }

        public function as_isOnTop(param1:String, param2:String) : Boolean
        {
            var obj:IManagedContent = null;
            var cType:String = param1;
            var vName:String = param2;
            var result:Boolean = false;
            try
            {
                obj = this.getInteractiveContainer(cType).getTopmostView();
                result = obj && vName == getViewName(obj);
            }
            catch(error:Error)
            {
                DebugUtils.LOG_ERROR(error.message,error.getStackTrace());
            }
            return result;
        }

        public function as_registerContainer(param1:String, param2:String) : void
        {
            var _loc7_:ISimpleManagedContainer = null;
            var _loc9_:ISimpleManagedContainer = null;
            assert(!this.containersMap.hasOwnProperty(param1),"ContainerManager.as_registerContainer container for type " + param1 + " is already registered");
            var _loc3_:ViewInfo = this._nameToView[param2];
            assert(_loc3_ != null && _loc3_.view != null,"ContainerManager.as_registerContainer view not found for name " + param2);
            var _loc4_:IView = _loc3_.view;
            var _loc5_:Array = _loc4_.getSubContainers();
            var _loc6_:int = _loc5_.length;
            var _loc8_:* = 0;
            while(_loc8_ < _loc6_ && _loc7_ == null)
            {
                _loc9_ = _loc5_[_loc8_];
                if(_loc9_ != null && _loc9_.type == param1)
                {
                    _loc7_ = _loc9_;
                }
                _loc8_++;
            }
            if(_loc7_ != null)
            {
                this.containersMap[param1] = _loc7_;
                if(_loc7_.manageFocus)
                {
                    _loc7_.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOutHandler);
                }
            }
            else
            {
                assert(false,"ContainerManager.as_registerContainer container is null for type " + param1 + " in view for name " + param2);
            }
        }

        public function as_show(param1:String, param2:int, param3:int) : Boolean
        {
            var _loc6_:IView = null;
            var _loc7_:LoadViewVO = null;
            var _loc4_:* = false;
            var _loc5_:ViewInfo = this._nameToView[param1];
            if(_loc5_ && _loc5_.view)
            {
                _loc6_ = _loc5_.view;
                _loc6_.x = param2;
                _loc6_.y = param3;
                if(App.popoverMgr.isPopover(_loc5_.view))
                {
                    if(!App.popoverMgr.popoverCaller || !App.popoverMgr.popoverCaller.getTargetButton())
                    {
                        return false;
                    }
                }
                _loc5_.addView();
                _loc7_ = _loc6_.as_config;
                this.callLogEvent(_loc6_,EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEW_LOADED,APP_CONTAINERS_NAMES.CONTAINER_TYPES.indexOf(_loc7_.configVO.type));
                this.updateFocus();
                _loc4_ = true;
                dispatchEvent(new ContainerManagerEvent(ContainerManagerEvent.VIEW_ADDED,_loc5_.view,_loc5_.container.type));
                if(_loc7_.configVO.type == APP_CONTAINERS_NAMES.WAITING)
                {
                    dispatchEvent(new LoaderEvent(LoaderEvent.WAITING_LOADED,_loc7_.configVO,param1,_loc6_));
                }
                return _loc4_;
            }
            throw new InfrastructureException("net.wg.infrastructure.base.BaseView is not found using name = " + param1);
        }

        public function as_unregisterContainer(param1:String) : void
        {
            assert(this.containersMap.hasOwnProperty(param1),"ContainerManager.as_unregisterContainer container for type " + param1 + " is not registered");
            var _loc2_:ISimpleManagedContainer = this.getContainer(param1);
            assert(_loc2_ != null,"ContainerManager.as_unregisterContainer container is null for type " + param1);
            this.cancelLoadingsForContainer(param1);
            delete this._containersForLoadingViews[param1];
            delete this.containersMap[_loc2_.type];
            _loc2_.removeEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOutHandler);
        }

        public function getContainersFocusOrder() : Array
        {
            return FOCUS_ORDER;
        }

        public function getFocusPriority(param1:String) : Number
        {
            var _loc2_:Array = this.getContainersFocusOrder();
            var _loc3_:Number = _loc2_.indexOf(param1);
            return _loc3_ >= 0?_loc2_.length - _loc3_ - 1:0;
        }

        public function isModalViewsExisting() : Boolean
        {
            return isModalViewsIsExistsS();
        }

        public function registerContainer(param1:ISimpleManagedContainer) : void
        {
            assert(!this.containersMap.hasOwnProperty(param1.type),"ContainerManager.registerContainer container for type " + param1.type + " is already registered");
            this.containersMap[param1.type] = param1;
            if(param1.manageFocus)
            {
                param1.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOutHandler);
            }
        }

        public function removeGFItemFromContainer(param1:String, param2:DisplayObject) : void
        {
            this.removeItemFromContainer(param1,IManagedContent(param2));
        }

        public function removeUssItemFromContainer(param1:String, param2:DisplayObject) : void
        {
            this.removeItemFromContainer(param1,IManagedContent(param2));
        }

        public function setVisibleContainers(param1:Boolean, param2:Vector.<String>) : void
        {
            var _loc3_:ISimpleManagedContainer = null;
            var _loc4_:String = null;
            for each(_loc4_ in this._visibleContainers)
            {
                if(param2.indexOf(_loc4_) == -1)
                {
                    _loc3_ = this._containersMap[_loc4_];
                    if(_loc3_)
                    {
                        _loc3_.visible = param1;
                    }
                }
            }
        }

        public function storeVisibleContainers() : void
        {
            var _loc1_:ISimpleManagedContainer = null;
            this._visibleContainers = new Vector.<String>();
            for each(_loc1_ in this._containersMap)
            {
                if(_loc1_.visible)
                {
                    this._visibleContainers.push(_loc1_.type);
                }
            }
        }

        public function updateFocus(param1:Object = null) : void
        {
            var _loc2_:String = null;
            var _loc3_:IManagedContainer = null;
            var _loc6_:IWaitingView = null;
            var _loc4_:* = false;
            var _loc5_:Array = this.getContainersFocusOrder();
            for each(_loc2_ in _loc5_)
            {
                _loc3_ = this.getInteractiveContainer(_loc2_);
                if(!(!_loc3_ || _loc3_ == param1))
                {
                    _loc6_ = _loc3_.getTopmostView() as IWaitingView;
                    if(!(_loc6_ && !_loc6_.isFocusable))
                    {
                        if(!_loc4_)
                        {
                            _loc4_ = _loc3_.tryToSetFocus(true);
                        }
                        else
                        {
                            _loc3_.tryToUpdateContent();
                        }
                    }
                }
            }
            if(!_loc4_)
            {
                App.utils.focusHandler.setModalFocus(null);
            }
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:String = null;
            var _loc4_:ISimpleManagedContainer = null;
            for(_loc3_ in this.containersMap)
            {
                _loc4_ = this.containersMap[_loc3_];
                if(_loc4_.manageSize)
                {
                    IManagedContainer(_loc4_).updateStage(param1,param2);
                }
            }
        }

        protected function getViewByName(param1:String) : IView
        {
            var _loc2_:ViewInfo = this._nameToView[param1];
            assertNotNull(_loc2_,"ContainerManager.getViewByName View " + param1 + "Not Found");
            return _loc2_.view;
        }

        private function addItemInContainer(param1:String, param2:IManagedContent, param3:Boolean) : void
        {
            var containerName:String = param1;
            var item:IManagedContent = param2;
            var stayInvisible:Boolean = param3;
            var wrapper:DisplayObject = DisplayObject(item);
            var container:DisplayObjectContainer = DisplayObjectContainer(this.getContainer(containerName));
            container.addChild(wrapper);
            wrapper.visible = false;
            dispatchEvent(new ContainerManagerEvent(ContainerManagerEvent.VIEW_ADDED,item.sourceView,containerName));
            if(this._scheduler)
            {
                this._addWrapperInNextFrameDict[wrapper] = function(param1:DisplayObject, param2:String):void
                {
                    addWrapperInNextFrame(param1,param2,stayInvisible);
                };
                this._scheduler.scheduleOnNextFrame(this._addWrapperInNextFrameDict[wrapper],wrapper,containerName);
            }
        }

        private function removeItemFromContainer(param1:String, param2:IManagedContent) : void
        {
            var _loc3_:Function = this._addWrapperInNextFrameDict[param2];
            if(this._scheduler && _loc3_ != null)
            {
                this._scheduler.cancelTask(_loc3_);
            }
            if(_loc3_ != null)
            {
                delete this._addWrapperInNextFrameDict[param2];
            }
            var _loc4_:ISimpleManagedContainer = this.getContainer(param1);
            if(param2 != null)
            {
                if(_loc4_ == param2.parent)
                {
                    _loc4_.removeChild(DisplayObject(param2));
                    if(!this.isContainerFocused(DisplayObject(_loc4_)))
                    {
                        this.updateFocus();
                    }
                    dispatchEvent(new ContainerManagerEvent(ContainerManagerEvent.VIEW_REMOVED,param2.sourceView,param1));
                }
                else
                {
                    assert(false,"There is no such item in container \"" + param1 + "\"");
                }
            }
        }

        private function isContainerFocused(param1:DisplayObject) : Boolean
        {
            var _loc2_:DisplayObject = param1.stage.focus;
            while(_loc2_ != null && _loc2_ != param1.root)
            {
                if(_loc2_ == param1)
                {
                    return true;
                }
                _loc2_ = _loc2_.parent;
            }
            return false;
        }

        private function addWrapperInNextFrame(param1:DisplayObject, param2:String, param3:Boolean) : void
        {
            this.getContainer(param2).addChild(param1);
            if(!param3)
            {
                param1.visible = true;
            }
            this.updateFocus();
        }

        private function callLogEvent(param1:IView, param2:String, param3:Number) : void
        {
            var _loc4_:DisplayObject = param1 as DisplayObject;
            App.utils.asserter.assertNotNull(_loc4_,Errors.CANT_NULL);
            App.eventLogManager.logUIElementTooltip(_loc4_,param2,param3);
        }

        private function cancelLoadingsForContainer(param1:String) : void
        {
            var _loc3_:Array = null;
            var _loc4_:AliasVO = null;
            var _loc2_:Vector.<AliasVO> = this._containersForLoadingViews[param1];
            if(_loc2_)
            {
                _loc3_ = [];
                for each(_loc4_ in _loc2_)
                {
                    _loc3_.push(_loc4_.name);
                }
                this._loader.stopLoadingByViewNames(_loc3_);
                _loc3_.length = 0;
                _loc2_.length = 0;
            }
            delete this._containersForLoadingViews[param1];
        }

        private function cancelLoadingForViewByName(param1:String, param2:String) : void
        {
            var _loc4_:* = false;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc3_:Vector.<AliasVO> = this._containersForLoadingViews[param1];
            if(_loc3_)
            {
                _loc4_ = false;
                _loc5_ = _loc3_.length;
                _loc6_ = 0;
                while(_loc6_ < _loc5_)
                {
                    if(param2 == _loc3_[_loc6_].name)
                    {
                        _loc3_.splice(_loc6_,1);
                        _loc4_ = true;
                        break;
                    }
                    _loc6_++;
                }
                if(_loc4_)
                {
                    this._loader.stopLoadingByViewNames([param2]);
                    if(_loc5_ == 1)
                    {
                        delete this._containersForLoadingViews[param1];
                    }
                }
            }
        }

        private function clearContainersForViewsDict() : void
        {
            var _loc1_:String = null;
            var _loc2_:Vector.<AliasVO> = null;
            for(_loc1_ in this._containersForLoadingViews)
            {
                _loc2_ = this._containersForLoadingViews[_loc1_];
                _loc2_.length = 0;
                delete this._containersForLoadingViews[_loc1_];
            }
        }

        private function getContainer(param1:String) : ISimpleManagedContainer
        {
            return this.containersMap[param1] as ISimpleManagedContainer;
        }

        private function getInteractiveContainer(param1:String) : IManagedContainer
        {
            return IManagedContainer(this.getContainer(param1));
        }

        public function get containersMap() : Dictionary
        {
            return this._containersMap;
        }

        public function set containersMap(param1:Dictionary) : void
        {
            var _loc2_:String = null;
            var _loc3_:IManagedContainer = null;
            this._containersMap = param1;
            for(_loc2_ in this.containersMap)
            {
                _loc3_ = this.containersMap[_loc2_];
                if(_loc3_.manageFocus)
                {
                    _loc3_.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOutHandler);
                }
            }
        }

        public function get loader() : ILoaderManager
        {
            return this._loader;
        }

        public function set loader(param1:ILoaderManager) : void
        {
            App.utils.asserter.assertNull(this._loader,"setter for loader must be called onetime only!");
            App.utils.asserter.assertNotNull(param1,"Loader shouldn\'t be null!");
            this._loader = param1;
            this._loader.addEventListener(LoaderEvent.VIEW_LOADED,this.onViewLoadedHandler);
            this._loader.addEventListener(LoaderEvent.VIEW_LOADING,this.onStartLoadViewHandler);
            this._loader.addEventListener(LoaderEvent.VIEW_LOADING_CANCEL,this.onViewLoadingCancelHandler);
        }

        public function get lastFocusedView() : IView
        {
            return this._lastFocusedView;
        }

        public function set lastFocusedView(param1:IView) : void
        {
            this._lastFocusedView = param1;
        }

        public function get cursorContainer() : ISimpleManagedContainer
        {
            return this._containersMap[APP_CONTAINERS_NAMES.CURSOR];
        }

        private function onViewLoadedHandler(param1:LoaderEvent) : void
        {
            var viewImpl:IView = null;
            var asConfig:LoadViewVO = null;
            var viewType:String = null;
            var alias:String = null;
            var container:IManagedContainer = null;
            var n:int = 0;
            var isDeleted:Boolean = false;
            var i:int = 0;
            var event:LoaderEvent = param1;
            try
            {
                viewImpl = event.view;
                viewImpl.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onViewDisposeHandler);
                asConfig = viewImpl.as_config;
                viewType = asConfig.configVO.type;
                alias = asConfig.alias;
                container = this.getInteractiveContainer(viewType);
                assertNotNull(container,"container is null for type " + viewType + " of " + alias + " view.");
                this._nameToView[asConfig.name] = new ViewInfo(container,viewImpl);
                n = this._containersForLoadingViews[viewType].length;
                i = 0;
                while(i < n)
                {
                    if(this._containersForLoadingViews[viewType][i].name == asConfig.name)
                    {
                        this._containersForLoadingViews[viewType].splice(i,1);
                        isDeleted = true;
                        break;
                    }
                    i++;
                }
                assert(isDeleted,"view (" + viewType + ") " + alias + " has been loaded, but it not exists in loading views.");
                return;
            }
            catch(err:Error)
            {
                DebugUtils.LOG_ERROR("ContainerManager.onLoaded",err.getStackTrace());
                return;
            }
        }

        private function onStartLoadViewHandler(param1:LoaderEvent) : void
        {
            /*
            var _loc2_:String = param1.config.type;
            var _loc3_:String = param1.config.alias;
            var _loc4_:Vector.<AliasVO> = this._containersForLoadingViews[_loc2_];
            if(_loc4_ == null)
            {
                this._containersForLoadingViews[_loc2_] = new <ContainerManagerBase>[new AliasVO(_loc3_,param1.name)];
            }
            else
            {
                _loc4_.push(new AliasVO(_loc3_,param1.name));
            }
            */
        }

        private function onViewLoadingCancelHandler(param1:LoaderEvent) : void
        {
            this.cancelLoadingForViewByName(param1.config.type,param1.name);
        }

        private function onContainerFocusOutHandler(param1:FocusEvent) : void
        {
            if(param1.target == param1.currentTarget)
            {
                this.updateFocus(param1.target);
            }
        }

        private function onViewDisposeHandler(param1:LifeCycleEvent) : void
        {
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc2_:IView = IView(param1.currentTarget);
            _loc2_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onViewDisposeHandler);
            var _loc3_:String = _loc2_.as_config.name;
            var _loc4_:ViewInfo = this._nameToView[_loc3_];
            var _loc5_:String = _loc2_.as_config.configVO.type;
            var _loc6_:Vector.<AliasVO> = this._containersForLoadingViews[_loc5_];
            if(_loc6_)
            {
                _loc8_ = _loc6_.length;
                _loc9_ = 0;
                while(_loc9_ < _loc8_)
                {
                    if(_loc6_[_loc9_].name == _loc3_)
                    {
                        _loc6_.splice(_loc9_,1);
                        break;
                    }
                    _loc9_++;
                }
            }
            delete this._nameToView[_loc3_];
            var _loc7_:Boolean = _loc4_.removeView();
            if(_loc7_)
            {
                this.callLogEvent(_loc2_,EVENT_LOG_CONSTANTS.EVENT_TYPE_VIEW_UNLOADED,APP_CONTAINERS_NAMES.CONTAINER_TYPES.indexOf(_loc5_));
            }
            dispatchEvent(new ContainerManagerEvent(ContainerManagerEvent.VIEW_REMOVED,_loc4_.view,_loc4_.container.type));
            _loc4_.dispose();
            _loc4_ = null;
            this.updateFocus();
        }
    }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.interfaces.IView;
import net.wg.infrastructure.interfaces.IManagedContainer;
import flash.display.DisplayObject;
import net.wg.utils.IAssertable;
import net.wg.data.constants.Errors;

class ViewInfo extends Object implements IDisposable
{

    private var _view:IView = null;

    private var _container:IManagedContainer = null;

    function ViewInfo(param1:IManagedContainer, param2:IView)
    {
        super();
        App.utils.asserter.assertNotNull(param1,"container " + Errors.CANT_NULL);
        App.utils.asserter.assertNotNull(param2,"view " + Errors.CANT_NULL);
        this._container = param1;
        this._view = param2;
    }

    public function addView() : void
    {
        this._container.addChild(DisplayObject(this._view));
    }

    public function dispose() : void
    {
        this._container = null;
        this._view = null;
    }

    public function removeView() : Boolean
    {
        var _loc1_:IAssertable = App.utils.asserter;
        _loc1_.assertNotNull(this._container,"_container " + Errors.CANT_NULL);
        _loc1_.assertNotNull(this._view,"_view " + Errors.CANT_NULL);
        var _loc2_:DisplayObject = DisplayObject(this._view.containerContent);
        if(_loc2_)
        {
            if(this._container.contains(_loc2_))
            {
                this._container.removeChild(DisplayObject(this._view));
                return true;
            }
        }
        return false;
    }

    public function setFocused() : void
    {
        this._container.setFocusedView(this._view);
    }

    public function get view() : IView
    {
        return this._view;
    }

    public function get container() : IManagedContainer
    {
        return this._container;
    }
}

class AliasVO extends Object
{

    private var _alias:String;

    private var _name:String;

    function AliasVO(param1:String, param2:String)
    {
        super();
        this._alias = param1;
        this._name = param2;
    }

    public function toString() : String
    {
        return "AliasVO (name :" + this.name + ", alias: " + this.alias + ")";
    }

    public function get name() : String
    {
        return this._name;
    }

    public function get alias() : String
    {
        return this._alias;
    }
}
