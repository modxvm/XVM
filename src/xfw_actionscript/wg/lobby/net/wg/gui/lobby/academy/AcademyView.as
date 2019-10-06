package net.wg.gui.lobby.academy
{
    import net.wg.infrastructure.base.meta.impl.AcademyViewMeta;
    import net.wg.infrastructure.base.meta.IAcademyViewMeta;
    import net.wg.gui.lobby.browser.Browser;
    import net.wg.gui.components.common.waiting.Waiting;
    import net.wg.gui.components.windows.ScreenBg;
    import net.wg.data.Aliases;
    import scaleform.clik.constants.InvalidationType;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import net.wg.gui.lobby.browser.events.BrowserEvent;
    import scaleform.clik.events.InputEvent;

    public class AcademyView extends AcademyViewMeta implements IAcademyViewMeta
    {

        public var browser:Browser = null;

        public var waiting:Waiting = null;

        public var screenBg:ScreenBg = null;

        public function AcademyView()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            setSize(param1,param2);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.browser,Aliases.BROWSER);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.browser.setSize(_width,_height);
                this.waiting.setSize(_width,_height);
                this.screenBg.setSize(_width,_height);
            }
        }

        override protected function onDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.removeEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
            this.browser = null;
            this.waiting.dispose();
            this.waiting = null;
            this.screenBg.dispose();
            this.screenBg = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.waiting.setMessage(WAITING.LOADCONTENT);
            this.waiting.setSize(_width,_height);
            this.waiting.show();
            this.screenBg.setSize(_width,_height);
            this.browser.addEventListener(BrowserEvent.LOADING_STARTED,this.onBrowserLoadingStartedHandler);
            this.browser.addEventListener(BrowserEvent.LOADING_STOPPED,this.onBrowserLoadingStoppedHandler);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler,true);
        }

        private function onEscapeKeyUpHandler(param1:InputEvent) : void
        {
            closeViewS();
        }

        private function onBrowserLoadingStartedHandler(param1:BrowserEvent) : void
        {
            this.waiting.show();
        }

        private function onBrowserLoadingStoppedHandler(param1:BrowserEvent) : void
        {
            this.waiting.hide();
        }
    }
}
