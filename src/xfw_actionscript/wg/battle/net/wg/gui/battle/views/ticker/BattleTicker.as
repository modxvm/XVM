package net.wg.gui.battle.views.ticker
{
    import net.wg.gui.components.common.ticker.Ticker;
    import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;

    public class BattleTicker extends Ticker implements IDisplayableComponent
    {

        public function BattleTicker()
        {
            super();
            _isBattle = true;
        }

        public function setCompVisible(param1:Boolean) : void
        {
            visible = param1;
        }
    }
}
