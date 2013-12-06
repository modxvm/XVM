package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class RosterSlotSettingsWindowMeta extends AbstractWindowView
   {
          
      public function RosterSlotSettingsWindowMeta() {
         super();
      }

      public var onFiltersUpdate:Function = null;

      public var getFilterData:Function = null;

      public var submitButtonHandler:Function = null;

      public var cancelButtonHandler:Function = null;

      public function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int) : void {
         App.utils.asserter.assertNotNull(this.onFiltersUpdate,"onFiltersUpdate" + Errors.CANT_NULL);
         this.onFiltersUpdate(param1,param2,param3,param4);
      }

      public function getFilterDataS() : Object {
         App.utils.asserter.assertNotNull(this.getFilterData,"getFilterData" + Errors.CANT_NULL);
         return this.getFilterData();
      }

      public function submitButtonHandlerS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.submitButtonHandler,"submitButtonHandler" + Errors.CANT_NULL);
         this.submitButtonHandler(param1);
      }

      public function cancelButtonHandlerS() : void {
         App.utils.asserter.assertNotNull(this.cancelButtonHandler,"cancelButtonHandler" + Errors.CANT_NULL);
         this.cancelButtonHandler();
      }
   }

}