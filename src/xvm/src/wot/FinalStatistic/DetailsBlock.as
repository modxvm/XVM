import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Locale;
import wot.utils.Utils;

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

        shotsTitle = _createTextField("shotsTitle", xpTitleLbl, 1, "left");
        shotsCount = _createTextField("shotsCount", xpLbl, 1, "right");
        shotsPercent = _createTextField("shotsPercent", premXpLbl, 1, "right");
        damageAssistedTitle = _createTextField("damageAssistedTitle", xpTitleLbl, 2, "left");
        damageAssistedValue = _createTextField("damageAssistedValue", premXpLbl, 2, "right");
        damageTitle = _createTextField("damageTitle", xpTitleLbl, 3, "left");
        damageValue = _createTextField("damageValue", premXpLbl, 3, "right");
    }

    private function _createTextField(name, f, yOffset, align)
    {
        var res = this.createTextField("name", this.getNextHighestDepth(),
            f._x, f._y + f._height * yOffset + 10, f._width, f._height);
        res.antiAliasType = "advanced";
        res.html = true;
        res.autoSize = align; // http://theolagendijk.com/2006/09/07/aligning-htmltext-inside-flash-textfield/
        var tf: TextFormat = f.getNewTextFormat();
        res.styleSheet = Utils.createStyleSheet(Utils.createCSS("xvm_" + name, 
            tf.color, tf.font, tf.size, align, tf.bold, tf.italic));

        return res;
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
            shotsPercent.htmlText = "<span class='xvm_shotsPercent'><font color='#eeeeee'>" + Math.round(pdata.hits / pdata.shots * 100) + "%" + "</font></span>";
            damageAssistedTitle.htmlText = "<span class='xvm_damageAssistedTitle'><font color='#C9C9B6'>" + Locale.get("Damage upon detecting") + "</font></span>";
            damageAssistedValue.htmlText = "<span class='xvm_damageAssistedValue'><font color='#408ccf'>" + dmgAss + "</font></span>";
            damageTitle.htmlText = "<span class='xvm_damageTitle'><font color='#C9C9B6'>" + Locale.get("Damage dealt") + "</font></span>";
            damageValue.htmlText = "<span class='xvm_damageValue'><font color='#ffc133'>" + dmg + "</font></span>";
        }
    }

}
