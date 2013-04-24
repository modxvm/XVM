import com.xvm.Config;

class wot.TeamBasesPanel.CapConfig
{
    private static var ALLY_BASE:String = "red"; // by base owner, not by capturers

    public static function get enabled():Boolean
    {
        return Config.s_config.captureBar.enabled;
    }

    public static function get primaryTitleOffset():Number
    {
        return Config.s_config.captureBar.primaryTitleOffset;
    }

    public static function get appendPlus():Boolean
    {
        return Config.s_config.captureBar.appendPlus;
    }

    // -- Team dependent

    public static function primaryTitleFormat(capColor:String):String
    {
        if (capColor == ALLY_BASE)
            return Config.s_config.captureBar.ally.primaryTitleFormat;
        return Config.s_config.captureBar.enemy.primaryTitleFormat;
    }

    public static function secondaryTitleFormat(team:String):String
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.secondaryTitleFormat;
        return Config.s_config.captureBar.enemy.secondaryTitleFormat;
    }

    public static function captureDoneFormat(team:String):String
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.captureDoneFormat;
        return Config.s_config.captureBar.enemy.captureDoneFormat;
    }

    public static function extra(team:String):String
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.extra;
        return Config.s_config.captureBar.enemy.extra;
    }


    // -- Shadow filter style

    public static function shadowColor(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.shadow.color;
        return Config.s_config.captureBar.enemy.shadow.color;
    }

    public static function shadowAlpha(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.shadow.alpha;
        return Config.s_config.captureBar.enemy.shadow.alpha;
    }

    public static function shadowBlur(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.shadow.blur;
        return Config.s_config.captureBar.enemy.shadow.blur;
    }

    public static function shadowStrength(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.s_config.captureBar.ally.shadow.strength;
        return Config.s_config.captureBar.enemy.shadow.strength;
    }
}
