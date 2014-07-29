package net.wg.gui.cyberSport.views.autoSearch
{
    import flash.display.MovieClip;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    
    public class SearchEnemy extends StateViewBase
    {
        
        public function SearchEnemy()
        {
            super();
            currentState = CYBER_SPORT_ALIASES.AUTO_SEARCH_ENEMY_STATE;
            mainField.text = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHENEMY_MAINTEXT;
            cancelButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
            this.buttonsBG.visible = false;
            cancelButton.visible = false;
        }
        
        public var buttonsBG:MovieClip;
        
        override protected function updateView() : void
        {
            super.updateView();
            this.buttonsBG.visible = cancelButton.visible = model.canInvokeBattleQueue;
            updateTime();
            startTimer();
        }
        
        override protected function onTimer() : void
        {
            super.onTimer();
            updateTime();
            startTimer();
        }
    }
}
