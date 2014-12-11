package net.wg.gui.lobby.browser
{
    import scaleform.clik.core.UIComponent;
    import net.wg.utils.IEventCollector;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    
    public class BrowserHitArea extends UIComponent
    {
        
        public function BrowserHitArea()
        {
            this.events = App.utils.events;
            super();
        }
        
        private var events:IEventCollector;
        
        private var bgImg:Bitmap;
        
        private var isMouseDown:Boolean = false;
        
        public function setBgClass(param1:Boolean) : void
        {
            var _loc2_:Class = null;
            if(param1)
            {
                _loc2_ = App.browserBgClass;
            }
            else
            {
                _loc2_ = App.altBrowserBgClass;
            }
            this.bgImg = new _loc2_();
            addChild(this.bgImg);
        }
        
        public function setMaskSize(param1:Number, param2:Number) : void
        {
            var _loc4_:Bitmap = null;
            this.width = param1;
            this.height = param2;
            var _loc3_:BitmapData = new BitmapData(param1,param2,true,0);
            _loc4_ = new Bitmap(_loc3_);
            this.mask = _loc4_;
            addChild(_loc4_);
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this.events.removeEvent(App.stage,MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            this.events.removeEvent(App.stage,MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            removeChild(this.bgImg);
            this.events = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler,false,0,true);
            this.events.addEvent(App.stage,MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
            this.events.addEvent(App.stage,MouseEvent.MOUSE_UP,this.onMouseUpHandler,false,0,true);
        }
        
        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler,false,0,true);
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_IN));
        }
        
        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            if(!this.isMouseDown)
            {
                removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
                removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
                dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_OUT));
            }
        }
        
        private function onMouseWheelHandler(param1:MouseEvent) : void
        {
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_MOVE,0,0,param1.delta));
        }
        
        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            if(param1.target == this)
            {
                this.isMouseDown = true;
                dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_DOWN,this.mouseX,this.mouseY));
            }
            else
            {
                dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_OUT));
            }
        }
        
        private function onMouseUpHandler(param1:MouseEvent) : void
        {
            this.isMouseDown = false;
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_UP,this.mouseX,this.mouseY));
        }
        
        private function onMouseMoveHandler(param1:MouseEvent) : void
        {
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_MOVE,this.mouseX,this.mouseY));
        }
    }
}
