package net.wg.gui.bootcamp.containers
{
    import net.wg.infrastructure.base.meta.impl.BCBattleResultTransitionMeta;
    import net.wg.gui.bootcamp.interfaces.IBCBattleResultTransition;
    import flash.text.TextField;

    public class BCBattleResultTransition extends BCBattleResultTransitionMeta implements IBCBattleResultTransition
    {

        private static const SMALL_SCALE:Number = 0.78;

        private static const POSITION_PERCENT:Number = 0.1;

        private static const SMALL_STAGE_HEIGHT:int = 1000;

        public var textField:TextField = null;

        public function BCBattleResultTransition()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.textField = null;
            super.onDispose();
        }

        public function as_msgTypeHandler(param1:String) : void
        {
            this.textField.htmlText = param1;
        }

        public function as_updateStage(param1:int, param2:int) : void
        {
            this.textField.y = POSITION_PERCENT * param2 >> 0;
            if(param2 <= SMALL_STAGE_HEIGHT)
            {
                this.textField.scaleX = this.textField.scaleY = SMALL_SCALE;
            }
            this.textField.x = param1 - this.textField.width >> 1;
        }
    }
}
