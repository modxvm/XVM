class net.wargaming.ingame.VehicleMarkerEnemy extends wot.XVM
{
    function VehicleMarkerEnemy()
    {
        super();
        this.actionMarker._actionRendererMap["attack"] = "AttackEnemyMarker";
    } // End of the function
} // End of Class
