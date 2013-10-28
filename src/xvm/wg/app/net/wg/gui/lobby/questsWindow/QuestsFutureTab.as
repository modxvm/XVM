package net.wg.gui.lobby.questsWindow
{


   public class QuestsFutureTab extends QuestsCurrentTab
   {
          
      public function QuestsFutureTab() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         doneCB.visible = false;
         noQuestsMC.noResult.text = QUESTS.QUESTS_FUTURE_NODATA;
      }

      override protected function draw() : void {
         super.draw();
         doneCB.visible = false;
      }
   }

}