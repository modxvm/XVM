import com.xvm.*;
import wot.Minimap.*;

class wot.Minimap.view.MapSizeLabel
{
    private static var MAP_SIZE_TEXT_FIELD_NAME = "mapSize";

    private var tf:TextField;

    public function MapSizeLabel()
    {
        var cfg:Object = Minimap.config.mapSize;
        tf = bg.createTextField(MAP_SIZE_TEXT_FIELD_NAME, bg.getNextHighestDepth(),
            cfg.offsetX, cfg.offsetY, cfg.width, cfg.height);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.multiline = true;
        tf.selectable = false;

        tf.htmlText = Macros.FormatGlobalStringValue(cfg.format);

        tf._alpha = cfg.alpha;

        if (cfg.shadow.enabled)
        {
            tf.filters = [ Utils.createShadowFiltersFromConfig(cfg.shadow) ];
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

    private function get bg():MovieClip
    {
        return MinimapProxy.wrapper.backgrnd;
    }
}
