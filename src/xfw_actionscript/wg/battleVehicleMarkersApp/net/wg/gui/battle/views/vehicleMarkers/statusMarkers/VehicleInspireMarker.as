package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
    import flash.text.TextField;

    public class VehicleInspireMarker extends VehicleStunMarker
    {

        public var glowContainer:GlowMarkerContainer = null;

        public function VehicleInspireMarker()
        {
            super();
        }

        override public function onDispose() : void
        {
            var _loc1_:ArrowMarkerContainer = arrowMc as ArrowMarkerContainer;
            if(_loc1_)
            {
                _loc1_.dispose();
            }
            this.glowContainer.dispose();
            this.glowContainer = null;
            super.onDispose();
        }

        override protected function updateColorSettings(param1:uint) : void
        {
            var _loc2_:ArrowMarkerContainer = arrowMc as ArrowMarkerContainer;
            if(_loc2_)
            {
                _loc2_.updateColorSettings(color);
            }
            this.glowContainer.updateColorSettings(color);
            TextField(counterMc.labelTf).textColor = param1;
        }
    }
}
