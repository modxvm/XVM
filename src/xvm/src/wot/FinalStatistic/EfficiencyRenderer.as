class wot.FinalStatistic.EfficiencyRenderer extends net.wargaming.hangar.FinalStatistic.view.EfficiencyRenderer
{
    // override
    function draw()
    {
        var dirty = _dataDirty;
        super.draw();
        
        if (data == null || data.isFake)
            return;

        if (data.damageDealt > 0)
        {
            //damageIcon.iconLabelMc._x = 0;
            //damageIcon.iconLabelMc._width = damageIcon._width;
            //damageIcon.value = data.damageDealt;
        }
        if (data.damageAssisted > 0)
        {
            //evilIcon.iconLabelMc._x = 0;
            //evilIcon.iconLabelMc._width = evilIcon._width;
            //evilIcon.value = data.damageAssisted;
        }
    }
}
