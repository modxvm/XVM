import wot.VehicleMarkersManager.components.LevelIconProxy;

class wot.VehicleMarkersManager.components.LevelIconComponent
{
    private var proxy:LevelIconProxy;

    public function LevelIconComponent(proxy:LevelIconProxy)
    {
        this.proxy = proxy;
    }
    
    public function init()
    {
        if (proxy.levelIcon != null)
            proxy.levelIcon.gotoAndStop(proxy.level);
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.levelIcon;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        proxy.levelIcon._visible = visible;
    }

    private function draw(cfg:Object)
    {
        proxy.levelIcon._x = cfg.x;
        proxy.levelIcon._y = cfg.y;

        //TODO: extract formatDynamicAlpha
        proxy.levelIcon._alpha = proxy.formatDynamicAlpha(cfg.alpha);
    }
}
