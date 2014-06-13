import com.xvm.Config;

class wot.TeamBasesPanel.CapConfig
{
    private static var ALLY_BASE:String = "red"; // by base owner, not by capturers

    public static function get enabled():Boolean
    {
        return Config.config.captureBar.enabled;
    }

    public static function get allyColor():String
    {
        return Config.config.captureBar.allyColor;
    }

    public static function get enemyColor():String
    {
        return Config.config.captureBar.enemyColor;
    }

    public static function get primaryTitleOffset():Number
    {
        return Config.config.captureBar.primaryTitleOffset;
    }

    public static function get appendPlus():Boolean
    {
        return Config.config.captureBar.appendPlus;
    }

    // -- Team dependent

    public static function primaryTitleFormat(capColor:String):String
    {
        if (capColor == ALLY_BASE)
            return Config.config.captureBar.ally.primaryTitleFormat;
        return Config.config.captureBar.enemy.primaryTitleFormat;
    }

    public static function secondaryTitleFormat(team:String):String
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.secondaryTitleFormat;
        return Config.config.captureBar.enemy.secondaryTitleFormat;
    }

    public static function captureDoneFormat(team:String):String
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.captureDoneFormat;
        return Config.config.captureBar.enemy.captureDoneFormat;
    }

    public static function extra(team:String):String
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.extra;
        return Config.config.captureBar.enemy.extra;
    }


    // -- Shadow filter style

    public static function shadowColor(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.shadow.color;
        return Config.config.captureBar.enemy.shadow.color;
    }

    public static function shadowAlpha(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.shadow.alpha;
        return Config.config.captureBar.enemy.shadow.alpha;
    }

    public static function shadowBlur(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.shadow.blur;
        return Config.config.captureBar.enemy.shadow.blur;
    }

    public static function shadowStrength(team:String):Number
    {
        if (team == ALLY_BASE)
            return Config.config.captureBar.ally.shadow.strength;
        return Config.config.captureBar.enemy.shadow.strength;
    }
}
