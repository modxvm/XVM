package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
    public class VehiclePowerUpMarker extends VehicleAnimatedStatusBaseMarker
    {

        public function VehiclePowerUpMarker()
        {
            super();
        }

        override public function hideEffectTimer(param1:Boolean = false) : void
        {
            gotoAndPlay(STATE_HIDE);
        }
    }
}
