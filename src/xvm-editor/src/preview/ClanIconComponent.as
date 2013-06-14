package preview
{

import flash.display.MovieClip;

import preview.*;

import spark.components.Image;

import utils.*;

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

    public function updateState(state_cfg:Object):void
    {
        if (m_clanIcon == null || m_clanIcon.source == "")
            return;

        var cfg:Object = state_cfg.clanIcon;

        var visible:Boolean = cfg.visible;

        if (visible)
            draw(cfg);

        m_clanIcon.visible = visible;
    }

    private function draw(cfg:Object):void
    {
		m_clanIcon.visible = cfg.visible;
		m_clanIcon.x = cfg.x - cfg.w / 2.0;
		m_clanIcon.y = cfg.y - cfg.h / 2.0;
		m_clanIcon.width = cfg.w;
		m_clanIcon.height = cfg.h;
		m_clanIcon.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
    }
}

}
