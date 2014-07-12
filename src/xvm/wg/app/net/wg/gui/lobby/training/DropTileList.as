package net.wg.gui.lobby.training
{
   import net.wg.gui.components.controls.TileList;
   import net.wg.infrastructure.interfaces.IDropList;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class DropTileList extends TileList implements IDropList
   {
      
      public function DropTileList() {
         super();
         this.focusIndicator.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false,0,true);
      }
      
      private var _selectable:Boolean = false;
      
      public var focusIndicator:MovieClip;
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.focusIndicator.gotoAndStop("dragOver");
      }
      
      override protected function onDispose() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false);
         this.focusIndicator = null;
         super.onDispose();
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.focusIndicator.gotoAndStop("dragOut");
      }
      
      public function highlightList() : void {
         this.focusIndicator.visible = true;
      }
      
      public function hideHighLight() : void {
         this.focusIndicator.visible = false;
      }
      
      public function get selectable() : Boolean {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:IListItemRenderer = null;
         this._selectable = param1;
         if(_renderers != null)
         {
            _loc2_ = _renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = getRendererAt(_loc3_);
               _loc4_.selectable = this._selectable;
               _loc3_++;
            }
         }
      }
   }
}
