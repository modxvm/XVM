package net.wg.gui.lobby.questsWindow.data
{
    public class CounterTextElementVO extends QuestDashlineItemVO
    {
        
        public function CounterTextElementVO(param1:Object)
        {
            super(param1);
        }
        
        private var _battlesLeft:Number = 0;
        
        private var _showDone:Boolean = false;
        
        private var _fullLabel:String = "";
        
        public function get battlesLeft() : Number
        {
            return this._battlesLeft;
        }
        
        public function set battlesLeft(param1:Number) : void
        {
            this._battlesLeft = param1;
        }
        
        public function get showDone() : Boolean
        {
            return this._showDone;
        }
        
        public function set showDone(param1:Boolean) : void
        {
            this._showDone = param1;
        }
        
        public function get fullLabel() : String
        {
            return this._fullLabel;
        }
        
        public function set fullLabel(param1:String) : void
        {
            this._fullLabel = param1;
        }
    }
}
