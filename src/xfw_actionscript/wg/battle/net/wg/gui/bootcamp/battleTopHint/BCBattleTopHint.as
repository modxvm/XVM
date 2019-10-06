package net.wg.gui.bootcamp.battleTopHint
{
    import net.wg.infrastructure.base.meta.impl.BCBattleTopHintMeta;
    import net.wg.infrastructure.base.meta.IBCBattleTopHintMeta;
    import net.wg.gui.bootcamp.battleTopHint.containers.HintContainer;
    import scaleform.clik.motion.Tween;

    public class BCBattleTopHint extends BCBattleTopHintMeta implements IBCBattleTopHintMeta
    {

        private static const BACKGROUND_POSITION_Y:int = 69;

        private static const FRAME_COMPLETE_FINISH:int = 141;

        private static const FRAME_SHOW_FINISH:int = 65;

        public var hintContainer:HintContainer = null;

        private var _tween:Tween;

        public function BCBattleTopHint()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.hintContainer.addFrameScript(FRAME_COMPLETE_FINISH,this.animFinishHandler);
            this.hintContainer.addFrameScript(FRAME_SHOW_FINISH,this.animFinishHandler);
        }

        override protected function onDispose() : void
        {
            this.hintContainer.addFrameScript(FRAME_COMPLETE_FINISH,null);
            this.hintContainer.addFrameScript(FRAME_SHOW_FINISH,null);
            this.hintContainer.dispose();
            this.hintContainer = null;
            this.disposeTween();
            super.onDispose();
        }

        public function as_closeHint() : void
        {
            if(this.hintContainer)
            {
                this.hintContainer.closeHint();
                animFinishS();
            }
        }

        public function as_hideHint() : void
        {
            this.hintContainer.hideHint();
            this.updateStage(App.appWidth,App.appHeight);
        }

        public function as_showHint(param1:int, param2:String, param3:Boolean) : void
        {
            this.hintContainer.showHint(param1,param2,param3);
            this.updateStage(App.appWidth,App.appHeight);
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this.hintContainer.x = param1 >> 1;
            this.hintContainer.y = BACKGROUND_POSITION_Y;
            this.hintContainer.updateStage(param1,param2);
        }

        private function animFinishHandler() : void
        {
            animFinishS();
            this.hintContainer.stop();
        }

        private function disposeTween() : void
        {
            if(this._tween != null)
            {
                this._tween.paused = true;
                this._tween.dispose();
                this._tween = null;
            }
        }
    }
}
