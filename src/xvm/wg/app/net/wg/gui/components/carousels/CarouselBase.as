package net.wg.gui.components.carousels
{
   import scaleform.clik.controls.CoreList;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import flash.display.MovieClip;
   import scaleform.clik.controls.Button;
   import scaleform.clik.utils.Padding;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Cursors;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.display.DisplayObject;
   import scaleform.clik.data.ListData;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   import flash.display.InteractiveObject;
   import net.wg.data.constants.DragType;


   public class CarouselBase extends CoreList implements IDraggable
   {
          
      public function CarouselBase() {
         this._padding = new Padding(0);
         super();
         this.visible = false;
      }

      private static const SHOW_EMPTY_ITEMS:Boolean = false;

      public static const INIT_CAROUSEL:String = "initCarousel";

      private static const DRAG_ENABLE:Boolean = true;

      private static const DRAG_ACCELERATOR:Number = 3;

      private static const SLIDE_SELF_ACCELERATOR:Number = 7;

      private static const SLIDE_TO_POS_ACCELERATOR:Number = 7;

      private static const MAX_DRAG_OFFSET:Number = 100;

      private static const MAX_DX:Number = 30;

      private static const ARROW_LEFT:String = "left";

      private static const ARROW_RIGHT:String = "right";

      public var margin:uint = 3;

      public var slotImageWidth:uint = 60;

      public var slotImageHeight:uint = 60;

      public var countVisibleSlots:uint = 5;

      public var offsetArrowHeight:int = 0;

      public var useShadow:Boolean = false;

      public var renderersMask:MovieClip;

      public var leftArrow:Button;

      public var rightArrow:Button;

      public var shadow:MovieClip;

      protected var allowDrag:Boolean;

      protected var skippCall:Boolean = false;

      protected var _currentFirstRenderer:uint = 0;

      protected var isInitSize:Boolean = false;

      private var _padding:Padding;

      private var _carouselType:String = "horizontal";

      private var countFactor:int = 0;

      private var slidingScheduled:Boolean = false;

      private var arrowSlideScheduled:Boolean = false;

      private var sourceFactor:Number = 0;

      private var slideSelfAcceleratorDynamic:Number = 7;

      private var lastContainerXPos:Number = 0;

      private var lastDx:Number = 0;

      override protected function onDispose() : void {
         this.leftArrow.removeEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
         this.rightArrow.removeEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
         this.leftArrow.removeEventListener(ButtonEvent.PRESS,this.arrowPress);
         this.rightArrow.removeEventListener(ButtonEvent.PRESS,this.arrowPress);
         this.leftArrow.removeEventListener(ButtonEvent.CLICK,this.arrowClick);
         this.rightArrow.removeEventListener(ButtonEvent.CLICK,this.arrowClick);
         this.leftArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         this.rightArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         this.leftArrow.dispose();
         this.leftArrow = null;
         this.rightArrow.dispose();
         this.rightArrow = null;
         if((DRAG_ENABLE) && (initialized))
         {
            App.cursor.unRegisterDragging(this);
         }
         App.utils.scheduler.cancelTask(this.updateDragPosition);
         this.startOrStopSlidingFn(false,null);
         this.startOrStopInvokingArrowSlide(false);
         super.onDispose();
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         if(_dataProvider == param1)
         {
            return;
         }
         if(_dataProvider != null)
         {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
         }
         _dataProvider = param1;
         if(_dataProvider == null)
         {
            return;
         }
         _dataProvider.addEventListener(Event.CHANGE,handleDataChange,false,0,true);
      }

      public function get padding() : Object {
         return this._padding;
      }

      public function set padding(param1:Object) : void {
         if(!param1)
         {
            return;
         }
         this._padding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }

      public function get carouselType() : String {
         return this._carouselType;
      }

      public function set carouselType(param1:String) : void {
         this._carouselType = param1;
      }

      override protected function draw() : void {
         super.draw();
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.SIZE)) && (this.useShadow))
         {
            this.setChildIndex(this.shadow,this.numChildren-1);
         }
         if((isInvalid(INIT_CAROUSEL)) && !(dataProvider == null) && dataProvider.length > 0)
         {
            this.drawRenderers(dataProvider.length);
            this.drawLayout();
            this.refreshData();
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.leftArrow.x = 0;
         this.rightArrow.width = 21;
         this.leftArrow.width = 21;
         this.shadow.visible = false;
         this.shadow.mouseEnabled = false;
         this.shadow.tabEnabled = this.shadow.tabChildren = this.shadow.mouseChildren = this.shadow.mouseEnabled = false;
         if(DRAG_ENABLE)
         {
            App.cursor.registerDragging(this,Cursors.MOVE);
         }
         this.leftArrow.autoRepeat = true;
         this.rightArrow.autoRepeat = true;
         this.leftArrow.addEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
         this.rightArrow.addEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
         this.leftArrow.addEventListener(ButtonEvent.PRESS,this.arrowPress);
         this.rightArrow.addEventListener(ButtonEvent.PRESS,this.arrowPress);
         this.leftArrow.addEventListener(ButtonEvent.CLICK,this.arrowClick);
         this.rightArrow.addEventListener(ButtonEvent.CLICK,this.arrowClick);
         this.leftArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         this.rightArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
      }

      override protected function drawRenderers(param1:Number) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:DisplayObject = null;
         if(_itemRenderer == null)
         {
            return;
         }
         _loc2_ = _renderers.length;
         while(_loc2_ < param1)
         {
            _loc4_ = createRenderer(_loc2_);
            if(_loc4_ == null)
            {
               break;
            }
            this.tryToDisableHandCursorForRenderer(_loc4_);
            _renderers.push(_loc4_);
            container.addChild(_loc4_ as DisplayObject);
            _loc2_++;
         }
         _loc3_ = _renderers.length;
         _loc2_ = _loc3_-1;
         while(_loc2_ >= param1)
         {
            _loc4_ = getRendererAt(_loc2_);
            if(_loc4_ != null)
            {
               cleanUpRenderer(_loc4_);
               _loc5_ = _loc4_ as DisplayObject;
               if(container.contains(_loc5_))
               {
                  container.removeChild(_loc5_);
               }
            }
            _renderers.splice(_loc2_,1);
            _loc2_--;
         }
      }

      override protected function refreshData() : void {
         _dataProvider.requestItemRange(0,_dataProvider.length,this.populateData);
      }

      override protected function drawLayout() : void {
         var _loc1_:uint = 0;
         var _loc2_:* = NaN;
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:IListItemRenderer = null;
         if(_renderers)
         {
            _loc1_ = _renderers.length;
            _loc2_ = this._padding.left + this._padding.right;
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc5_ = getRendererAt(_loc4_);
               this.tryToDisableHandCursorForRenderer(_loc5_);
               this.updateRenderPosition(_loc5_,_loc4_,_loc3_,_loc2_);
               _loc3_ = _loc5_.x;
               _loc4_++;
            }
            if(!this.isInitSize)
            {
               this.initPosition();
            }
            else
            {
               this.updateContainerPosition();
               if(this.useShadow)
               {
                  this.shadow.visible = this.leftArrow.visible;
               }
            }
         }
      }

      private function tryToDisableHandCursorForRenderer(param1:IListItemRenderer) : void {
         var _loc2_:Button = null;
         if(param1  is  Button)
         {
            _loc2_ = Button(param1);
            _loc2_.useHandCursor = _loc2_.buttonMode = false;
         }
      }

      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint {
         return dataProvider.length;
      }

      protected function getScopeWidth() : Number {
         var _loc1_:Number = 0;
         if(_renderers)
         {
            _loc1_ = _renderers.length * this.getSlotWidth() + this.margin;
            _loc1_ = _loc1_ - 3;
         }
         return _loc1_;
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
            _loc5_.enabled = _loc4_ < _loc2_;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            if(!SHOW_EMPTY_ITEMS)
            {
               UIComponent(_loc5_).visible = !(param1[_loc4_] == null);
            }
            _loc4_++;
         }
      }

      protected function updateRenderPosition(param1:IListItemRenderer, param2:uint, param3:int, param4:Number) : void {
         param1.x = param2 == 0?this._padding.left:param3 + (this.slotImageWidth + param4);
         param1.y = this._padding.top;
      }

      protected function updateContainerPosition() : void {
         var _loc1_:* = 0;
         if(_renderers.length <= this.countVisibleSlots)
         {
            this.leftArrow.visible = this.rightArrow.visible = false;
            _loc1_ = (this.slotImageWidth + this._padding.left + this._padding.right) * _renderers.length ^ 0;
            container.x = this.renderersMask.x + this.renderersMask.width / 2 - _loc1_ / 2 ^ 0;
         }
         else
         {
            this.leftArrow.visible = this.rightArrow.visible = true;
         }
         this.updateArrowsState();
      }

      protected function initPosition() : void {
         this.isInitSize = true;
         container.x = this.getDefContainerPos();
         this.renderersMask.x = this.leftArrow.x + this.leftArrow.width;
         this.renderersMask.y = 0;
         this.renderersMask.width = this.countVisibleSlots * (this.slotImageWidth + this._padding.left + this._padding.right);
         this.renderersMask.height = this.slotImageHeight + 2;
         this.shadow.x = this.renderersMask.x;
         this.shadow.width = this.renderersMask.width;
         this.shadow.height = this.leftArrow.height;
         container.mask = null;
         container.mask = this.renderersMask;
         this.rightArrow.height = this.leftArrow.height = this.renderersMask.height + this.offsetArrowHeight;
         this.rightArrow.x = container.x + this.renderersMask.width + this.leftArrow.width ^ 0;
         this.rightArrow.y = this.leftArrow.y = (this.renderersMask.height - this.leftArrow.height) * 0.5 ^ 0;
         this.visible = true;
         this.updateContainerPosition();
         this.updateArrowsState();
      }

      protected function getSlotWidth() : Number {
         return this.slotImageWidth + this._padding.left + this._padding.right;
      }

      protected function getDefContainerPos() : Number {
         if((this.leftArrow) && (this.leftArrow.visible))
         {
            return this.leftArrow.x + this.leftArrow.width ^ 0;
         }
         return 0;
      }

      protected function updateArrowsState() : void {
         var _loc1_:Number = this.calculateRendererTotal(0,0);
         if(_loc1_ <= this.countVisibleSlots)
         {
            this.enableLeftArrow(false);
            this.enableRightArrow(false);
            this.skippCall = false;
            this.allowDrag = false;
         }
         else
         {
            if(this.currentFirstRenderer == 0)
            {
               this.enableLeftArrow(false);
               this.enableRightArrow(true);
               this.skippCall = false;
               this.allowDrag = true;
            }
            else
            {
               if(this.currentFirstRenderer >= _loc1_ - this.countVisibleSlots)
               {
                  this.enableLeftArrow(true);
                  this.enableRightArrow(false);
                  this.skippCall = false;
                  this.allowDrag = true;
               }
               else
               {
                  this.enableLeftArrow(true);
                  this.enableRightArrow(true);
                  this.allowDrag = true;
               }
            }
         }
      }

      protected function enableLeftArrow(param1:Boolean=false) : void {
         if(this.leftArrow.enabled != param1)
         {
            this.leftArrow.enabled = param1;
            this.leftArrow.validateNow();
         }
      }

      protected function enableRightArrow(param1:Boolean=false) : void {
         if(this.rightArrow.enabled != param1)
         {
            this.rightArrow.enabled = param1;
            this.rightArrow.validateNow();
         }
      }

      private function get currentFirstRenderer() : uint {
         return this._currentFirstRenderer;
      }

      private function set currentFirstRenderer(param1:uint) : void {
         if(param1 == this._currentFirstRenderer)
         {
            return;
         }
         this._currentFirstRenderer = param1;
         this.updateArrowsState();
      }

      override protected function handleMouseWheel(param1:MouseEvent) : void {
         if(_renderers.length > this.countVisibleSlots)
         {
            this.startSlideByArrow(param1.delta > 0?ARROW_LEFT:ARROW_RIGHT,false);
            this.stopSlideByArrow(param1.delta > 0?ARROW_LEFT:ARROW_RIGHT);
         }
      }

      private function renderersMouseEnabled(param1:Boolean=false) : void {
         var _loc2_:int = _renderers?_renderers.length:0;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            if(_renderers[_loc3_]  is  ICarouselItemRenderer)
            {
               ICarouselItemRenderer(_renderers[_loc3_]).canBeSelected = param1;
               _loc3_++;
               continue;
            }
            return;
         }
      }

      private function updateDragPosition(param1:DisplayObject, param2:Object) : void {
         var _loc3_:Number = param2.scopeStartX + (param1.mouseX - param2.startMouseX);
         if(_loc3_ > param2.scopeDefPosition + MAX_DRAG_OFFSET)
         {
            _loc3_ = param2.scopeDefPosition + MAX_DRAG_OFFSET;
         }
         else
         {
            if(_loc3_ < param2.scopeDefPosition - param2.allowDragDistance - MAX_DRAG_OFFSET)
            {
               _loc3_ = param2.scopeDefPosition - param2.allowDragDistance - MAX_DRAG_OFFSET;
            }
         }
         container.x = container.x + (_loc3_ - container.x) / DRAG_ACCELERATOR;
         container.x = container.x ^ 0;
         this.lastDx = container.x - this.lastContainerXPos;
         this.lastContainerXPos = container.x;
         App.utils.scheduler.scheduleTask(this.updateDragPosition,30,this,param2);
      }

      private function startOrStopSlidingFn(param1:Boolean, param2:Object) : void {
         if(param1)
         {
            App.utils.scheduler.scheduleTask(this.slidingFn,30,param2);
         }
         else
         {
            App.utils.scheduler.cancelTask(this.slidingFn);
            this.renderersMouseEnabled(true);
            this.lastDx = 0;
         }
         this.slidingScheduled = param1;
      }

      private function slidingFn(param1:Object) : void {
         this.startOrStopSlidingFn(true,param1);
         var _loc2_:Number = container.x + this.lastDx;
         this.lastDx = this.lastDx + -this.lastDx / this.slideSelfAcceleratorDynamic;
         this.currentFirstRenderer = this.getCurrentFirstRendererOnAnim();
         if(_loc2_ > param1.scopeDefPosition)
         {
            container.x = container.x + (param1.scopeDefPosition - container.x + this.lastDx) / SLIDE_TO_POS_ACCELERATOR;
            this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            if(container.x - param1.scopeDefPosition + this.lastDx < 1 && Math.abs(this.lastDx) < 1)
            {
               container.x = param1.scopeDefPosition;
               this.startOrStopSlidingFn(false,null);
               this.currentFirstRenderer = 0;
            }
         }
         else
         {
            if(_loc2_ < param1.scopeDefPosition - param1.allowDragDistance)
            {
               container.x = container.x + (param1.scopeDefPosition - param1.allowDragDistance - container.x + this.lastDx) / SLIDE_TO_POS_ACCELERATOR;
               this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
               if(Math.abs(param1.scopeDefPosition - param1.allowDragDistance - container.x + this.lastDx) < 1 && Math.abs(this.lastDx) < 1)
               {
                  container.x = param1.scopeDefPosition - param1.allowDragDistance;
                  this.startOrStopSlidingFn(false,null);
               }
            }
            else
            {
               container.x = _loc2_;
               if(Math.abs(this.lastDx) < 1)
               {
                  container.x = container.x ^ 0;
                  this.startOrStopSlidingFn(false,null);
                  this.beginSlideToPos();
               }
            }
         }
      }

      private function beginSlideToPos() : void {
         var _loc1_:Number = this.getCurrentFirstRendererOnAnim();
         this.slideToRenderer(_loc1_);
      }

      private function slideToRenderer(param1:Number) : void {
         this.currentFirstRenderer = param1;
         var _loc2_:Number = -param1 * this.getSlotWidth() + this.getDefContainerPos();
      }

      private function stopSlideByArrow(param1:String) : void {
         var _loc2_:Number = -this.currentFirstRenderer * this.getSlotWidth() - (container.x - this.getDefContainerPos());
         var _loc3_:Number = this._padding.left + this._padding.right + 10;
         var _loc4_:Number = this.currentFirstRenderer;
         if(param1 == ARROW_RIGHT && _loc2_ > _loc3_)
         {
            _loc4_ = this.currentFirstRenderer + Math.round(_loc2_ / this.getSlotWidth()) + 1;
         }
         else
         {
            if(param1 == ARROW_LEFT && _loc2_ < -_loc3_)
            {
               _loc4_ = this.currentFirstRenderer - Math.floor(-_loc2_ / this.getSlotWidth())-1;
            }
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         else
         {
            if(_loc4_ > _renderers.length - this.countVisibleSlots)
            {
               _loc4_ = _renderers.length - this.countVisibleSlots;
            }
         }
         this.currentFirstRenderer = _loc4_;
         this.sourceFactor = 0;
      }

      private function startSlideByArrow(param1:String, param2:Boolean) : void {
         this.startOrStopSlidingFn(false,null);
         if(!this.skippCall)
         {
            this.skippCall = param2;
            this.currentFirstRenderer = param1 == ARROW_LEFT?Math.max(0,this.currentFirstRenderer-1):Math.min(_renderers.length - this.countVisibleSlots,this.currentFirstRenderer + 1);
            if(this.currentFirstRenderer == 0 || this.currentFirstRenderer == _renderers.length - this.countVisibleSlots)
            {
               this.sourceFactor = 0;
            }
            else
            {
               this.sourceFactor = param1 == ARROW_LEFT?1:-1;
            }
            if(!this.arrowSlideScheduled && (container))
            {
               this.slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
               this.startOrStopInvokingArrowSlide(true);
            }
         }
         else
         {
            this.skippCall = param2;
         }
      }

      private function arrowSlide() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         this.startOrStopInvokingArrowSlide(true);
         this.lastDx = this.lastDx + (MAX_DX * this.sourceFactor - this.lastDx) / SLIDE_SELF_ACCELERATOR;
         if(this.sourceFactor == 0)
         {
            this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            this.lastDx = this.lastDx + -this.lastDx / this.slideSelfAcceleratorDynamic;
            _loc1_ = this.getDefContainerPos() - this.currentFirstRenderer * this.getSlotWidth();
            _loc2_ = (_loc1_ - container.x) / SLIDE_SELF_ACCELERATOR + this.lastDx;
            _loc2_ = _loc2_ >= 0?Math.min(MAX_DX,_loc2_):-Math.min(-_loc2_,MAX_DX);
            container.x = container.x + _loc2_;
            if(Math.abs(container.x + this.lastDx - _loc1_) < 1)
            {
               container.x = _loc1_;
               this.startOrStopInvokingArrowSlide(false);
            }
         }
         else
         {
            this.countFactor++;
            container.x = container.x + this.lastDx;
            if(this.getCurrentFirstRendererOnAnim() == 0 && this.sourceFactor == 1)
            {
               this.currentFirstRenderer = 0;
               this.sourceFactor = 0;
            }
            else
            {
               if(this.getCurrentFirstRendererOnAnim() == _renderers.length - this.countVisibleSlots && this.sourceFactor == -1)
               {
                  this.currentFirstRenderer = _renderers.length - this.countVisibleSlots;
                  this.sourceFactor = 0;
               }
            }
         }
      }

      private function startOrStopInvokingArrowSlide(param1:Boolean) : void {
         if(param1)
         {
            App.utils.scheduler.scheduleTask(this.arrowSlide,30);
         }
         else
         {
            App.utils.scheduler.cancelTask(this.arrowSlide);
         }
         this.arrowSlideScheduled = param1;
      }

      private function getCurrentFirstRendererOnAnim() : Number {
         var _loc1_:Number = -Math.round((container.x - this.getDefContainerPos()) / this.getSlotWidth());
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         else
         {
            if(_loc1_ > _renderers.length - this.countVisibleSlots)
            {
               _loc1_ = _renderers.length - this.countVisibleSlots;
            }
         }
         return _loc1_;
      }

      private function arrowRelease(param1:ButtonEvent) : void {
         this.stopSlideByArrow(param1.target == this.leftArrow?ARROW_LEFT:ARROW_RIGHT);
      }

      private function arrowClick(param1:ButtonEvent) : void {
         this.startSlideByArrow(param1.target == this.leftArrow?ARROW_LEFT:ARROW_RIGHT,false);
      }

      private function arrowPress(param1:ButtonEvent) : void {
         this.startSlideByArrow(param1.target == this.leftArrow?ARROW_LEFT:ARROW_RIGHT,true);
      }

      private function arrowUp(param1:MouseEvent) : void {
         param1.target.dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE));
      }

      public function getHitArea() : InteractiveObject {
         return container;
      }

      public function onStartDrag() : void {
         var _loc1_:Object = null;
         if(this.allowDrag)
         {
            this.startOrStopSlidingFn(false,null);
            _loc1_ =
               {
                  "scopeStartX":container.x,
                  "startMouseX":mouseX,
                  "allowDragDistance":this.getScopeWidth() - this.renderersMask.width,
                  "scopeDefPosition":this.getDefContainerPos()
               }
            ;
            this.lastContainerXPos = container.x;
            this.startOrStopInvokingArrowSlide(false);
            App.utils.scheduler.scheduleTask(this.updateDragPosition,30,this,_loc1_);
         }
      }

      public function onDragging(param1:Number, param2:Number) : void {
         this.renderersMouseEnabled(false);
      }

      public function onEndDrag() : void {
         var _loc1_:Object = null;
         if(this.allowDrag)
         {
            this.slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
            if(!this.slidingScheduled)
            {
               _loc1_ =
                  {
                     "scopeDefPosition":this.getDefContainerPos(),
                     "allowDragDistance":this.getScopeWidth() - this.renderersMask.width
                  }
               ;
               this.startOrStopSlidingFn(true,_loc1_);
            }
         }
         else
         {
            this.renderersMouseEnabled(true);
         }
         App.utils.scheduler.cancelTask(this.updateDragPosition);
      }

      public function getDragType() : String {
         return DragType.SOFT;
      }
   }

}