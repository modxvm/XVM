package net.wg.gui.components.controls
{
   import scaleform.clik.controls.TileList;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.data.ListData;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ICommons;
   import net.wg.utils.IEventCollector;


   public class TileList extends scaleform.clik.controls.TileList
   {
          
      public function TileList() {
         super();
         componentInspectorSetting = true;
      }

      public var showEmptyItems:Boolean;

      public var paddingBottom:Number;

      public var paddingRight:Number;

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
            _loc6_ = _scrollPosition * (_direction == DirectionMode.HORIZONTAL?_totalRows:_totalColumns) + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            if(_loc4_ >= _loc2_)
            {
               _loc5_.enabled = false;
            }
            else
            {
               if(param1[_loc4_].hasOwnProperty("enabled"))
               {
                  _loc5_.enabled = param1[_loc4_].enabled;
               }
               else
               {
                  _loc5_.enabled = true;
               }
            }
            _loc5_.validateNow();
            if(!this.showEmptyItems)
            {
               UIComponent(_loc5_).visible = !(param1[_loc4_] == null);
            }
            _loc4_++;
         }
      }

      override protected function drawLayout() : void {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = columnWidth;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            if(direction == DirectionMode.HORIZONTAL)
            {
               _loc8_.y = _loc7_ % _totalRows * (_loc2_ + this.paddingBottom + padding.bottom) + margin + padding.top;
               _loc8_.x = (_loc7_ / _totalRows >> 0) * (_loc3_ + this.paddingRight + padding.right) + margin + padding.left;
            }
            else
            {
               _loc8_.x = _loc7_ % _totalColumns * (_loc3_ + this.paddingRight + padding.right) + margin + padding.left;
               _loc8_.y = (_loc7_ / _totalColumns >> 0) * (_loc2_ + this.paddingBottom + padding.bottom) + margin + padding.top;
            }
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }

      override protected function cleanUpRenderer(param1:IListItemRenderer) : void {
         super.cleanUpRenderer(param1);
      }

      override public function dispose() : void {
         removeEventListener(MouseEvent.MOUSE_WHEEL,handleMouseWheel,false);
         removeEventListener(InputEvent.INPUT,handleInput,false);
         this.disposeRenderers();
         if(_scrollBar)
         {
            _scrollBar.removeEventListener(MouseEvent.MOUSE_WHEEL,blockMouseWheel,false);
            _scrollBar.removeEventListener(Event.SCROLL,handleScroll,false);
            _scrollBar.removeEventListener(Event.CHANGE,handleScroll,false);
            _scrollBar.focusTarget = null;
            _scrollBar.dispose();
            if(container.contains(DisplayObject(_scrollBar)))
            {
               container.removeChild(DisplayObject(_scrollBar));
            }
            _scrollBar = null;
         }
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
            _dataProvider.cleanUp();
            _dataProvider = null;
         }
         if((container) && (contains(container)))
         {
            removeChild(container);
            container = null;
         }
         thumbOffset = null;
         _padding = null;
         super.dispose();
      }

      public function disposeRenderers() : void {
         var _loc3_:* = NaN;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:IDisposable = null;
         var _loc6_:DisplayObject = null;
         var _loc1_:ICommons = App.utils.commons;
         var _loc2_:Number = _renderers.length;
         _loc3_ = _loc2_-1;
         while(_loc3_ >= 0)
         {
            _loc4_ = getRendererAt(_loc3_);
            if(_loc4_ != null)
            {
               this.cleanUpRenderer(_loc4_);
               _loc5_ = _loc4_ as IDisposable;
               if(_loc5_)
               {
                  _loc5_.dispose();
               }
               _loc6_ = _loc4_ as DisplayObject;
               _loc1_.releaseReferences(_loc6_);
               if(container.contains(_loc6_))
               {
                  container.removeChild(_loc6_);
               }
            }
            _renderers.splice(_loc3_,1);
            _loc3_--;
         }
      }

      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:IEventCollector = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            createScrollBar();
         }
         if(isInvalid(InvalidationType.RENDERERS))
         {
            _autoRowHeight = NaN;
            _autoColumnWidth = NaN;
            if(_usingExternalRenderers)
            {
               _totalColumns = externalColumnCount == 0?1:externalColumnCount;
               _totalRows = Math.ceil(_renderers.length / _totalColumns);
            }
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
                  this.cleanUpRenderer(_loc3_);
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
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.SIZE)))
         {
            _loc5_ = App.utils.events;
            _loc5_.disableDisposingForObj(container);
            removeChild(container);
            setActualSize(_width,_height);
            container.scaleX = 1 / scaleX;
            container.scaleY = 1 / scaleY;
            _totalRenderers = calculateRendererTotal(availableWidth,availableHeight);
            addChild(container);
            _loc5_.enableDisposingForObj(container);
            invalidateData();
         }
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.RENDERERS,InvalidationType.SIZE)))
         {
            drawRenderers(_totalRenderers);
            this.drawLayout();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            refreshData();
            updateScrollBar();
         }
      }
   }

}