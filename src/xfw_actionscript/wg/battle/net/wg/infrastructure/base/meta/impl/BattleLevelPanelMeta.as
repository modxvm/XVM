package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.data.constants.Errors;

    public class BattleLevelPanelMeta extends BattleDisplayable
    {

        public var onPlaySound:Function;

        public function BattleLevelPanelMeta()
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
