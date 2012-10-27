import wot.utils.Config;

class wot.TeamBasesPanel.CapConfig
{
    public static function get enabled():Boolean{
        return Config.s_config.captureBar.enabled;
    }
    public static function get primaryTitleFormat():String{
        return Config.s_config.captureBar.primaryTitleFormat;
    }
    public static function get secondaryTitleFormat():String{
        return Config.s_config.captureBar.secondaryTitleFormat;
    }
    public static function get captureDoneFormat():String{
        return Config.s_config.captureBar.captureDoneFormat;
    }
    public static function get extra():String{
        return Config.s_config.captureBar.extra;
    }
    public static function get primaryTitleOffset():Number {
        return Config.s_config.captureBar.primaryTitleOffset;
    }
    
    // Shadow filter style
    public static function get shadowColor():Number {
        return Config.s_config.captureBar.shadow.color;
    }
    public static function get shadowAlpha():Number{
        return Config.s_config.captureBar.shadow.alpha;
    }
    public static function get shadowBlur():Number {
        return Config.s_config.captureBar.shadow.blur;
    }
    public static function get shadowStrength():Number {
        return Config.s_config.captureBar.shadow.strength;
    }
}
