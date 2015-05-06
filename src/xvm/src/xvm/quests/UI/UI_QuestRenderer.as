package xvm.quests.UI
{
    import com.xfw.*;
    import xvm.quests.*;

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

            QuestsHelper.updateProgressIndicatorTextFielf(progressIndicator.textField);
        }
    }
}
