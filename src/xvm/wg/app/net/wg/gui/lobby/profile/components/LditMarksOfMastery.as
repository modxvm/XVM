package net.wg.gui.lobby.profile.components
{
    import net.wg.gui.components.advanced.LineDescrIconText;
    
    public class LditMarksOfMastery extends LineDescrIconText
    {
        
        public function LditMarksOfMastery() {
            super();
        }
        
        private var _totalCount:uint = 0;
        
        public function set totalCount(param1:uint) : void {
            this._totalCount = param1;
            invalidate(TEXT_INVALID);
        }
        
        override protected function applyText(param1:String) : void {
            if(enabled)
            {
                param1 = param1 + "<font size=\'14\' color=\'#939188\'>" + "/" + App.utils.locale.integer(this._totalCount) + "</font>";
            }
            super.applyText(param1);
            invalidate(DESCRIPTION_TEXT_INVALID);
        }
    }
}
