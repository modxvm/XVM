package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.IEventCollector;
    import net.wg.gui.events.ModuleInfoEvent;
    import net.wg.data.constants.FittingTypes;
    
    public class EquipmentSlot extends DeviceSlot
    {
        
        public function EquipmentSlot() {
            super();
            this.events = App.utils.events;
        }
        
        public var icon:UILoaderAlt;
        
        private var events:IEventCollector;
        
        override protected function configUI() : void {
            super.configUI();
            this.events = App.utils.events;
            this.events.addEvent(App.stage,ModuleInfoEvent.SHOW_INFO,this.onShowModuleInfoHandler);
            if(this.icon)
            {
                this.icon.mouseEnabled = this.icon.mouseChildren = false;
            }
        }
        
        override protected function onDispose() : void {
            this.icon.dispose();
            this.events.removeEvent(App.stage,ModuleInfoEvent.SHOW_INFO,this.onShowModuleInfoHandler);
            super.onDispose();
        }
        
        public function setIcon(param1:String, param2:Boolean) : void {
            this.icon.source = param1;
            locked.visible = !param2;
        }
        
        override protected function applyIconData(param1:*) : void {
            if(param1)
            {
                this.setIcon(param1.icon,param1.removable);
            }
            else
            {
                this.setIcon(FittingTypes.EMPTY_ARTIFACT_ICON,true);
            }
        }
        
        private function onShowModuleInfoHandler(param1:ModuleInfoEvent) : void {
            select.close();
        }
    }
}
