package net.wg.gui.bootcamp.questsView.containers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.bootcamp.questsView.data.BCQuestsViewVO;

    public class MissionContainer extends UIComponentEx
    {

        public var rewardPremium:AnimatedLoaderTextContainer;

        public var rewardGold:AnimatedLoaderTextContainer;

        public var rewardBackground:MovieClip;

        public var btnClose:SoundButtonEx;

        public var txtHeader:TextField;

        public var missionLabel:TextField;

        public var missionCondition:TextField;

        public function MissionContainer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.txtHeader = null;
            this.missionLabel = null;
            this.missionCondition = null;
            this.rewardPremium.dispose();
            this.rewardPremium = null;
            this.rewardBackground = null;
            this.rewardGold.dispose();
            this.rewardGold = null;
            this.btnClose.dispose();
            this.btnClose = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.txtHeader.text = BOOTCAMP.QUEST_TITLE;
            this.missionLabel.text = BOOTCAMP.QUEST_NAME;
            this.missionCondition.text = BOOTCAMP.QUEST_CONDITION;
        }

        public function setData(param1:BCQuestsViewVO) : void
        {
            this.rewardBackground.visible = this.rewardGold.visible = this.rewardPremium.visible = param1.showRewards;
            this.rewardPremium.text = param1.premiumText;
            this.rewardGold.text = param1.goldText;
            this.rewardPremium.source = param1.premiumIcon;
            this.rewardGold.source = param1.goldIcon;
        }
    }
}
