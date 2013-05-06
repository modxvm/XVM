import wot.crew.PingServersView;
import com.xvm.Utils;

/**
 * TextField building is separated here.
 * Other classes do not care about field creation process.
 * And this class does not care about other classes using fields.
 */
class wot.crew.PingFieldBuilder
{
    private static var TF_NAME_PREFIX:String = "__xvm_pingTextField";

    private var cfg:Object;
    
    public function PingFieldBuilder(cfg:Object) 
    {
        this.cfg = cfg;
    }
    
    public function createField(num:Number):TextField
    {
        var depth:Number = holder.getNextHighestDepth();
        var tf:TextField = holder.createTextField(TF_NAME_PREFIX + num, depth, cfg.x, cfg.y, 200, 200);
        tf.autoSize = true;
        tf.multiline = true;
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.selectable = false;
        tf.styleSheet = Utils.createStyleSheet(createCss());
        tf._alpha = cfg.alpha;
        tf.htmlText = "";
        
        if (cfg.shadow.enabled)
        {
            tf.filters = [Utils.extractShadowFilter(cfg.shadow)];
        }
        
        return tf;
    }
    
    // -- Private
    
    private function createQualityCss(quality:String):String
    {
        var size:Number = cfg.fontStyle.size;
        var bold:Boolean = cfg.fontStyle.bold;
        var italic:Boolean = cfg.fontStyle.italic;
        var name:String = cfg.fontStyle.name;
        var color:Number = parseInt(cfg.fontStyle.color[quality], 16);
        
        return Utils.createCSS(PingServersView.STYLE_NAME_PREFIX + quality, color, name, size, "left", bold, italic);
    }
    
    private function createCss():String
    {
        var css:String = "";
        css += createQualityCss(PingServersView.QUALITY_GREAT);
        css += createQualityCss(PingServersView.QUALITY_GOOD)
        css += createQualityCss(PingServersView.QUALITY_POOR);
        css += createQualityCss(PingServersView.QUALITY_BAD);
        
        return css;
    }
    
    private function get holder():MovieClip
    {
        return _root.header;
    }
}
