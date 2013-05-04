import com.xvm.Config;
import com.xvm.Utils;

class wot.crew.PingServersView
{
    private static var TF_NAME:String = "__xvm_pingTextField";
    private static var TF_DEPTH:Number = 0;
    private static var TF_WIDTH:Number = 100;
    private static var TF_HEIGHT:Number = 300;
    
    private var cfg:Object;
    
    public function PingServersView(cfg:Object)
    {
        this.cfg = cfg;
        createField();
    }
    
    public function update(responceTimeList:Array)
    {
        var list:String = "";
        for (var i:Number = 0; i < responceTimeList.length; i++)
        {
            list += responceTimeList[i].cluster + ": " + responceTimeList[i].time + "\n";
        }
        tf.htmlText = "<span class='xvm_ping'>" + list + "</span>";
    }
    
    public function createField():Void
    {
        var xPos:Number = cfg.x;
        var yPos:Number = cfg.y;
        var fontSize:Number = cfg.style.fontSize;
        tf = _root.createTextField(TF_NAME, TF_DEPTH,
            xPos, yPos, TF_WIDTH, TF_HEIGHT);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.selectable = false;
        tf.styleSheet = Utils.createStyleSheet(
            Utils.createCSS("xvm_ping", 0xCCCCCC, "$FieldFont", fontSize, "left", false, false));
    }
    
    private function get tf():TextField
    {
        return _root[TF_NAME];
    }
}
