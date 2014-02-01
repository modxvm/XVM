package net.wg.gui.components.common
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;
   import net.wg.infrastructure.interfaces.IWrapper;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.data.constants.ContainerTypes;
   import flash.events.MouseEvent;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import flash.events.FocusEvent;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.motion.Tween;
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   import net.wg.gui.events.ManagedContainerEvent;
   import flash.events.Event;


   public class ManagedContainer extends UIComponent implements IManagedContainer
   {
          
      public function ManagedContainer() {
         this.groupCounters = {};
         super();
         this.mouseEnabled = false;
      }

      private var _modalBg:DisplayObject = null;

      private var _manageFocus:Boolean = true;

      private var _manageSize:Boolean = true;

      private var groupCounters:Object;

      private var _type:String = "view";

      private const ADD_CHILD_ERROR_STR:String = "ManagedContainer.addChild - passed child is not net.wg.infrastructure.base.BaseView instance or it\'s config is not valid";

      private const REMOVE_CHILD_ERROR_STR:String = "ManagedContainer.removeChild - passed child is not net.wg.infrastructure.base.BaseView instance or it\'s config is not valid";

      private const GROUP_X_OFFSET:int = 20;

      private const GROUP_Y_OFFSET:int = 20;

      override public function addChild(param1:DisplayObject) : DisplayObject {
         var _loc3_:IAbstractWrapperView = null;
         var _loc4_:IWrapper = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:String = null;
         this.assertContent(param1);
         var _loc2_:IView = IManagedContent(param1).sourceView;
         if(param1  is  IAbstractWrapperView)
         {
            _loc3_ = IAbstractWrapperView(param1);
            _loc4_ = IWrapper(App.utils.classFactory.getComponent(_loc3_.wrapperLinkage,IWrapper));
            _loc4_.wrapperContent = _loc3_;
            _loc4_.wrapperContent.wrapper = _loc4_;
         }
         _loc2_.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onAfterManagedContentDisposeHandler);
         if((_loc2_) && (_loc2_.as_config) && (_loc2_.as_config.hasOwnProperty("type")))
         {
            _loc5_ = DisplayObject(_loc2_.containerContent);
            super.addChild(_loc5_);
            _loc2_.playShowTween(_loc5_);
            if(_loc2_.as_config.type == ContainerTypes.WINDOW || _loc2_.as_config.type == ContainerTypes.TOP_WINDOW)
            {
               _loc6_ = null;
               if(_loc2_.as_config.hasOwnProperty("group"))
               {
                  _loc6_ = _loc2_.as_config.group;
                  _loc6_ = _loc6_.length?_loc6_:null;
               }
               if(_loc6_)
               {
                  this.addGroupCounter(_loc6_,_loc2_.as_token);
                  this.movieViewToVector(_loc5_,_loc6_);
               }
            }
            if(this.manageFocus)
            {
               _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.onViewClickHandler,false,0,true);
            }
            _loc2_.sourceView.updateStage(width,height);
            return DisplayObject(_loc2_);
         }
         throw new Error(this.ADD_CHILD_ERROR_STR);
      }

      override public function removeChild(param1:DisplayObject) : DisplayObject {
         var _loc5_:String = null;
         var _loc6_:GroupCounter = null;
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assertNotNull(param1,"child" + Errors.CANT_NULL);
         this.assertContent(param1);
         var _loc3_:IView = IManagedContent(param1).sourceView;
         var _loc4_:DisplayObject = DisplayObject(_loc3_.containerContent);
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
            if(!_loc3_.playHideTween(_loc4_,this.onTweenEnd))
            {
               this.performRemoveChild(IManagedContent(_loc4_));
            }
            return _loc4_;
         }
         throw new Error(this.REMOVE_CHILD_ERROR_STR);
      }

      override protected function onDispose() : void {
         var _loc1_:String = null;
         var _loc2_:GroupCounter = null;
         super.onDispose();
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

      public function getTopmostView() : IManagedContent {
         if(numChildren)
         {
            return IManagedContent(getChildAt(numChildren-1));
         }
         return null;
      }

      public function setFocusedView(param1:IManagedContent) : void {
         if((contains(DisplayObject(param1))) && !(param1.sourceView == App.containerMgr.lastFocusedView))
         {
            if(App.containerMgr.lastFocusedView != null)
            {
               App.containerMgr.lastFocusedView.leaveModalFocus();
            }
            App.utils.focusHandler.setModalFocus(param1);
            if(param1.isModal)
            {
               this.updateOrCreateModalBg(param1.modalAlpha);
            }
            setChildIndex(DisplayObject(param1.containerContent),numChildren-1);
            param1.sourceView.setModalFocus();
            App.containerMgr.lastFocusedView = param1.sourceView;
         }
      }

      public function tryToSetFocus(param1:Boolean=false) : Boolean {
         var _loc2_:IManagedContent = null;
         if(this.manageFocus)
         {
            _loc2_ = this.getTopmostView();
            if(_loc2_)
            {
               this.setFocusedView(_loc2_);
            }
            else
            {
               App.utils.focusHandler.setModalFocus(null);
               if(!param1)
               {
                  dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
               }
            }
         }
         return !(_loc2_ == null);
      }

      public function tryToUpdateContent() : void {
          
      }

      public function updateStage(param1:Number, param2:Number) : void {
         var _loc3_:* = 0;
         var _loc4_:DisplayObject = null;
         if(this._modalBg != null)
         {
            this._modalBg.width = App.appWidth;
            this._modalBg.height = App.appHeight;
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
            this.performRemoveChild(IManagedContent(param1.target));
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

      protected function updateOrCreateModalBg(param1:Number=1.0) : void {
         if(this._modalBg == null)
         {
            this._modalBg = MovieClip(App.utils.classFactory.getComponent(this.getModalBgLinkage(),MovieClip));
            if(this._modalBg == null)
            {
               DebugUtils.LOG_DEBUG("Error until getting ");
               return;
            }
            addChildAt(this._modalBg,numChildren-1);
         }
         else
         {
            this.assertNumberChildrenForModalBg();
            setChildIndex(this._modalBg,numChildren - 2);
         }
         this._modalBg.width = App.appWidth;
         this._modalBg.height = App.appHeight;
         this._modalBg.alpha = param1;
      }

      protected function getModalBgLinkage() : String {
         return Linkages.POPUP_MODAL;
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

      protected function get manageFocus() : Boolean {
         return this._manageFocus;
      }

      protected function set manageFocus(param1:Boolean) : void {
         this._manageFocus = param1;
      }

      private function assertNumberChildrenForModalBg() : void {
         var _loc1_:* = "If modalBg is not null, the container must have more then 1 children.";
         App.utils.asserter.assert(numChildren > 1,_loc1_);
      }

      private function performRemoveChild(param1:IManagedContent) : void {
         var _loc2_:* = "for performRemoveChild " + param1 + " must implements IView or IWrapper";
         App.utils.asserter.assert(param1  is  IWrapper || param1  is  IView,_loc2_,InfrastructureException);
         this.superRemoveChild(DisplayObject(param1));
         if(!(this._modalBg == null) && (param1.sourceView.isModal) && !this.isModalViewsIsExisting())
         {
            this.superRemoveChild(this._modalBg);
            this._modalBg = null;
         }
         else
         {
            if(this._modalBg != null)
            {
               this.assertNumberChildrenForModalBg();
               setChildIndex(this._modalBg,numChildren - 2);
            }
         }
         if(this.manageFocus)
         {
            param1.containerContent.removeEventListener(MouseEvent.MOUSE_DOWN,this.onViewClickHandler,false);
         }
         param1.sourceView.removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onAfterManagedContentDisposeHandler);
         dispatchEvent(new ManagedContainerEvent(ManagedContainerEvent.CHILD_REMOVED));
      }

      private function isModalViewsIsExisting() : Boolean {
         var _loc2_:DisplayObject = null;
         var _loc1_:Number = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            this.assertContent(_loc2_);
            if(_loc2_ != this._modalBg)
            {
               if(IManagedContent(_loc2_).isModal)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }

      private function assertContent(param1:Object) : void {
         var _loc2_:* = "if element of managedContainer is not a ModalBG, that must implements IManagedContent";
         App.utils.asserter.assert(param1  is  IManagedContent || param1 == this._modalBg,_loc2_,InfrastructureException);
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

      private function onAfterManagedContentDisposeHandler(param1:LifeCycleEvent) : void {
         var _loc2_:IManagedContent = IManagedContent(param1.target);
         _loc2_.containerContent.removeEventListener(MouseEvent.MOUSE_DOWN,this.onViewClickHandler,false);
         _loc2_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onAfterManagedContentDisposeHandler);
      }

      private function onViewClickHandler(param1:Event) : void {
         var _loc2_:IManagedContent = null;
         var _loc3_:String = null;
         if((contains(DisplayObject(param1.currentTarget))) && (this.isOwnedByMe(DisplayObject(param1.target))))
         {
            _loc2_ = null;
            if(param1.currentTarget == this._modalBg)
            {
               _loc2_ = this.getTopmostView();
            }
            else
            {
               _loc2_ = IManagedContent(param1.currentTarget);
            }
            _loc3_ = "sourceView in " + _loc2_ + Errors.CANT_NULL;
            App.utils.asserter.assertNotNull(_loc2_.sourceView,_loc3_,InfrastructureException);
            if(_loc2_.sourceView != App.containerMgr.lastFocusedView)
            {
               this.setFocusedView(_loc2_.sourceView);
            }
         }
      }

      private function isOwnedByMe(param1:DisplayObject) : Boolean {
         while(!(param1 == null) && !(param1 == this))
         {
            if(param1  is  IManagedContainer)
            {
               return param1 == this;
            }
            param1 = param1.parent;
         }
         return true;
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
