package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
    public class VehicleInspireTargetMarker extends VehicleAnimatedStatusBaseMarker
    {

        public var glowContainer:GlowMarkerContainer = null;

        public var arrowContainer:ArrowMarkerContainer = null;

        public function VehicleInspireTargetMarker()
        {
            super();
        }

        override public function onDispose() : void
        {
            this.glowContainer.dispose();
            this.glowContainer = null;
            this.arrowContainer.dispose();
            this.arrowContainer = null;
            super.onDispose();
        }

        override protected function updateColorSettings(param1:uint) : void
        {
            this.glowContainer.updateColorSettings(color);
            this.arrowContainer.updateColorSettings(color);
        }
    }
}
