import wot.Minimap.MinimapProxy;
import flash.geom.Point;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.Minimap.model.mapSize.MapSizeModel;

class wot.Minimap.view.MapSizeLabel
{
    private static var CELLSIZE_MACRO:String = "{{cellsize}}";

    public function MapSizeLabel()
    {
        var offset:Point = MapConfig.mapSizeLabelOffset;
        var tf:TextField = bg.createTextField("mapSize", bg.getNextHighestDepth(),
            offset.x, offset.y, MapConfig.mapSizeLabelWidth, MapConfig.mapSizeLabelHeight);
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
            tf.filters = [MapConfig.mapSizeLabelShadow];
        }
    }

    /** -- Private */

    private function defineLabelText(format:String):String
    {
        var formatArr:Array = format.split(CELLSIZE_MACRO);
        if (formatArr.length > 1)
        {
            format = formatArr.join(cellSize.toString());
        }

        return format;
    }
    
    private function get bg():MovieClip
    {
        return MinimapProxy.wrapper.backgrnd;
    }
    
    private function get cellSize():Number
    {
        return MapSizeModel.instance.getCellSide();
    }
}
