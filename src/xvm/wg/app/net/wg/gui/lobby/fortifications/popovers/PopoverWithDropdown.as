package net.wg.gui.lobby.fortifications.popovers
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import net.wg.gui.components.controls.events.DropdownMenuEvent;
    import net.wg.utils.IEventCollector;
    import flash.events.Event;
    
    public class PopoverWithDropdown extends SmartPopOverView
    {
        
        public function PopoverWithDropdown()
        {
            super();
        }
        
        private var dropdownListRef:MovieClip = null;
        
        private var dropdownListXY:Point = null;
        
        override protected function configUI() : void
        {
            addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onShowDropdownHandler);
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onShowDropdownHandler);
            if((this.dropdownListRef) && (contains(this.dropdownListRef)))
            {
                removeChild(this.dropdownListRef);
            }
            this.dropdownListRef = null;
            this.dropdownListXY = null;
            super.onDispose();
        }
        
        protected function onShowDropdownHandler(param1:DropdownMenuEvent) : void
        {
            var _loc2_:IEventCollector = App.utils.events;
            this.dropdownListRef = param1.dropDownRef;
            this.dropdownListXY = globalToLocal(new Point(this.dropdownListRef.x,this.dropdownListRef.y));
            _loc2_.disableDisposingForObj(this.dropdownListRef);
            addChild(this.dropdownListRef);
            _loc2_.enableDisposingForObj(this.dropdownListRef);
            this.dropdownListRef.x = this.dropdownListXY.x;
            this.dropdownListRef.y = this.dropdownListXY.y;
            addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onHideDropdownHandler);
            stage.addEventListener(Event.RESIZE,this.updateDDListPosition);
        }
        
        private function updateDDListPosition(param1:Event) : void
        {
            this.dropdownListRef.x = this.dropdownListXY.x;
            this.dropdownListRef.y = this.dropdownListXY.y;
        }
        
        private function onHideDropdownHandler(param1:DropdownMenuEvent) : void
        {
            removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onHideDropdownHandler);
            if((stage) && (stage.hasEventListener(Event.RESIZE)))
            {
                stage.removeEventListener(Event.RESIZE,this.updateDDListPosition);
            }
        }
    }
}
