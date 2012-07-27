import wot.utils.Config;
import wot.utils.Utils;
import wot.utils.GlobalEventDispatcher;

class wot.battleloading.RealClock
{
    private var form_mc:MovieClip;
    
    public function RealClock(form_mc) 
    {
        this.form_mc = form_mc;
        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
    }
    
    private function onConfigLoaded()
    {
        showClock(Config.s_config.battleLoading.clockFormat);
    }
    
    private function showClock(format)
    {
        if (!format || format == "")
            return;
        var f = form_mc.helpTip;
        var clock: TextField = form_mc.createTextField("xvm_clock", form_mc.getNextHighestDepth(), f._x, f._y, f._width, f._height);
        clock.antiAliasType = "advanced";
        var tf: TextFormat = f.getNewTextFormat();
        tf.color = 0xFFFFFF;
        tf.align = "right";
        clock.setNewTextFormat(tf);
        clock.filters = f.filters;
        setInterval(function() { clock.text = Utils.FormatDate(format, new Date()); }, 1000);
    }
}