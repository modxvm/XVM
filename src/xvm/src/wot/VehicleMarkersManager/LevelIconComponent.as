import wot.VehicleMarkersManager.XVM;
import wot.utils.Logger;

class wot.VehicleMarkersManager.LevelIconComponent
{
    var owner:XVM // Reference to composition owner
    
    public function LevelIconComponent(owner:XVM) 
    {
        Logger.add("LevelIconComponent()");
        this.owner = owner;
        if (owner.levelIcon != null)
            owner.levelIcon.gotoAndStop(owner.m_level);
    }
     
    public function updateState(cfg:Object)
    {
        var visible = cfg.levelIcon.visible;
        Logger.add("LevelIconComponent: updateState(); visible = " + visible);
        if (visible)
        {
            draw(cfg);
        }
        owner.levelIcon._visible = visible;
    }
    
    private function draw(cfg:Object)
    {
        Logger.add("LevelIconComponent: draw()");
        owner.levelIcon._x = cfg.levelIcon.x;
        owner.levelIcon._y = cfg.levelIcon.y;
        owner.levelIcon._alpha = owner.XVMFormatDynamicAlpha(cfg.levelIcon.alpha, owner.m_curHealth);
    }
}