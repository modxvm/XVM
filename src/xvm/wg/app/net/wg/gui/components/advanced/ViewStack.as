package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IGroupedControl;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
   import net.wg.utils.IAssertable;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import flash.utils.getDefinitionByName;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   
   public class ViewStack extends UIComponent
   {
      
      public function ViewStack() {
         super();
         this.cachedViews = {};
         this.container = new Sprite();
         this.addChild(this.container);
      }
      
      public var cache:Boolean = false;
      
      public var cachedViews:Object;
      
      protected var container:Sprite;
      
      private var _targetGroup:IGroupedControl = null;
      
      private var _currentView:MovieClip;
      
      private var _currentLinkage:String;
      
      override public function toString() : String {
         return "[WG ViewStack " + name + "]";
      }
      
      public function show(param1:String) : MovieClip {
         var _loc2_:MovieClip = this.createView(param1);
         this.setCurrentView(_loc2_,param1,true);
         if(_loc2_ != null)
         {
            if(IViewStackContent(_loc2_).canShowAutomatically())
            {
               _loc2_.visible = true;
            }
         }
         invalidate();
         return _loc2_;
      }
      
      public function get targetGroup() : String {
         return this._targetGroup.name;
      }
      
      public function set targetGroup(param1:String) : void {
         if(param1 != "")
         {
            this.assertTargetGroup(param1);
            this.groupRef = IGroupedControl(parent[param1]);
         }
      }
      
      public function set groupRef(param1:IGroupedControl) : void {
         if(this._targetGroup != param1)
         {
            if(this._targetGroup != null)
            {
               this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
            }
            this._targetGroup = param1;
            if(this._targetGroup != null)
            {
               this._targetGroup.addEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
               this.changeView();
            }
         }
      }
      
      public function get currentLinkage() : String {
         return this._currentLinkage;
      }
      
      public function get currentView() : MovieClip {
         return this._currentView;
      }
      
      override protected function configUI() : void {
         super.configUI();
         tabEnabled = false;
      }
      
      override protected function draw() : void {
         if(isInvalid(InvalidationType.SIZE))
         {
            this.container.width = this.container.height = 5;
            width = _width;
            height = _height;
         }
         this.container.scaleX = 1 / scaleX;
         this.container.scaleY = 1 / scaleY;
      }
      
      override protected function onDispose() : void {
         var _loc1_:IDisposable = null;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:* = 0;
         if(this._targetGroup != null)
         {
            this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
            this._targetGroup = null;
         }
         if(this.container)
         {
            if(this.cache)
            {
               _loc3_ = [];
               for(_loc4_ in this.cachedViews)
               {
                  _loc3_.push(_loc4_);
               }
               for each(_loc2_ in _loc3_)
               {
                  if(this.cachedViews[_loc2_] is IDisposable)
                  {
                     IDisposable(this.cachedViews[_loc2_]).dispose();
                  }
                  else
                  {
                     this.clearSubView(this.cachedViews[_loc2_]);
                  }
               }
               this.cachedViews = null;
               _loc3_.splice(0,_loc3_.length);
               _loc3_ = null;
            }
            if(this.container.numChildren > 0)
            {
               _loc5_ = this.container.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  _loc1_ = IDisposable(this.container.getChildAt(_loc5_));
                  if(!(_loc1_ is IDAAPIEntity))
                  {
                     _loc1_.dispose();
                  }
                  _loc5_--;
               }
            }
            removeChild(this.container);
            this.container = null;
         }
         super.onDispose();
      }
      
      private function assertTargetGroup(param1:String) : void {
         if(!App.utils)
         {
            return;
         }
         var _loc2_:* = "component with instance \'" + param1 + "\'";
         var _loc3_:IAssertable = App.utils.asserter;
         _loc3_.assert(parent.hasOwnProperty(param1),"container \'" + parent + "\' has no " + _loc2_,ArgumentException);
         _loc3_.assert(parent[param1] is IGroupedControl,"container \'" + parent + "\'  must implements IGroupController interface");
      }
      
      private function changeView() : void {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         if(this._targetGroup.selectedItem != null)
         {
            _loc1_ = this._targetGroup.data;
            if(_loc1_ != null)
            {
               if(_loc1_.hasOwnProperty("linkage"))
               {
                  if(_loc1_.linkage != null)
                  {
                     this.show(_loc1_.linkage);
                  }
               }
               else
               {
                  _loc2_ = "renderers data for View stack must have a linkage property!";
                  DebugUtils.LOG_DEBUG(_loc2_);
               }
            }
         }
      }
      
      private function setCurrentView(param1:MovieClip, param2:String, param3:Boolean) : void {
         if(this._currentView != null)
         {
            if(this._currentView["__cached__"] == true)
            {
               this._currentView.visible = false;
            }
            else
            {
               this.container.removeChild(this._currentView);
               if(param3)
               {
                  if(!(param1 is IDAAPIEntity))
                  {
                     (this._currentView as IDisposable).dispose();
                  }
                  else
                  {
                     this.clearSubView(this._currentView);
                  }
               }
               this._currentView = null;
            }
         }
         this._currentView = param1;
         if(this._currentView != null)
         {
            this._currentView.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
         }
         this._currentLinkage = param2;
      }
      
      private function createView(param1:String) : UIComponent {
         var _loc3_:Class = null;
         var _loc2_:UIComponent = null;
         if(this.cachedViews[param1] != null)
         {
            _loc2_ = this.cachedViews[param1];
         }
         else
         {
            if(App.utils)
            {
               _loc2_ = App.utils.classFactory.getComponent(param1,UIComponent);
               App.utils.asserter.assert(_loc2_ is IViewStackContent,"view must implements IViewStackContent");
            }
            else
            {
               _loc3_ = getDefinitionByName(param1) as Class;
               _loc2_ = new _loc3_() as UIComponent;
            }
            _loc2_.visible = false;
            _loc2_.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
            this.container.addChild(_loc2_);
            _loc2_.validateNow();
            dispatchEvent(new ViewStackEvent(ViewStackEvent.NEED_UPDATE,IViewStackContent(_loc2_),param1));
            if(!(_loc2_ == null) && (this.cache))
            {
               _loc2_["__cached__"] = true;
               this.cachedViews[param1] = _loc2_;
            }
         }
         dispatchEvent(new ViewStackEvent(ViewStackEvent.VIEW_CHANGED,IViewStackContent(_loc2_),param1));
         return _loc2_;
      }
      
      private function onChangeViewHandler(param1:IndexEvent) : void {
         this.changeView();
      }
      
      private function onDisposeSubViewHandler(param1:LifeCycleEvent) : void {
         var _loc2_:MovieClip = MovieClip(param1.target);
         if(_loc2_)
         {
            this.clearSubView(_loc2_);
         }
      }
      
      private function clearSubView(param1:MovieClip) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         param1.removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onDisposeSubViewHandler);
         var _loc2_:* = false;
         if(this.container.contains(param1))
         {
            this.container.removeChild(param1);
         }
         if(this._currentView == param1)
         {
            this.setCurrentView(null,null,false);
            _loc2_ = true;
         }
         for(_loc3_ in this.cachedViews)
         {
            if(this.cachedViews[_loc3_] == param1)
            {
               delete this.cachedViews[_loc3_];
               _loc2_ = true;
               break;
            }
         }
         _loc4_ = "View \' " + param1.name + "\'is disposed, but was not removed from viewStack \'" + name + "\'!";
         App.utils.asserter.assert(_loc2_,_loc4_,InfrastructureException);
      }
   }
}
