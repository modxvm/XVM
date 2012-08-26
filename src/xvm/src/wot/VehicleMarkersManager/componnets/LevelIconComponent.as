import wot.VehicleMarkersManager.componnets.LevelIconProxy;

class wot.VehicleMarkersManager.componnets.LevelIconComponent
{
    var proxy:LevelIconProxy
    
    public function LevelIconComponent(proxy:LevelIconProxy) 
    {
        this.proxy = proxy;
        
        if (proxy.levelIcon != null)
            proxy.levelIcon.gotoAndStop(proxy.level);
    }
     
    public function updateState(cfg:Object)
    {
        var visible = cfg.levelIcon.visible;
        
        if (visible)
            draw(cfg);
            
        proxy.levelIcon._visible = visible;
    }
    
    private function draw(cfg:Object)
    {
        proxy.levelIcon._x = cfg.levelIcon.x;
        proxy.levelIcon._y = cfg.levelIcon.y;
        
        //TODO: extract XVMFormatDynamicAlpha
        proxy.levelIcon._alpha = proxy.XVMFormatDynamicAlpha(cfg.levelIcon.alpha);
    }
}