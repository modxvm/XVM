/**
 * @author sirmax
 */
import com.xvm.*;
import net.wargaming.controls.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;

class wot.Minimap.view.StrategicAimMarker
{
    private static var CONTAINER_NAME:String = "strategicAimContainer";

    private var holder:MovieClip;
    private var icon:UILoaderAlt;
    private var prevPos:Object = null;

    public function StrategicAimMarker(owner:MovieClip)
    {
        var iconPath = Config.config.minimap.minimapAimIcon;
        if (!iconPath || iconPath == "")
            return;
        iconPath = Utils.fixImgTagSrc(Macros.FormatGlobalStringValue(iconPath));

        holder = IconsProxy.createEmptyMovieClip(CONTAINER_NAME, MinimapConstants.STRATEGIC_AIM_ZINDEX);
        holder.hitTestDisable = true;

        icon = (UILoaderAlt)(holder.attachMovie("UILoaderAlt", "icon", 0));

        var il:IconLoader = new IconLoader();
        il.init(icon, [ iconPath, "" ], false);

        icon.source = il.currentIcon;
        var $this = this;
        icon.onLoadInit = function(mc:MovieClip) { $this.icon_onLoadInit(mc); }
    }

    public function updatePosition(owner:MovieClip)
    {
        if (!holder)
            return;

        if (prevPos != null && prevPos.xs == owner._xscale && prevPos.ys == owner._yscale && prevPos.x == owner._x && prevPos.y == owner._y)
            return;

        prevPos = { x: owner._x, y: owner._y, xs: owner._xscale, ys: owner._yscale };

        var x:Number = prevPos.x;
        var y:Number = prevPos.y;

        //Logger.add(x + " " + y + " <= " + prevPos.x + " " + prevPos.y + " " + prevPos.xs + " " + prevPos.ys);

        holder._x = x;
        holder._y = y;
    }

    private function icon_onLoadInit(mc:MovieClip)
    {
        icon.setSize(mc._width, mc._height);
        icon._x = Math.round(mc._width / -2);
        icon._y = Math.round(mc._height / -2);
    }
}
