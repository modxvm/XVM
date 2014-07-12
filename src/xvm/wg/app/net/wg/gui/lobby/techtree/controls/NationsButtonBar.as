package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.Sprite;
   import scaleform.clik.controls.Button;
   
   public class NationsButtonBar extends ButtonBarEx
   {
      
      public function NationsButtonBar() {
         super();
      }
      
      public static const TOP_ALIGN:String = "top";
      
      public static const CENTER_ALIGN:String = "center";
      
      public static const BOTTOM_ALIGN:String = "bottom";
      
      private var _tabVAlign:String;
      
      public var barBG:Sprite;
      
      public function get tabVAlign() : String {
         return this._tabVAlign;
      }
      
      public function set tabVAlign(param1:String) : void {
         this._tabVAlign = param1;
         invalidate();
      }
      
      override protected function configUI() : void {
         if(this.barBG != null)
         {
            this.barBG.mouseEnabled = false;
         }
         super.configUI();
      }
      
      override protected function draw() : void {
         super.draw();
      }
      
      override protected function updateRenderers() : void {
         var _loc1_:Button = null;
         super.updateRenderers();
         switch(this.tabVAlign)
         {
            case CENTER_ALIGN:
               if(_renderers.length > 0 && _dataProvider.length >= _renderers.length)
               {
                  _loc1_ = _renderers[_renderers.length - 1];
                  this.repositionRenderers((actualHeight >> 1) - (_loc1_.y + _loc1_.height >> 1));
               }
               break;
            case BOTTOM_ALIGN:
               if(_renderers.length > 0 && _dataProvider.length >= _renderers.length)
               {
                  _loc1_ = _renderers[_renderers.length - 1];
                  this.repositionRenderers(actualHeight - (_loc1_.y + _loc1_.height));
               }
               break;
         }
      }
      
      override public function toString() : String {
         return "[WG NationsButtonBar " + name + "]";
      }
      
      private function repositionRenderers(param1:Number) : void {
         var _loc2_:Button = null;
         var _loc3_:Number = 0;
         while(_loc3_ < _renderers.length)
         {
            _loc2_ = _renderers[_loc3_];
            _loc2_.y = param1;
            param1 = param1 + (_loc2_.height + _spacing);
            _loc3_++;
         }
      }
   }
}
