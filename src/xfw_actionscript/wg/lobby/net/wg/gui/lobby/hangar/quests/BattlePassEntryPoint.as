package net.wg.gui.lobby.hangar.quests
{
    import net.wg.infrastructure.base.meta.impl.BattlePassEntryPointMeta;
    import net.wg.infrastructure.base.meta.IBattlePassEntryPointMeta;
    import scaleform.clik.constants.InvalidationType;

    public class BattlePassEntryPoint extends BattlePassEntryPointMeta implements IBattlePassEntryPointMeta
    {

        private static const BP_ENTRY_POINT_BOTTOM_INDENT:int = 15;

        private static const BP_ENTRY_POINT_SIDE_INDENT:int = 2;

        private static const BP_ENTRY_POINT_MARGIN_X:int = 30;

        private static const BP_ENTRY_POINT_SMALL_WIDTH:int = 100 + BP_ENTRY_POINT_MARGIN_X * 2;

        private static const BP_ENTRY_POINT_SMALL_HEIGHT:int = 120;

        private static const BP_ENTRY_POINT_WIDTH:int = 142 + BP_ENTRY_POINT_MARGIN_X * 2;

        private static const BP_ENTRY_POINT_HEIGHT:int = 160;

        private var _isMouseEnabled:Boolean = true;

        private var _isSmall:Boolean = false;

        public function BattlePassEntryPoint()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            buttonMode = this._isMouseEnabled;
            useHandCursor = this._isMouseEnabled;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                width = (this._isSmall?BP_ENTRY_POINT_SMALL_WIDTH:BP_ENTRY_POINT_WIDTH) + BP_ENTRY_POINT_SIDE_INDENT;
                height = (this._isSmall?BP_ENTRY_POINT_SMALL_HEIGHT:BP_ENTRY_POINT_HEIGHT) + BP_ENTRY_POINT_BOTTOM_INDENT;
            }
        }

        public function as_setIsMouseEnabled(param1:Boolean) : void
        {
            this._isMouseEnabled = param1;
            buttonMode = this._isMouseEnabled;
            useHandCursor = this._isMouseEnabled;
        }

        public function setIsSmallSize(param1:Boolean) : void
        {
            if(this._isSmall != param1)
            {
                this._isSmall = param1;
                invalidateSize();
                validateNow();
                setIsSmallS(this._isSmall);
            }
        }

        public function get marginX() : Number
        {
            return BP_ENTRY_POINT_MARGIN_X;
        }
    }
}
