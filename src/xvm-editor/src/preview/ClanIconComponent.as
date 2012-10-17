package preview
{

import flash.display.MovieClip;
import spark.components.Image;
import utils.*;
import preview.*;

public class ClanIconComponent
{
    private var proxy:ClanIconProxy;

    public var m_clanIcon:Image = new Image();

    public function ClanIconComponent(proxy:ClanIconProxy)
    {
        this.proxy = proxy;

        m_clanIcon.includeInLayout = false;
//        m_clanIcon.source = proxy.team == "ally" ? new Resources.IMG_clan1() : new Resources.IMG_clan2();
        m_clanIcon.visible = false;
        proxy.addChild(m_clanIcon);
    }

    public function updateState(state_cfg:Object)
    {
        if (m_clanIcon == null || m_clanIcon.source == "")
            return;

        var cfg = state_cfg.clanIcon;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        m_clanIcon["holder"]._visible = visible;
    }

    private function draw(cfg:Object)
    {
        var holder = m_clanIcon["holder"];
        holder._x = cfg.x - (cfg.w / 2.0);
        holder._y = cfg.y - (cfg.h / 2.0);
        m_clanIcon.width = cfg.w;
        m_clanIcon.height = cfg.h;
        holder._alpha = proxy.formatDynamicAlpha(cfg.alpha);
    }
}

}
