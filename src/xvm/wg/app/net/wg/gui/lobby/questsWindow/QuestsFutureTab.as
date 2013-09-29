package net.wg.gui.lobby.questsWindow 
{
    public class QuestsFutureTab extends net.wg.gui.lobby.questsWindow.QuestsCurrentTab
    {
        public function QuestsFutureTab()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            doneCB.visible = false;
            noQuestsMC.noResult.text = QUESTS.QUESTS_FUTURE_NODATA;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            doneCB.visible = false;
            return;
        }
    }
}
