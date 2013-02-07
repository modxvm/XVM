class wot.FinalStatistic.TeamMemberItemRenderer extends net.wargaming.hangar.FinalStatistic.view.TeamMemberItemRenderer
{
    // override
    function draw()
    {
        var dirty = _dataDirty;
        super.draw();
        if (dirty)
        {
            //fragsLbl.text = "0";
            healthLbl.text = data.damageDealt;
        }
    }
}
