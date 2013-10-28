package net.wg.gui.lobby.sellDialog
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([MovingResult,SellDialogListItemRenderer,SaleItemBlockRenderer,SettingsButton,SlidingScrollingList,TotalResult,VehicleSellDialog,SellDevicesComponent,SellHeaderComponent,SellSlidingComponent,ControlQuestionComponent]));
      }
   }

}