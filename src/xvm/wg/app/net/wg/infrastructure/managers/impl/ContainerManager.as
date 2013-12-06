package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.base.meta.impl.ContainerManagerMeta;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.base.meta.IContainerManagerMeta;
   import net.wg.infrastructure.interfaces.IView;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import flash.events.FocusEvent;
   import net.wg.data.constants.ContainerTypes;
   import net.wg.infrastructure.events.LoaderEvent;
   import flash.display.DisplayObject;
   import net.wg.gui.components.common.ManagedContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.base.AbstractView;


   public class ContainerManager extends ContainerManagerMeta implements IContainerManager, IContainerManagerMeta
   {
          
      public function ContainerManager() {
         this.tokenToView = {};
         this.nameToView = {};
         super();
         this._containersMap = new Dictionary();
      }

      private var tokenToView:Object;

      private var nameToView:Object;

      private var _lastFocusedView:IView = null;

      private var _containersMap:Dictionary;

      private var _loader:ILoaderManagerMeta;

      public function registerContainer(param1:IManagedContainer) : void {
         assert(!this.containersMap.hasOwnProperty(param1.type),"ContainerManager.registerContainer container for type " + param1.type + " is already registered");
         this.containersMap[param1.type] = param1;
         param1.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
      }

      public function updateStage(param1:Number, param2:Number) : void {
         var _loc3_:String = null;
         var _loc4_:IManagedContainer = null;
         for (_loc3_ in this.containersMap)
         {
            _loc4_ = this.containersMap[_loc3_];
            if(_loc4_.manageSize)
            {
               _loc4_.updateStage(param1,param2);
            }
         }
      }

      public function as_getView(param1:String) : Boolean {
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

      public function as_getNameByToken(param1:String) : String {
         var _loc2_:ViewInfo = this.tokenToView[param1];
         if(_loc2_)
         {
            return _loc2_.view.as_name;
         }
         return null;
      }

      public function as_getViewTypeByToken(param1:String) : String {
         var _loc2_:ViewInfo = this.tokenToView[param1];
         if(_loc2_)
         {
            return _loc2_.container.type;
         }
         return null;
      }

      public function as_show(param1:String, param2:int=0, param3:int=0) : Boolean {
         var _loc4_:* = false;
         var _loc5_:ViewInfo = this.tokenToView[param1];
         if((_loc5_) && (_loc5_.view))
         {
            _loc5_.view.x = param2;
            _loc5_.view.y = param3;
            _loc5_.addView();
            this.updateFocus();
            this.nameToView[_loc5_.view.as_name] = _loc5_;
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
         throw new Error("net.wg.infrastructure.base.BaseView is not found using token = " + param1);
      }

      public function as_hide(param1:String) : Boolean {
         var _loc2_:* = false;
         var _loc3_:ViewInfo = this.tokenToView[param1];
         if(_loc3_)
         {
            delete this.nameToView[[_loc3_.view.as_name]];
            delete this.tokenToView[[param1]];
            _loc3_.removeView();
            _loc3_.dispose();
            _loc3_ = null;
            _loc2_ = true;
            this.updateFocus();
            return _loc2_;
         }
         throw new Error("net.wg.infrastructure.base.AbstractView is not found using token = " + param1);
      }

      public function as_registerContainer(param1:String, param2:String) : void {
         assert(!this.containersMap.hasOwnProperty(param1),"ContainerManager.as_registerContainer container for type " + param1 + " is already registered");
         var _loc3_:ViewInfo = this.tokenToView[param2];
         var _loc4_:IView = _loc3_.view;
         assert(!(_loc3_ == null) && !(_loc3_.view == null),"ContainerManager.as_registerContainer view not found for token " + param2);
         var _loc5_:IManagedContainer = _loc4_.getSubContainer();
         assert(!(_loc5_ == null),"ContainerManager.as_registerContainer container is null for type " + param1 + " in view for token " + param2);
         this.containersMap[param1] = _loc5_;
         _loc5_.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
      }

      public function as_unregisterContainer(param1:String) : void {
         assert(this.containersMap.hasOwnProperty(param1),"ContainerManager.as_unregisterContainer container for type " + param1 + " is not registered");
         var _loc2_:IManagedContainer = this.getContainer(param1);
         assert(!(_loc2_ == null),"ContainerManager.as_unregisterContainer container is null for type " + param1);
         delete this.containersMap[[_loc2_.type]];
         _loc2_.removeEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
      }

      public function as_closePopUps() : void {
         App.toolTipMgr.hide();
         App.utils.popupMgr.removeAll();
      }

      public function as_isOnTop(param1:String, param2:String) : Boolean {
         var obj:DisplayObject = null;
         var cType:String = param1;
         var vName:String = param2;
         var result:Boolean = false;
         try
         {
            obj = ManagedContainer(this._containersMap[cType]).getTopmostView();
            result = (obj) && vName == this.getViewName(obj);
         }
         catch(e:Error)
         {
            DebugUtils.LOG_ERROR(e.message,e.getStackTrace());
         }
         return result;
         result = (obj) && vName == this.getViewName(obj);
         return result;
      }

      public function as_bringToFront(param1:String, param2:String) : void {
         var container:ManagedContainer = null;
         var currentView:DisplayObject = null;
         var childrenCount:int = 0;
         var i:int = 0;
         var cType:String = param1;
         var vName:String = param2;
         try
         {
            container = ManagedContainer(this._containersMap[cType]);
            currentView = null;
            childrenCount = container.numChildren;
            i = 0;
            while(i < childrenCount)
            {
               currentView = container.getChildAt(i);
               if(this.getViewName(currentView) == vName)
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

      public function get containersMap() : Dictionary {
         return this._containersMap;
      }

      public function set containersMap(param1:Dictionary) : void {
         var _loc2_:String = null;
         var _loc3_:IManagedContainer = null;
         this._containersMap = param1;
         for (_loc2_ in this.containersMap)
         {
            _loc3_ = this.containersMap[_loc2_];
            _loc3_.addEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
         }
      }

      public function get loader() : ILoaderManagerMeta {
         return this._loader;
      }

      public function set loader(param1:ILoaderManagerMeta) : void {
         this._loader = param1;
         if(this._loader)
         {
            this._loader.addEventListener(LoaderEvent.VIEW_LOADED,this.handleViewLoaded);
         }
      }

      public function get lastFocusedView() : IView {
         return this._lastFocusedView;
      }

      public function set lastFocusedView(param1:IView) : void {
         if((this._lastFocusedView) && !(this._lastFocusedView == param1))
         {
            this.lastFocusedView.removeFocus();
         }
         this._lastFocusedView = param1;
      }

      override protected function onPopulate() : void {
          
      }

      override protected function onDispose() : void {
         var key:String = null;
         var container:IManagedContainer = null;
         try
         {
            for (key in this.tokenToView)
            {
               if(!this.as_hide(key))
               {
                  delete this.tokenToView[[key]];
               }
            }
            this.tokenToView = null;
            for (key in this.containersMap)
            {
               container = this.getContainer(key);
               assert(!(container == null),"ContainerManager.onDispose container is null for type " + key);
               container.removeEventListener(FocusEvent.FOCUS_OUT,this.onContainerFocusOut);
               (container as IDisposable).dispose();
               delete this.containersMap[[key]];
            }
            this.containersMap = null;
            this._lastFocusedView = null;
            if(this.loader)
            {
               this.loader.removeEventListener(LoaderEvent.VIEW_LOADED,this.handleViewLoaded);
               this.loader = null;
            }
         }
         catch(e:Error)
         {
            DebugUtils.LOG_ERROR("ContainerManager.onDispose",e.getStackTrace());
         }
      }

      private function getContainer(param1:String) : IManagedContainer {
         var _loc2_:IManagedContainer = null;
         if(this.containersMap.hasOwnProperty(param1))
         {
            _loc2_ = this.containersMap[param1] as IManagedContainer;
         }
         return _loc2_;
      }

      private function getViewName(param1:DisplayObject) : String {
         return param1  is  IAbstractWindowView?IAbstractWindowView(param1).as_name:IWindow(param1).sourceView.as_name;
      }

      private function handleViewLoaded(param1:LoaderEvent) : void {
         var container:IManagedContainer = null;
         var e:LoaderEvent = param1;
         try
         {
            container = this.getContainer(e.view.as_config.type);
            assert(!(container == null),"container is null for type " + e.view.as_config.type + "of " + e.view.as_alias + "view.");
            this.tokenToView[e.token] = new ViewInfo(container,e.view as AbstractView);
         }
         catch(err:Error)
         {
            DebugUtils.LOG_ERROR("ContainerManager.onLoaded",err.getStackTrace());
         }
      }

      private function onContainerFocusOut(param1:FocusEvent) : void {
         if(param1.target == param1.currentTarget)
         {
            this.updateFocus(param1.target);
         }
      }

      public function updateFocus(param1:Object=null) : void {
         var _loc2_:String = null;
         var _loc3_:IManagedContainer = null;
         for each (_loc2_ in ContainerTypes.CTNR_ORDER)
         {
            _loc3_ = this.getContainer(_loc2_);
            if((_loc3_) && (!(_loc3_ == param1)) && (_loc3_.setFocused(true)))
            {
               break;
            }
         }
      }
   }

}   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import flash.display.DisplayObject;


   class ViewInfo extends Object implements IDisposable
   {
          
      function ViewInfo(param1:IManagedContainer, param2:AbstractView) {
         super();
         App.utils.asserter.assertNotNull(param1,"_container " + Errors.CANT_NULL);
         this._container = param1;
         this._view = param2;
      }

      private var _view:AbstractView = null;

      private var _container:IManagedContainer = null;

      public function dispose() : void {
         this._container = null;
         this._view = null;
      }

      public function addView() : void {
         this._container.addChild(this._view);
      }

      public function setFocused() : void {
         this._container.setFocusedView(this._view);
      }

      public function removeView() : void {
         var _loc1_:IAssertable = App.utils.asserter;
         _loc1_.assertNotNull(this._container,"_container " + Errors.CANT_NULL);
         _loc1_.assertNotNull(this._view,"_view " + Errors.CANT_NULL);
         var _loc2_:DisplayObject = this._view  is  IAbstractWindowView?DisplayObject((this._view as IAbstractWindowView).window):this._view;
         if(_loc2_)
         {
            if(this._container.contains(_loc2_))
            {
               this._container.removeChild(this._view);
            }
         }
      }

      public function get view() : AbstractView {
         return this._view;
      }

      public function get container() : IManagedContainer {
         return this._container;
      }
   }
