import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.JSONx;
import com.xvm.Utils;
import wot.crew.PingServersView;

class wot.crew.PingServers
{
    private static var instance:PingServers = null;
    
    private var view:PingServersView;
    private var pingCommandCounter:Number;
    private var pingTimer:Function;

    public static function initFeature()
    {
        if (Config.s_config.hangar.pingServers.enabled == false)
            return;
        
        if (instance == null)
            instance = new PingServers();
        instance.view = new PingServersView();
        instance.pingTimer = _global.setInterval(
            function() { PingServers.instance.showPing.call(PingServers.instance) },
            Config.s_config.hangar.pingServers.updateInterval);

        // immediately
        PingServers.instance.showPing.call(PingServers.instance);
        // after 1, 3, 5 sec
        _global.setTimeout(function() { PingServers.instance.showPing.call(PingServers.instance) }, 1000);
        _global.setTimeout(function() { PingServers.instance.showPing.call(PingServers.instance) }, 3000);
        _global.setTimeout(function() { PingServers.instance.showPing.call(PingServers.instance) }, 5000);
    }

    public function PingServers()
    {
        pingCommandCounter = 0;
    }

    private function showPing()
    {
        Comm.Sync(Defines.COMMAND_PING, String(pingCommandCounter++), this, answerCallback);
    }
    
    private function answerCallback(event):Void
    {
        var answer:String = event.str;
        if (answer == null || answer == "")
            return;
            
        view.update(parseAnswer(answer));
    }
    
    private function parseAnswer(answer:String):Object
    {
        return JSONx.parse(answer);
    }
}
