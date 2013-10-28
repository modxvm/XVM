package net.wg.gui.components.controls
{
   import scaleform.clik.controls.ScrollingList;
   import flash.display.MovieClip;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.data.ListData;
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObject;


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

      override public function dispose() : void {
         this.disposeRenderers();
         if(_dataProvider)
         {
            _dataProvider.cleanUp();
            _dataProvider = null;
         }
         if(_scrollBar)
         {
            _scrollBar.dispose();
         }
         thumbOffset = null;
         _padding = null;
         super.dispose();
      }

      public function disposeRenderers() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:IDisposable = null;
         var _loc5_:DisplayObject = null;
         if(_renderers != null)
         {
            _loc1_ = _renderers.length;
            _loc2_ = _loc1_-1;
            while(_loc2_ >= 0)
            {
               _loc3_ = getRendererAt(_loc2_);
               if(_loc3_ != null)
               {
                  cleanUpRenderer(_loc3_);
                  _loc4_ = _loc3_ as IDisposable;
                  if(_loc4_)
                  {
                     _loc4_.dispose();
                  }
                  _loc5_ = _loc3_ as DisplayObject;
                  if(container.contains(_loc5_))
                  {
                     container.removeChild(_loc5_);
                  }
               }
               _renderers.splice(_loc2_,1);
               _loc2_--;
            }
         }
      }
   }

}