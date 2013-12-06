package net.wg.gui.components.controls
{
   import net.wg.infrastructure.interfaces.IDraggableList;
   import flash.display.MovieClip;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.motion.Tween;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.interfaces.IListItemRenderer;
   import fl.transitions.easing.*;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.ListData;
   import flash.utils.setInterval;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import flash.utils.clearTimeout;
   import scaleform.gfx.MouseEventEx;


   public class Carousel extends CoreListEx implements IDraggableList
   {
          
      public function Carousel() {
         this._padding = new Padding([0,0,0,0]);
         super();
      }

      public static var contentMargin:Number = 0;

      public static const CAROUSEL_BUTTON_ARROW_OFFSET:Number = 0;

      public var margin:Number = 0;

      public var slotImageWidth:Number = 0;

      public var slotImageHeight:Number = 0;

      public var leftArrow:SoundButton;

      public var rightArrow:SoundButton;

      public var renderersMask:MovieClip;

      public var dragHitArea:MovieClip;

      public var bg:MovieClip;

      protected var _padding:Padding;

      protected var _visibleSlots:Number = 0;

      protected var slotWidth:Number = 0;

      private var scopeWidth:Number = 0;

      protected var _allowW:Number = 0;

      protected var _allowH:Number = 0;

      protected var _defContainerPos:Number = 0;

      protected var isPreDragging:Boolean = false;

      protected var isDragging:Boolean = false;

      protected var draggingIntervalId:Number = 0;

      protected var slidingIntervalId:Number = 0;

      protected var arrowSlideIntervalId:Number = 0;

      protected var isTween:Boolean = false;

      protected var tween:Tween = null;

      protected var _isMoving:Boolean = false;

      protected var _isSliding:Boolean = false;

      protected var _currentFirstRenderer:uint = 0;

      protected var _currentFirstRendererOnAnim:uint = 0;

      protected var distanceOfDragDelay:uint = 10;

      private var courseFactor:Number = 0;

      private var slideAcceleratorAfterDrag:Number = 16;

      private var slideAcceleratorByArrow:Number = 7;

      private var slideToPosAccelerator:Number = 7;

      private var dragAccelerator:Number = 3;

      protected var lastDx:Number = 0;

      private var maxDx:Number = 20;

      private var lastContainerXPos:Number = 0;

      private var maxDragOffset:Number = 100;

      private var _dragEnabled:Boolean = true;

      protected var allowDrag:Boolean = false;

      private var _isMouseOver:Boolean = false;

      private const SLIDE_COURSE_LEFT:String = "left";

      private const SLIDE_COURSE_RIGHT:String = "right";

      private const INTERVAL_SPEED:Number = 16.666666666666668;

      override public function scrollToIndex(param1:uint) : void {
         var _loc2_:uint = 0;
         if((container) && (_renderers))
         {
            _loc2_ = Math.floor(this._visibleSlots / 2);
            param1 = Math.min(_renderers.length - this._visibleSlots,Math.max(0,param1 - _loc2_));
            this.currentFirstRenderer = Math.min(_renderers.length - this._visibleSlots,param1);
            this.goToFirstRenderer();
         }
      }

      override public function toString() : String {
         return "[Wargaming Carousel" + name + "]";
      }

      override public function dispose() : void {
         super.dispose();
         this.tryClearTween();
         this.clearWheelTimeout();
         this.clearDraggingIntervalId();
         this.clearSlidingIntervalId();
         this.clearArrowSlide();
         if(this.dragHitArea)
         {
            this.dragHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDragAreaMouseDown);
         }
         if((this.leftArrow) && (this.rightArrow))
         {
            this.leftArrow.removeEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
            this.leftArrow.removeEventListener(ButtonEvent.PRESS,this.arrowPress);
            this.leftArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
            this.rightArrow.removeEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
            this.rightArrow.removeEventListener(ButtonEvent.PRESS,this.arrowPress);
            this.rightArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         }
         removeEventListener(ListEventEx.ITEM_CLICK,this.onItemClick);
         removeEventListener(ListEventEx.ITEM_ROLL_OVER,this.onItemRollOver);
         removeEventListener(ListEventEx.ITEM_ROLL_OUT,this.onItemRollOut);
         this.removeRenderers();
         _renderers = null;
         if((container) && (this.contains(container)))
         {
            removeChild(container);
         }
         this.leftArrow.dispose();
         this.leftArrow = null;
         this.rightArrow.dispose();
         this.rightArrow = null;
         this.renderersMask = null;
         this.dragHitArea = null;
         this.bg = null;
         this._padding = null;
      }

      public function set isSliding(param1:Boolean) : void {
         var _loc2_:DragableListItemRenderer = null;
         this._isSliding = param1;
         if(!this._isSliding && (this.dragHitArea.hitTestPoint(stage.mouseX,stage.mouseY,true)) && (this._isMouseOver))
         {
            _loc2_ = this.findHitTestRenderer();
            if(_loc2_)
            {
               _loc2_.imitateMouseOver();
            }
         }
      }

      public function get isSliding() : Boolean {
         return this._isSliding;
      }

      public function set isMoving(param1:Boolean) : void {
         this._isMoving = param1;
      }

      public function get isMoving() : Boolean {
         return this._isMoving;
      }

      private function findHitTestRenderer() : DragableListItemRenderer {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc1_:DragableListItemRenderer = null;
         if((container) && (_renderers))
         {
            _loc2_ = container.mouseX - this.padding.horizontal;
            _loc3_ = Math.floor(_loc2_ / this.slotWidth);
            if(_loc2_ <= (_loc3_ + 1) * this.slotWidth - this.padding.horizontal)
            {
               _loc1_ = getRendererAt(_loc3_) as DragableListItemRenderer;
            }
         }
         return _loc1_;
      }

      public function updateSize(param1:int, param2:int) : void {
         this._allowW = param1;
         this._allowH = param2;
         _originalWidth = param1;
         _originalHeight = param2;
         setSize(param1,param2);
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.updateArrowsState();
      }

      override public function get selectedIndex() : int {
         return _selectedIndex;
      }

      override public function set selectedIndex(param1:int) : void {
         if(param1 == _selectedIndex)
         {
            return;
         }
         var _loc2_:IListItemRenderer = getRendererAt(_selectedIndex);
         if(_loc2_ != null)
         {
            _loc2_.selected = false;
         }
         super.selectedIndex = param1;
         _loc2_ = getRendererAt(_selectedIndex);
         if(_loc2_ != null)
         {
            _loc2_.selected = true;
         }
      }

      public function get dragEnabled() : Boolean {
         return this._dragEnabled;
      }

      public function set dragEnabled(param1:Boolean) : void {
         var _loc2_:uint = 0;
         var _loc3_:DragableListItemRenderer = null;
         if(this._dragEnabled == param1)
         {
            return;
         }
         this._dragEnabled = param1;
         if(_renderers)
         {
            _loc2_ = 0;
            while(_loc2_ < _renderers.length)
            {
               _loc3_ = getRendererAt(_loc2_) as DragableListItemRenderer;
               _loc3_.dragEnabled = this._dragEnabled;
               _loc2_++;
            }
         }
      }

      public function get padding() : Padding {
         return this._padding;
      }

      public function set padding(param1:Padding) : void {
         this._padding = param1;
      }

      public function set inspectablePadding(param1:Object) : void {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.padding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }

      override protected function configUI() : void {
         contentMargin = this.margin;
         super.configUI();
         this.initUIStartPosition();
         this.updateSlotWidth();
         if((this.dragHitArea) && (this._dragEnabled))
         {
            this.dragHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onDragAreaMouseDown);
         }
         if((this.leftArrow) && (this.rightArrow))
         {
            this.leftArrow.autoRepeat = true;
            this.rightArrow.autoRepeat = true;
            this.leftArrow.addEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
            this.rightArrow.addEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
            this.leftArrow.addEventListener(ButtonEvent.PRESS,this.arrowPress);
            this.rightArrow.addEventListener(ButtonEvent.PRESS,this.arrowPress);
            this.leftArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
            this.rightArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         }
         this.addEventListener(ListEventEx.ITEM_CLICK,this.onItemClick);
         this.addEventListener(ListEventEx.ITEM_ROLL_OVER,this.onItemRollOver);
         this.addEventListener(ListEventEx.ITEM_ROLL_OUT,this.onItemRollOut);
      }

      override protected function draw() : void {
         if(isInvalid(InvalidationType.DATA))
         {
            this.refreshData();
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateVisibleSlots();
            this.updateEmptyRenderers();
            this.updateScopeWidth();
            this.updateLayout();
         }
      }

      override protected function refreshData() : void {
         this.removeRenderers();
         this.invalidateContainer();
         this.drawRenderers(_totalRenderers);
         _dataProvider.requestItemRange(0,_dataProvider.length,this.populateData);
      }

      override protected function drawRenderers(param1:Number) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:IListItemRenderer = null;
         if(_itemRenderer == null)
         {
            return;
         }
         if(_renderers == null)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _totalRenderers)
         {
            _loc4_ = createRenderer(_loc2_);
            if(_loc4_ == null)
            {
               break;
            }
            _loc4_.x = this.padding.horizontal + _loc2_ * this.slotWidth;
            _renderers.push(_loc4_);
            container.addChild(_loc4_ as DisplayObject);
            _loc2_++;
         }
      }

      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint {
         var _loc3_:Number = 0;
         if(_dataProvider.length > 0)
         {
            _loc3_ = _dataProvider.length;
         }
         return _loc3_;
      }

      protected function initUIStartPosition() : void {
         this.leftArrow.x = contentMargin;
         this.leftArrow.y = contentMargin;
         this.rightArrow.y = contentMargin;
         container.x = contentMargin;
         container.y = contentMargin;
         this.renderersMask.x = contentMargin;
         this.renderersMask.y = contentMargin;
         this.dragHitArea.x = this.renderersMask.x;
         this.dragHitArea.y = this.renderersMask.x;
         this.updateDefContainerPos();
      }

      protected function removeRenderers() : void {
         var _loc1_:* = 0;
         var _loc2_:IListItemRenderer = null;
         var _loc3_:* = 0;
         if(_renderers)
         {
            _loc1_ = _renderers.length;
            _loc2_ = null;
            _loc3_ = _loc1_-1;
            while(_loc3_ >= 0)
            {
               _loc2_ = getRendererAt(_loc3_);
               if(_loc2_ != null)
               {
                  cleanUpRenderer(_loc2_);
                  IDisposable(_loc2_).dispose();
                  if(container.contains(DisplayObject(_loc2_)))
                  {
                     container.removeChild(DisplayObject(_loc2_));
                  }
               }
               _loc3_--;
            }
            _renderers.splice(0,_renderers.length);
         }
         _renderers = new Vector.<IListItemRenderer>();
      }

      protected function populateData(param1:Array) : void {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:uint = 0;
         var _loc7_:ListData = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_ && (enabled);
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
      }

      protected function updateVisibleSlots() : Number {
         this._visibleSlots = (this._allowW - (this.leftArrow.x + this.leftArrow.width + this.rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET * 2 + contentMargin + this.padding.horizontal)) / this.slotWidth;
         return this._visibleSlots;
      }

      protected function getEmptySlotsNumForShow() : uint {
         var _loc1_:Number = 0;
         if(initialized)
         {
            _loc1_ = this._visibleSlots - _totalRenderers;
         }
         return Math.max(_loc1_,0);
      }

      protected function updateDefContainerPos() : Number {
         if((this.leftArrow) && (this.leftArrow.visible))
         {
            this._defContainerPos = this.leftArrow.x + this.leftArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET ^ 0;
         }
         else
         {
            this._defContainerPos = 0;
         }
         return this._defContainerPos;
      }

      protected function updateSlotWidth() : void {
         this.slotWidth = this.slotImageWidth + this.padding.horizontal;
      }

      protected function updateScopeWidth() : void {
         this.scopeWidth = _renderers.length * this.slotWidth + this.margin * 2;
      }

      protected function updateArrowsState() : void {
         if(_totalRenderers <= this._visibleSlots || !enabled)
         {
            this.allowDrag = false;
            this.leftArrow.enabled = false;
            this.rightArrow.enabled = false;
         }
         else
         {
            if(this.currentFirstRenderer == 0)
            {
               this.leftArrow.enabled = false;
               this.rightArrow.enabled = true;
               this.allowDrag = true;
            }
            else
            {
               if(this.currentFirstRenderer >= _totalRenderers - this._visibleSlots)
               {
                  this.leftArrow.enabled = true;
                  this.rightArrow.enabled = false;
                  this.allowDrag = true;
               }
               else
               {
                  this.leftArrow.enabled = true;
                  this.rightArrow.enabled = true;
                  this.allowDrag = true;
               }
            }
         }
      }

      protected function updateLayout() : void {
         if((initialized) && (_renderers))
         {
            this.updateArrowsState();
            this.updateUIPosition();
            this.correctContainerPosition();
            this.x = this._allowW - (this.rightArrow.x + contentMargin) >> 1;
         }
      }

      private function correctContainerPosition() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         if(container)
         {
            _loc1_ = this.scopeWidth - this.renderersMask.width;
            _loc2_ = this._defContainerPos;
            if(container.x < _loc2_ - _loc1_)
            {
               this.currentFirstRenderer = Math.max(_renderers.length - this._visibleSlots,0);
               this.goToFirstRenderer();
            }
         }
      }

      protected function goToFirstRenderer() : void {
         container.x = this._defContainerPos - this.currentFirstRenderer * this.slotWidth ^ 0;
      }

      protected function updateUIPosition() : void {
         if((container) && (this.rightArrow))
         {
            this.rightArrow.x = this._defContainerPos + this.slotWidth * this._visibleSlots + this.rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET + this.padding.horizontal;
            this.renderersMask.width = this.rightArrow.x - this._defContainerPos - this.rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET;
            this.dragHitArea.width = this.renderersMask.width;
         }
         this.correctBg();
      }

      protected function updateEmptyRenderers() : void {
         this.clearEmptyRenderers();
         this.createdEmptyRenderers();
      }

      protected function createdEmptyRenderers() : void {
         var _loc1_:uint = 0;
         var _loc2_:IListItemRenderer = null;
         var _loc3_:uint = 0;
         var _loc4_:* = 0;
         if(_renderers)
         {
            _loc3_ = this.getEmptySlotsNumForShow();
            _loc1_ = _renderers.length;
            _loc4_ = _loc1_;
            while(_loc4_ < _loc1_ + _loc3_)
            {
               _loc2_ = createRenderer(_loc4_);
               if(_loc2_ == null)
               {
                  break;
               }
               _loc2_.x = this.padding.horizontal + _loc4_ * this.slotWidth;
               _loc2_.setData(this.getEmptyRendererData());
               _renderers.push(_loc2_);
               container.addChild(_loc2_ as DisplayObject);
               _loc2_.validateNow();
               _loc4_++;
            }
         }
      }

      protected function clearEmptyRenderers() : void {
         var _loc1_:IListItemRenderer = null;
         var _loc2_:uint = 0;
         var _loc3_:DisplayObject = null;
         var _loc4_:IDisposable = null;
         var _loc5_:* = 0;
         if(_renderers)
         {
            _loc2_ = _renderers.length;
            _loc5_ = _loc2_-1;
            while(_loc5_ >= 0)
            {
               _loc1_ = getRendererAt(_loc5_);
               if(!(_loc1_ == null) && "empty"  in  _loc1_ && (_loc1_["empty"]))
               {
                  cleanUpRenderer(_loc1_);
                  _loc4_ = _loc1_ as IDisposable;
                  _loc4_.dispose();
                  _loc3_ = _loc1_ as DisplayObject;
                  if(container.contains(_loc3_))
                  {
                     container.removeChild(_loc3_);
                  }
                  _renderers.splice(_loc5_,1);
               }
               _loc5_--;
            }
         }
      }

      protected function getEmptyRendererData() : Object {
         var _loc1_:Object = {"empty":true};
         return _loc1_;
      }

      override protected function handleItemClick(param1:ButtonEvent) : void {
         if(this.isMoving)
         {
            this.isMoving = false;
            return;
         }
         super.handleItemClick(param1);
      }

      protected function startDragging() : void {
         var _loc1_:Object = null;
         this.isDragging = false;
         if((this._dragEnabled) && (this.allowDrag))
         {
            this.clearSlidingIntervalId();
            if(!this.isPreDragging)
            {
               this.clearArrowSlide();
               this.tryClearTween();
               _loc1_ =
                  {
                     "scopeStartX":container.x,
                     "startMouseX":mouseX,
                     "allowDragDistance":this._defContainerPos - (this.scopeWidth - this.renderersMask.width),
                     "scopeDefPosition":this._defContainerPos
                  }
               ;
               this.isPreDragging = true;
               this.lastContainerXPos = container.x;
               this.draggingIntervalId = setInterval(this.updateDrugPosition,this.INTERVAL_SPEED,this,_loc1_);
            }
         }
      }

      private function clearDraggingIntervalId() : void {
         if(this.draggingIntervalId)
         {
            clearInterval(this.draggingIntervalId);
            this.draggingIntervalId = 0;
         }
      }

      protected function stopDragging() : void {
         var _loc1_:Object = null;
         this.clearDraggingIntervalId();
         if(this.slidingIntervalId == 0)
         {
            _loc1_ =
               {
                  "scopeDefPosition":this._defContainerPos,
                  "allowDragDistance":this._defContainerPos - (this.scopeWidth - this.renderersMask.width)
               }
            ;
            this.tryClearTween();
            this.isSliding = true;
            this.slidingFn(_loc1_);
            this.slidingIntervalId = setInterval(this.slidingFn,this.INTERVAL_SPEED,_loc1_);
         }
         this.isPreDragging = false;
      }

      protected function get currentFirstRenderer() : uint {
         return this._currentFirstRenderer;
      }

      protected function set currentFirstRenderer(param1:uint) : void {
         if(param1 == this._currentFirstRenderer)
         {
            return;
         }
         this._currentFirstRenderer = param1;
         this.updateArrowsState();
      }

      override protected function onItemStartDrag(param1:ListEventEx) : void {
         if(param1.buttonIdx == 0)
         {
            stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
            this.startDragging();
         }
      }

      private var wheelStopTimeoutId:Number = 0;

      private var wheelPrevCourse:String = "";

      override protected function handleMouseWheel(param1:MouseEvent) : void {
         if(!enabled)
         {
            return;
         }
         App.contextMenuMgr.hide();
         var _loc2_:String = param1.delta > 0?this.SLIDE_COURSE_LEFT:this.SLIDE_COURSE_RIGHT;
         var _loc3_:Number = 300;
         if(this.wheelStopTimeoutId == 0)
         {
            this.startSlideByArrow(_loc2_);
            _loc3_ = 200;
         }
         else
         {
            if(this.wheelPrevCourse != _loc2_)
            {
               this.stopSlideByArrow(this.wheelPrevCourse);
               this.startSlideByArrow(_loc2_);
            }
         }
         this.wheelPrevCourse = _loc2_;
         this.clearWheelTimeout();
         this.wheelStopTimeoutId = setTimeout(this.wheelStop,_loc3_,_loc2_);
      }

      private function clearWheelTimeout() : void {
         if(this.wheelStopTimeoutId != 0)
         {
            clearTimeout(this.wheelStopTimeoutId);
            this.wheelStopTimeoutId = 0;
         }
      }

      private function wheelStop(param1:String) : void {
         this.clearWheelTimeout();
         this.wheelPrevCourse = "";
         this.stopSlideByArrow(param1);
      }

      private function invalidateContainer() : void {
         if(this.contains(container))
         {
            removeChild(container);
         }
         if(!this.contains(container))
         {
            addChild(container);
         }
         if(this.renderersMask)
         {
            this.setChildIndex(this.renderersMask,this.numChildren-1);
            container.mask = this.renderersMask;
         }
      }

      private function correctBg() : void {
         if(this.bg)
         {
            this.bg.width = this._allowW;
            this.bg.height = this.slotImageHeight + contentMargin * 2 ^ 0;
            this.bg.x = -(this._allowW - (this.rightArrow.x + contentMargin) >> 1);
         }
      }

      private function startSlideByArrow(param1:String) : void {
         this.clearSlidingIntervalId();
         this.currentFirstRenderer = this.getCurrentFirstRendererOnAnim();
         this.currentFirstRenderer = param1 == "left"?Math.max(0,this.currentFirstRenderer-1):Math.min(_renderers.length - this._visibleSlots,this.currentFirstRenderer + 1);
         if(this.currentFirstRenderer == 0 || this.currentFirstRenderer == _renderers.length - this._visibleSlots)
         {
            this.courseFactor = 0;
         }
         else
         {
            this.courseFactor = param1 == "left"?1:-1;
         }
         if(this.arrowSlideIntervalId == 0 && (container))
         {
            this.tryClearTween();
            this.isMoving = true;
            this.isSliding = true;
            this.arrowSlideIntervalId = setInterval(this.arrowSlide,this.INTERVAL_SPEED);
         }
      }

      private function stopSlideByArrow(param1:String) : void {
         var _loc2_:Number = -this.currentFirstRenderer * this.slotWidth - (container.x - this._defContainerPos);
         var _loc3_:Number = this.padding.horizontal + 10;
         var _loc4_:Number = this.currentFirstRenderer;
         if(param1 == "right" && _loc2_ > _loc3_)
         {
            _loc4_ = this.currentFirstRenderer + Math.round(_loc2_ / this.slotWidth) + 1;
         }
         else
         {
            if(param1 == "left" && _loc2_ < -_loc3_)
            {
               _loc4_ = this.currentFirstRenderer - Math.floor(-_loc2_ / this.slotWidth)-1;
            }
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         else
         {
            if(_loc4_ > _renderers.length - this._visibleSlots)
            {
               _loc4_ = _renderers.length - this._visibleSlots;
            }
         }
         this.currentFirstRenderer = _loc4_;
         this.courseFactor = 0;
      }

      private function arrowSlide() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         this.lastDx = this.lastDx + (this.maxDx * this.courseFactor - this.lastDx) / this.slideAcceleratorByArrow;
         if(this.courseFactor == 0)
         {
            this.lastDx = this.lastDx + -this.lastDx / this.slideToPosAccelerator;
            _loc1_ = this._defContainerPos - this.currentFirstRenderer * this.slotWidth;
            _loc2_ = (_loc1_ - container.x) / this.slideAcceleratorByArrow + this.lastDx;
            _loc2_ = _loc2_ >= 0?Math.min(this.maxDx,_loc2_):-Math.min(-_loc2_,this.maxDx);
            container.x = container.x + _loc2_;
            if(Math.abs(container.x + this.lastDx - _loc1_) < 1)
            {
               container.x = _loc1_;
               this.lastDx = 0;
               this.clearArrowSlide();
            }
         }
         else
         {
            container.x = container.x + this.lastDx;
            this.getCurrentFirstRendererOnAnim();
            if(this._currentFirstRendererOnAnim == 0 && this.courseFactor == 1)
            {
               this.currentFirstRenderer = 0;
               this.courseFactor = 0;
            }
            else
            {
               if(this._currentFirstRendererOnAnim == _renderers.length - this._visibleSlots && this.courseFactor == -1)
               {
                  this.currentFirstRenderer = _renderers.length - this._visibleSlots;
                  this.courseFactor = 0;
               }
            }
         }
      }

      private function clearArrowSlide() : void {
         if(this.arrowSlideIntervalId)
         {
            this.isMoving = false;
            this.isSliding = false;
            clearInterval(this.arrowSlideIntervalId);
            this.arrowSlideIntervalId = 0;
         }
      }

      private function updateDrugPosition(param1:Carousel, param2:Object) : void {
         var _loc3_:* = NaN;
         if(this.isPreDragging)
         {
            if(!this.isDragging && Math.abs(param1.mouseX - param2.startMouseX) > this.distanceOfDragDelay)
            {
               this.isDragging = true;
               this.isMoving = true;
            }
            if(this.isDragging)
            {
               _loc3_ = param2.scopeStartX + (param1.mouseX - param2.startMouseX);
               if(_loc3_ > param2.scopeDefPosition + this.maxDragOffset)
               {
                  _loc3_ = param2.scopeDefPosition + this.maxDragOffset;
               }
               else
               {
                  if(_loc3_ < param2.allowDragDistance - this.maxDragOffset)
                  {
                     _loc3_ = param2.allowDragDistance - this.maxDragOffset;
                  }
               }
               container.x = container.x + (_loc3_ - container.x) / this.dragAccelerator;
               container.x = container.x ^ 0;
               this.lastDx = container.x - this.lastContainerXPos;
               this.lastContainerXPos = container.x;
            }
         }
      }

      private function clearSlidingIntervalId() : void {
         if(this.slidingIntervalId)
         {
            this.isSliding = false;
            clearInterval(this.slidingIntervalId);
            this.slidingIntervalId = 0;
            this.lastDx = 0;
         }
      }

      private function slidingFn(param1:Object) : void {
         var _loc2_:Number = container.x + this.lastDx;
         this.lastDx = this.lastDx + -this.lastDx / this.slideAcceleratorAfterDrag;
         if(_loc2_ > param1.scopeDefPosition)
         {
            container.x = container.x + (param1.scopeDefPosition - container.x + this.lastDx) / this.slideToPosAccelerator;
            if(container.x - param1.scopeDefPosition + this.lastDx < 1 && Math.abs(this.lastDx) < 1)
            {
               container.x = param1.scopeDefPosition;
               this.clearSlidingIntervalId();
               this.currentFirstRenderer = 0;
               this.isMoving = false;
            }
         }
         else
         {
            if(_loc2_ < param1.allowDragDistance)
            {
               _loc2_ = param1.allowDragDistance - container.x + this.lastDx;
               container.x = container.x + _loc2_ / this.slideToPosAccelerator;
               if(Math.abs(_loc2_) < 1 && Math.abs(this.lastDx) < 1)
               {
                  container.x = param1.allowDragDistance;
                  this.clearSlidingIntervalId();
                  this.currentFirstRenderer = _renderers.length-1;
                  this.isMoving = false;
               }
            }
            else
            {
               container.x = _loc2_;
               if(Math.abs(this.lastDx) < 1)
               {
                  this.currentFirstRenderer = this.getCurrentFirstRendererOnAnim();
                  container.x = container.x ^ 0;
                  this.clearSlidingIntervalId();
                  this.beginSlideToPos();
               }
            }
         }
      }

      private function beginSlideToPos() : void {
         var _loc1_:Number = this.getCurrentFirstRendererOnAnim();
         this.slideToRenderer(_loc1_);
      }

      private function getCurrentFirstRendererOnAnim() : Number {
         var _loc1_:Number = -Math.round((container.x - this._defContainerPos) / this.slotWidth);
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         else
         {
            if(_loc1_ >= _renderers.length - this._visibleSlots)
            {
               _loc1_ = _renderers.length - this._visibleSlots;
            }
         }
         this._currentFirstRendererOnAnim = _loc1_;
         return this._currentFirstRendererOnAnim;
      }

      private function slideToRenderer(param1:Number) : void {
         this.currentFirstRenderer = param1;
         var _loc2_:Number = -param1 * this.slotWidth + this._defContainerPos;
         this.tryClearTween();
         if(container.x != _loc2_)
         {
            this.isTween = true;
            this.tween = new Tween(1000,container,{"x":_loc2_},
               {
                  "paused":false,
                  "onComplete":this.onTweenComplete,
                  "ease":Strong.easeInOut
               }
            );
         }
      }

      private function onTweenComplete() : void {
         this.isTween = false;
         this.tryClearTween();
      }

      protected function tryClearTween() : void {
         if(this.tween)
         {
            this.tween.paused = true;
            this.tween = null;
            this.isTween = false;
            this.isMoving = false;
         }
      }

      private function arrowPress(param1:ButtonEvent) : void {
         this.startSlideByArrow(param1.target == this.leftArrow?this.SLIDE_COURSE_LEFT:this.SLIDE_COURSE_RIGHT);
      }

      private function arrowUp(param1:MouseEvent) : void {
         param1.target.dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE));
      }

      private function arrowRelease(param1:ButtonEvent) : void {
         this.stopSlideByArrow(param1.target == this.leftArrow?this.SLIDE_COURSE_LEFT:this.SLIDE_COURSE_RIGHT);
      }

      private function onDragAreaMouseDown(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.mouseIdx;
         var _loc4_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc4_ != 0)
         {
            return;
         }
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.startDragging();
      }

      private function onStageMouseUp(param1:MouseEvent) : void {
         if(stage.hasEventListener(MouseEvent.MOUSE_UP))
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         }
         this.stopDragging();
      }

      protected function onItemClick(param1:ListEventEx) : void {
          
      }

      protected function onItemRollOut(param1:ListEventEx) : void {
         this._isMouseOver = false;
      }

      protected function onItemRollOver(param1:ListEventEx) : void {
         this._isMouseOver = true;
      }
   }

}