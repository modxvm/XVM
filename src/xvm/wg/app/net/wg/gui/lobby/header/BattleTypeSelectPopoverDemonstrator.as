package net.wg.gui.lobby.header
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
    
    public class BattleTypeSelectPopoverDemonstrator extends UIComponent
    {
        
        public function BattleTypeSelectPopoverDemonstrator()
        {
            super();
        }
        
        public var label:TextField = null;
        
        public var button:SoundButtonEx = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.label.text = MENU.HEADER_DEMONSTRATION_INFO;
            this.button.label = MENU.HEADER_DEMONSTRATION_BTNLABEL;
            this.button.addEventListener(ButtonEvent.CLICK,this.onDemoClick);
        }
        
        private function onDemoClick(param1:ButtonEvent) : void
        {
            dispatchEvent(new BattleTypeSelectorEvent(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT,BattleTypeSelectorEvent.ITEM_ID_DEMO_CLICK));
        }
        
        override protected function onDispose() : void
        {
            this.button.removeEventListener(ButtonEvent.CLICK,this.onDemoClick);
            super.onDispose();
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            this.button.enabled = param1;
            super.enabled = param1;
        }
    }
}
