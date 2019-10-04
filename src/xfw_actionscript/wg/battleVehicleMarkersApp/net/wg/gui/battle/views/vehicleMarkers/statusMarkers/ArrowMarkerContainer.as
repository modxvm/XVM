package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class ArrowMarkerContainer extends MovieClip implements IDisposable
    {

        public var arrowIcon:MovieClip = null;

        public function ArrowMarkerContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.arrowIcon = null;
        }

        public function updateColorSettings(param1:String) : void
        {
            this.arrowIcon.gotoAndStop(param1);
        }
    }
}
