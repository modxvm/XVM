import flash.geom.Point;
import flash.filters.DropShadowFilter;
import wot.Minimap.model.externalProxy.MapConfig;

class wot.Minimap.MapSizeLabel
{
    private static var CELLSIZE_MACRO:String = "{{cellsize}}";
    
    private var side:Number;
        
    public function MapSizeLabel(mc:MovieClip, side:Number)
    {
        this.side = side;
        
        var offset:Point = MapConfig.mapSizeLabelOffset;
        var tf:TextField = mc.createTextField("mapSize", mc.getNextHighestDepth(), offset.x, offset.y, 100, 40);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.multiline = true;
        tf.selectable = false;
        
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(".mapsize{" + MapConfig.mapSizeLabelCss + "}");
        tf.styleSheet = style;
        
        tf.htmlText = "<span class='mapsize'>" + defineLabelText(MapConfig.mapSizeLabelFormat) + "</span>";
        
        tf._alpha = MapConfig.mapSizeLabelAlpha;
        
        if (MapConfig.mapSizeLabelShadowEnabled)
        {
            tf.filters = [new DropShadowFilter(
                    MapConfig.mapSizeLabelShadowDistance, // distance
                    MapConfig.mapSizeLabelShadowAngle, // angle
                    MapConfig.mapSizeLabelShadowColor,
                    // DropShadowFilter accepts alpha be from 0 to 1.
                    // 90 at default config.
                    MapConfig.mapSizeLabelShadowAlpha / 100, 
                    MapConfig.mapSizeLabelShadowBlur,
                    MapConfig.mapSizeLabelShadowBlur,
                    MapConfig.mapSizeLabelShadowStrength,
                    3 // quality
                )];
        }
    }
    
    /** -- Private */
    
    private function defineLabelText(format:String):String
    {
        var formatArr:Array = format.split(CELLSIZE_MACRO);
        if (formatArr.length > 1)
        {
            format = formatArr.join(side.toString());
        }
        
        return format;
    }
}
