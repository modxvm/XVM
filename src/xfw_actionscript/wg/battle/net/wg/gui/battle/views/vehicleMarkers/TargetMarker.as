package net.wg.gui.battle.views.vehicleMarkers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;

    public class TargetMarker extends MovieClip implements IDisposable
    {

        public var marker:Sprite;

        public function TargetMarker()
        {
            super();
        }

        public final function dispose() : void
        {
            this.marker = null;
        }
    }
}
