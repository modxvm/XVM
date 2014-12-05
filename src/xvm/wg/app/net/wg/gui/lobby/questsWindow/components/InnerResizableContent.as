package net.wg.gui.lobby.questsWindow.components
{
    public class InnerResizableContent extends EventsResizableContent
    {
        
        public function InnerResizableContent()
        {
            super();
        }
        
        private static var AVAILABLE_WIDTH:int = 365;
        
        override protected function configUI() : void
        {
            headerYShift = -4;
            super.configUI();
            resizableContainer.availableWidth = AVAILABLE_WIDTH;
        }
    }
}
