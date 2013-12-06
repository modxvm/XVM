package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class BattleResultsMeta extends AbstractWindowView
   {
          
      public function BattleResultsMeta() {
         super();
      }

      public var saveSorting:Function = null;

      public var showEventsWindow:Function = null;

      public function saveSortingS(param1:String, param2:String) : void {
         App.utils.asserter.assertNotNull(this.saveSorting,"saveSorting" + Errors.CANT_NULL);
         this.saveSorting(param1,param2);
      }

      public function showEventsWindowS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.showEventsWindow,"showEventsWindow" + Errors.CANT_NULL);
         this.showEventsWindow(param1);
      }
   }

}