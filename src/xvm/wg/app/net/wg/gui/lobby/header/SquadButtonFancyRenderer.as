package net.wg.gui.lobby.header
{
    import flash.text.TextField;
    import flash.display.Sprite;
    
    public class SquadButtonFancyRenderer extends FightButtonFancyRenderer
    {
        
        public function SquadButtonFancyRenderer()
        {
            super();
        }
        
        private static var EVENT_SQUAD_ID:String = "eventSquad";
        
        public var descrField:TextField = null;
        
        public var eventSquadBg:Sprite = null;
        
        override protected function applyData(param1:BattleSelectDropDownVO) : void
        {
            super.applyData(param1);
            this.descrField.text = param1.description;
            this.eventSquadBg.visible = param1.data == EVENT_SQUAD_ID;
        }
    }
}
