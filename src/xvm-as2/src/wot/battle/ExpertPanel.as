import com.xvm.Config;
import wot.battle.ExpertPanelWG;

class wot.battle.ExpertPanel
{
    public static function modify():Void
    {
        panel.FADE_DELAY = cfg.delay;
        panel._xscale = cfg.scale;
        panel._yscale = cfg.scale;
        panel.configUI();
    }

    private static function get panel():ExpertPanelWG
    {
        return _root.damageInfoPanel;
    }

    private static function get cfg():Object
    {
        return Config.config.expertPanel;
    }
}
