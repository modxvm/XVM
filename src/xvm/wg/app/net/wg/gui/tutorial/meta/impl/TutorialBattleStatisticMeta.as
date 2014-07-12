package net.wg.gui.tutorial.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class TutorialBattleStatisticMeta extends AbstractWindowView
   {
      
      public function TutorialBattleStatisticMeta() {
         super();
      }
      
      public var restart:Function = null;
      
      public var showVideoDialog:Function = null;
      
      public function restartS() : void {
         App.utils.asserter.assertNotNull(this.restart,"restart" + Errors.CANT_NULL);
         this.restart();
      }
      
      public function showVideoDialogS() : void {
         App.utils.asserter.assertNotNull(this.showVideoDialog,"showVideoDialog" + Errors.CANT_NULL);
         this.showVideoDialog();
      }
   }
}
