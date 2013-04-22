import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Locale;
import com.xvm.Utils;

class wot.FinalStatistic.DetailsBlock extends net.wargaming.hangar.FinalStatistic.view.DetailsBlock
{
    var shotsTitle: TextField;
    var shotsCount: TextField;
    var shotsPercent: TextField;
    var damageAssistedTitle: TextField;
    var damageAssistedValue: TextField;
    var damageTitle: TextField;
    var damageValue: TextField;

    function DetailsBlock()
    {
        super();

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("DetailsBlock.as");

        var h = xpTitleLbl._height;
        shotsTitle = Utils.duplicateTextField(this, "shotsTitle", xpTitleLbl, h + 10, "left");
        shotsCount = Utils.duplicateTextField(this, "shotsCount", xpLbl, h + 10, "right");
        shotsPercent = Utils.duplicateTextField(this, "shotsPercent", premXpLbl, h + 10, "right");
        damageAssistedTitle = Utils.duplicateTextField(this, "damageAssistedTitle", xpTitleLbl, 2 * h + 10, "left");
        damageAssistedValue = Utils.duplicateTextField(this, "damageAssistedValue", premXpLbl, 2 * h + 10, "right");
        damageTitle = Utils.duplicateTextField(this, "damageTitle", xpTitleLbl, 3 * h + 10, "left");
        damageValue = Utils.duplicateTextField(this, "damageValue", premXpLbl, 3 * h + 10, "right");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        // currently for locale, and other options in the future
    }

    // override
    function draw()
    {
        var dirty = _dataDirty;
        super.draw();
        if (dirty)
        {
            var data = _parent._parent._parent._parent.data;
            var team1 = data.team1;

            var cr = data.personal.creditsData;
            creditsLbl.htmlText = cr[cr.length - 1].col1;
            premCreditsLbl.htmlText = cr[cr.length - 1].col3;

            var pos = 0;
            for (var i = 0; i < 15; ++i)
            {
                if (team1[i].playerName == data.common.playerNameStr)
                {
                    pos = i;
                    break;
                }
            }

            var pdata = team1[pos];
            var dmg = pdata.damageDealt.toString();
            if (pdata.damageDealt >= 1000)
                dmg = dmg.substr(0, dmg.length - 3) + " " + dmg.substr(dmg.length - 3, 3);

            var dmgAss = pdata.damageAssisted.toString();
            if (pdata.damageAssisted >= 1000)
                dmgAss = dmgAss.substr(0, dmgAss.length - 3) + " " + dmgAss.substr(dmgAss.length - 3, 3);

            shotsTitle.htmlText = "<span class='xvm_shotsTitle'><font color='#C9C9B6'>" + Locale.get("Hit percent") + "</font></span>";
            shotsCount.htmlText = "<span class='xvm_shotsCount'><font color='#C9C9B6'>" + pdata.hits + " / " + pdata.shots + "</font></span>";
            shotsPercent.htmlText = "<span class='xvm_shotsPercent'><font color='#eeeeee'>" +
                (pdata.shots > 0 ? Math.round(pdata.hits / pdata.shots * 100, 2) : "0") + "%" + "</font></span>";
            damageAssistedTitle.htmlText = "<span class='xvm_damageAssistedTitle'><font color='#C9C9B6'>" + Locale.get("Damage upon detecting") + "</font></span>";
            damageAssistedValue.htmlText = "<span class='xvm_damageAssistedValue'><font color='#408CCF'>" + dmgAss + "</font></span>";
            damageTitle.htmlText = "<span class='xvm_damageTitle'><font color='#C9C9B6'>" + Locale.get("Damage dealt") + "</font></span>";
            damageValue.htmlText = "<span class='xvm_damageValue'><font color='#FFC133'>" + dmg + "</font></span>";
        }
    }

}
