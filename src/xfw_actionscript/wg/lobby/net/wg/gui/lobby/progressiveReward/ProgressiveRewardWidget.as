package net.wg.gui.lobby.progressiveReward
{
    import net.wg.infrastructure.base.meta.impl.ProgressiveRewardWidgetMeta;
    import net.wg.infrastructure.base.meta.IProgressiveRewardWidgetMeta;
    import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
    import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;

    public class ProgressiveRewardWidget extends ProgressiveRewardWidgetMeta implements IProgressiveRewardWidgetMeta
    {

        public var progressiveReward:ProgressiveReward = null;

        public function ProgressiveRewardWidget()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.progressiveReward.removeEventListener(ProgressiveRewardEvent.LINK_BTN_CLICK,this.onProgressiveRewardLinkBtnClickHandler);
            this.progressiveReward.dispose();
            this.progressiveReward = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.progressiveReward.addEventListener(ProgressiveRewardEvent.LINK_BTN_CLICK,this.onProgressiveRewardLinkBtnClickHandler);
        }

        override protected function setData(param1:ProgressiveRewardVO) : void
        {
            var _loc2_:Boolean = param1.isEnabled;
            dispatchEvent(new ProgressiveRewardEvent(ProgressiveRewardEvent.SWITCH_WIDGET_ENABLED,_loc2_));
            if(_loc2_)
            {
                this.progressiveReward.setData(param1);
            }
        }

        private function onProgressiveRewardLinkBtnClickHandler(param1:ProgressiveRewardEvent) : void
        {
            onWidgetClickS();
        }
    }
}
