package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.ContainerManagerMeta;
    import net.wg.infrastructure.managers.IContainerManager;
    import net.wg.infrastructure.base.meta.IContainerManagerMeta;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import flash.utils.Dictionary;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.managers.ILoaderManager;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import flash.events.FocusEvent;
    import net.wg.data.constants.ContainerTypes;
    import net.wg.infrastructure.events.LoaderEvent;
    import flash.display.DisplayObjectContainer;
    
    public class ContainerManager extends ContainerManagerMeta implements IContainerManager, IContainerManagerMeta
    {
        
        public function ContainerManager()
        {
            this.nameToView = {};
            super();
            this._containersMap = new Dictionary();
            this._containersForLoadingViews = new Dictionary();
        }
        
        private static function getViewName(param1:IManagedContent) : String
        {
            return param1.sourceView.as_name;
        }
        
        private var nameToView:Object;
        
        private var _containersForLoadingViews:Dictionary;
        
        private var _lastFocusedView:IView = null;
        
        private var _containersMap:Dictionary;
        
        private var _loader:ILoaderManager;
        
        public function registerContainer(param1:IManagedContainer) : void
        {
            assert(!this.containersMap.hasOwnProperty(param1.type),"ContainerManager.registerContainer container for type " + param1.type + " is already registered");
            this.containersMap[param1.type] = param1;
            param1.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
        }
        
        public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:String = null;
            var _loc4_:IManagedContainer = null;
            for(_loc3_ in this.containersMap)
            {
                _loc4_ = this.containersMap[_loc3_];
                if(_loc4_.manageSize)
                {
                    _loc4_.updateStage(param1,param2);
                }
            }
        }
        
        public function as_getView(param1:String) : Boolean
        {
            var _loc3_:ViewInfo = null;
            var _loc2_:* = false;
            if(this.nameToView.hasOwnProperty(param1))
            {
                _loc3_ = this.nameToView[param1];
                _loc3_.setFocused();
                _loc2_ = true;
            }
            return _loc2_;
        }
        
        public function as_show(param1:String, param2:int = 0, param3:int = 0) : Boolean
        {
            var _loc4_:* = false;
            var _loc5_:ViewInfo = this.nameToView[param1];
            if((_loc5_) && (_loc5_.view))
            {
                _loc5_.view.x = param2;
                _loc5_.view.y = param3;
                _loc5_.addView();
                this.updateFocus();
                _loc4_ = true;
                if(_loc5_.view.as_config.type == ContainerTypes.CURSOR)
                {
                    dispatchEvent(new LoaderEvent(LoaderEvent.CURSOR_LOADED,_loc5_.view.as_config,param1,_loc5_.view));
                }
                if(_loc5_.view.as_config.type == ContainerTypes.WAITING)
                {
                    dispatchEvent(new LoaderEvent(LoaderEvent.WAITING_LOADED,_loc5_.view.as_config,param1,_loc5_.view));
                }
                return _loc4_;
            }
            throw new Error("net.wg.infrastructure.base.BaseView is not found using name = " + param1);
        }
        
        public function as_hide(param1:String) : Boolean
        {
            var _loc5_:* = NaN;
            var _loc2_:* = false;
            var _loc3_:ViewInfo = this.nameToView[param1];
            var _loc4_:String = _loc3_.view.as_config.type;
            if(this._containersForLoadingViews[_loc4_])
            {
                _loc5_ = this._containersForLoadingViews[_loc4_].indexOf(_loc3_.view.as_alias);
                if(_loc5_ != -1)
                {
                    this._containersForLoadingViews[_loc4_].splice(_loc5_,1);
                }
            }
            if(_loc3_)
            {
                delete this.nameToView[_loc3_.view.as_name];
                true;
                _loc3_.removeView();
                _loc3_.dispose();
                _loc3_ = null;
                _loc2_ = true;
                this.updateFocus();
                return _loc2_;
            }
            throw new Error("net.wg.infrastructure.base.AbstractView is not found using name = " + param1);
        }
        
        public function as_registerContainer(param1:String, param2:String) : void
        {
            assert(!this.containersMap.hasOwnProperty(param1),"ContainerManager.as_registerContainer container for type " + param1 + " is already registered");
            var _loc3_:ViewInfo = this.nameToView[param2];
            var _loc4_:IView = _loc3_.view;
            assert(!(_loc3_ == null) && !(_loc3_.view == null),"ContainerManager.as_registerContainer view not found for name " + param2);
            var _loc5_:IManagedContainer = _loc4_.getSubContainer();
            assert(!(_loc5_ == null),"ContainerManager.as_registerContainer container is null for type " + param1 + " in view for name " + param2);
            this.containersMap[param1] = _loc5_;
            _loc5_.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
        }
        
        public function as_unregisterContainer(param1:String) : void
        {
            assert(this.containersMap.hasOwnProperty(param1),"ContainerManager.as_unregisterContainer container for type " + param1 + " is not registered");
            var _loc2_:IManagedContainer = this.getContainer(param1);
            assert(!(_loc2_ == null),"ContainerManager.as_unregisterContainer container is null for type " + param1);
            this.cancelLoadingsForContainer(param1);
            delete this._containersForLoadingViews[param1];
            true;
            delete this.containersMap[_loc2_.type];
            true;
            _loc2_.removeEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
        }
        
        public function as_closePopUps() : void
        {
            App.toolTipMgr.hide();
            App.utils.popupMgr.removeAll();
        }
        
        public function as_isOnTop(param1:String, param2:String) : Boolean
        {
            var obj:IManagedContent = null;
            var cType:String = param1;
            var vName:String = param2;
            var result:Boolean = false;
            try
            {
                obj = IManagedContainer(this._containersMap[cType]).getTopmostView();
                result = (obj) && vName == getViewName(obj);
            }
            catch(e:Error)
            {
                DebugUtils.LOG_ERROR(e.message,e.getStackTrace());
            }
            return result;
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
                container = IManagedContainer(this._containersMap[cType]);
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
            }
            catch(e:Error)
            {
                DebugUtils.LOG_ERROR(e.message,e.getStackTrace());
            }
        }
        
        public function updateFocus(param1:Object = null) : void
        {
            var _loc2_:String = null;
            var _loc3_:IManagedContainer = null;
            var _loc4_:* = false;
            for each(_loc2_ in ContainerTypes.CTNR_ORDER)
            {
                _loc3_ = this.getContainer(_loc2_);
                if(!(!_loc3_ || _loc3_ == param1))
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
            if(!_loc4_)
            {
                App.utils.focusHandler.setModalFocus(null);
            }
        }
        
        public function isModalViewsExisting() : Boolean
        {
            return isModalViewsIsExistsS();
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
                _loc3_.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
            }
        }
        
        public function get loader() : ILoaderManager
        {
            return this._loader;
        }
        
        public function set loader(param1:ILoaderManager) : void
        {
            App.utils.asserter.assertNull(this._loader,"setter for loader must be called onetime only!");
            this._loader = param1;
            if(this._loader)
            {
                this._loader.addEventListener(LoaderEvent.VIEW_LOADED,this.handleViewLoaded);
                this._loader.addEventListener(LoaderEvent.VIEW_LOADING,this.handleViewLoading);
            }
        }
        
        public function get lastFocusedView() : IView
        {
            return this._lastFocusedView;
        }
        
        public function set lastFocusedView(param1:IView) : void
        {
            this._lastFocusedView = param1;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            var key:String = null;
            var viewInfo:ViewInfo = null;
            var container:IManagedContainer = null;
            try
            {
                for(key in this.nameToView)
                {
                    viewInfo = this.nameToView[key];
                    if(!this.as_hide(key))
                    {
                        delete this.nameToView[key];
                        true;
                    }
                }
                this.nameToView = null;
                for(key in this.containersMap)
                {
                    container = this.getContainer(key);
                    assert(!(container == null),"ContainerManager.onDispose container is null for type " + key);
                    container.removeEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
                    delete this.containersMap[key];
                    true;
                }
                this.clearContainersForViewsDict();
                this.containersMap = null;
                this._containersForLoadingViews = null;
                this._lastFocusedView = null;
                if(this._loader)
                {
                    this._loader.removeEventListener(LoaderEvent.VIEW_LOADED,this.handleViewLoaded);
                    this._loader = null;
                }
            }
            catch(e:Error)
            {
                DebugUtils.LOG_ERROR("ContainerManager.onDispose",e.getStackTrace());
            }
        }
        
        private function cancelLoadingsForContainer(param1:String) : void
        {
            var _loc2_:Array = this._containersForLoadingViews[param1];
            if(_loc2_)
            {
                this._loader.stopLoadingByAliases(_loc2_);
                _loc2_.splice(0,_loc2_.length);
            }
            delete this._containersForLoadingViews[param1];
            true;
        }
        
        private function clearContainersForViewsDict() : void
        {
            var _loc1_:String = null;
            var _loc2_:Array = null;
            for(_loc1_ in this._containersForLoadingViews)
            {
                _loc2_ = this._containersForLoadingViews[_loc1_];
                _loc2_.splice(0,_loc2_.length);
                delete this._containersForLoadingViews[_loc1_];
                true;
            }
        }
        
        private function getContainer(param1:String) : IManagedContainer
        {
            var _loc2_:IManagedContainer = null;
            if(this.containersMap.hasOwnProperty(param1))
            {
                _loc2_ = this.containersMap[param1] as IManagedContainer;
            }
            return _loc2_;
        }
        
        private function handleViewLoaded(param1:LoaderEvent) : void
        {
            var viewType:String = null;
            var alias:String = null;
            var container:IManagedContainer = null;
            var vi:ViewInfo = null;
            var viewIndex:int = 0;
            var e:LoaderEvent = param1;
            try
            {
                viewType = e.view.as_config.type;
                alias = e.view.as_alias;
                container = this.getContainer(viewType);
                assert(!(container == null),"container is null for type " + e.view.as_config.type + " of " + alias + " view.");
                vi = new ViewInfo(container,IView(e.view));
                this.nameToView[vi.view.as_name] = vi;
                viewIndex = this._containersForLoadingViews[viewType].indexOf(alias);
                assert(!(viewIndex == -1),"view " + alias + " has been loaded, but it not exists in loading views.");
                this._containersForLoadingViews[viewType].splice(viewIndex,1);
            }
            catch(err:Error)
            {
                DebugUtils.LOG_ERROR("ContainerManager.onLoaded",err.getStackTrace());
            }
        }
        
        private function handleViewLoading(param1:LoaderEvent) : void
        {
            var _loc2_:String = param1.config.type;
            var _loc3_:String = param1.config.alias;
            var _loc4_:Array = this._containersForLoadingViews[_loc2_];
            if(_loc4_ == null)
            {
                this._containersForLoadingViews[_loc2_] = [_loc3_];
            }
            else if(canCancelPreviousLoadingS(_loc2_))
            {
                this.cancelLoadingsForContainer(_loc2_);
                this._containersForLoadingViews[_loc2_] = [_loc3_];
            }
            else
            {
                _loc4_.push(_loc3_);
            }
            
        }
        
        private function onContainerFocusOut(param1:FocusEvent) : void
        {
            if(param1.target == param1.currentTarget)
            {
                this.updateFocus(param1.target);
            }
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
    
    function ViewInfo(param1:IManagedContainer, param2:IView)
    {
        super();
        App.utils.asserter.assertNotNull(param1,"container " + Errors.CANT_NULL);
        App.utils.asserter.assertNotNull(param2,"view " + Errors.CANT_NULL);
        this._container = param1;
        this._view = param2;
    }
    
    private var _view:IView = null;
    
    private var _container:IManagedContainer = null;
    
    public function dispose() : void
    {
        this._container = null;
        this._view = null;
    }
    
    public function addView() : void
    {
        this._container.addChild(DisplayObject(this._view));
    }
    
    public function setFocused() : void
    {
        this._container.setFocusedView(this._view);
    }
    
    public function removeView() : void
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
            }
        }
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
