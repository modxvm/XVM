package net.wg.gui.prebattle.company
{
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    
    public class CompanyDropList extends ScrollingListEx
    {
        
        public function CompanyDropList()
        {
            super();
        }
        
        private static var AUTHENTIC_WIDTH:uint = 245;
        
        private static var AUTHENTIC_HEIGHT:uint = 411;
        
        public var topLabel:TextField;
        
        public var bottomLabel:TextField;
        
        override protected function initialize() : void
        {
            super.initialize();
            setActualSize(AUTHENTIC_WIDTH,AUTHENTIC_HEIGHT);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            buttonMode = true;
            mouseEnabled = true;
            this.bottomLabel.mouseEnabled = false;
            this.topLabel.mouseEnabled = false;
            this.topLabel.text = PREBATTLE.LABELS_COMPANY_PLAYERS_TOP;
            this.bottomLabel.text = PREBATTLE.LABELS_COMPANY_PLAYERS_BOTTOM;
            this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
            this.addEventListener(MouseEvent.CLICK,this.clickHandler);
        }
        
        private function mouseOverHandler(param1:MouseEvent) : void
        {
            if(!enabled)
            {
                return;
            }
            if(!_focused)
            {
                setState("over");
            }
        }
        
        private function mouseOutHandler(param1:MouseEvent) : void
        {
            if(!enabled)
            {
                return;
            }
            if(!_focused)
            {
                setState("out");
            }
        }
        
        private function clickHandler(param1:MouseEvent) : void
        {
            if(enabled)
            {
                return;
            }
            setState("down");
        }
    }
}
