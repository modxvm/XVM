package net.wg.gui.lobby.browser
{
    import net.wg.infrastructure.base.meta.impl.BrowserMeta;
    import net.wg.infrastructure.base.meta.IBrowserMeta;
    import flash.display.Bitmap;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.browser.events.BrowserTitleEvent;
    import net.wg.gui.lobby.browser.events.BrowserEvent;

    public class Browser extends BrowserMeta implements IBrowserMeta
    {

        private static const BG_IMG_VISIBLE_INVALID:String = "bgImgVisibleInvalid";

        public var serviceView:ServiceView = null;

        private var _bgImg:Bitmap = null;

        private var _mouseDown:Boolean = false;

        public function Browser()
        {
            super();
            this.serviceView.visible = false;
        }

        public function as_invalidateView() : void
        {
            invalidateViewS();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            if(this._bgImg != null)
            {
                this.resizeBgImg(param1,param2);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(BG_IMG_VISIBLE_INVALID) && this._bgImg != null)
            {
                this._bgImg.visible = !this.serviceView.visible;
            }
            if(isInvalid(InvalidationType.SIZE) && this.serviceView.visible)
            {
                this.updateServiceViewPos();
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            if(this._bgImg != null)
            {
                removeChild(this._bgImg);
                this._bgImg.bitmapData.dispose();
                this._bgImg.bitmapData = null;
                this._bgImg = null;
            }
            this.serviceView.dispose();
            this.serviceView = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
            addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler,false,0,true);
        }

        public function as_changeTitle(param1:String) : void
        {
            dispatchEvent(new BrowserTitleEvent(BrowserTitleEvent.TITLE_CHANGE,param1));
        }

        public function as_hideServiceView() : void
        {
            this.serviceView.visible = false;
            this.invalidBgImgVisible();
            dispatchEvent(new BrowserEvent(BrowserEvent.SERVICE_VIEW_HIDDEN));
        }

        public function as_loadingStart() : void
        {
            dispatchEvent(new BrowserEvent(BrowserEvent.LOADING_STARTED));
        }

        public function as_loadingStop() : void
        {
            this.checkAndCreateBgImg();
            this.invalidBgImgVisible();
            dispatchEvent(new BrowserEvent(BrowserEvent.LOADING_STOPPED));
        }

        public function as_showContextMenu(param1:String, param2:Object) : void
        {
            App.contextMenuMgr.show(param1,this,param2);
            App.toolTipMgr.hide();
        }

        public function as_showServiceView(param1:String, param2:String) : void
        {
            this.serviceView.setData(param1,param2);
            this.updateServiceViewPos();
            this.serviceView.visible = true;
            this.invalidBgImgVisible();
            dispatchEvent(new BrowserEvent(BrowserEvent.SERVICE_VIEW_SHOWED));
        }

        private function updateServiceViewPos() : void
        {
            this.serviceView.x = width - this.serviceView.width >> 1;
            this.serviceView.y = height - this.serviceView.height >> 1;
        }

        private function resizeBgImg(param1:Number, param2:Number) : void
        {
            setBrowserSizeS(param1,param2);
            this._bgImg.width = param1;
            this._bgImg.height = param2;
        }

        private function invalidBgImgVisible() : void
        {
            invalidate(BG_IMG_VISIBLE_INVALID);
        }

        private function checkAndCreateBgImg() : void
        {
            if(this._bgImg == null)
            {
                this._bgImg = new App.browserBgClass();
                this._bgImg.visible = false;
                this.resizeBgImg(width,height);
                addChild(this._bgImg);
                this.invalidBgImgVisible();
            }
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler,false,0,true);
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
            onBrowserShowS(false);
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            if(!this._mouseDown)
            {
                removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
                removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
                browserFocusOutS();
            }
        }

        private function onMouseWheelHandler(param1:MouseEvent) : void
        {
            browserMoveS(0,0,param1.delta);
        }

        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            this._mouseDown = true;
            browserDownS(mouseX,mouseY,0);
        }

        private function onMouseUpHandler(param1:MouseEvent) : void
        {
            this._mouseDown = false;
            browserUpS(mouseX,mouseY,0);
        }

        private function onMouseMoveHandler(param1:MouseEvent) : void
        {
            browserMoveS(mouseX,mouseY,0);
        }
    }
}
