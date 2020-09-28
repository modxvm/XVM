package net.wg.gui.battle.views.minimap.components.entries.WT
{
    import net.wg.gui.battle.components.BattleUIComponent;

    public class WaveSpawnFlashMinimapEntry extends BattleUIComponent
    {

        private const _START_ANIMATION_FRAME:Number = 1;

        public function WaveSpawnFlashMinimapEntry()
        {
            super();
        }

        public function playAnimation() : void
        {
            gotoAndPlay(this._START_ANIMATION_FRAME);
        }
    }
}
