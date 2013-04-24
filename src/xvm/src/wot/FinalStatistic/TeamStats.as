import com.xvm.Config;
import com.xvm.Utils;

class wot.FinalStatistic.TeamStats
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.hangar.FinalStatistic.TeamStats;
    private var base:net.wargaming.hangar.FinalStatistic.TeamStats;

    public function TeamStats(wrapper:net.wargaming.hangar.FinalStatistic.TeamStats, base:net.wargaming.hangar.FinalStatistic.TeamStats)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("FinalStatistic");
    }

    function configUI()
    {
        return this.configUIImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    function configUIImpl()
    {
        base.configUI();

        // TeamStats recreated every time tab page is changed, so save flag at the parent form class.
        if (wrapper.parent["_xvm_TeamStats_initialized"])
            return;
        wrapper.parent["_xvm_TeamStats_initialized"] = true;

        com.xvm.Logger.add("Sort");

        var sortInfo;
        switch (Config.s_config.finalStatistic.sortColumn)
        {
            case 1:
                sortInfo = { f1: wrapper.sqadHead1, f2: wrapper.sqadHead2, iconType: "squad", sortDirection: "desc" };
                break;
            case 2:
                sortInfo = { f1: wrapper.playerHead1, f2: wrapper.playerHead2, iconType: "player", sortDirection: "asc" };
                break;
            case 3:
                sortInfo = { f1: wrapper.tankHead1, f2: wrapper.tankHead2, iconType: "tank", sortDirection: "desc" };
                break;
            case 4:
                sortInfo = { f1: wrapper.damageHead1, f2: wrapper.damageHead2, iconType: "damage", sortDirection: "desc" };
                break;
            case 5:
                sortInfo = { f1: wrapper.fragHead1, f2: wrapper.fragHead2, iconType: "frag", sortDirection: "desc" };
                break;
            case 6:
                sortInfo = { f1: wrapper.xpHead1, f2: wrapper.xpHead2, iconType: "xp", sortDirection: "desc" };
                break;
            case 7:
                sortInfo = { f1: wrapper.medalHead1, f2: wrapper.medalHead2, iconType: "medal", sortDirection: "desc" };
                break;
            default:
                sortInfo = { f1: wrapper.xpHead1, f2: wrapper.xpHead2, iconType: "xp", sortDirection: "desc" };
                break;
        }

        wrapper.clearHeadersSelection(wrapper.team1buttons, sortInfo.f1);
        wrapper.clearHeadersSelection(wrapper.team2buttons, sortInfo.f2);
        sortInfo.f1.selected = sortInfo.f2.selected = true;
        wrapper.applySort(sortInfo.iconType, sortInfo.sortDirection);
    }
}
