package net.wg.gui.components.advanced
{
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.interfaces.IDataProvider;


   public class SortableHeaderButtonBar extends ButtonBar
   {
          
      public function SortableHeaderButtonBar() {
         super();
      }

      override public function get dataProvider() : IDataProvider {
         return super.dataProvider;
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         super.dataProvider = param1;
      }

      override protected function updateRenderers() : void {
         super.updateRenderers();
      }

      public function getRenderers() : Array {
         return _renderers;
      }
   }

}