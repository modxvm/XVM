package net.wg.gui.lobby.browser 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class BrowserHitArea extends scaleform.clik.core.UIComponent
    {
        public function BrowserHitArea()
        {
            this.events = App.utils.events;
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMouseRollOverHandler);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMouseRollOutHandler);
            this.events.removeEvent(App.stage, flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
            this.events.removeEvent(App.stage, flash.events.MouseEvent.MOUSE_UP, this.onMouseUpHandler);
            removeChild(this.bgImg);
            this.events = null;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=App.browserBgClass;
            this.bgImg = new loc1();
            addChild(this.bgImg);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onMouseRollOverHandler, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onMouseRollOutHandler, false, 0, true);
            this.events.addEvent(App.stage, flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDownHandler, false, 0, true);
            this.events.addEvent(App.stage, flash.events.MouseEvent.MOUSE_UP, this.onMouseUpHandler, false, 0, true);
            return;
        }

        internal function onMouseRollOverHandler(arg1:flash.events.MouseEvent):void
        {
            addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler, false, 0, true);
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler, false, 0, true);
            dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_IN));
            return;
        }

        internal function onMouseRollOutHandler(arg1:flash.events.MouseEvent):void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_OUT));
            return;
        }

        internal function onMouseWheelHandler(arg1:flash.events.MouseEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_MOVE, 0, 0, arg1.delta));
            return;
        }

        internal function onMouseDownHandler(arg1:flash.events.MouseEvent):void
        {
            if (arg1.target != this) 
                dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_OUT));
            else 
                dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_DOWN, this.mouseX, this.mouseY));
            return;
        }

        internal function onMouseUpHandler(arg1:flash.events.MouseEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_UP, this.mouseX, this.mouseY));
            return;
        }

        internal function onMouseMoveHandler(arg1:flash.events.MouseEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_MOVE, this.mouseX, this.mouseY));
            return;
        }

        internal var events:net.wg.utils.IEventCollector;

        internal var bgImg:flash.display.Bitmap;
    }
}
