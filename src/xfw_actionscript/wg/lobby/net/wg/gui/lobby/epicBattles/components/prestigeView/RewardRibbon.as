package net.wg.gui.lobby.epicBattles.components.prestigeView
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.components.AwardItemRendererEx;
    import net.wg.gui.lobby.epicBattles.components.EpicBattlesMetaLevel;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
    import net.wg.gui.lobby.epicBattles.data.EpicMetaLevelIconVO;

    public class RewardRibbon extends UIComponentEx
    {

        private static const SHOW_RIBBON_STATE:String = "showRibbon";

        private static const SHOW_AWARD_TEMPLATE_STATE:String = "showAward";

        private static const END_FRAME:int = 33;

        private static const EPIC_META_LEVEL_SIZE:int = 190;

        private static const RIBBON_RED_GOLD_LABEL:String = "red_gold";

        public var award1:AwardItemRendererEx = null;

        public var award2:AwardItemRendererEx = null;

        public var award3:AwardItemRendererEx = null;

        public var award4:AwardItemRendererEx = null;

        public var award5:AwardItemRendererEx = null;

        public var award6:AwardItemRendererEx = null;

        public var epicMetaLevelRegular:EpicBattlesMetaLevel = null;

        public var glow:MovieClip = null;

        public var ribbon:MovieClip = null;

        private var _awards:Vector.<AwardItemRendererEx> = null;

        private var _awardCount:int = 0;

        private var _maxAwardCount:int = 2147483647;

        private var _state:String = "";

        public function RewardRibbon()
        {
            super();
            addFrameScript(END_FRAME,this.onShowRibbonAnimationComplete);
        }

        override protected function onBeforeDispose() : void
        {
            stop();
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            stop();
            addFrameScript(END_FRAME,null);
            if(this.award1)
            {
                this.award1.dispose();
                this.award1 = null;
            }
            if(this.award2)
            {
                this.award2.dispose();
                this.award2 = null;
            }
            if(this.award3)
            {
                this.award3.dispose();
                this.award3 = null;
            }
            if(this.award4)
            {
                this.award4.dispose();
                this.award4 = null;
            }
            if(this.award5)
            {
                this.award5.dispose();
                this.award5 = null;
            }
            if(this.award6)
            {
                this.award6.dispose();
                this.award6 = null;
            }
            this.epicMetaLevelRegular.dispose();
            this.epicMetaLevelRegular = null;
            this.glow = null;
            this.ribbon = null;
            this._awards.splice(0,this._awards.length);
            this._awards = null;
            super.onDispose();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._awards = new <AwardItemRendererEx>[this.award1,this.award2,this.award3,this.award4,this.award5,this.award6];
            this._maxAwardCount = this._awards.length;
        }

        public function setAwards(param1:Vector.<AwardItemRendererExVO>) : void
        {
            this._awardCount = Math.min(param1.length,this._maxAwardCount);
            var _loc2_:* = 0;
            while(_loc2_ < this._awardCount)
            {
                this._awards[_loc2_].setData(param1[_loc2_]);
                _loc2_++;
            }
            if(param1.length > this._maxAwardCount)
            {
                App.utils.asserter.assert(false,"Too many awards");
            }
        }

        public function setLevel(param1:EpicMetaLevelIconVO, param2:Boolean = false) : void
        {
            this.epicMetaLevelRegular.setIconSize(EPIC_META_LEVEL_SIZE);
            this.epicMetaLevelRegular.setData(param1);
            this.glow.visible = param2;
            if(param2)
            {
                this.ribbon.gotoAndStop(RIBBON_RED_GOLD_LABEL);
            }
        }

        public function show() : void
        {
            this.setState(SHOW_RIBBON_STATE);
        }

        private function onShowRibbonAnimationComplete() : void
        {
            if(this._awardCount > 0)
            {
                this.setState(SHOW_AWARD_TEMPLATE_STATE + this._awardCount.toString());
            }
        }

        private function setState(param1:String) : void
        {
            if(param1 == this._state)
            {
                return;
            }
            this._state = param1;
            gotoAndPlay(param1);
        }
    }
}
