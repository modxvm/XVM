package net.wg.gui.lobby.browser 
{
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.utils.*;
    
    public class BrowserWindow extends net.wg.infrastructure.base.meta.impl.BrowserMeta implements net.wg.infrastructure.base.meta.IBrowserMeta
    {
        public function BrowserWindow()
        {
            super();
            showWindowBg = false;
            return;
        }

        public function as_loadingStart():void
        {
            this.actionBtn.action = net.wg.gui.lobby.browser.BrowserActionBtn.ACTION_LOADING;
            return;
        }

        public function as_loadingStop():void
        {
            this.actionBtn.action = net.wg.gui.lobby.browser.BrowserActionBtn.ACTION_RELOAD;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.title = MENU.BROWSER_WINDOW_TITLE;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.bottom = -8;
            window.contentPadding = loc1;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.actionBtn.dispose();
            this.actionBtn.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.ACTION_LOADING, this.onBtnAction);
            this.actionBtn.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.ACTION_RELOAD, this.onBtnAction);
            this.browserHitArea.dispose();
            this.browserHitArea.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_DOWN, this.onBrowserDown);
            this.browserHitArea.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_UP, this.onBrowserUp);
            this.browserHitArea.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_MOVE, this.onBrowserMove);
            this.browserHitArea.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_IN, this.onBrowserFocusIn);
            this.browserHitArea.removeEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_OUT, this.onBrowserFocusOut);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.actionBtn.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.ACTION_LOADING, this.onBtnAction);
            this.actionBtn.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.ACTION_RELOAD, this.onBtnAction);
            this.browserHitArea.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_DOWN, this.onBrowserDown);
            this.browserHitArea.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_UP, this.onBrowserUp);
            this.browserHitArea.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_MOVE, this.onBrowserMove);
            this.browserHitArea.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_IN, this.onBrowserFocusIn);
            this.browserHitArea.addEventListener(net.wg.gui.lobby.browser.BrowserEvent.BROWSER_FOCUS_OUT, this.onBrowserFocusOut);
            return;
        }

        internal function onBtnAction(arg1:net.wg.gui.lobby.browser.BrowserEvent):void
        {
            browserActionS(arg1.type);
            return;
        }

        internal function onBrowserDown(arg1:net.wg.gui.lobby.browser.BrowserEvent):void
        {
            browserDownS(arg1.mouseX, arg1.mouseY, arg1.delta);
            return;
        }

        internal function onBrowserUp(arg1:net.wg.gui.lobby.browser.BrowserEvent):void
        {
            browserUpS(arg1.mouseX, arg1.mouseY, arg1.delta);
            return;
        }

        internal function onBrowserMove(arg1:net.wg.gui.lobby.browser.BrowserEvent):void
        {
            browserMoveS(arg1.mouseX, arg1.mouseY, arg1.delta);
            return;
        }

        internal function onBrowserFocusIn(arg1:net.wg.gui.lobby.browser.BrowserEvent):void
        {
            onBrowserShowS(false);
            return;
        }

        internal function onBrowserFocusOut(arg1:net.wg.gui.lobby.browser.BrowserEvent):void
        {
            browserFocusOut();
            return;
        }

        public var actionBtn:net.wg.gui.lobby.browser.BrowserActionBtn;

        public var browserHitArea:net.wg.gui.lobby.browser.BrowserHitArea;
    }
}
