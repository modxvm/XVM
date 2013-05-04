import com.xvm.Config;
import com.xvm.Utils;

class wot.crew.PingServersView
{
    private static var TF_NAME:String = "__xvm_pingTextField";
    private static var TF_DEPTH:Number = 0;
    private static var TF_WIDTH:Number = 100;
    private static var TF_HEIGHT:Number = 300;
    
    public function PingServersView()
    {
        createField();
    }
    
    public function update(responceTimeList:Array)
    {
        var list:String = "";
        for (var i:Number = 0; i < responceTimeList.length; i++)
        {
            list += responceTimeList[i].cluster + ": " + responceTimeList[i].time + "\n";
        }
        tf.htmlText = "<span class='xvm_ping'>" + Utils.fixImgTag(list) + "</span>";
    }
    
    public function createField():Void
    {
        var xPos:Number = Config.s_config.hangar.pingServers.x;
        var yPos:Number = Config.s_config.hangar.pingServers.y;
        tf = _root.createTextField(TF_NAME, TF_DEPTH,
            xPos, yPos, TF_WIDTH, TF_HEIGHT);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.selectable = false;
        tf.styleSheet = Utils.createStyleSheet(
            Utils.createCSS("xvm_ping", 0xCCCCCC, "$FieldFont", 11, "left", false, false));
    }
    
    private function get tf():TextField
    {
        return _root[TF_NAME];
    }
}
