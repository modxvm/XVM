package net.wg.gui.lobby.eventBrowserScreen
{
    import net.wg.infrastructure.base.meta.impl.EventBrowserScreenMeta;
    import net.wg.infrastructure.base.meta.IEventBrowserScreenMeta;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;

    public class EventBrowserScreen extends EventBrowserScreenMeta implements IEventBrowserScreenMeta
    {

        private static const SMALL_HEIGHT:int = 900;

        private static const SMALL_WIDTH:int = 1500;

        private static const SMALL_PADDING:int = 100;

        private static const FULL_PADDING:int = 150;

        private static const CLOSE_BTN_OFFSET:int = 10;

        public var eventBg:MovieClip = null;

        public var messengerBg:Sprite = null;

        public var dividerLine:MovieClip = null;

        public var divider:MovieClip = null;

        private var _browserPadding:Boolean = false;

        public function EventBrowserScreen()
        {
            super();
        }

        override public function as_loadBrowser() : void
        {
            super.as_loadBrowser();
            addChild(DisplayObject(closeBtn));
            addChild(DisplayObject(this.dividerLine));
            addChild(DisplayObject(this.divider));
        }

        override protected function updateBrowser() : void
        {
            var _loc1_:* = false;
            if(browser != null)
            {
                this.dividerLine.visible = this.divider.visible = this._browserPadding;
                if(this._browserPadding)
                {
                    _loc1_ = _width < SMALL_WIDTH || _height < SMALL_HEIGHT;
                    if(_loc1_)
                    {
                        browser.setSize(_width,_height - SMALL_PADDING);
                        browser.y = SMALL_PADDING;
                    }
                    else
                    {
                        browser.setSize(_width,_height - FULL_PADDING);
                        browser.y = FULL_PADDING;
                    }
                    this.divider.y = this.dividerLine.y = browser.y;
                }
                else
                {
                    browser.setSize(_width,_height);
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.visible = true;
            this.divider.mouseEnabled = this.dividerLine.mouseEnabled = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.eventBg.width = _width;
                this.eventBg.height = _height + this.messengerBg.height;
                this.messengerBg.y = _height;
                this.messengerBg.width = _width;
                closeBtn.validateNow();
                closeBtn.x = width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
                this.dividerLine.width = _width;
                this.divider.x = _width - this.divider.width >> 1;
            }
        }

        override protected function onDispose() : void
        {
            this.messengerBg = null;
            this.dividerLine = null;
            this.divider = null;
            this.eventBg = null;
            super.onDispose();
        }

        public function as_setBrowserPadding(param1:Boolean) : void
        {
            this._browserPadding = param1;
            invalidateSize();
        }
    }
}
