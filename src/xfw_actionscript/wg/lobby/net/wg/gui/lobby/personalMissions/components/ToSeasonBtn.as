package net.wg.gui.lobby.personalMissions.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.Sprite;

    public class ToSeasonBtn extends SoundButtonEx
    {

        public var imageSeason:Sprite = null;

        public function ToSeasonBtn()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.imageSeason = null;
            super.onDispose();
        }
    }
}
