class wot.FinalStatistic.TeamStats extends net.wargaming.hangar.FinalStatistic.TeamStats // gfx.core.UIComponent
{
    function TeamStats()
    {
        super();
        iconTypeToKey.health.key = "damageDealt";
    }

    function configUI()
    {
        super.configUI();
        tankHead1.selected = tankHead2.selected = false;
        healthHead1.selected = healthHead1.selected = true;
        this.applySort("health", "desc");
        //this.applySort("xp", "desc");
    }
}
