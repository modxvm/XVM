package net.wg.gui.bootcamp.battleResult.containers.bottomReward
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultsGroup;
    import scaleform.clik.data.DataProvider;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
    import net.wg.data.constants.generated.BOOTCAMP_BATTLE_RESULT_CONSTANTS;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;

    public class BottomRewardContainer extends UIComponentEx
    {

        private static const RENDERER_SPACING:int = 42;

        private static const RENDERER_WIDTH:int = 80;

        private static const REWARD_MARGIN_Y:int = 15;

        public var rewardBgMC:MovieClip = null;

        public var rewardLineMC:MovieClip = null;

        public var reward:AnimatedTextContainer = null;

        public var rewardList:BattleResultsGroup = null;

        private var _data:DataProvider = null;

        public function BottomRewardContainer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.rewardBgMC.visible = false;
            this.rewardLineMC.visible = false;
            this.reward.visible = false;
            this.reward.text = BOOTCAMP.REWARD_LABEL;
            this.reward.textField.autoSize = TextFieldAutoSize.LEFT;
            this.rewardList.addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onRewardListAllRenderersLoadedHandler);
            this.rewardList.layout = new BottomRewardGroupLayout(RENDERER_WIDTH,RENDERER_SPACING);
            this.rewardList.elementId = BOOTCAMP_BATTLE_RESULT_CONSTANTS.REWARD_LIST;
            this.rewardList.itemRendererLinkage = Linkages.BC_BOTTOM_REWARD_RENDERER;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.LAYOUT))
            {
                this.validateLayout();
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.validateDate();
            }
        }

        override protected function onDispose() : void
        {
            this.rewardList.removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onRewardListAllRenderersLoadedHandler);
            this.rewardList.dispose();
            this.rewardList = null;
            this.reward.dispose();
            this.reward = null;
            this.rewardBgMC = null;
            this.rewardLineMC = null;
            this._data = null;
            super.onDispose();
        }

        public function setData(param1:DataProvider) : void
        {
            this._data = param1;
            invalidateData();
        }

        private function validateDate() : void
        {
            this.rewardList.dataProvider = this._data;
            invalidateLayout();
        }

        private function validateLayout() : void
        {
            this.rewardList.x = -this.rewardList.width >> 1;
            this.rewardList.y = this.reward.contentHeight + REWARD_MARGIN_Y >> 0;
        }

        override public function get height() : Number
        {
            return this.rewardList.y + this.rewardList.height >> 0;
        }

        private function onRewardListAllRenderersLoadedHandler(param1:BattleViewEvent) : void
        {
            this.validateLayout();
            this.rewardBgMC.visible = true;
            this.rewardLineMC.visible = true;
            this.reward.visible = true;
            this.rewardList.showAppearAnimation();
            this.play();
        }
    }
}
