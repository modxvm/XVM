import com.xvm.Utils;
import flash.geom.Point;
import com.xvm.Config;
import flash.filters.DropShadowFilter;

class wot.Minimap.model.externalProxy.MapConfig
{
    public static function get enabled():Boolean    {
        return minimap.enabled;        }
    public static function get mapBackgroundImageAlpha():Number    {
        return minimap.mapBackgroundImageAlpha;    }
    public static function get selfIconAlpha():Number    {
        return minimap.selfIconAlpha;  }
    public static function get cameraAlpha():Number    {
        return minimap.cameraAlpha;    }
    public static function get iconScale():Number    {
        return minimap.iconScale;    }

    /** Zoom */
        public static function get zoomEnabled():Boolean    {
            return Config.s_config.hotkeys.minimapZoom.enabled;        }
        public static function get zoomHold():Boolean    {
            return Config.s_config.hotkeys.minimapZoom.onHold;        }
        public static function get zoomKey():Number    {
            return Config.s_config.hotkeys.minimapZoom.keyCode;        }
        public static function get zoomCentered():Boolean    {
            return minimap.zoom.centered;        }
        public static function get zoomPixelsBack():Number    {
            return minimap.zoom.pixelsBack;        }
    
    /** Labels */
        public static function get nickShrink():Number    {
            return labels.nickShrink;    }
        /** Vehicle class macro */
            public static function get lightSymbol():String    {
                return vehicleclassmacro.light; }
            public static function get mediumSymbol():String    {
                return vehicleclassmacro.medium;}
            public static function get heavySymbol():String    {
                return vehicleclassmacro.heavy; }
            public static function get tdSymbol():String    {
                return vehicleclassmacro.td;    }
            public static function get spgSymbol():String    {
                return vehicleclassmacro.spg;   }
            public static function get superSymbol():String    {
                return vehicleclassmacro.superh;   }
        /** Units */
            public static function get revealedEnabled():Boolean    {
                return labels.units.revealedEnabled;    }
            public static function get lostEnemyEnabled():Boolean    {
                return labels.units.lostEnemyEnabled;   }

            /** Format */
            public static function unitLabelFormat(entryName:String)
            {
                var unitType:String = entryType(entryName);
                return labels.units.format[unitType];
            }
            /** CSS */
            public static function unitLabelCss(entryName:String)
            {
                var unitType:String = entryType(entryName);
                return labels.units.css[unitType];
            }
            /** Alpha */
            public static function unitLabelAlpha(entryName:String)
            {
                var unitType:String = entryType(entryName);
                return labels.units.alpha[unitType];
            }
            /** Shadow enabled */
            public static function unitShadowEnabled(entryName:String):Boolean
            {
                var unitType:String = entryType(entryName);
                return labels.units.shadow[unitType].enabled;
            }
            /** Shadow filter */
            public static function unitShadow(entryName:String):DropShadowFilter
            {
                var unitType:String = entryType(entryName);
                return Utils.extractShadowFilter(labels.units.shadow[unitType]);
            }
            /** Offset */
            public static function unitLabelOffset(entryName:String)
            {
                var unitType:String = entryType(entryName);
                return new Point(labels.units.offset[unitType].x,
                                 labels.units.offset[unitType].y);
            }

        /** Map size label */
            public static function get mapSizeLabelEnabled():Boolean  {
                return mapSize.enabled;    }

            public static function get mapSizeLabelFormat():String    {
                return mapSize.format;     }

            public static function get mapSizeLabelCss():String       {
                return mapSize.css;        }

            public static function get mapSizeLabelAlpha():Number     {
                return mapSize.alpha;      }

            public static function get mapSizeLabelOffset():Point     {
                return new Point(mapSize.offsetX,
                                 mapSize.offsetY); }
            /** Shadow */
                public static function get mapSizeLabelShadowEnabled(vehicleClass):Boolean    {
                    return mapSize.shadow.enabled;    }
                public static function get mapSizeLabelShadow():DropShadowFilter    {
                    return Utils.extractShadowFilter(labels.mapSize.shadow);    }

            public static function get mapSizeLabelWidth() :Number   {
                return mapSize.width;     }
            public static function get mapSizeLabelHeight():Number   {
                return mapSize.height;    }
     /** Circles */
        public static function get circlesEnabled():Boolean {
            return circles.enabled;
        }
        public static function get circlesMajor():Array     {
            return circles.major;
        }
        public static function get circlesSpecial():Array   {
            return circles.special;
        }

    /** Squarea*/
        public static function get squareEnabled():Boolean {
            return square.enabled;
        }
        public static function get artiEnabled():Boolean {
            return square.artilleryEnabled;
        }
        public static function get squareConfig():Object {
            return square;
        }

    /** Lines */
        public static function get linesEnabled():Boolean   {
            return lines.enabled;
        }
        public static function get linesVehicle():Array     {
            return lines.vehicle;
        }
        public static function get linesCamera():Array      {
            return lines.camera;
        }
        public static function get linesTraverseAngle():Array{
            return lines.traverseAngle;
        }

    // -- Private

    /** Translate internal WG entryName to minimap config file marker type*/
    private static function entryType(entryName:String):String
    {
        switch (entryName)
        {
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_ALLY:
                return "ally";
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_ENEMY:
                return "enemy";
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_SQUAD:
                return "squad"; // originally "squadman"
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_SELF:
                return "oneself";  // originally ""
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_LOST_ENEMY:
                return "lost";
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_LOST_ALLY:
                return "lostally";
            case wot.Minimap.MinimapEntry.MINIMAP_ENTRY_NAME_LOST_SQUAD:
                return "lostsquad";
        }
        return null;
    }

    private static function get labels():Object
    {
        return minimap.labels;
    }

    private static function get lines():Object
    {
        return minimap.lines;
    }

    private static function get circles():Object
    {
        return minimap.circles;
    }

    private static function get square():Object
    {
        return minimap.square;
    }

    private static function get mapSize():Object
    {
        return labels.mapSize;
    }

    private static function get vehicleclassmacro():Object
    {
        return labels.vehicleclassmacro;
    }

    private static function get minimap():Object
    {
        return Config.s_config.minimap;
    }
}
