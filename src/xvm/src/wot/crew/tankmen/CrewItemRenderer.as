/**
 * 
 * @author LEMAXHO
 */
import wot.utils.Locale;
import wot.crew.CrewLoader;

class wot.crew.tankmen.CrewItemRenderer extends net.wargaming.tankmen.CrewItemRenderer
{
    var onMouseDownFuncBase;

    function CrewItemRenderer()
    {
        super();
        onMouseDownFuncBase = null;
    }

    function configUI()
    {
        super.configUI();
        onMouseDownFuncBase = onMouseDownFunc;
        onMouseDownFunc = onMouseDownFunc2;
        onMouseDown = onMouseDownFunc
    }

    function onMouseDownFunc2(button, target)
    {
        onMouseDownFuncBase.apply(this, arguments);

        if (_disabled || data.tankmanID != null)
            return;
        if (Mouse.RIGHT != button || !this.hitTest(_root._xmouse, _root._ymouse, true))
            return;

        // check for empty space click
        var top = Mouse.getTopMostEntity();
        var ok = false;
        while (top)
        {
            if (top == this)
            {
                ok = true;
                break;
            }
            top = top._parent;
        }
        if (!ok)
            return;

        var menu = net.wargaming.managers.ContextMenuManager.instance.show([
            [{id: "PutOwnCrew", label: Locale.get("PutOwnCrew") }],
            [net.wargaming.controls.ContextMenu.SEPARATE],
            [{id: "PutBestCrew", label: Locale.get("PutBestCrew") }]
            ], false, {id: this.data.tankmanID});
        menu.addEventListener("action", CrewLoader.PutCrewAction);
    }
} 
