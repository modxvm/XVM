package net.wg.gui.lobby.profile.components
{
   import net.wg.gui.components.controls.TileList;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.events.Event;


   public class ResizableTileList extends TileList
   {
          
      public function ResizableTileList() {
         super();
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         if(_dataProvider == param1)
         {
            return;
         }
         super.dataProvider = param1;
         invalidate();
      }

      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint {
         var _loc5_:IListItemRenderer = null;
         var _loc3_:Boolean = (isNaN(_rowHeight)) && (isNaN(_autoRowHeight));
         var _loc4_:Boolean = (isNaN(_columnWidth)) && (isNaN(_autoColumnWidth));
         if((_loc3_) || (_loc4_))
         {
            _loc5_ = createRenderer(0);
            if(_loc3_)
            {
               _autoRowHeight = _loc5_.height;
            }
            if(_loc4_)
            {
               _autoColumnWidth = _loc5_.width;
            }
            cleanUpRenderer(_loc5_);
         }
         _totalColumns = availableWidth / columnWidth >> 0;
         _totalRenderers = _dataProvider?_dataProvider.length:0;
         _totalRows = Math.ceil(_totalRenderers / _totalColumns);
         return _totalRenderers;
      }

      override protected function drawLayout() : void {
         var _loc1_:IListItemRenderer = null;
         super.drawLayout();
         if((_renderers) && _renderers.length > 0)
         {
            _loc1_ = getRendererAt(_renderers.length-1);
            _height = _loc1_.height + _loc1_.y + margin + paddingBottom;
         }
         dispatchEvent(new Event(Event.RESIZE,true));
      }
   }

}