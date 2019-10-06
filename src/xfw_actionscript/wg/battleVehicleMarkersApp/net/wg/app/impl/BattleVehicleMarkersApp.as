package net.wg.app.impl
{
    import net.wg.app.iml.base.RootApp;
    import net.wg.infrastructure.base.meta.impl.ClassManagerBattleMarkersMeta;
    import net.wg.infrastructure.interfaces.IRootAppMainContent;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
    import net.wg.data.constants.generated.ROOT_SWF_CONSTANTS;

    public class BattleVehicleMarkersApp extends RootApp
    {

        public static const CLASS_MANAGER_META:Class = ClassManagerBattleMarkersMeta;

        private static const LIBS_LIST:Vector.<String> = new <String>["epicSharedAssets.swf","battleStaticMarkers.swf","battleVehicleMarkers.swf"];

        public function BattleVehicleMarkersApp()
        {
            super(new VehicleMarkersManager(),LIBS_LIST,ROOT_SWF_CONSTANTS.BATTLE_VEHICLE_MARKERS_REGISTER_CALLBACK);
        }

        override protected function onLibsLoadingComplete() : void
        {
            callRegisterCallback();
        }

        public function get vehicleMarkersCanvas() : IRootAppMainContent
        {
            return main;
        }
    }
}
