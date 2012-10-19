package preview
{

import preview.*;

public class LevelIconComponent
{
    private var proxy:LevelIconProxy;

    public function LevelIconComponent(proxy:LevelIconProxy)
    {
        this.proxy = proxy;

        if (proxy.levelIcon != null)
            proxy.levelIcon.gotoAndStop(proxy.level);
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.levelIcon;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        proxy.levelIcon.visible = visible;
    }

    private function draw(cfg:Object)
    {
        proxy.levelIcon.x = cfg.x;
        proxy.levelIcon.y = cfg.y;

        //TODO: extract formatDynamicAlpha
        proxy.levelIcon.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
    }
}

}
