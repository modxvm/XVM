import com.xvm.*;
import wot.Minimap.*;
import wot.Minimap.model.mapSize.*;

class wot.Minimap.view.MapSizeLabel
{
    private static var MAP_SIZE_TEXT_FIELD_NAME = "mapSize";
    private static var CELLSIZE_MACRO:String = "{{cellsize}}";

    private var tf:TextField = null;

    public function MapSizeLabel()
    {
        var cfg:Object = Minimap.config.mapSize;
        tf = bg.createTextField(MAP_SIZE_TEXT_FIELD_NAME, bg.getNextHighestDepth(),
            cfg.offsetX, cfg.offsetY, cfg.width, cfg.height);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.multiline = true;
        tf.selectable = false;

        tf.htmlText = defineLabelText(cfg.format);

        tf._alpha = cfg.alpha;

        if (cfg.shadow.enabled)
        {
            tf.filters = [ Utils.extractShadowFilter(cfg.shadow) ];
        }
    }

    public function Dispose()
    {
        if (tf != null)
        {
            tf.removeTextField();
            delete tf;
        }
    }

    /** -- Private */

    private function defineLabelText(format:String):String
    {
        var formatArr:Array = format.split(CELLSIZE_MACRO);
        if (formatArr.length > 1)
        {
            format = formatArr.join(Math.round(Minimap.MapSize / 10).toString());
        }
        return format;
    }

    private function get bg():MovieClip
    {
        return MinimapProxy.wrapper.backgrnd;
    }
}
