package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.constants.InvalidationType;
    
    public class ServerIndicator extends UIComponent
    {
        
        public function ServerIndicator()
        {
            super();
        }
        
        public static var NORMAL:int = 0;
        
        public static var RECOMMENDED:int = 1;
        
        public static var UNKNOWN:int = 2;
        
        public static var IGNORED:int = 3;
        
        public static var NOT_AVAILABLE:int = -1;
        
        private var _state:int = -1;
        
        public function setState(param1:int) : void
        {
            this._state = param1;
            invalidate(InvalidationType.STATE);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                switch(this._state)
                {
                    case UNKNOWN:
                        visible = true;
                        gotoAndStop("unknown");
                        break;
                    case NOT_AVAILABLE:
                        visible = false;
                        break;
                    case IGNORED:
                        visible = false;
                        break;
                    default:
                        visible = false;
                }
            }
        }
    }
}
