package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class ProgressCrew extends MovieClip implements IDisposable
    {

        public var iconCrew:UILoaderAlt = null;

        public var iconLevel:UILoaderAlt = null;

        public function ProgressCrew()
        {
            super();
        }

        public final function dispose() : void
        {
            this.iconCrew.dispose();
            this.iconCrew = null;
            this.iconLevel.dispose();
            this.iconLevel = null;
        }

        public function setIcons(param1:String, param2:String) : void
        {
            this.iconCrew.source = param1;
            this.iconLevel.source = param2;
        }
    }
}
