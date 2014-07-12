package net.wg.gui.components.controls
{
   import scaleform.clik.interfaces.IScrollBar;
   import flash.display.Sprite;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import flash.events.MouseEvent;
   
   public class ScrollingListPx extends CoreListEx
   {
      
      public function ScrollingListPx() {
         super();
      }
      
      public static const SCROLL_UPDATE_INV:String = "scrollUpdInv";
      
      public static const SCROLL_POSITION_INV:String = "scrollPosInv";
      
      public var _scrollBar:IScrollBar;
      
      protected var _scrollBarValue:Object;
      
      protected var totalHeight:uint;
      
      public var padding:int = 0;
      
      private var _scrollStepFactor:Number = 1.0;
      
      public var wrapping:String = "normal";
      
      public var thumbOffset:Object;
      
      protected var _autoScrollBar:Boolean = false;
      
      protected var _scrollPosition:uint = 0;
      
      public var maskObject:Sprite;
      
      override protected function configUI() : void {
         super.configUI();
         if(!this.maskObject)
         {
            this.maskObject = new Sprite();
            addChild(this.maskObject);
         }
         mask = this.maskObject;
      }
      
      override public function handleInput(param1:InputEvent) : void {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:Boolean = _loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.UP:
               this.scrollPosition = this.scrollPosition - 1;
               break;
            case NavigationCode.DOWN:
               this.scrollPosition = this.scrollPosition + 1;
               break;
            case NavigationCode.END:
               if(!_loc3_)
               {
                  this.scrollPosition = this.maxScroll;
               }
               break;
            case NavigationCode.HOME:
               if(!_loc3_)
               {
                  this.scrollPosition = 0;
               }
               break;
            case NavigationCode.PAGE_UP:
               if(_loc3_)
               {
                  this.scrollPosition = this.scrollPosition - this.scrollPageSize;
               }
               break;
            case NavigationCode.PAGE_DOWN:
               if(_loc3_)
               {
                  this.scrollPosition = this.scrollPosition + this.scrollPageSize;
               }
               break;
            default:
               return;
         }
         param1.handled = true;
      }
      
      override protected function scrollList(param1:int) : void {
         this.scrollPosition = this.scrollPosition - param1;
      }
      
      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:Graphics = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
            invalidate(SCROLL_POSITION_INV);
         }
         if(isInvalid(InvalidationType.SIZE,SCROLL_POSITION_INV))
         {
            this.drawScrollBar();
            _loc5_ = this.maskObject.graphics;
            _loc5_.beginFill(0,1);
            _loc5_.drawRect(0,0,_width,_height);
            _loc5_.endFill();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
         }
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.RENDERERS,InvalidationType.DATA)))
         {
            if(_renderers != null)
            {
               _loc2_ = _renderers.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = getRendererAt(_loc1_);
                  cleanUpRenderer(_loc3_);
                  _loc4_ = _loc3_ as DisplayObject;
                  if(container.contains(_loc4_))
                  {
                     container.removeChild(_loc4_);
                  }
                  _loc1_++;
               }
            }
            _renderers = new Vector.<IListItemRenderer>();
            if(_dataProvider)
            {
               this.drawRenderers(_dataProvider.length);
            }
         }
         if(isInvalid(SCROLL_UPDATE_INV))
         {
            this.applyScrollBarUpdating();
         }
      }
      
      protected function applyScrollBarUpdating() : void {
         container.y = -(this._scrollStepFactor * this._scrollPosition);
         this.scrollBar.setScrollProperties(this.scrollPageSize,0,this.maxScroll);
         this.scrollBar.position = this.scrollPosition;
         this.scrollBar.trackScrollPageSize = this.scrollPageSize;
      }
      
      protected function drawScrollBar() : void {
         if(!this._autoScrollBar)
         {
            return;
         }
         this._scrollBar.x = _width - this._scrollBar.width;
         this._scrollBar.height = availableHeight;
         this._scrollBar.validateNow();
      }
      
      override protected function drawRenderers(param1:Number) : void {
         this.totalHeight = 0;
         var _loc2_:* = 0;
         while(_loc2_ < param1)
         {
            this.createRendererByDataIndex(_loc2_);
            _loc2_++;
         }
         this.scrollPosition = 0;
      }
      
      protected function createRendererByDataIndex(param1:int) : void {
         var _loc2_:IListItemRenderer = this.createRenderer(param1);
         if(_loc2_ == null)
         {
            return;
         }
         container.addChild(_loc2_ as DisplayObject);
         _renderers.push(_loc2_);
         var _loc3_:Object = _dataProvider[param1];
         _loc2_.setListData(new ListData(param1,itemToLabel(_loc3_),false));
         _loc2_.setData(_loc3_);
         _loc2_.owner = this;
         _loc2_.validateNow();
         _loc2_.y = this.totalHeight;
         this.totalHeight = this.totalHeight + (Math.round(_loc2_.height) + this.padding);
      }
      
      public function get maxScroll() : Number {
         if(this.maskObject)
         {
            return Math.round((this.totalHeight - this.maskObject.height) / this._scrollStepFactor);
         }
         return 0;
      }
      
      public function get scrollPageSize() : Number {
         return Math.round(this.maskObject.height / this._scrollStepFactor);
      }
      
      protected function createScrollBar() : void {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         if(this._scrollBar)
         {
            this._scrollBar.removeEventListener(Event.SCROLL,this.handleScroll,false);
            this._scrollBar.removeEventListener(Event.CHANGE,this.handleScroll,false);
            this._scrollBar.focusTarget = null;
            if(this.contains(this._scrollBar as DisplayObject))
            {
               this.removeChild(this._scrollBar as DisplayObject);
            }
            this._scrollBar = null;
         }
         if(!this._scrollBarValue || this._scrollBarValue == "")
         {
            return;
         }
         this._autoScrollBar = false;
         if(this._scrollBarValue is String)
         {
            if(parent != null)
            {
               _loc1_ = parent.getChildByName(this._scrollBarValue.toString()) as IScrollBar;
            }
            if(_loc1_ == null)
            {
               _loc2_ = getDefinitionByName(this._scrollBarValue.toString()) as Class;
               if(_loc2_)
               {
                  _loc1_ = new _loc2_() as IScrollBar;
               }
               if(_loc1_)
               {
                  this._autoScrollBar = true;
                  _loc3_ = _loc1_ as Object;
                  if((_loc3_) && (this.thumbOffset))
                  {
                     _loc3_.offsetTop = this.thumbOffset.top;
                     _loc3_.offsetBottom = this.thumbOffset.bottom;
                  }
                  _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.blockMouseWheel,false,0,true);
                  this.addChild(_loc1_ as DisplayObject);
               }
            }
         }
         else if(this._scrollBarValue is Class)
         {
            _loc1_ = new (this._scrollBarValue as Class)() as IScrollBar;
            _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.blockMouseWheel,false,0,true);
            if(_loc1_ != null)
            {
               this._autoScrollBar = true;
               (_loc1_ as Object).offsetTop = this.thumbOffset.top;
               (_loc1_ as Object).offsetBottom = this.thumbOffset.bottom;
               this.addChild(_loc1_ as DisplayObject);
            }
         }
         else
         {
            _loc1_ = this._scrollBarValue as IScrollBar;
         }
         
         this._scrollBar = _loc1_;
         invalidateSize();
         if(this._scrollBar == null)
         {
            return;
         }
         this._scrollBar.addEventListener(Event.SCROLL,this.handleScroll,false,0,true);
         this._scrollBar.addEventListener(Event.CHANGE,this.handleScroll,false,0,true);
         this._scrollBar.focusTarget = this;
         this._scrollBar.tabEnabled = false;
      }
      
      protected function handleScroll(param1:Event) : void {
         this.scrollPosition = this._scrollBar.position;
      }
      
      protected function blockMouseWheel(param1:MouseEvent) : void {
         param1.stopPropagation();
      }
      
      public function get scrollPosition() : Number {
         return this._scrollPosition;
      }
      
      public function set scrollPosition(param1:Number) : void {
         var param1:Number = Math.max(0,Math.min(this.maxScroll,Math.round(param1)));
         if(this._scrollPosition == param1)
         {
            return;
         }
         this._scrollPosition = param1;
         invalidate(SCROLL_UPDATE_INV);
      }
      
      public function get scrollBar() : Object {
         return this._scrollBar;
      }
      
      public function set scrollBar(param1:Object) : void {
         this._scrollBarValue = param1;
         invalidate(InvalidationType.SCROLL_BAR);
      }
      
      protected function populateData(param1:Array) : void {
      }
      
      override protected function drawLayout() : void {
      }
      
      override protected function createRenderer(param1:uint) : IListItemRenderer {
         var _loc3_:IListItemRenderer = null;
         var _loc2_:* = "List Couldn\'t create item renderer, because ";
         if(_itemRenderer)
         {
            _loc3_ = new _itemRenderer() as IListItemRenderer;
            if(_loc3_ == null)
            {
               _loc2_ = _loc2_ + "_itemRenderer have to be implementer of IListItemRenderer";
            }
            else
            {
               return _loc3_;
            }
         }
         else
         {
            _loc2_ = _loc2_ + "item renderer class have to be not null!";
         }
         return null;
      }
      
      public function get scrollStepFactor() : Number {
         return this._scrollStepFactor;
      }
      
      public function set scrollStepFactor(param1:Number) : void {
         this._scrollStepFactor = param1;
         invalidate(SCROLL_UPDATE_INV);
      }
   }
}
