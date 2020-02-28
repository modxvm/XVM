package net.wg.gui.lobby.window
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;

    public class EpicPrimeTime extends PrimeTime
    {

        private static const TITLE_TF_DEF_OFFSET:int = 70;

        private static const TITLE_TF_SMALL_OFFSET:int = 45;

        private static const BREAKPOINT_SMALL_WIDTH:int = 1366;

        public var titleTf:TextField = null;

        public var shadow:MovieClip = null;

        private var _titleText:String = null;

        private var _txtStyle:String = null;

        public function EpicPrimeTime()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._titleText = EPIC_BATTLE.PRIMETIME_TITLE;
            setBackground(RES_ICONS.MAPS_ICONS_EPICBATTLES_PRIMETIME_PRIME_TIME_BACK_DEFAULT);
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
    }
}
