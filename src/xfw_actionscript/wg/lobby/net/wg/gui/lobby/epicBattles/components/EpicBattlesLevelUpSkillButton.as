package net.wg.gui.lobby.epicBattles.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;

    public class EpicBattlesLevelUpSkillButton extends SoundButtonEx
    {

        public var upgradeIcon:MovieClip = null;

        public function EpicBattlesLevelUpSkillButton()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.upgradeIcon = null;
            super.onDispose();
        }
    }
}
