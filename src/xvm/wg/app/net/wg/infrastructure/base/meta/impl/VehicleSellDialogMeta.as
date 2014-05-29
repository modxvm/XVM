package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class VehicleSellDialogMeta extends AbstractWindowView
   {
          
      public function VehicleSellDialogMeta() {
         super();
      }

      public var getDialogSettings:Function = null;

      public var setDialogSettings:Function = null;

      public var sell:Function = null;

      public var setUserInput:Function = null;

      public var setResultCredit:Function = null;

      public var checkControlQuestion:Function = null;

      public function getDialogSettingsS() : Object {
         App.utils.asserter.assertNotNull(this.getDialogSettings,"getDialogSettings" + Errors.CANT_NULL);
         return this.getDialogSettings();
      }

      public function setDialogSettingsS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.setDialogSettings,"setDialogSettings" + Errors.CANT_NULL);
         this.setDialogSettings(param1);
      }

      public function sellS(param1:Object, param2:Array, param3:Array, param4:Array, param5:Array, param6:Boolean) : void {
         App.utils.asserter.assertNotNull(this.sell,"sell" + Errors.CANT_NULL);
         this.sell(param1,param2,param3,param4,param5,param6);
      }

      public function setUserInputS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.setUserInput,"setUserInput" + Errors.CANT_NULL);
         this.setUserInput(param1);
      }

      public function setResultCreditS(param1:Boolean, param2:int) : void {
         App.utils.asserter.assertNotNull(this.setResultCredit,"setResultCredit" + Errors.CANT_NULL);
         this.setResultCredit(param1,param2);
      }

      public function checkControlQuestionS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.checkControlQuestion,"checkControlQuestion" + Errors.CANT_NULL);
         this.checkControlQuestion(param1);
      }
   }

}