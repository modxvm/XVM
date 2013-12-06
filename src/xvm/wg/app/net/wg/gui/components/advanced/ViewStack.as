package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IGroupedControl;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.IndexEvent;
   import net.wg.utils.IAssertable;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.utils.getDefinitionByName;
   import net.wg.gui.events.ViewStackEvent;


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

      private var depth:Number = 0;

      private var _targetGroup:IGroupedControl = null;

      public var currentView:MovieClip;

      private var _currentLinkage:String;

      protected var container:Sprite;

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

      public function get targetGroup() : String {
         return this._targetGroup.name;
      }

      public function set targetGroup(param1:String) : void {
         var _loc2_:IGroupedControl = null;
         if(param1 != "")
         {
            this.assertTargetGroup(param1);
            _loc2_ = IGroupedControl(parent[param1]);
            this.groupRef = _loc2_;
         }
      }

      public function set groupRef(param1:IGroupedControl) : void {
         var _loc2_:IGroupedControl = param1;
         if(this._targetGroup != _loc2_)
         {
            if(this._targetGroup != null)
            {
               this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
            }
            this._targetGroup = _loc2_;
            if(this._targetGroup != null)
            {
               this._targetGroup.addEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
               this.changeView();
            }
         }
      }

      private function assertTargetGroup(param1:String) : void {
         if(!App.utils)
         {
            return;
         }
         var _loc2_:* = "component with instance \'" + param1 + "\'";
         var _loc3_:IAssertable = App.utils.asserter;
         _loc3_.assert(parent.hasOwnProperty(param1),"container \'" + parent + "\' has no " + _loc2_,ArgumentException);
         _loc3_.assert(parent[param1]  is  IGroupedControl,"container \'" + parent + "\'  must implements IGroupController interface");
         var _loc4_:IGroupedControl = IGroupedControl(parent[param1]);
      }

      private function onChangeViewHandler(param1:IndexEvent) : void {
         this.changeView();
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

      public function show(param1:String) : MovieClip {
         if(this.currentView != null)
         {
            if(this.currentView["__cached__"] == true)
            {
               this.currentView.visible = false;
            }
            else
            {
               this.container.removeChild(this.currentView);
               (this.currentView as IDisposable).dispose();
               this.currentView = null;
            }
         }
         var _loc2_:MovieClip = this.createView(param1);
         this.currentView = _loc2_;
         this._currentLinkage = param1;
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
         invalidate();
         return _loc2_;
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
               App.utils.asserter.assert(_loc2_  is  IViewStackContent,"view must implements IViewStackContent");
            }
            else
            {
               _loc3_ = getDefinitionByName(param1) as Class;
               _loc2_ = new _loc3_() as UIComponent;
            }
            _loc2_.visible = false;
            this.container.addChild(_loc2_);
            _loc2_.validateNow();
            dispatchEvent(new ViewStackEvent(ViewStackEvent.NEED_UPDATE,IViewStackContent(_loc2_),param1));
            if(!(_loc2_ == null) && (this.cache))
            {
               _loc2_["__cached__"] = true;
               this.cachedViews[param1] = _loc2_;
               _loc2_ = _loc2_;
            }
         }
         dispatchEvent(new ViewStackEvent(ViewStackEvent.VIEW_CHANGED,IViewStackContent(_loc2_),param1));
         return _loc2_;
      }

      override public function dispose() : void {
         var _loc1_:IDisposable = null;
         var _loc2_:String = null;
         if(this._targetGroup != null)
         {
            this._targetGroup.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
            this._targetGroup = null;
         }
         if(this.container)
         {
            if(this.cache)
            {
               for (_loc2_ in this.cachedViews)
               {
                  delete this.cachedViews[[_loc2_]];
               }
               this.cachedViews = null;
            }
            while(this.container.numChildren > 0)
            {
               _loc1_ = IDisposable(this.container.getChildAt(0));
               _loc1_.dispose();
               this.container.removeChildAt(0);
            }
            this.removeChild(this.container);
            this.container = null;
         }
         super.dispose();
      }

      override public function toString() : String {
         return "[WG ViewStack " + name + "]";
      }

      public function get currentLinkage() : String {
         return this._currentLinkage;
      }
   }

}