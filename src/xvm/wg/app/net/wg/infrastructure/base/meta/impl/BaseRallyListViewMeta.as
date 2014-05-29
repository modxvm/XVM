package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.rally.BaseRallyView;
   import net.wg.data.constants.Errors;


   public class BaseRallyListViewMeta extends BaseRallyView
   {
          
      public function BaseRallyListViewMeta() {
         super();
      }

      public var getRallyDetails:Function = null;

      public function getRallyDetailsS(param1:int) : Object {
         App.utils.asserter.assertNotNull(this.getRallyDetails,"getRallyDetails" + Errors.CANT_NULL);
         return this.getRallyDetails(param1);
      }
   }

}