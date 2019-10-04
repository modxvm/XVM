package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class GlowMarkerContainer extends MovieClip implements IDisposable
    {

        public var glowBgMc:MovieClip = null;

        public function GlowMarkerContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.glowBgMc = null;
        }

        public function updateColorSettings(param1:String) : void
        {
            this.glowBgMc.gotoAndStop(param1);
        }
    }
}
