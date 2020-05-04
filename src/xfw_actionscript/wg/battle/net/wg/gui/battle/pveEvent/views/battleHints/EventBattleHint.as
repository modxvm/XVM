package net.wg.gui.battle.pveEvent.views.battleHints
{
    import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
    import net.wg.infrastructure.base.meta.IBattleHintMeta;
    import net.wg.gui.battle.pveEvent.views.battleHints.data.HintInfoVO;

    public class EventBattleHint extends BattleHintMeta implements IBattleHintMeta
    {

        public var hintContainer:InfoContainer = null;

        public function EventBattleHint()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.hintContainer.dispose();
            this.hintContainer = null;
            super.onDispose();
        }

        public function as_closeHint() : void
        {
            this.hintContainer.hideHint();
        }

        public function as_hideHint() : void
        {
            this.hintContainer.hideHint();
        }

        override protected function showHint(param1:String, param2:HintInfoVO) : void
        {
            this.hintContainer.showHint(param1,param2);
            this.updateStage(App.appWidth,App.appHeight);
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this.hintContainer.x = param1 >> 1;
        }
    }
}
