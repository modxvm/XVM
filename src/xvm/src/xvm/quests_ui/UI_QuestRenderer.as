/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests_ui
{
    import com.xfw.*;
    import xvm.quests.*;
    import xvm.quests_ui.components.QuestsHelper;

    public dynamic class UI_QuestRenderer extends QuestRenderer_UI
    {
        public function UI_QuestRenderer()
        {
            //Logger.add("UI_QuestRenderer");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();

            QuestsHelper.updateProgressIndicatorTextField(progressIndicator.textField);
        }
    }
}
