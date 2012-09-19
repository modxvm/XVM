import net.wargaming.controls.UILoaderAlt;
import wot.utils.PlayerInfo;
import wot.utils.Utils;
import wot.VehicleMarkersManager.components.ClanIconProxy;

class wot.VehicleMarkersManager.components.ClanIconComponent
{
    private var proxy:ClanIconProxy

    private var m_clanIcon: UILoaderAlt;

    public function ClanIconComponent(proxy:ClanIconProxy)
    {
        this.proxy = proxy;
    }

    public function initialize(cfg:Object, mc:MovieClip)
    {
        if (m_clanIcon == null)
            m_clanIcon = PlayerInfo.createIcon(mc, cfg, cfg.x - (cfg.w / 2.0), cfg.y - (cfg.h / 2.0));
        PlayerInfo.setSource(m_clanIcon, Utils.GetPlayerName(proxy.playerName), Utils.GetClanName(proxy.playerName));
    }

    public function updateState(state_cfg:Object)
    {
        if (m_clanIcon == null || m_clanIcon.source == "")
            return;

        var cfg = state_cfg.clanIcon;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        m_clanIcon._visible = visible;
    }

    private function draw(cfg:Object)
    {
        var holder = m_clanIcon["holder"];
        holder._x = cfg.x - (cfg.w / 2.0);
        holder._y = cfg.y - (cfg.h / 2.0);
        m_clanIcon.setSize(cfg.w, cfg.h);
        holder._alpha = proxy.formatDynamicAlpha(cfg.alpha);
    }
}
