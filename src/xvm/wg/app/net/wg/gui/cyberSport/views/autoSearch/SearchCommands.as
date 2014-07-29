package net.wg.gui.cyberSport.views.autoSearch
{
    import flash.text.TextField;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    
    public class SearchCommands extends StateViewBase
    {
        
        public function SearchCommands()
        {
            super();
            currentState = CYBER_SPORT_ALIASES.AUTO_SEARCH_COMMANDS_STATE;
            mainField.text = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_MAINTEXT;
            this.ctxText.text = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CTXMESSAGE;
            cancelButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
            this.ctxText.mouseEnabled = this.dynamicCtxText.mouseEnabled = false;
        }
        
        public var ctxText:TextField;
        
        public var dynamicCtxText:TextField;
        
        override protected function updateView() : void
        {
            super.updateView();
            updateTime();
            startTimer();
            this.contextMessage(model.contextMessage);
        }
        
        override protected function onTimer() : void
        {
            super.onTimer();
            updateTime();
            startTimer();
        }
        
        override protected function contextMessage(param1:String) : void
        {
            super.contextMessage(param1);
            this.dynamicCtxText.htmlText = param1;
        }
    }
}
