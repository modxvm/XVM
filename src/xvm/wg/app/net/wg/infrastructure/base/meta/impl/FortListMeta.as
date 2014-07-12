package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.rally.views.list.BaseRallyListView;
   import net.wg.data.constants.Errors;
   
   public class FortListMeta extends BaseRallyListView
   {
      
      public function FortListMeta() {
         super();
      }
      
      public var changeDivisionIndex:Function = null;
      
      public function changeDivisionIndexS(param1:int) : void {
         App.utils.asserter.assertNotNull(this.changeDivisionIndex,"changeDivisionIndex" + Errors.CANT_NULL);
         this.changeDivisionIndex(param1);
      }
   }
}
