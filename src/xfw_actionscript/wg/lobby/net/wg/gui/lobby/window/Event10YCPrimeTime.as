package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.Event10YCPrimeTimeMeta;
    import net.wg.infrastructure.base.meta.IEvent10YCPrimeTimeMeta;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;

    public class Event10YCPrimeTime extends Event10YCPrimeTimeMeta implements IEvent10YCPrimeTimeMeta
    {

        private static const TITLE_TF_DEF_OFFSET:int = 70;

        private static const TITLE_TF_SMALL_OFFSET:int = 45;

        private static const BREAKPOINT_SMALL_WIDTH:int = 1366;

        public var titleTf:TextField = null;

        public var shadow:MovieClip = null;

        private var _titleText:String = "";

        private var _txtStyle:String = "";

        private var _backgroundSrc:String = "";

        public function Event10YCPrimeTime()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.titleTf = null;
            this.shadow = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.titleTf.x = 0;
                this.titleTf.width = width;
                this.shadow.width = width;
                this.shadow.height = height;
                if(width <= BREAKPOINT_SMALL_WIDTH)
                {
                    _loc1_ = TEXT_MANAGER_STYLES.HERO_TITLE;
                    this.titleTf.y = TITLE_TF_SMALL_OFFSET;
                }
                else
                {
                    _loc1_ = TEXT_MANAGER_STYLES.EPIC_TITLE;
                    this.titleTf.y = TITLE_TF_DEF_OFFSET;
                }
                if(this._txtStyle != _loc1_)
                {
                    this._txtStyle = _loc1_;
                    this.titleTf.htmlText = App.textMgr.getTextStyleById(_loc1_,this._titleText);
                }
            }
        }

        public function as_setTitle(param1:String) : void
        {
            if(param1 != this._titleText)
            {
                this._titleText = param1;
                invalidateData();
            }
        }

        public function as_setBg(param1:String) : void
        {
            if(param1 != this._backgroundSrc)
            {
                this._backgroundSrc = param1;
                setBackground(this._backgroundSrc);
            }
        }
    }
}
