package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.PlayersPanelBase;
    import net.wg.data.constants.Errors;

    public class EpicRandomPlayersPanelMeta extends PlayersPanelBase
    {

        public var focusedColumnChanged:Function;

        public function EpicRandomPlayersPanelMeta()
        {
            super();
        }

        public function focusedColumnChangedS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.focusedColumnChanged,"focusedColumnChanged" + Errors.CANT_NULL);
            this.focusedColumnChanged(param1);
        }
    }
}
