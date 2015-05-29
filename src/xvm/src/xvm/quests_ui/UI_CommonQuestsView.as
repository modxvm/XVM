/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests_ui
{
    import com.xfw.*;
    import xvm.quests_ui.components.*;

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
            QuestsHelper.updateProgressIndicatorTextField(questContent.header.progressIndicator.textField);
        }
    }
}
