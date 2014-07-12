package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;
   import net.wg.data.VO.StoreTableData;
   import net.wg.data.VO.generated.ShopNationFilterData;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class StoreMeta extends AbstractView
   {
      
      public function StoreMeta() {
         super();
      }
      
      public var requestTableData:Function = null;
      
      public var requestFilterData:Function = null;
      
      public var onCloseButtonClick:Function = null;
      
      public var onShowInfo:Function = null;
      
      public var getName:Function = null;
      
      public function requestTableDataS(param1:Number, param2:String, param3:Array) : void {
         App.utils.asserter.assertNotNull(this.requestTableData,"requestTableData" + Errors.CANT_NULL);
         this.requestTableData(param1,param2,param3);
      }
      
      public function requestFilterDataS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.requestFilterData,"requestFilterData" + Errors.CANT_NULL);
         this.requestFilterData(param1);
      }
      
      public function onCloseButtonClickS() : void {
         App.utils.asserter.assertNotNull(this.onCloseButtonClick,"onCloseButtonClick" + Errors.CANT_NULL);
         this.onCloseButtonClick();
      }
      
      public function onShowInfoS(param1:StoreTableData) : void {
         App.utils.asserter.assertNotNull(this.onShowInfo,"onShowInfo" + Errors.CANT_NULL);
         this.onShowInfo(param1);
      }
      
      public function getNameS() : String {
         App.utils.asserter.assertNotNull(this.getName,"getName" + Errors.CANT_NULL);
         return this.getName();
      }
      
      public function as_setFilterType(param1:Object) : void {
         var _loc2_:ShopNationFilterData = new ShopNationFilterData(param1);
         this.setFilterType(_loc2_);
      }
      
      protected function setFilterType(param1:ShopNationFilterData) : void {
         var _loc2_:String = "as_setFilterType" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
