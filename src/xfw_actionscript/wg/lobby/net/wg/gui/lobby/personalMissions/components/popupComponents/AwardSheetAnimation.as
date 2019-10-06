package net.wg.gui.lobby.personalMissions.components.popupComponents
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class AwardSheetAnimation extends MovieClip implements IDisposable
    {

        private static const ANIMATION_FRAME:String = "animation";

        public var icon:UILoaderAlt;

        public function AwardSheetAnimation()
        {
            super();
            mouseEnabled = mouseChildren = false;
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function playAnimation() : void
        {
            this.clearIcon();
            gotoAndPlay(ANIMATION_FRAME);
        }

        public function setIcon(param1:String) : void
        {
            this.icon.source = param1;
        }

        protected function onDispose() : void
        {
            this.clearIcon();
        }

        private function clearIcon() : void
        {
            if(this.icon)
            {
                this.icon.dispose();
                this.icon = null;
            }
        }
    }
}
