package net.wg.gui.lobby.window
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    import scaleform.clik.constants.InvalidationType;

    public class EpicPrimeTime extends PrimeTime
    {

        private static const TITLE_TF_OFFSET:int = 30;

        private static const TITLE_TF_ALPHA:Number = 0.05;

        private static const TITLE_TF_DEFAULT_SIZE:int = 160;

        private static const TITLE_TF_SMALL_SIZE:int = 110;

        private static const BREAKPOINT_WIDTH:int = 1600;

        private static const BREAKPOINT_HEIGHT:int = 900;

        public var titleTf:TextField = null;

        private var _titleFormat:TextFormat = null;

        public function EpicPrimeTime()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleTf.alpha = TITLE_TF_ALPHA;
            this.titleTf.text = EPIC_BATTLE.PRIMETIME_TITLE;
            this._titleFormat = this.titleTf.getTextFormat();
            setBackground(RES_ICONS.MAPS_ICONS_EPICBATTLES_PRIMETIME_PRIME_TIME_BACK_DEFAULT);
        }

        override protected function onDispose() : void
        {
            this.titleTf = null;
            this._titleFormat = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.titleTf.x = 0;
                this.titleTf.y = TITLE_TF_OFFSET;
                this.titleTf.width = width;
                this._titleFormat.size = width < BREAKPOINT_WIDTH || height < BREAKPOINT_HEIGHT?TITLE_TF_SMALL_SIZE:TITLE_TF_DEFAULT_SIZE;
                this.titleTf.setTextFormat(this._titleFormat);
            }
        }
    }
}
