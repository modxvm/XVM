package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;


   public class TrainingFormMeta extends AbstractView
   {
          
      public function TrainingFormMeta() {
         super();
      }

      public var joinTrainingRequest:Function = null;

      public var createTrainingRequest:Function = null;

      public var onEscape:Function = null;

      public function joinTrainingRequestS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.joinTrainingRequest,"joinTrainingRequest" + Errors.CANT_NULL);
         this.joinTrainingRequest(param1);
      }

      public function createTrainingRequestS() : void {
         App.utils.asserter.assertNotNull(this.createTrainingRequest,"createTrainingRequest" + Errors.CANT_NULL);
         this.createTrainingRequest();
      }

      public function onEscapeS() : void {
         App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
         this.onEscape();
      }
   }

}