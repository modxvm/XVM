import flash.filters.DropShadowFilter;
import flash.geom.Point;
import wot.utils.Config;
import wot.Minimap.MinimapEntry;

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
            return Config.s_config.minimap.labels.nickShrink;    }
        /** Vehicle class macro */
            public static function get lightSymbol():String    {
                return Config.s_config.minimap.labels.vehicleclassmacro.light;    }
            public static function get mediumSymbol():String    {
                return Config.s_config.minimap.labels.vehicleclassmacro.medium;    }
            public static function get heavySymbol():String    {
                return Config.s_config.minimap.labels.vehicleclassmacro.heavy;    }
            public static function get tdSymbol():String    {
                return Config.s_config.minimap.labels.vehicleclassmacro.td;    }
            public static function get spgSymbol():String    {
                return Config.s_config.minimap.labels.vehicleclassmacro.spg;    }
        /** allRevealedUnits */
            public static function get revealedEnabled():Boolean    {
                return Config.s_config.minimap.labels.allRevealedUnits.enabled;    }
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
            /** Shadow */
                public static function unitShadowEnabled(entryType:String):Boolean
                {
                    var shadowObject:Object = unitShadowObject(entryType);
                    return shadowObject.enabled;
                }
                
                public static function unitShadow(entryType:String):DropShadowFilter
                {
                    var shadowObject:Object = unitShadowObject(entryType);
                    return getShadowFilter(shadowObject);
                }
                
                private static function unitShadowObject(entryType:String):Object
                {
                    switch (entryType)
                    {   
                        case MinimapEntry.MINIMAP_ENTRY_TYPE_ALLY:
                            return Config.s_config.minimap.labels.allRevealedUnits.shadow.ally;
                            break;
                        case MinimapEntry.MINIMAP_ENTRY_TYPE_ENEMY:
                            return Config.s_config.minimap.labels.allRevealedUnits.shadow.enemy;
                            break;
                        case MinimapEntry.MINIMAP_ENTRY_TYPE_SQUAD:
                            return Config.s_config.minimap.labels.allRevealedUnits.shadow.squad;
                            break;
                        case MinimapEntry.MINIMAP_ENTRY_TYPE_SELF:
                            return Config.s_config.minimap.labels.allRevealedUnits.shadow.oneself;
                            break;
                        case MinimapEntry.MINIMAP_ENTRY_TYPE_LOST:
                            return Config.s_config.minimap.labels.lostEnemyUnits.shadow;
                            break;
                    }
                    return null;
                }
                    
            public static function get revealedOffset():Point    {
                return new Point(Config.s_config.minimap.labels.allRevealedUnits.offsetX,
                                 Config.s_config.minimap.labels.allRevealedUnits.offsetY); }
             
            
            
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
            /** Shadow */
                public static function get mapSizeLabelShadowEnabled(vehicleClass):Boolean    {
                    return Config.s_config.minimap.labels.mapSize.shadow.enabled;    }
                public static function get mapSizeLabelShadow():DropShadowFilter    {
                    return getShadowFilter(Config.s_config.minimap.labels.mapSize.shadow);    }
            
            public static function get mapSizeLabelWidth():Number    {
                return Config.s_config.minimap.labels.mapSize.width;    }
            public static function get mapSizeLabelHeight():Number    {
                return Config.s_config.minimap.labels.mapSize.height;    }
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
        
    // -- Private
    
    private static function getShadowFilter(of:Object):DropShadowFilter
    {
        return new DropShadowFilter(
            of.distance, // distance
            of.angle, // angle
            parseInt(of.color),
            // DropShadowFilter accepts alpha be from 0 to 1.
            // 90 at default config.
            of.alpha / 100, 
            of.blur,
            of.blur,
            of.strength,
            3 // quality
        )
    }
}
