package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendrerVO;
    import net.wg.gui.bootcamp.battleResult.data.RewardDataVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;

    public class RewardStatsContainer extends UIComponentEx implements IDisposable
    {

        private static const ICONS_SPACING:int = 42;

        private static const ICON_OFFSET_X:int = 60;

        private static const START_ANIMATION_FRAME:int = 2;

        public var expIcon:RewardStatContainer = null;

        public var expValue:RewardStatContainer = null;

        public var silverValue:RewardStatContainer = null;

        public var silverIcon:RewardStatContainer = null;

        private var _silverData:BattleItemRendrerVO;

        private var _expData:BattleItemRendrerVO;

        private var _premData:BattleItemRendrerVO;

        private var _silverRewardData:RewardDataVO;

        private var _expRewardData:RewardDataVO;

        public function RewardStatsContainer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.silverValue.addFrameScript(this.silverValue.totalFrames - 1,this.onAnimationSilverComplete);
            this.expValue.addFrameScript(this.expValue.totalFrames - 1,this.onAnimationExpComplete);
            this._silverData = new BattleItemRendrerVO({
                "label":BOOTCAMP.MESSAGE_CREDITS_LABEL,
                "description":BOOTCAMP.MESSAGE_CREDITS_TEXT,
                "iconTooltip":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_TOOLTIPS_BCCREDITS
            });
            this._expData = new BattleItemRendrerVO({
                "label":BOOTCAMP.MESSAGE_EXPERIENCE_LABEL,
                "description":BOOTCAMP.MESSAGE_EXPERIENCE_TEXT,
                "iconTooltip":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_TOOLTIPS_BCEXP
            });
            this._premData = new BattleItemRendrerVO({
                "label":BOOTCAMP.MESSAGE_PREMIUM_LABEL,
                "description":BOOTCAMP.MESSAGE_PREMIUM_TEXT,
                "iconTooltip":RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_TOOLTIPS_BCPREMIUM
            });
            this.expIcon.setTipData(this._expData);
            this.expValue.setTipData(this._expData);
            this.silverIcon.setTipData(this._silverData);
            this.silverValue.setTipData(this._silverData);
            mouseEnabled = mouseChildren = false;
        }

        override protected function onDispose() : void
        {
            this.silverValue.addFrameScript(this.silverValue.totalFrames - 1,null);
            this.expValue.addFrameScript(this.expValue.totalFrames - 1,null);
            this.expIcon.dispose();
            this.expValue.dispose();
            this.silverValue.dispose();
            this.silverIcon.dispose();
            this.expIcon = null;
            this.expValue = null;
            this.silverIcon = null;
            this.silverValue = null;
            this._premData.dispose();
            this._premData = null;
            this._silverData.dispose();
            this._silverData = null;
            this._expData.dispose();
            this._expData = null;
            this._expRewardData = null;
            this._silverRewardData = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._silverRewardData && this._expRewardData && isInvalid(InvalidationType.DATA))
            {
                this.silverValue.text = this._silverRewardData.str;
                this.expValue.text = this._expRewardData.str;
                this.silverValue.x = this.silverValue.contentWidth;
                this.silverIcon.x = this.silverValue.x + ICONS_SPACING >> 0;
                this.expValue.x = this.silverIcon.x + ICON_OFFSET_X + this.expValue.contentWidth >> 0;
                this.expIcon.x = Math.round(this.expValue.x + ICONS_SPACING);
                x = -(this.expIcon.x + (this.expIcon.width >> 1)) >> 1;
            }
        }

        public function appear() : void
        {
            this.showCreditsAnimation();
            this.showExpAnimation();
        }

        public function setAwardValues(param1:RewardDataVO, param2:RewardDataVO) : void
        {
            this._silverRewardData = param1;
            this._expRewardData = param2;
            invalidateData();
        }

        public function showCreditsAnimation() : void
        {
            this.silverIcon.gotoAndPlay(START_ANIMATION_FRAME);
            this.silverValue.gotoAndPlay(START_ANIMATION_FRAME);
        }

        public function showExpAnimation() : void
        {
            this.expIcon.gotoAndPlay(START_ANIMATION_FRAME);
            this.expValue.gotoAndPlay(START_ANIMATION_FRAME);
        }

        private function onAnimationExpComplete() : void
        {
            this.expValue.stop();
            this.expValue.addFrameScript(this.expValue.totalFrames - 1,null);
            mouseEnabled = mouseChildren = true;
            dispatchEvent(new BattleViewEvent(BattleViewEvent.ANIMATIONS_QUEUE_COMPLETE));
        }

        private function onAnimationSilverComplete() : void
        {
            this.silverValue.stop();
            this.silverValue.addFrameScript(this.silverValue.totalFrames - 1,null);
        }
    }
}
