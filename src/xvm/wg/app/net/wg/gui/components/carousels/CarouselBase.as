package net.wg.gui.components.carousels
{
   import scaleform.clik.controls.CoreList;
   import flash.display.MovieClip;
   import scaleform.clik.controls.Button;
   import scaleform.clik.utils.Padding;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import flash.display.Stage;
   import scaleform.gfx.MouseCursorEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.display.DisplayObject;
   import scaleform.clik.data.ListData;
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IPersonalCaseItemRenderer;
   import scaleform.clik.motion.Tween;
   import flash.utils.setInterval;
   import flash.utils.clearInterval;
   import net.wg.data.constants.Cursors;
   import net.wg.infrastructure.interfaces.ICursor;


   public class CarouselBase extends CoreList
   {
          
      public function CarouselBase() {
         this._padding = new Padding(0);
         this.lastCursor = Cursors.ARROW;
         super();
         this.visible = false;
      }

      public static const INIT_CAROUSEL:String = "initCarousel";

      private static const DRAG_ENABLE:Boolean = true;

      private static const DRAG_ACCELERATOR:Number = 3;

      private static const SLIDE_SELF_ACCELERATOR:Number = 7;

      private static const SLIDE_TO_POS_ACCELERATOR:Number = 7;

      private static const MAX_DRAG_ODDSET:Number = 100;

      private static const MAX_DX:Number = 30;

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

      public var dragHitArea:MovieClip;

      protected var isDragging:Boolean = false;

      protected var allowDrag:Boolean;

      protected var skippCall:Boolean = false;

      protected var _currentFirstRenederer:uint = 0;

      protected var isInitSize:Boolean = false;

      private var _padding:Padding;

      private var _carouselType:String = "horizontal";

      private var mouseIn:Boolean = false;

      private var lastCursor:String;

      private var countFactor:int = 0;

      private var draggingIntervalId:uint = 0;

      private var slidingIntervalId:uint = 0;

      private var arrowSlideIntervaId:uint = 0;

      private var courceFactor:Number = 0;

      private var slideSelfAcceleratorDynamic:Number = 7;

      private var lastContenerXPos:Number = 0;

      private var lastDx:Number = 0;

      private var isUpdated:Boolean = false;

      private var showEmptyItems:Boolean = false;

      override protected function onDispose() : void {
         super.onDispose();
         this.leftArrow.removeEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
         this.rightArrow.removeEventListener(MouseEvent.MOUSE_UP,this.arrowUp);
         this.leftArrow.removeEventListener(ButtonEvent.PRESS,this.arrowPress);
         this.rightArrow.removeEventListener(ButtonEvent.PRESS,this.arrowPress);
         this.leftArrow.removeEventListener(ButtonEvent.CLICK,this.arrowClick);
         this.rightArrow.removeEventListener(ButtonEvent.CLICK,this.arrowClick);
         this.leftArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         this.rightArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.arrowRelease);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.startDragging);
         var _loc1_:Stage = App.stage;
         _loc1_.removeEventListener(MouseEvent.MOUSE_UP,this.stopDragging);
         _loc1_.removeEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
         _loc1_.removeEventListener(MouseEvent.MOUSE_MOVE,this.carouselMouseMoveHandler);
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
            this.isUpdated = true;
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
         this.shadow.tabEnabled = this.shadow.tabChildren = this.shadow.mouseChildren = this.shadow.mouseEnabled = false;
         if(this.dragHitArea)
         {
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.startDragging);
         }
         if((this.leftArrow) && (this.rightArrow))
         {
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
         this.setCursorListeners();
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
         var _loc3_:* = false;
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:IListItemRenderer = null;
         if(_renderers)
         {
            _loc1_ = _renderers.length;
            _loc2_ = this._padding.left + this._padding.right;
            _loc3_ = isInvalid(InvalidationType.DATA);
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               _loc6_ = getRendererAt(_loc5_);
               this.updateRenderPosition(_loc6_,_loc5_,_loc4_,_loc2_);
               _loc4_ = _loc6_.x;
               if(_loc3_)
               {
               }
               _loc5_++;
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

      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint {
         return dataProvider.length;
      }

      protected function setCursorListeners() : void {
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
      }

      protected function removeCursorListeners() : void {
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
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
            _loc5_.enabled = _loc4_ >= _loc2_?false:true;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            if(!this.showEmptyItems)
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
         this.renderersMask.x = this.dragHitArea.x = this.leftArrow.x + this.leftArrow.width;
         this.renderersMask.y = this.dragHitArea.y = 0;
         this.renderersMask.width = this.dragHitArea.width = this.countVisibleSlots * (this.slotImageWidth + this._padding.left + this._padding.right);
         this.renderersMask.height = this.dragHitArea.height = this.slotImageHeight + 2;
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
            if(this.currentFirstRenederer == 0)
            {
               this.enableLeftArrow(false);
               this.enableRightArrow(true);
               this.skippCall = false;
               this.allowDrag = true;
            }
            else
            {
               if(this.currentFirstRenederer >= _loc1_ - this.countVisibleSlots)
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

      protected function get currentFirstRenederer() : uint {
         return this._currentFirstRenederer;
      }

      protected function set currentFirstRenederer(param1:uint) : void {
         if(param1 == this._currentFirstRenederer)
         {
            return;
         }
         this._currentFirstRenederer = param1;
         this.updateArrowsState();
      }

      override protected function handleMouseWheel(param1:MouseEvent) : void {
         if(_renderers.length > this.countVisibleSlots)
         {
            this.startSlideByArrow(param1.delta > 0?"left":"right",false);
            this.stopSlideByArrow(param1.delta > 0?"left":"right");
         }
      }

      private function renderersMouseEnabled(param1:Boolean=false) : void {
         var _loc2_:int = _renderers.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            if(_renderers[_loc3_]  is  IPersonalCaseItemRenderer)
            {
               IPersonalCaseItemRenderer(_renderers[_loc3_]).canSelected = param1;
               _loc3_++;
               continue;
            }
            return;
         }
      }

      private function updateDrugPosition(param1:DisplayObject, param2:Object) : void {
         var _loc3_:* = NaN;
         if(this.isDragging)
         {
            _loc3_ = param2.scopeStartX + (param1.mouseX - param2.startMouseX);
            if(_loc3_ > param2.scopeDefPosition + MAX_DRAG_ODDSET)
            {
               _loc3_ = param2.scopeDefPosition + MAX_DRAG_ODDSET;
            }
            else
            {
               if(_loc3_ < param2.scopeDefPosition - param2.allowDragDistance - MAX_DRAG_ODDSET)
               {
                  _loc3_ = param2.scopeDefPosition - param2.allowDragDistance - MAX_DRAG_ODDSET;
               }
            }
            container.x = container.x + (_loc3_ - container.x) / DRAG_ACCELERATOR;
            container.x = container.x ^ 0;
            this.lastDx = container.x - this.lastContenerXPos;
            this.lastContenerXPos = container.x;
         }
      }

      private function slidingFn(param1:Object) : void {
         var _loc2_:Number = container.x + this.lastDx;
         this.lastDx = this.lastDx + -this.lastDx / this.slideSelfAcceleratorDynamic;
         this.currentFirstRenederer = this.getCurrentFirstRendererOnAnim();
         if(_loc2_ > param1.scopeDefPosition)
         {
            container.x = container.x + (param1.scopeDefPosition - container.x + this.lastDx) / SLIDE_TO_POS_ACCELERATOR;
            this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            if(container.x - param1.scopeDefPosition + this.lastDx < 1 && Math.abs(this.lastDx) < 1)
            {
               container.x = param1.scopeDefPosition;
               this.clearSlidingIntervalId();
               this.currentFirstRenederer = 0;
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
                  this.clearSlidingIntervalId();
               }
            }
            else
            {
               container.x = _loc2_;
               if(Math.abs(this.lastDx) < 1)
               {
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

      private function slideToRenderer(param1:Number) : void {
         this.currentFirstRenederer = param1;
         var _loc2_:Number = -param1 * this.getSlotWidth() + this.getDefContainerPos();
      }

      private function stopSlideByArrow(param1:String) : void {
         var _loc2_:Number = -this.currentFirstRenederer * this.getSlotWidth() - (container.x - this.getDefContainerPos());
         var _loc3_:Number = this._padding.left + this._padding.right + 10;
         var _loc4_:Number = this.currentFirstRenederer;
         if(param1 == "right" && _loc2_ > _loc3_)
         {
            _loc4_ = this.currentFirstRenederer + Math.round(_loc2_ / this.getSlotWidth()) + 1;
         }
         else
         {
            if(param1 == "left" && _loc2_ < -_loc3_)
            {
               _loc4_ = this.currentFirstRenederer - Math.floor(-_loc2_ / this.getSlotWidth())-1;
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
         this.currentFirstRenederer = _loc4_;
         this.courceFactor = 0;
      }

      private function startSlideByArrow(param1:String, param2:Boolean) : void {
         this.clearSlidingIntervalId();
         if(!this.skippCall)
         {
            this.skippCall = param2;
            this.currentFirstRenederer = param1 == "left"?Math.max(0,this.currentFirstRenederer-1):Math.min(_renderers.length - this.countVisibleSlots,this.currentFirstRenederer + 1);
            if(this.currentFirstRenederer == 0 || this.currentFirstRenederer == _renderers.length - this.countVisibleSlots)
            {
               this.courceFactor = 0;
            }
            else
            {
               this.courceFactor = param1 == "left"?1:-1;
            }
            if(this.arrowSlideIntervaId == 0 && (container))
            {
               this.slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
               this.arrowSlideIntervaId = setInterval(this.arrowSlide,30);
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
         this.lastDx = this.lastDx + (MAX_DX * this.courceFactor - this.lastDx) / SLIDE_SELF_ACCELERATOR;
         if(this.courceFactor == 0)
         {
            this.slideSelfAcceleratorDynamic = SLIDE_TO_POS_ACCELERATOR;
            this.lastDx = this.lastDx + -this.lastDx / this.slideSelfAcceleratorDynamic;
            _loc1_ = this.getDefContainerPos() - this.currentFirstRenederer * this.getSlotWidth();
            _loc2_ = (_loc1_ - container.x) / SLIDE_SELF_ACCELERATOR + this.lastDx;
            _loc2_ = _loc2_ >= 0?Math.min(MAX_DX,_loc2_):-Math.min(-_loc2_,MAX_DX);
            container.x = container.x + _loc2_;
            if(Math.abs(container.x + this.lastDx - _loc1_) < 1)
            {
               container.x = _loc1_;
               this.clearArrowSlide();
            }
         }
         else
         {
            this.countFactor++;
            container.x = container.x + this.lastDx;
            if(this.getCurrentFirstRendererOnAnim() == 0 && this.courceFactor == 1)
            {
               this.currentFirstRenederer = 0;
               this.courceFactor = 0;
            }
            else
            {
               if(this.getCurrentFirstRendererOnAnim() == _renderers.length - this.countVisibleSlots && this.courceFactor == -1)
               {
                  this.currentFirstRenederer = _renderers.length - this.countVisibleSlots;
                  this.courceFactor = 0;
               }
            }
         }
      }

      private function clearArrowSlide() : void {
         if(this.arrowSlideIntervaId)
         {
            clearInterval(this.arrowSlideIntervaId);
            this.arrowSlideIntervaId = 0;
         }
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

      private function clearSlidingIntervalId() : void {
         if(this.slidingIntervalId)
         {
            this.renderersMouseEnabled(true);
            clearInterval(this.slidingIntervalId);
            this.slidingIntervalId = 0;
            this.lastDx = 0;
         }
      }

      private function carouselMouseMoveHandler(param1:MouseEvent) : void {
         if(this.isDragging)
         {
            this.renderersMouseEnabled(false);
            App.cursor.setCursor(Cursors.MOVE);
         }
      }

      private function isMouseOnDragArea(param1:MouseEvent) : Boolean {
         var _loc2_:Boolean = this.mouseX > this.dragHitArea.x && this.mouseX < this.dragHitArea.x + this.dragHitArea.width;
         if(param1.target == this.leftArrow || param1.target == this.rightArrow || _loc2_ == false)
         {
            return false;
         }
         return true;
      }

      private function arrowRelease(param1:ButtonEvent) : void {
         this.stopSlideByArrow(param1.target == this.leftArrow?"left":"right");
      }

      private function arrowClick(param1:ButtonEvent) : void {
         this.startSlideByArrow(param1.target == this.leftArrow?"left":"right",false);
      }

      private function arrowPress(param1:ButtonEvent) : void {
         this.startSlideByArrow(param1.target == this.leftArrow?"left":"right",true);
      }

      private function arrowUp(param1:MouseEvent) : void {
         param1.target.dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE));
      }

      private function startDragging(param1:MouseEvent) : void {
         var _loc3_:Stage = null;
         var _loc4_:Object = null;
         var _loc2_:Boolean = this.mouseX > this.dragHitArea.x && this.mouseX < this.dragHitArea.x + this.dragHitArea.width;
         if(param1.target == this.leftArrow || param1.target == this.rightArrow || _loc2_ == false)
         {
            return;
         }
         if((DRAG_ENABLE) && (this.allowDrag))
         {
            this.mouseIn = true;
            if(App.cursor)
            {
               App.cursor.setCursor(Cursors.MOVE);
            }
            _loc3_ = App.stage;
            _loc3_.addEventListener(MouseEvent.MOUSE_UP,this.stopDragging);
            _loc3_.addEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.carouselMouseMoveHandler);
            this.clearSlidingIntervalId();
            if(!this.isDragging)
            {
               _loc4_ =
                  {
                     "scopeStartX":container.x,
                     "startMouseX":mouseX,
                     "allowDragDistance":this.getScopeWidth() - this.renderersMask.width,
                     "scopeDefPosition":this.getDefContainerPos()
                  }
               ;
               this.isDragging = true;
               this.lastContenerXPos = container.x;
               this.clearArrowSlide();
               this.draggingIntervalId = setInterval(this.updateDrugPosition,30,this,_loc4_);
            }
         }
      }

      private function onChangeCursorHandler(param1:MouseCursorEvent) : void {
         this.lastCursor = param1.cursor;
         param1.stopImmediatePropagation();
      }

      protected function mouseOverHandler(param1:MouseEvent) : void {
         if(!this.isDragging)
         {
            if((this.isMouseOnDragArea(param1)) && (App.cursor))
            {
               App.cursor.setCursor(Cursors.DRAG_OPEN);
            }
            else
            {
               if(App.cursor)
               {
                  App.cursor.setCursor(Cursors.BUTTON);
               }
            }
         }
         else
         {
            App.cursor.setCursor(Cursors.MOVE);
            App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.carouselMouseMoveHandler);
         }
      }

      protected function stopDragging(param1:MouseEvent=null) : void {
         var _loc4_:Object = null;
         var _loc2_:Stage = App.stage;
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.stopDragging);
         _loc2_.removeEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.carouselMouseMoveHandler);
         clearInterval(this.draggingIntervalId);
         this.slideSelfAcceleratorDynamic = SLIDE_SELF_ACCELERATOR;
         if(this.slidingIntervalId == 0)
         {
            _loc4_ =
               {
                  "scopeDefPosition":this.getDefContainerPos(),
                  "allowDragDistance":this.getScopeWidth() - this.renderersMask.width
               }
            ;
            this.slidingIntervalId = setInterval(this.slidingFn,30,_loc4_);
         }
         this.isDragging = false;
         var _loc3_:ICursor = App.cursor;
         if(!this.mouseIn)
         {
            _loc3_.setCursor(this.lastCursor);
         }
         else
         {
            if(_loc3_)
            {
               if(this.isMouseOnDragArea(param1))
               {
                  _loc3_.setCursor(Cursors.DRAG_OPEN);
               }
               else
               {
                  _loc3_.setCursor(Cursors.BUTTON);
               }
            }
         }
      }

      protected function mouseOutHandler(param1:MouseEvent) : void {
         this.mouseIn = false;
         if(!this.isDragging && (App.cursor))
         {
            App.cursor.setCursor(Cursors.ARROW);
         }
      }
   }

}