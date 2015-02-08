import com.xvm.*;
import com.xvm.DataTypes.*;
import net.wargaming.controls.*;
import wot.VehicleMarkersManager.components.*;

class wot.VehicleMarkersManager.components.ClanIconComponent
{
    private var proxy:ClanIconProxy;
    private var mc:MovieClip;
    private var m_clanIcon: UILoaderAlt;

    public function ClanIconComponent(proxy:ClanIconProxy)
    {
        this.proxy = proxy;
        this.m_clanIcon = null;
        this.mc = null;
    }

    public function initialize(mc:MovieClip)
    {
        this.mc = mc;
    }

    public function updateState(state_cfg:Object)
    {
        if (m_clanIcon != null && m_clanIcon.source == "")
            return;

        var cfg = state_cfg.clanIcon;

        var visible = cfg.visible;

        if (visible)
        {
            if (m_clanIcon == null && mc != null)
                m_clanIcon = PlayerInfo.createIcon(mc, "clanicon", cfg, cfg.x - (cfg.w / 2.0), cfg.y - (cfg.h / 2.0));

            var statData:Object = Stat.s_data[proxy.playerName];
            var emblem:String = (statData == null && statData.stat != null) ? null : statData.stat.emblem;

            PlayerInfo.setSource(m_clanIcon, proxy.playerId, proxy.playerName, proxy.playerClan, emblem);
            draw(cfg);
        }

        if (m_clanIcon != null)
            m_clanIcon["holder"]._visible = visible;
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
