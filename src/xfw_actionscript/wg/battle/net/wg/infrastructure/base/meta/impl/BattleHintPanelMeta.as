package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.data.constants.Errors;

    public class BattleHintPanelMeta extends BattleDisplayable
    {

        public var onPlaySound:Function;

        public function BattleHintPanelMeta()
        {
            super();
        }

        public function onPlaySoundS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onPlaySound,"onPlaySound" + Errors.CANT_NULL);
            this.onPlaySound(param1);
        }
    }
}
