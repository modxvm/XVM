import com.xvm.Config;
import com.xvm.Utils;

class wot.crew.PingServersView
{
    public function PingServersView()
    {
        createField();
    }
    
    public function update(parsedAnswerObj:Object)
    {
        var list:Array = [];
        for (var i in parsedAnswerObj)
        {
            var s = Utils.startsWith("WOT ", i) ? i.substring(4) : i;
            list.push(s + ": " + parsedAnswerObj[i])
        }
        list.sort();
        tf.htmlText = "<span class='xvm_ping'>" + Utils.fixImgTag(list.join("\n")) + "</span>";

        //com.xvm.Logger.add(str.join("\n"));
    }
    
    public function createField():Void
    {
        tf = _root.createTextField("__xvm_pingTextField", 0,
            Config.s_config.hangar.pingServers.x, Config.s_config.hangar.pingServers.y, 100, 300);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.selectable = false;
        tf.styleSheet = Utils.createStyleSheet(
            Utils.createCSS("xvm_ping", 0xCCCCCC, "$FieldFont", 10, "left", false, false));
    }
    
    private function get tf():TextField
    {
        return _root["__xvm_pingTextField"];
    }
}
