package net.wg.gui.components.common
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.ContainerTypes;
   import flash.events.MouseEvent;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.IView;
   import flash.display.InteractiveObject;
   import scaleform.gfx.FocusManager;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.events.FocusEvent;
   import scaleform.clik.motion.Tween;
   import net.wg.gui.events.ManagedContainerEvent;
   import flash.events.Event;


   public class ManagedContainer extends UIComponent implements IManagedContainer
   {
          
      public function ManagedContainer() {
         this.groupCounters = {};
         super();
         this.mouseEnabled = false;
      }

      protected var _modalBg:DisplayObject = null;

      public var manageFocus:Boolean = true;

      private var _manageSize:Boolean = true;

      private var groupCounters:Object;

      private var _type:String = "conatiner";

      private const ADD_CHILD_ERROR_STR:String = "ManagedContainer.addChild - passed child is not net.wg.infrastructure.base.BaseView instance or it\'s config is not valid";

      private const REMOVE_CHILD_ERROR_STR:String = "ManagedContainer.removeChild - passed child is not net.wg.infrastructure.base.BaseView instance or it\'s config is not valid";

      private const GROUP_X_OFFSET:int = 20;

      private const GROUP_Y_OFFSET:int = 20;

      override public function addChild(param1:DisplayObject) : DisplayObject {
         var _loc3_:IWindow = null;
         var _loc4_:String = null;
         var _loc2_:AbstractView = param1 as AbstractView;
         if(param1  is  IAbstractWindowView)
         {
            _loc3_ = IWindow(App.utils.classFactory.getComponent(Linkages.WINDOW,IWindow));
            _loc3_.sourceView = _loc2_ as IAbstractWindowView;
            _loc3_.sourceView.window = _loc3_;
            param1 = DisplayObject(_loc3_);
         }
         if((_loc2_) && (_loc2_.as_config) && (_loc2_.as_config.hasOwnProperty("type")))
         {
            super.addChild(param1);
            _loc2_.playShowTween(param1);
            if(_loc2_.as_config.type == ContainerTypes.WINDOW || _loc2_.as_config.type == ContainerTypes.DIALOG)
            {
               _loc4_ = null;
               if(_loc2_.as_config.hasOwnProperty("group"))
               {
                  _loc4_ = _loc2_.as_config.group;
                  _loc4_ = _loc4_.length?_loc4_:null;
               }
               if(_loc4_)
               {
                  this.addGroupCounter(_loc4_,_loc2_.as_token);
                  this.movieViewToVector(param1,_loc4_);
               }
            }
            if(this.manageFocus)
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onViewClick,true,0,true);
            }
            if(param1  is  AbstractView)
            {
               (param1 as AbstractView).updateStage(width,height);
            }
            else
            {
               if(param1  is  IWindow)
               {
                  (param1 as IWindow).sourceView.updateStage(width,height);
               }
            }
            return _loc2_;
         }
         throw new Error(this.ADD_CHILD_ERROR_STR);
      }

      override public function removeChild(param1:DisplayObject) : DisplayObject {
         var _loc4_:IAbstractWindowView = null;
         var _loc5_:String = null;
         var _loc6_:GroupCounter = null;
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assertNotNull(param1,"child" + Errors.CANT_NULL);
         var _loc3_:AbstractView = param1 as AbstractView;
         if(param1  is  IAbstractWindowView)
         {
            _loc4_ = IAbstractWindowView(_loc3_);
            param1 = DisplayObject(_loc4_.window);
            _loc2_.assertNotNull(param1,"abstractWindowView.window" + Errors.CANT_NULL);
         }
         if((_loc3_) && (_loc3_.as_config) && (_loc3_.as_config.hasOwnProperty("type")))
         {
            if(_loc3_.as_config.type != ContainerTypes.VIEW)
            {
               _loc5_ = null;
               if(_loc3_.as_config.hasOwnProperty("group"))
               {
                  _loc5_ = _loc3_.as_config.group;
                  _loc5_ = _loc5_.length?_loc5_:null;
               }
               if((_loc5_) && (this.groupCounters.hasOwnProperty(_loc5_)))
               {
                  _loc6_ = this.groupCounters[_loc5_];
                  _loc6_.decrement(_loc3_.as_token);
                  if(_loc6_.views.length == 0)
                  {
                     delete this.groupCounters[[_loc5_]];
                  }
               }
            }
            if(!_loc3_.playHideTween(param1,this.onTweenEnd))
            {
               this.performRemoveChild(param1);
            }
            return _loc3_;
         }
         throw new Error(this.REMOVE_CHILD_ERROR_STR);
      }

      override public function dispose() : void {
         var _loc1_:String = null;
         var _loc2_:GroupCounter = null;
         super.dispose();
         this.removeAllChildren();
         for (_loc1_ in this.groupCounters)
         {
            _loc2_ = this.groupCounters[_loc1_];
            _loc2_.dispose();
            delete this.groupCounters[[_loc1_]];
         }
         this.groupCounters = null;
         this._modalBg = null;
      }

      public function getTopmostView() : DisplayObject {
         var _loc1_:DisplayObject = null;
         if(numChildren)
         {
            _loc1_ = getChildAt(numChildren-1);
            if(_loc1_ == this._modalBg)
            {
               _loc1_ = null;
            }
         }
         return _loc1_;
      }

      public function setFocusedView(param1:DisplayObject) : void {
         var _loc2_:IWindow = null;
         var _loc3_:IView = null;
         if(contains(param1))
         {
            App.utils.focusHandler.setFocus(InteractiveObject(param1));
            if(param1  is  IAbstractWindowView)
            {
               _loc2_ = (param1 as IAbstractWindowView).window;
            }
            else
            {
               _loc2_ = param1 as IWindow;
            }
            if(_loc2_)
            {
               param1 = DisplayObject(_loc2_);
               FocusManager.setModalClip(param1 as Sprite);
               if(_loc2_.sourceView.isModal)
               {
                  this.createModalBg();
               }
            }
            setChildIndex(param1,numChildren-1);
            if(param1  is  AbstractView)
            {
               _loc3_ = param1 as IView;
            }
            else
            {
               if(_loc2_)
               {
                  _loc3_ = _loc2_.sourceView as IView;
               }
            }
            if(_loc3_)
            {
               _loc3_.setFocus();
            }
            App.containerMgr.lastFocusedView = _loc3_;
         }
      }

      protected function createModalBg() : void {
         if(this._modalBg == null)
         {
            this._modalBg = MovieClip(App.utils.classFactory.getObject(Linkages.POPUP_MODAL));
            if(this._modalBg == null)
            {
               DebugUtils.LOG_DEBUG("Error until getting ");
               return;
            }
         }
         this._modalBg.width = App.appWidth;
         this._modalBg.height = App.appHeight;
         addChildAt(this._modalBg,numChildren > 0?numChildren-1:0);
      }

      public function setFocused(param1:Boolean=false) : Boolean {
         var _loc2_:DisplayObject = null;
         if(this.manageFocus)
         {
            _loc2_ = this.getTopmostView();
            if(_loc2_)
            {
               this.setFocusedView(_loc2_);
            }
            else
            {
               App.utils.focusHandler.setFocus(null);
               FocusManager.setModalClip(null);
               if(!param1)
               {
                  dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
               }
            }
         }
         return !(_loc2_ == null);
      }

      public function updateStage(param1:Number, param2:Number) : void {
         var _loc3_:* = 0;
         var _loc4_:DisplayObject = null;
         if(this._modalBg != null)
         {
            this._modalBg.width = param1;
            this._modalBg.height = param2;
         }
         _originalWidth = param1;
         _originalHeight = param2;
         setSize(param1,param2);
         _loc3_ = numChildren-1;
         while(_loc3_ > -1)
         {
            _loc4_ = getChildAt(_loc3_);
            if(_loc4_  is  AbstractView)
            {
               (_loc4_ as AbstractView).updateStage(param1,param2);
            }
            else
            {
               if(_loc4_  is  IWindow)
               {
                  (_loc4_ as IWindow).sourceView.updateStage(param1,param2);
               }
            }
            _loc3_--;
         }
      }

      public function onTweenEnd(param1:Tween=null) : void {
         if(super.getChildByName(DisplayObject(param1.target).name) != null)
         {
            this.performRemoveChild(DisplayObject(param1.target));
         }
      }

      public function get manageSize() : Boolean {
         return this._manageSize;
      }

      public function set manageSize(param1:Boolean) : void {
         this._manageSize = param1;
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         this._type = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         initSize();
      }

      protected function removeAllChildren() : void {
         while(numChildren)
         {
            removeChildAt(numChildren-1);
         }
      }

      protected function superRemoveChild(param1:DisplayObject) : DisplayObject {
         return super.removeChild(param1);
      }

      private function performRemoveChild(param1:DisplayObject) : void {
         if(param1  is  IWindow && ((param1 as IWindow).sourceView.isModal) && !(this._modalBg == null))
         {
            super.removeChild(this._modalBg);
            this._modalBg = null;
         }
         super.removeChild(param1);
         if(this.manageFocus)
         {
            param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onViewClick,true);
         }
         dispatchEvent(new ManagedContainerEvent(ManagedContainerEvent.CHILD_REMOVED));
      }

      private function addGroupCounter(param1:String, param2:String) : void {
         if(param1 == null)
         {
            return;
         }
         if(!this.groupCounters.hasOwnProperty(param1))
         {
            this.groupCounters[param1] = new GroupCounter();
         }
         var _loc3_:GroupCounter = this.groupCounters[param1];
         _loc3_.increment(param2);
      }

      private function movieViewToVector(param1:DisplayObject, param2:String) : void {
         var _loc3_:GroupCounter = this.groupCounters[param2];
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Number = param1.x + (_loc3_.xAdjust-1) * this.GROUP_X_OFFSET;
         var _loc5_:Number = param1.y + (_loc3_.yAdjust-1) * this.GROUP_Y_OFFSET;
         var _loc6_:Number = param1.width;
         var _loc7_:Number = param1.height;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
            _loc3_.isReverceX = false;
         }
         else
         {
            if(_loc4_ + _loc6_ > stage.stageWidth)
            {
               _loc4_ = stage.stageWidth - _loc6_;
               _loc3_.isReverceX = true;
            }
         }
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
            _loc3_.isReverceY = false;
         }
         else
         {
            if(_loc5_ + _loc7_ > stage.stageHeight)
            {
               _loc5_ = stage.stageHeight - _loc7_;
               _loc3_.isReverceY = true;
            }
         }
         param1.x = _loc4_;
         param1.y = _loc5_;
      }

      private function onViewClick(param1:Event) : void {
         var _loc2_:DisplayObject = DisplayObject(param1.currentTarget);
         var _loc3_:IView = null;
         if(contains(_loc2_))
         {
            if(_loc2_  is  IWindow)
            {
               _loc3_ = IWindow(_loc2_).sourceView;
            }
            if(_loc3_)
            {
               if(_loc3_ != App.containerMgr.lastFocusedView)
               {
                  this.setFocusedView(_loc2_);
               }
            }
            else
            {
               _loc3_ = this.getTopmostView() as IView;
               if(_loc3_)
               {
                  App.containerMgr.lastFocusedView = _loc3_;
               }
               else
               {
                  DebugUtils.LOG_WARNING(_loc2_ + " is Not IView!");
               }
            }
         }
      }
   }

}   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import __AS3__.vec.Vector;


   class GroupCounter extends Object implements IDisposable
   {
          
      function GroupCounter() {
         super();
         this.views = new Vector.<GroupViewObject>();
      }

      public var views:Vector.<GroupViewObject> = null;

      public var isReverceX:Boolean = false;

      public var isReverceY:Boolean = false;

      public function dispose() : void {
         this.views.splice(0,this.views.length);
         this.views = null;
      }

      public function increment(param1:String) : void {
         var _loc2_:GroupViewObject = new GroupViewObject(param1);
         var _loc3_:int = this.views.length > 0?this.views[this.views.length-1].xAdjust:0;
         var _loc4_:int = this.views.length > 0?this.views[this.views.length-1].yAdjust:0;
         var _loc5_:int = this.isReverceX?-1:1;
         var _loc6_:int = this.isReverceY?-1:1;
         _loc2_.xAdjust = _loc5_ + _loc3_;
         _loc2_.yAdjust = _loc6_ + _loc4_;
         this.views.push(_loc2_);
      }

      public function decrement(param1:String) : void {
         var _loc2_:GroupViewObject = null;
         for each (_loc2_ in this.views)
         {
            if(_loc2_.id == param1)
            {
               this.views.splice(this.views.indexOf(_loc2_),1);
               break;
            }
         }
      }

      public function get xAdjust() : int {
         return this.views.length > 0?this.views[this.views.length-1].xAdjust:0;
      }

      public function get yAdjust() : int {
         return this.views.length > 0?this.views[this.views.length-1].yAdjust:0;
      }
   }


   class GroupViewObject extends Object
   {
          
      function GroupViewObject(param1:String) {
         super();
         this.id = param1;
      }

      public var xAdjust:int = 0;

      public var yAdjust:int = 0;

      public var id:String = "";
   }
