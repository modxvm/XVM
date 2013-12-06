package net.wg.gui.components.controls
{
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.DisplayObject;
   import scaleform.clik.data.ListData;


   public class ScrollingListAutoScroll extends ScrollingList
   {
          
      public function ScrollingListAutoScroll() {
         super();
      }

      override protected function drawLayout() : void {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = this.availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_ + _loc7_ * _loc2_;
            _loc8_.width = _loc3_;
            _loc8_.height = _loc2_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         this.drawScrollBar();
      }

      override protected function drawScrollBar() : void {
         super.drawScrollBar();
         if(_scrollBar)
         {
            (_scrollBar as DisplayObject).visible = (dataProvider) && dataProvider.length > rowCount;
            if(container.contains(_scrollBar as DisplayObject))
            {
               container.addChild(_scrollBar as DisplayObject);
            }
         }
      }

      override public function get availableWidth() : Number {
         return Math.round(_width) - margin * 2;
      }

      override public function set enabled(param1:Boolean) : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:IListItemRenderer = null;
         super.enabled = param1;
         setState(super.enabled?"default":"disabled");
         if(_renderers != null)
         {
            _loc2_ = _renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = getRendererAt(_loc3_);
               _loc4_.enabled = (enabled) && (_loc4_.getData()) && (_loc4_.getData().enabled);
               _loc3_++;
            }
         }
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
            _loc5_.enabled = _loc4_ >= _loc2_?false:enabled;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
      }
   }

}