package net.wg.gui.lobby.personalMissions.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.Image;

    public class PersonalMissionsPlanRegionCheck extends MovieClip implements IDisposable
    {

        public var checkmarkImg:Image = null;

        public function PersonalMissionsPlanRegionCheck()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        private function onDispose() : void
        {
            this.checkmarkImg.dispose();
            this.checkmarkImg = null;
        }
    }
}
