package net.wg.gui.prebattle.company 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    
    public class CompanyDropList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function CompanyDropList()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            setActualSize(AUTHENTIC_WIDTH, AUTHENTIC_HEIGHT);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            buttonMode = true;
            mouseEnabled = true;
            this.bottomLabel.mouseEnabled = false;
            this.topLabel.mouseEnabled = false;
            this.topLabel.text = PREBATTLE.LABELS_COMPANY_PLAYERS_TOP;
            this.bottomLabel.text = PREBATTLE.LABELS_COMPANY_PLAYERS_BOTTOM;
            this.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.addEventListener(flash.events.MouseEvent.CLICK, this.clickHandler);
            return;
        }

        internal function mouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            if (!enabled) 
            {
                return;
            }
            if (!_focused) 
            {
                setState("over");
            }
            return;
        }

        internal function mouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            if (!enabled) 
            {
                return;
            }
            if (!_focused) 
            {
                setState("out");
            }
            return;
        }

        internal function clickHandler(arg1:flash.events.MouseEvent):void
        {
            if (enabled) 
            {
                return;
            }
            setState("down");
            return;
        }

        internal static const AUTHENTIC_WIDTH:uint=245;

        internal static const AUTHENTIC_HEIGHT:uint=411;

        public var topLabel:flash.text.TextField;

        public var bottomLabel:flash.text.TextField;
    }
}
