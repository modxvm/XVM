package net.wg.gui.lobby.questsWindow.components
{
    public class InnerResizableContent extends EventsResizableContent
    {
        
        public function InnerResizableContent()
        {
            super();
        }
        
        private static var HEADER_HEIGHT:int = 25;
        
        private static var AVAILABLE_WIDTH:int = 365;
        
        override protected function configUI() : void
        {
            super.configUI();
            header.height = HEADER_HEIGHT;
            resizableContainer.availableWidth = AVAILABLE_WIDTH;
        }
    }
}
