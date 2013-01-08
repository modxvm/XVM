import flash.geom.Point;
import wot.Minimap.model.MapSizeModel;
import wot.Minimap.model.MapConfig;

class wot.Minimap.MapSizeLabel
{
    private static var CELLSIZE_MACRO:String = "{{cellsize}}";
    
    private var model:MapSizeModel;
        
    public function MapSizeLabel(mc:MovieClip, model:MapSizeModel)
    {
        this.model = model;
        
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
    }
    
    /** -- Private */
    
    private function defineLabelText(format:String):String
    {
        var formatArr:Array = format.split(CELLSIZE_MACRO);
        if (formatArr.length > 1)
        {
            format = formatArr.join(model.getSide().toString());
        }
        
        return format;
    }
}
