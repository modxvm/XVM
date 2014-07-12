package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.controls.ScrollingList;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.ISaleItemBlockRenderer;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.utils.Padding;
   import flash.display.DisplayObject;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.data.ListData;
   import flash.events.Event;
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import scaleform.clik.interfaces.IScrollBar;
   import flash.utils.getDefinitionByName;
   import net.wg.gui.components.controls.DropdownMenu;
   
   public class SlidingScrollingList extends ScrollingList
   {
      
      public function SlidingScrollingList() {
         super();
      }
      
      public var lowerContainer:MovieClip;
      
      public var upperContainer:MovieClip;
      
      private var _defaultListHeight:Number;
      
      private var listVisibleHight:Number = 0;
      
      private var scrollingListHeigth:Number = 0;
      
      private var autoScrollBar:Boolean = true;
      
      private var wasResized:Boolean = false;
      
      private var eventLengs:Number = 0;
      
      private var scrRect:Rectangle;
      
      private var downMargin:Number = 9;
      
      private var sbPadding:Number = 5;
      
      private var stepSize:Number = 5;
      
      private var totalHeight:Number = 0;
      
      public function getRenderers() : Vector.<ISaleItemBlockRenderer> {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Vector.<ISaleItemBlockRenderer> = null;
         var _loc4_:ISaleItemBlockRenderer = null;
         var _loc1_:Vector.<ISaleItemBlockRenderer> = new Vector.<ISaleItemBlockRenderer>();
         for each(_loc2_ in _renderers)
         {
            _loc3_ = SellDialogListItemRenderer(_loc2_).getRenderers();
            for each(_loc4_ in _loc3_)
            {
               _loc1_.push(_loc4_);
            }
         }
         return _loc1_;
      }
      
      override public function get availableWidth() : Number {
         return Math.round(_width) - margin * 2 - (_autoScrollBar?Math.round(_scrollBar.width + this.sbPadding):0);
      }
      
      override public function get scrollPosition() : Number {
         return _scrollPosition;
      }
      
      override public function set scrollPosition(param1:Number) : void {
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Vector.<ISaleItemBlockRenderer> = null;
         var _loc5_:ISaleItemBlockRenderer = null;
         var _loc2_:Number = Math.round((this.totalHeight - this._height) / 100 * param1);
         container.y = -_loc2_;
         for each(_loc3_ in _renderers)
         {
            _loc4_ = SellDialogListItemRenderer(_loc3_).getRenderers();
            for each(_loc5_ in _loc4_)
            {
               SaleItemBlockRenderer(_loc5_).ddm.close();
            }
         }
      }
      
      override protected function configUI() : void {
         if(container == null)
         {
            container = new Sprite();
            addChild(container);
         }
         tabEnabled = (_focusable) && (enabled);
         tabChildren = false;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,true,0,true);
         addEventListener(InputEvent.INPUT,handleInput,false,0,true);
         if(padding == null)
         {
            padding = new Padding();
         }
         if(_itemRenderer == null && !_usingExternalRenderers)
         {
            itemRendererName = _itemRendererName;
         }
         this.useHandCursor = false;
         this._defaultListHeight = Math.round(_height);
         this.scrRect = new Rectangle(0,0,_width,this._defaultListHeight + this.downMargin);
         this.scrollRect = this.scrRect;
         this.upperContainer.mouseEnabled = false;
         this.listVisibleHight = _height + this.downMargin;
      }
      
      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
         }
         if(isInvalid(InvalidationType.RENDERERS))
         {
            _autoRowHeight = NaN;
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            updateSelectedIndex();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
         }
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.RENDERERS)))
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
            invalidateData();
         }
         if(!_usingExternalRenderers && ((isInvalid(InvalidationType.SIZE)) || (isInvalid(InvalidationType.DATA))))
         {
            this.lowerContainer.removeChild(container);
            setActualSize(_width,_height);
            container.scaleX = 1 / scaleX;
            container.scaleY = 1 / scaleY;
            _totalRenderers = dataProvider.length;
            this.lowerContainer.addChild(container);
            invalidateData();
         }
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.RENDERERS,InvalidationType.SIZE)))
         {
            drawRenderers(_totalRenderers);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            refreshData();
            this.updateScrollBar();
         }
      }
      
      override protected function updateScrollBar() : void {
         var _loc2_:ScrollIndicator = null;
         this.stepSize = Math.round(20 * this.height / this.totalHeight);
         var _loc1_:Number = Math.round(this.height / this.totalHeight * 100);
         if(_scrollBar == null)
         {
            return;
         }
         if(_scrollBar is ScrollIndicator)
         {
            _loc2_ = _scrollBar as ScrollIndicator;
            _loc2_.setScrollProperties(_loc1_,0,100,this.stepSize);
         }
         _scrollBar.position = _scrollPosition;
         _scrollBar.validateNow();
      }
      
      override protected function populateData(param1:Array) : void {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:uint = 0;
         var _loc7_:ListData = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _scrollPosition + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ >= _loc2_?false:true;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
         this.drawLayout();
      }
      
      override protected function drawLayout() : void {
         var _loc6_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = 8;
         var _loc3_:Number = this.availableWidth - padding.horizontal;
         this.totalHeight = 0;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc6_ = getRendererAt(_loc7_);
            _loc6_.x = _loc4_;
            if(_loc7_ == 0)
            {
               _loc6_.y = 0;
            }
            else
            {
               _loc6_.y = getRendererAt(_loc7_ - 1).y + getRendererAt(_loc7_ - 1).height + _loc2_;
            }
            this.totalHeight = _loc6_.y + _loc6_.height;
            if(!_loc5_)
            {
               _loc6_.validateNow();
            }
            _loc7_++;
         }
         if(this.totalHeight < this.height)
         {
            if(_scrollBar)
            {
               _scrollBar.removeEventListener(Event.SCROLL,handleScroll,false);
               _scrollBar.removeEventListener(Event.CHANGE,handleScroll,false);
               _scrollBar.focusTarget = null;
               if(this.upperContainer.contains(_scrollBar as DisplayObject))
               {
                  this.upperContainer.removeChild(_scrollBar as DisplayObject);
               }
               _scrollBar = null;
               _autoScrollBar = false;
            }
            this.listVisibleHight = this.totalHeight + this.downMargin;
            this.scrRect = new Rectangle(0,0,_width,this.listVisibleHight);
            this.scrollRect = this.scrRect;
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel);
         }
         else
         {
            if(this.totalHeight > 0)
            {
               this.totalHeight = this.totalHeight + this.downMargin;
            }
            this.drawScrollBar();
         }
         if(this.totalHeight == 0)
         {
            this.listVisibleHight = 0;
         }
         var _loc8_:uint = 0;
         while(_loc8_ < _loc1_)
         {
            _loc6_ = getRendererAt(_loc8_);
            (_loc6_ as UIComponent).setSize(this.availableWidth,_loc6_.height);
            _loc8_++;
         }
         this.upperContainer.height = this.listVisibleHight;
         dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.listVisibleHight));
      }
      
      override protected function createScrollBar() : void {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         if(_scrollBar)
         {
            _scrollBar.removeEventListener(Event.SCROLL,handleScroll,false);
            _scrollBar.removeEventListener(Event.CHANGE,handleScroll,false);
            _scrollBar.focusTarget = null;
            if(this.upperContainer.contains(_scrollBar as DisplayObject))
            {
               this.upperContainer.removeChild(_scrollBar as DisplayObject);
            }
            _scrollBar = null;
         }
         if(!_scrollBarValue || _scrollBarValue == "")
         {
            return;
         }
         _autoScrollBar = false;
         if(_scrollBarValue is String)
         {
            if(parent != null)
            {
               _loc1_ = parent.getChildByName(_scrollBarValue.toString()) as IScrollBar;
            }
            if(_loc1_ == null)
            {
               _loc2_ = getDefinitionByName(_scrollBarValue.toString()) as Class;
               if(_loc2_)
               {
                  _loc1_ = new _loc2_() as IScrollBar;
               }
               if(_loc1_)
               {
                  _autoScrollBar = true;
                  _loc3_ = _loc1_ as Object;
                  if((_loc3_) && (thumbOffset))
                  {
                     _loc3_.offsetTop = thumbOffset.top;
                     _loc3_.offsetBottom = thumbOffset.bottom;
                  }
                  _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,blockMouseWheel,false,0,true);
                  this.upperContainer.addChild(_loc1_ as DisplayObject);
               }
            }
         }
         else if(_scrollBarValue is Class)
         {
            _loc1_ = new (_scrollBarValue as Class)() as IScrollBar;
            _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,blockMouseWheel,false,0,true);
            if(_loc1_ != null)
            {
               _autoScrollBar = true;
               (_loc1_ as Object).offsetTop = thumbOffset.top;
               (_loc1_ as Object).offsetBottom = thumbOffset.bottom;
               this.upperContainer.addChild(_loc1_ as DisplayObject);
            }
         }
         else
         {
            _loc1_ = _scrollBarValue as IScrollBar;
         }
         
         _scrollBar = _loc1_;
         invalidateSize();
         if(_scrollBar == null)
         {
            return;
         }
         _scrollBar.addEventListener(Event.SCROLL,handleScroll,false,0,true);
         _scrollBar.addEventListener(Event.CHANGE,handleScroll,false,0,true);
         _scrollBar.focusTarget = this;
         _scrollBar.tabEnabled = false;
      }
      
      override protected function drawScrollBar() : void {
         if(!_autoScrollBar)
         {
            return;
         }
         _scrollBar.x = _width - _scrollBar.width - this.sbPadding;
         _scrollBar.y = this.sbPadding;
         _scrollBar.height = availableHeight - this.sbPadding * 2;
         _scrollBar.validateNow();
      }
      
      override protected function scrollList(param1:int) : void {
         _scrollBar.position = _scrollBar.position - param1 * this.stepSize;
         _scrollBar.validateNow();
      }
      
      override protected function handleMouseWheel(param1:MouseEvent) : void {
         if(!(param1.target is DropdownMenu))
         {
            this.scrollList(param1.delta > 0?1:-1);
            param1.stopImmediatePropagation();
         }
      }
   }
}
