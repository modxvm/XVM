import flash.geom.Point;
import wot.utils.Config;

class wot.Minimap.model.externalProxy.MapConfig
{
    public static function get enabled():Boolean    {
        return Config.s_config.minimap.enabled;    }
    public static function get mapBackgroundImageAlpha():Number    {
        return Config.s_config.minimap.mapBackgroundImageAlpha;    }
    public static function get selfIconAlpha():Number    {
        return Config.s_config.minimap.selfIconAlpha;    }
    public static function get cameraAlpha():Number    {
        return Config.s_config.minimap.cameraAlpha;    }
    public static function get markerScale():Number    {
        return Config.s_config.minimap.markerScale;    }
   
    /** Labels */
        public static function get nickShrink():Number    {
        return Config.s_config.minimap.nickShrink;    }
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
     /** Circles */
        public static function get circlesEnabled():Boolean     {
            return Config.s_config.minimap.circles.enabled
        }
        public static function get circlesMajor():Array     {
            return Config.s_config.minimap.circles.major
        }
        public static function get circlesSpecial():Array     {
            return Config.s_config.minimap.circles.special
        }
        
    /** Lines */
        public static function get linesEnabled():Boolean     {
            return Config.s_config.minimap.lines.enabled
        }
        public static function get linesVehicle():Array     {
            return Config.s_config.minimap.lines.vehicle
        }
        public static function get linesCamera():Array     {
            return Config.s_config.minimap.lines.camera
        }
        public static function get linesTraverseAngle():Array     {
            return Config.s_config.minimap.lines.traverseAngle
        }
}
