class wot.FinalStatistic.TeamStats extends net.wargaming.hangar.FinalStatistic.TeamStats // gfx.core.UIComponent
{
    function configUI()
    {
        super.configUI();
        tankHead1.selected = tankHead2.selected = false;
        xpHead1.selected = xpHead2.selected = true;
        this.applySort("xp", "desc");
    }
}
