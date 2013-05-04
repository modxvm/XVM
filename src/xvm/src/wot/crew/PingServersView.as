import com.xvm.Config;
import com.xvm.Utils;

class wot.crew.PingServersView
{
    private static var TF_NAME:String = "__xvm_pingTextField";
    private static var TF_WIDTH:Number = 100;
    private static var TF_HEIGHT:Number = 300;
    private static var STYLE_NAME_PREFIX:String = "xvm_ping_";
    private static var QUALITY_BAD:String = "bad";
    private static var QUALITY_POOR:String = "poor";
    private static var QUALITY_GOOD:String = "good";
    private static var QUALITY_GREAT:String = "great";
    
    private var cfg:Object;

    public function PingServersView(cfg:Object)
    {
        this.cfg = cfg;
        createField();
    }
    
    public function update(responceTimeList:Array)
    {
        tf.htmlText = "";
        for (var i:Number = 0; i < responceTimeList.length; i++)
        {
            var time:Number = responceTimeList[i].time;
            var cluster:String = responceTimeList[i].cluster;
            var raw:String = cluster + ": " + time;
            var styled:String = "<span class='" + STYLE_NAME_PREFIX + defineQuality(time) + "'>" + raw + "</span>";
            tf.htmlText += styled + "\n";
        }
    }
    
    public function createField():Void
    {
        var xPos:Number = cfg.x;
        var yPos:Number = cfg.y;
        
        var depth:Number = _root.getNextHighestDepth();
        tf = _root.createTextField(TF_NAME, depth, xPos, yPos, TF_WIDTH, TF_HEIGHT);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.selectable = false;
        var css:String = createQualityCss(QUALITY_GOOD) + createQualityCss(QUALITY_POOR);
        css += createQualityCss(QUALITY_BAD) + createQualityCss(QUALITY_GREAT);
        tf.styleSheet = Utils.createStyleSheet(css);
        tf._alpha = cfg.alpha;
    }
    
    private function defineQuality(time):String
    {
        if (time < cfg.threshold[QUALITY_GREAT])
            return QUALITY_GREAT;
        if (time < cfg.threshold[QUALITY_GOOD])
            return QUALITY_GOOD;
        else if (time < cfg.threshold[QUALITY_POOR]) 
            return QUALITY_POOR;
            
        return QUALITY_BAD; 
    }
    
    private function createQualityCss(quality:String):String
    {
        var size:Number = cfg.fontStyle.size;
        var bold:Boolean = cfg.fontStyle.bold;
        var italic:Boolean = cfg.fontStyle.italic;
        var name:String = cfg.fontStyle.name;
        var color:Number = parseInt(cfg.fontStyle.color[quality], 16);
        
        return Utils.createCSS(STYLE_NAME_PREFIX + quality, color, name, size, "left", bold, italic);
    }
    
    private function get tf():TextField
    {
        return _root[TF_NAME];
    }
}
