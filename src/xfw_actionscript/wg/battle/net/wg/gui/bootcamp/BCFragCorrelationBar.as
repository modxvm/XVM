package net.wg.gui.bootcamp
{
    import net.wg.infrastructure.base.meta.impl.BCFragCorrelationBarMeta;
    import net.wg.gui.battle.random.views.fragCorrelationBar.VehicleMarkersList;
    import flash.display.MovieClip;

    public class BCFragCorrelationBar extends BCFragCorrelationBarMeta
    {

        public function BCFragCorrelationBar()
        {
            super();
        }

        override protected function createVehicleMarkersLists(param1:MovieClip, param2:Boolean, param3:String) : VehicleMarkersList
        {
            return new BCVehicleMarkersList(param1,param2,param3);
        }

        public function as_showHint() : void
        {
            BCVehicleMarkersList(enemyVehicleMarkersList).showHint();
            BCVehicleMarkersList(allyVehicleMarkersList).showHint();
        }
    }
}
