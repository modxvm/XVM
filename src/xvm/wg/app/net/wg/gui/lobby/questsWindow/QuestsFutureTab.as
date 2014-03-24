package net.wg.gui.lobby.questsWindow
{
   import net.wg.data.constants.QuestsStates;


   public class QuestsFutureTab extends QuestsCurrentTab
   {
          
      public function QuestsFutureTab() {
         super();
      }

      override protected function configUI() : void {
         questContent.hideSortPanel(true);
         questContent.setNodataLabel(QUESTS.QUESTS_FUTURE_NODATA);
         questContent.questsList.questsState = QuestsStates.FUTURE_STATE;
         questContent.validateNow();
      }
   }

}