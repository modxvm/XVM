import com.xvm.Config;

class wot.FinalStatistic.TeamStats extends net.wargaming.hangar.FinalStatistic.TeamStats // gfx.core.UIComponent
{
    function configUI()
    {
        super.configUI();

        // TeamStats recreated every time tab page is changed, so save flag at the parent form class.
		if (parent["__xvm_TeamStats_initialized"])
            return;
        parent["__xvm_TeamStats_initialized"] = true;

        com.xvm.Logger.add("Sort");
        
        var sortInfo;
        switch (Config.s_config.finalStatistic.sortColumn)
        {
            case 1:
                sortInfo = { f1: sqadHead1, f2: sqadHead2, iconType: "squad", sortDirection: "desc" };
                break;
            case 2:
                sortInfo = { f1: playerHead1, f2: playerHead2, iconType: "player", sortDirection: "asc" };
                break;
            case 3:
                sortInfo = { f1: tankHead1, f2: tankHead2, iconType: "tank", sortDirection: "desc" };
                break;
            case 4:
                sortInfo = { f1: damageHead1, f2: damageHead2, iconType: "damage", sortDirection: "desc" };
                break;
            case 5:
                sortInfo = { f1: fragHead1, f2: fragHead2, iconType: "frag", sortDirection: "desc" };
                break;
            case 6:
                sortInfo = { f1: xpHead1, f2: xpHead2, iconType: "xp", sortDirection: "desc" };
                break;
            case 7:
                sortInfo = { f1: medalHead1, f2: medalHead2, iconType: "medal", sortDirection: "desc" };
                break;
            default:
                sortInfo = { f1: xpHead1, f2: xpHead2, iconType: "xp", sortDirection: "desc" };
                break;
        }

        clearHeadersSelection(team1buttons, sortInfo.f1);
        clearHeadersSelection(team2buttons, sortInfo.f2);
        sortInfo.f1.selected = sortInfo.f2.selected = true;
        applySort(sortInfo.iconType, sortInfo.sortDirection);
    }
}
