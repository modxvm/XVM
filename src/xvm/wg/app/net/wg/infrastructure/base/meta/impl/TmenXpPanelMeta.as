package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class TmenXpPanelMeta extends BaseDAAPIComponent
   {
          
      public function TmenXpPanelMeta() {
         super();
      }

      public var accelerateTmenXp:Function = null;

      public function accelerateTmenXpS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.accelerateTmenXp,"accelerateTmenXp" + Errors.CANT_NULL);
         this.accelerateTmenXp(param1);
      }
   }

}