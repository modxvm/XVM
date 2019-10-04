package net.wg.gui.lobby.settings.feedback.damageLog
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class ScreenSizeAlert extends MovieClip implements IDisposable
    {

        public var tf:TextField = null;

        public var alertIcon:UILoaderAlt = null;

        public function ScreenSizeAlert()
        {
            super();
        }

        public final function dispose() : void
        {
            this.alertIcon.dispose();
            this.alertIcon = null;
            this.tf = null;
        }
    }
}
