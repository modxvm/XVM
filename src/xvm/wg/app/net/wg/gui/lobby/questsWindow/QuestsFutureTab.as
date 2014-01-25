package net.wg.gui.lobby.questsWindow
{


   public class QuestsFutureTab extends QuestsCurrentTab
   {
          
      public function QuestsFutureTab() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         questContent.hideDoneCheckbox(true);
         questContent.setNodataLabel(QUESTS.QUESTS_FUTURE_NODATA);
      }

      override protected function onDispose() : void {
         super.onDispose();
      }
   }

}