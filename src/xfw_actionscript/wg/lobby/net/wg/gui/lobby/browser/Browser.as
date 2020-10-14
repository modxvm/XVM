package net.wg.gui.lobby.browser
{
    import net.wg.infrastructure.base.meta.impl.BrowserMeta;
    import net.wg.infrastructure.base.meta.IBrowserMeta;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import net.wg.gui.lobby.browser.events.BrowserTitleEvent;
    import net.wg.gui.lobby.browser.events.BrowserEvent;
    import flash.net.URLRequest;

    public class Browser extends BrowserMeta implements IBrowserMeta
    {

        private static const BG_IMG_VISIBLE_INVALID:String = "bgImgVisibleInvalid";

        public var serviceView:ServiceView = null;

        private var _bgImg:Bitmap = null;

        private var _mouseDown:Boolean = false;

        private var _showContentUnderWaiting:Boolean = true;

        private var _bgLoader:Loader = null;

        private var _bitmapUrl:String = null;

        public function Browser()
        {
            super();
            this.serviceView.visible = false;
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
            if(isInvalid(InvalidationType.SIZE))
            {
                if(this.serviceView.visible)
                {
                    this.updateServiceViewPos();
                }
                if(!this._showContentUnderWaiting)
                {
                    this.drawNoTransparencyBG();
                }
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
            if(this._bgLoader != null)
            {
                this._bgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBgLoaderCompleteHandler);
                this._bgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBgLoaderIoErrorHandler);
                this._bgLoader.unload();
                this._bgLoader = null;
            }
            if(this._bgImg != null)
            {
                removeChild(this._bgImg);
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

        public function as_invalidateView() : void
        {
            invalidateViewS();
        }

        public function as_loadingStart(param1:Boolean) : void
        {
            dispatchEvent(new BrowserEvent(BrowserEvent.LOADING_STARTED));
            this._showContentUnderWaiting = param1;
            if(this._bgImg)
            {
                this._bgImg.alpha = this.bgImagaAlpha;
            }
            if(!this._showContentUnderWaiting)
            {
                this.drawNoTransparencyBG();
            }
            else
            {
                graphics.clear();
            }
        }

        public function as_loadBitmap(param1:String) : void
        {
            if(this._bitmapUrl == param1)
            {
                DebugUtils.LOG_WARNING("Requested bitmap already loaded or in progress. url: " + this._bitmapUrl);
                return;
            }
            if(this._bgLoader != null)
            {
                this._bgLoader.unload();
            }
            else
            {
                this._bgLoader = new Loader();
                this._bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBgLoaderCompleteHandler);
                this._bgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBgLoaderIoErrorHandler);
            }
            this._bitmapUrl = param1;
            this._bgLoader.load(new URLRequest(this._bitmapUrl));
        }

        private function onBgLoaderCompleteHandler(param1:Event) : void
        {
            DebugUtils.LOG_DEBUG("Browser bitmap is loaded: " + this._bitmapUrl);
            if(this._bgImg != null)
            {
                removeChild(this._bgImg);
            }
            this._bgImg = Bitmap(this._bgLoader.content);
            this._bgImg.alpha = this.bgImagaAlpha;
            this.resizeBgImg(width,height);
            addChild(this._bgImg);
            this.invalidBgImgVisible();
        }

        private function onBgLoaderIoErrorHandler(param1:IOErrorEvent) : void
        {
            DebugUtils.LOG_ERROR("Cant load browser bitmap: " + this._bitmapUrl);
        }

        public function as_loadingStop() : void
        {
            this._showContentUnderWaiting = true;
            if(this._bgImg)
            {
                this._bgImg.alpha = this.bgImagaAlpha;
            }
            graphics.clear();
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

        private function drawNoTransparencyBG() : void
        {
            graphics.clear();
            graphics.beginFill(0);
            graphics.drawRect(0,0,_width,_height);
            graphics.endFill();
        }

        private function updateServiceViewPos() : void
        {
            this.serviceView.x = width - this.serviceView.width >> 1;
            this.serviceView.y = height - this.serviceView.height >> 1;
        }

        private function resizeBgImg(param1:Number, param2:Number) : void
        {
            if(this._bgImg.width != param1 || this._bgImg.height != param2)
            {
                setBrowserSizeS(param1,param2);
                this._bgImg.width = param1;
                this._bgImg.height = param2;
            }
        }

        private function invalidBgImgVisible() : void
        {
            invalidate(BG_IMG_VISIBLE_INVALID);
        }

        private function get bgImagaAlpha() : Number
        {
            return this._showContentUnderWaiting?1:0;
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
