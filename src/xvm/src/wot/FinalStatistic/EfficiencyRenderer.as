import com.xvm.Utils;

class wot.FinalStatistic.EfficiencyRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.hangar.FinalStatistic.view.EfficiencyRenderer;
    private var base:net.wargaming.hangar.FinalStatistic.view.EfficiencyRenderer;

    public function EfficiencyRenderer(wrapper:net.wargaming.hangar.FinalStatistic.view.EfficiencyRenderer, base:net.wargaming.hangar.FinalStatistic.view.EfficiencyRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;
        EfficiencyRendererCtor();
    }

    function draw()
    {
        return this.drawImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    function EfficiencyRendererCtor()
    {
        Utils.TraceXvmModule("FinalStatistic");
    }
    
    function drawImpl()
    {
        var dirty = wrapper._dataDirty;
        base.draw();

        if (wrapper.data == null || wrapper.data.isFake)
            return;

        if (wrapper.data.damageDealt > 0)
        {
            //damageIcon.iconLabelMc._x = 0;
            //damageIcon.iconLabelMc._width = damageIcon._width;
            //damageIcon.value = data.damageDealt;
        }
        if (wrapper.data.damageAssisted > 0)
        {
            //evilIcon.iconLabelMc._x = 0;
            //evilIcon.iconLabelMc._width = evilIcon._width;
            //evilIcon.value = data.damageAssisted;
        }
    }
}
