package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;
   
   public class QuestsCurrentTabMeta extends BaseDAAPIComponent
   {
      
      public function QuestsCurrentTabMeta() {
         super();
      }
      
      public var sort:Function = null;
      
      public var getQuestInfo:Function = null;
      
      public var getSortedTableData:Function = null;
      
      public function sortS(param1:int, param2:Boolean) : void {
         App.utils.asserter.assertNotNull(this.sort,"sort" + Errors.CANT_NULL);
         this.sort(param1,param2);
      }
      
      public function getQuestInfoS(param1:String) : Object {
         App.utils.asserter.assertNotNull(this.getQuestInfo,"getQuestInfo" + Errors.CANT_NULL);
         return this.getQuestInfo(param1);
      }
      
      public function getSortedTableDataS(param1:Object) : Array {
         App.utils.asserter.assertNotNull(this.getSortedTableData,"getSortedTableData" + Errors.CANT_NULL);
         return this.getSortedTableData(param1);
      }
   }
}
