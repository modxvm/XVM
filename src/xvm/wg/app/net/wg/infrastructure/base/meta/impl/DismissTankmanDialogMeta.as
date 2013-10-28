package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.lobby.dialogs.SimpleDialog;
   import net.wg.data.constants.Errors;


   public class DismissTankmanDialogMeta extends SimpleDialog
   {
          
      public function DismissTankmanDialogMeta() {
         super();
      }

      public var sendControlNumber:Function = null;

      public function sendControlNumberS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.sendControlNumber,"sendControlNumber" + Errors.CANT_NULL);
         this.sendControlNumber(param1);
      }
   }

}