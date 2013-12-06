package net.wg.data.VO
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.data.VO.generated.ShopNationFilterData;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([AnimationObject,BattleResultsQuestVO,ColorScheme,PointVO,PremiumFormModel,ProgressElementVO,SellDialogElement,SellDialogItem,ShopNationFilterData,ShopSubFilterData,ShopVehicleFilterElementData,StoreTableData,StoreTableVO,TrainingFormRendererVO,TrainingRoomInfoVO,TrainingRoomListVO,TrainingWindowVO,TrainingRoomRendererVO,WalletStatusVO]));
      }
   }

}