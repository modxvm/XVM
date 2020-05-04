package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPointsVO;
    import net.wg.data.constants.Values;
    import flash.events.MouseEvent;

    public class ResultPointsBonusAnim extends ResultPointsAnim
    {

        private static const ICON_OFFSET_MIN:int = 20;

        public var iconContainer:AnimatedLoaderTextContainer = null;

        public var modifierBgFx:MovieClip = null;

        public var modifierBg:MovieClip = null;

        private var _data:ResultPointsVO;

        public function ResultPointsBonusAnim()
        {
            super();
        }

        override public function setSizeFrame(param1:int) : void
        {
            super.setSizeFrame(param1);
            if(_disposed)
            {
                return;
            }
            this.iconContainer.icon.x = param1 == 1?Values.ZERO:ICON_OFFSET_MIN;
            this.modifierBgFx.gotoAndStop(param1);
            if(_disposed)
            {
                return;
            }
            this.modifierBg.gotoAndStop(param1);
        }

        override public function appearBonus() : void
        {
            super.appearBonus();
            if(_disposed)
            {
                return;
            }
            playIncrease(this._data.withoutBonus,this._data.points);
        }

        override public function appear() : void
        {
            super.appear();
            playIncrease(Values.ZERO,this._data.withoutBonus);
        }

        override public function immediateAppear() : void
        {
            super.immediateAppear();
            points.text = getPlusText(this._data.points);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.iconContainer.addEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
            this.iconContainer.addEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
        }

        override public function setData(param1:ResultPointsVO) : void
        {
            super.setData(param1);
            this._data = param1;
            this.iconContainer.source = param1.bonusIcon;
        }

        override protected function onDispose() : void
        {
            this.iconContainer.removeEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
            this.iconContainer.removeEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
            this.iconContainer.dispose();
            this.iconContainer = null;
            this.modifierBgFx = null;
            this.modifierBg = null;
            this._data = null;
            super.onDispose();
        }

        private function onIconRollOverHandler(param1:MouseEvent) : void
        {
            showTooltip();
        }

        private function onIconRollOutHandler(param1:MouseEvent) : void
        {
            hideTooltip();
        }
    }
}
