package xvm.quests.UI
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class UI_CommonQuestsView extends CurrentTab_UI
    {
        public function UI_CommonQuestsView()
        {
            //Logger.add("UI_CommonQuestsView");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            questContent.questsList.itemRenderer = UI_QuestRenderer;
        }
    }
}
