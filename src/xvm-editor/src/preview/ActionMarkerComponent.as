package preview
{

import preview.*;

public class ActionMarkerComponent
{
    private var proxy:ActionMarkerProxy;

    public function ActionMarkerComponent(proxy:ActionMarkerProxy)
    {
        this.proxy = proxy;
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.actionMarker;

        var visible = cfg.visible;

        if (visible)
            draw(cfg);

        proxy.actionMarker._visible = visible;
    }

    public function showActionMarker(actionState)
    {
        proxy.actionMarker.showAction(actionState);
    }

    private function draw(cfg:Object)
    {
        proxy.actionMarker._x = cfg.x;
        proxy.actionMarker._y = cfg.y;
    }
}

}