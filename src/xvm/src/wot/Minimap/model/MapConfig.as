import flash.geom.Point;
import wot.utils.Config;

class wot.Minimap.model.MapConfig
{
    public static function get enabled():Boolean    {
        return Config.s_config.minimap.enabled;    }
    public static function get mapBackgroundImageAlpha():Number    {
        return Config.s_config.minimap.mapBackgroundImageAlpha;    }
    public static function get iconScale():Number    {
        return Config.s_config.minimap.iconScale;    }
    public static function get nickShrink():Number    {
        return Config.s_config.minimap.nickShrink;    }
    
    /** Labels */
        /** allRevealedUnits */
            public static function get revealedEnabled():Boolean    {
                return Config.s_config.minimap.enabled;    }
            /** Format*/
                public static function get formatAlly():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.format.ally;    }
                public static function get formatEnemy():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.format.enemy;    }
                public static function get formatSquad():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.format.squad;    }
                public static function get formatOneself():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.format.oneself;    }
            /** CSS */
                public static function get cssAlly():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.css.ally;    }
                public static function get cssEnemy():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.css.enemy;    }
                public static function get cssSquad():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.css.squad;    }
                public static function get cssOneself():String    {
                    return Config.s_config.minimap.labels.allRevealedUnits.css.oneself;    }
            public static function get revealedOffset():Point    {
                return new Point(Config.s_config.minimap.labelOffsetX,
                                 Config.s_config.minimap.labelOffsetY); }
        /** lostEnemyUnits*/
            public static function get lostEnemyEnabled():Boolean    {
                return Config.s_config.minimap.labels.lostEnemyUnits.enabled;    }
                
            public static function get lostEnemyFormat():String    {
                return Config.s_config.minimap.labels.lostEnemyUnits.format;    } 
                
            public static function get lostEnemyCss():String    {
                return Config.s_config.minimap.labels.lostEnemyUnits.css;    }

            public static function get lostEnemyAlpha():Number    {
                return Config.s_config.minimap.labels.lostEnemyUnits.alpha;    }
            
            public static function get lostEnemyOffset():Point    {
                return new Point(Config.s_config.minimap.labels.lostEnemyUnits.offsetX,
                                 Config.s_config.minimap.labels.lostEnemyUnits.offsetY); }               
            
        /** Map size label */
            public static function get mapSizeLabelEnabled():Boolean    {
                return Config.s_config.minimap.labels.mapSize.enabled;    }
                
            public static function get mapSizeLabelFormat():String    {
                return Config.s_config.minimap.labels.mapSize.format;    }
                
            public static function get mapSizeLabelCss():String    {
                return Config.s_config.minimap.labels.mapSize.css;    }
                
            public static function get mapSizeLabelAlpha():Number    {
                return Config.s_config.minimap.labels.mapSize.alpha;    }
                
            public static function get mapSizeLabelOffset():Point    {
                return new Point(Config.s_config.minimap.labels.mapSize.offsetX,
                                 Config.s_config.minimap.labels.mapSize.offsetY); }   
}
