package net.wg.gui.lobby.profile.components 
{
    public class LditMarksOfMastery extends net.wg.gui.lobby.profile.components.LineDescrIconText
    {
        public function LditMarksOfMastery()
        {
            super();
            return;
        }

        public function set totalCount(arg1:uint):void
        {
            this._totalCount = arg1;
            isTextChanged = true;
            invalidate();
            return;
        }

        protected override function applyText():void
        {
            textComponent.text = _text + "<font size=\'14\' color=\'#939188\'>" + "/" + this._totalCount + "</font>";
            return;
        }

        internal var _totalCount:uint=0;
    }
}
