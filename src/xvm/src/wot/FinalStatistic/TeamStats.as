import wot.utils.Config;
import wot.utils.Locale;

class wot.FinalStatistic.TeamStats extends net.wargaming.hangar.FinalStatistic.TeamStats // gfx.core.UIComponent
{
    function TeamStats()
    {
        super();
        iconTypeToKey.health.key = "damageDealt";
        healthHead1.helpText = healthHead2.helpText = Locale.get("Damage dealt");
    }

    function configUI()
    {
        super.configUI();

        tankHead1.selected = tankHead2.selected = false;

        switch (Config.s_config.finalStatistic.sortColumn)
        {
            case 1:
                sqadHead1.selected = sqadHead2.selected = true;
                this.applySort("squad", "desc");
                break;
            case 2:
                playerHead1.selected = playerHead2.selected = true;
                this.applySort("player", "asc");
                break;
            case 3:
                tankHead1.selected = tankHead2.selected = true;
                this.applySort("tank", "desc");
                break;
            case 4:
                healthHead1.selected = healthHead2.selected = true;
                this.applySort("health", "desc");
                break;
            case 5:
                fragHead1.selected = fragHead2.selected = true;
                this.applySort("frag", "desc");
                break;
            case 6:
                xpHead1.selected = xpHead2.selected = true;
                this.applySort("xp", "desc");
                break;
            case 7:
                medalHead1.selected = medalHead2.selected = true;
                this.applySort("medal", "desc");
                break;
            default:
                xpHead1.selected = xpHead2.selected = true;
                this.applySort("xp", "desc");
                break;
        }
    }
}
