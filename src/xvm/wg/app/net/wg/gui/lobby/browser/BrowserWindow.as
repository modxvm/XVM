package net.wg.gui.lobby.browser
{
    import net.wg.infrastructure.base.meta.impl.BrowserMeta;
    import net.wg.infrastructure.base.meta.IBrowserMeta;
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.windows.Window;
    import scaleform.clik.utils.Padding;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.constants.WindowViewInvalidationType;
    
    public class BrowserWindow extends BrowserMeta implements IBrowserMeta
    {
        
        public function BrowserWindow()
        {
            super();
            showWindowBgForm = false;
            this.serviceView.visible = false;
        }
        
        private static var ACTION_BUTTON_OFFSET:Number = 62;
        
        public var actionBtn:BrowserActionBtn;
        
        public var browserHitArea:BrowserHitArea;
        
        public var serviceView:ServiceView;
        
        private var windowTitle:String = "#menu:browser/window/title";
        
        private var _browserWidth:Number = 0;
        
        private var _browserHeight:Number = 0;
        
        override public function as_showWaiting(param1:String, param2:Object) : void
        {
            super.as_showWaiting(param1,param2);
            this.browserHitArea.visible = false;
        }
        
        override public function as_hideWaiting() : void
        {
            super.as_hideWaiting();
            this.browserHitArea.visible = true;
        }
        
        public function as_loadingStart() : void
        {
            this.actionBtn.action = BrowserActionBtn.ACTION_LOADING;
            this.updateFocus();
        }
        
        public function as_loadingStop() : void
        {
            this.actionBtn.action = BrowserActionBtn.ACTION_RELOAD;
        }
        
        override protected function applyWaitingChanges(param1:int, param2:int) : void
        {
            if(this.actionBtn.y < 0)
            {
                param2 = param2 - Math.abs(this.actionBtn.y);
            }
            super.applyWaitingChanges(param1,param2);
        }
        
        public function as_configure(param1:Boolean, param2:String, param3:Boolean) : void
        {
            if(param2)
            {
                window.title = this.windowTitle = param2;
            }
            this.actionBtn.visible = param3;
            this.browserHitArea.setBgClass(param1);
        }
        
        public function as_showServiceView(param1:String, param2:String) : void
        {
            this.serviceView.setData(param1,param2);
            this.serviceView.x = width - this.serviceView.width >> 1;
            this.serviceView.y = height - this.serviceView.height >> 1;
            showWindowBgForm = true;
            this.serviceView.visible = true;
            this.browserHitArea.visible = false;
            UIComponent(window).invalidate(Window.INVALID_SRC_VIEW);
        }
        
        public function as_hideServiceView() : void
        {
            this.serviceView.visible = false;
            showWindowBgForm = false;
            this.browserHitArea.visible = true;
            UIComponent(window).invalidate(Window.INVALID_SRC_VIEW);
        }
        
        public function as_setBrowserSize(param1:Number, param2:Number) : void
        {
            this.width = this._browserWidth = param1;
            this.height = this._browserHeight = param2;
            if(this.actionBtn.y < 0)
            {
                this.height = this.height + Math.abs(this.actionBtn.y);
            }
            this.updateWindowSize();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.title = this.windowTitle;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.bottom = -8;
            window.contentPadding = _loc1_;
            DisplayObject(window).visible = false;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.actionBtn.dispose();
            this.actionBtn.removeEventListener(BrowserEvent.ACTION_LOADING,this.onBtnAction);
            this.actionBtn.removeEventListener(BrowserEvent.ACTION_RELOAD,this.onBtnAction);
            this.browserHitArea.dispose();
            this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_DOWN,this.onBrowserDown);
            this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_UP,this.onBrowserUp);
            this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_MOVE,this.onBrowserMove);
            this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_FOCUS_IN,this.onBrowserFocusIn);
            this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_FOCUS_OUT,this.onBrowserFocusOut);
            this.serviceView.dispose();
            this.serviceView = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.actionBtn.addEventListener(BrowserEvent.ACTION_LOADING,this.onBtnAction);
            this.actionBtn.addEventListener(BrowserEvent.ACTION_RELOAD,this.onBtnAction);
            this.browserHitArea.addEventListener(BrowserEvent.BROWSER_DOWN,this.onBrowserDown);
            this.browserHitArea.addEventListener(BrowserEvent.BROWSER_UP,this.onBrowserUp);
            this.browserHitArea.addEventListener(BrowserEvent.BROWSER_MOVE,this.onBrowserMove);
            this.browserHitArea.addEventListener(BrowserEvent.BROWSER_FOCUS_IN,this.onBrowserFocusIn);
            this.browserHitArea.addEventListener(BrowserEvent.BROWSER_FOCUS_OUT,this.onBrowserFocusOut);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((window) && (isInvalid(WindowViewInvalidationType.POSITION_INVALID)))
            {
                this.updatePosition();
            }
        }
        
        private function updateFocus() : void
        {
            if(!this.actionBtn.isMouseOver)
            {
                setFocus(this);
            }
        }
        
        private function updateWindowSize() : void
        {
            this.browserHitArea.setMaskSize(this._browserWidth,this._browserHeight);
            this.actionBtn.x = this._browserWidth - ACTION_BUTTON_OFFSET;
            invalidate(WindowViewInvalidationType.POSITION_INVALID);
        }
        
        private function updatePosition() : void
        {
            var _loc1_:Number = window.width;
            var _loc2_:Number = window.height;
            if(this.browserHitArea.mask)
            {
                _loc1_ = _loc1_ - (this.browserHitArea.width - this.browserHitArea.mask.width);
                _loc2_ = _loc2_ - (this.browserHitArea.height - this.browserHitArea.mask.height);
            }
            window.x = App.appWidth - _loc1_ >> 1;
            window.y = App.appHeight - _loc2_ >> 1;
            DisplayObject(window).visible = true;
        }
        
        private function onBtnAction(param1:BrowserEvent) : void
        {
            browserActionS(param1.type);
        }
        
        private function onBrowserDown(param1:BrowserEvent) : void
        {
            browserDownS(param1.mouseX,param1.mouseY,param1.delta);
        }
        
        private function onBrowserUp(param1:BrowserEvent) : void
        {
            browserUpS(param1.mouseX,param1.mouseY,param1.delta);
        }
        
        private function onBrowserMove(param1:BrowserEvent) : void
        {
            browserMoveS(param1.mouseX,param1.mouseY,param1.delta);
        }
        
        private function onBrowserFocusIn(param1:BrowserEvent) : void
        {
            onBrowserShowS(false);
        }
        
        private function onBrowserFocusOut(param1:BrowserEvent) : void
        {
            browserFocusOut();
        }
    }
}
