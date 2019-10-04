package net.wg.gui.battle.views.epicRandomScorePanel.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;

    public class ERScoreHealthBar extends UIComponentEx
    {

        private static const PERCENTAGE_TO_FRAME_MULTIPLIER:Number = 2;

        private static const ENEMY_COLORBLIND_SCHEME:String = "enemy_colorblind";

        private static const ENEMY_DEFAULT_SCHEME:String = "enemy";

        private static const ALLY_DEFAULT_SCHEME:String = "ally";

        public var hpBar:MovieClip = null;

        public var background:MovieClip = null;

        public function ERScoreHealthBar()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.hpBar = null;
            this.background = null;
            super.onDispose();
        }

        public function setHealth(param1:int) : void
        {
            var _loc2_:int = (param1 * PERCENTAGE_TO_FRAME_MULTIPLIER >> 0) + 1;
            this.hpBar.gotoAndStop(_loc2_);
        }

        public function setColor(param1:Boolean, param2:Boolean) : void
        {
            if(param1)
            {
                gotoAndStop(ALLY_DEFAULT_SCHEME);
            }
            else
            {
                gotoAndStop(param2?ENEMY_COLORBLIND_SCHEME:ENEMY_DEFAULT_SCHEME);
            }
        }
    }
}
