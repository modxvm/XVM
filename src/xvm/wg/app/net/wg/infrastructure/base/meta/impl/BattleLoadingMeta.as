package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;


   public class BattleLoadingMeta extends AbstractView
   {
          
      public function BattleLoadingMeta() {
         super();
      }

      public var getData:Function = null;

      public function getDataS() : void {
         App.utils.asserter.assertNotNull(this.getData,"getData" + Errors.CANT_NULL);
         this.getData();
      }
   }

}