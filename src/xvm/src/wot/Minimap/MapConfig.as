import wot.utils.Config;

class wot.Minimap.MapConfig
{
    public static function get iconScale():Number
    {
        return Config.s_config.minimap.iconScale;
    }
    
    public static function get isDeadPermanent():Boolean
    {
        return Config.s_config.minimap.isDeadPermanent;
    }
}