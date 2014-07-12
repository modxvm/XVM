package net.wg.gui.components.controls
{
   import scaleform.clik.controls.ScrollingList;
   import flash.display.MovieClip;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.data.ListData;
   import scaleform.clik.core.UIComponent;
   
   public class WgScrollingList extends ScrollingList
   {
      
      public function WgScrollingList() {
         super();
      }
      
      public var showEmptyItems:Boolean;
      
      public var bg:MovieClip;
      
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
            if(!this.showEmptyItems)
            {
               UIComponent(_loc5_).visible = !(param1[_loc4_] == null);
            }
            _loc5_.validateNow();
            _loc4_++;
         }
      }
   }
}
