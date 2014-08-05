import com.xvm.*;
import flash.geom.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.model.mapSize.*;

class wot.Minimap.view.MapSizeLabel
{
    private static var MAP_SIZE_TEXT_FIELD_NAME = "mapSize";
    private static var CELLSIZE_MACRO:String = "{{cellsize}}";

    private var tf:TextField = null;

    public function MapSizeLabel()
    {
        var offset:Point = MapConfig.mapSizeLabelOffset;
        tf = bg.createTextField(MAP_SIZE_TEXT_FIELD_NAME, bg.getNextHighestDepth(),
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

    public function Dispose()
    {
        if (tf != null)
        {
            tf.removeTextField();
            delete tf;
            tf = null;
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
