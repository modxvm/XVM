package net.wg.gui.lobby.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;

    public class BaseMissionDetailsBg extends Sprite implements IDisposable
    {

        public var statusBg:MovieClip;

        public function BaseMissionDetailsBg()
        {
            super();
            this.statusBg.gotoAndStop(0);
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function onDispose() : void
        {
            this.statusBg = null;
        }

        public function setStatus(param1:String) : void
        {
            this.statusBg.gotoAndStop(param1);
        }
    }
}
