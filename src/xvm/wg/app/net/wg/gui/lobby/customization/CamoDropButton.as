package net.wg.gui.lobby.customization
{
    import scaleform.clik.controls.Button;
    import scaleform.clik.events.ButtonEvent;
    
    public class CamoDropButton extends Button
    {
        
        public function CamoDropButton() {
            super();
        }
        
        public var kind:int = -1;
        
        override protected function configUI() : void {
            super.configUI();
            addEventListener(ButtonEvent.CLICK,this.onClick,false,0,true);
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            removeEventListener(ButtonEvent.CLICK,this.onClick);
        }
        
        private function onClick(param1:ButtonEvent) : void {
            var _loc2_:CustomizationEvent = new CustomizationEvent(CustomizationEvent.DROP_ITEM);
            _loc2_.kind = this.kind;
            dispatchEvent(_loc2_);
        }
    }
}
