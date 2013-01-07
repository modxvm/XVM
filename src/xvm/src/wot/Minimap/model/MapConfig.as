import flash.geom.Point;
import wot.utils.Config;

class wot.Minimap.model.MapConfig
{
    public static function get enabled():Boolean    {
        return Config.s_config.minimap.enabled;    }
    public static function get mapAlpha():Number    {
        return Config.s_config.minimap.mapAlpha;    }
    
    public static function get iconScale():Number    {
        return Config.s_config.minimap.iconScale;    }
    
    public static function get nickShrink():Number    {
        return Config.s_config.minimap.nickShrink;    }
        
    public static function get formatAlly():String    {
        return Config.s_config.minimap.format.ally;    }
    public static function get formatEnemy():String    {
        return Config.s_config.minimap.format.enemy;    }
    public static function get formatSquad():String    {
        return Config.s_config.minimap.format.squad;    }
    public static function get formatOneself():String    {
        return Config.s_config.minimap.format.oneself;    }
    public static function get formatLostenemy():String    {
        return Config.s_config.minimap.format.lostenemy;    }
        
    public static function get cssAlly():String    {
        return Config.s_config.minimap.css.ally;    }
    public static function get cssEnemy():String    {
        return Config.s_config.minimap.css.enemy;    }
    public static function get cssSquad():String    {
        return Config.s_config.minimap.css.squad;    }
    public static function get cssOneself():String    {
        return Config.s_config.minimap.css.oneself;    }
    public static function get cssLostenemy():String    {
        return Config.s_config.minimap.css.lostenemy;    }
        
    public static function get labelOffset():Point    {
        return new Point(Config.s_config.minimap.labelOffsetX, Config.s_config.minimap.labelOffsetY); }
        
    /** Lost */
     /** Enabled */
    public static function get lostEnemyEnabled():Boolean    {
        return Config.s_config.minimap.lostEnemy.enabled;    }
     /** Alpha */
    public static function get lostEnemyAlpha():Number    {
        return Config.s_config.minimap.lostEnemy.alpha;    }
     /** Alpha */
    public static function get lostEnemyLabelOffset():Point    {
        return new Point(Config.s_config.minimap.lostEnemy.labelOffsetX, Config.s_config.minimap.lostEnemy.labelOffsetY); }
}