import com.xvm.*;
import flash.geom.*;
import net.wargaming.ingame.*;

class wot.battle.FragCorrelation
{
    public static function modify():Void
    {
        if (mc == null || mc.alliedMarkers.dataProvider == null)
        {
            setTimeout(FragCorrelation.modify, 1);
        }
        else
        {
            FragCorrelation.instance._modify();
        }
    }

    // PRIVATE STATIC

    private static var _instance:FragCorrelation = null;
    private static function get instance()
    {
        if (_instance == null)
            _instance = new FragCorrelation();
        return _instance;
    }

    private static function get mc():MovieClip
    {
        return _root.fragsContainer.TeamsCounterUI;
    }

    // PRIVATE

    private function _modify():Void
    {
        if (Config.config.fragCorrelation.hideTeamTextFields == true)
            hideFragCorellationBarTeamTextFields();
        colorizeMarkers();
    }

    private function hideFragCorellationBarTeamTextFields():Void
    {
        // Everything outside of this rectangular mask will be invisible
        mc.scrollRect = new flash.geom.Rectangle(-mc._width / 2, mc._y, mc._width, mc._height / 2);
        mc._x = -mc._width / 2;
    }

    private function colorizeMarkers():Void
    {
        setupMarkers(mc.alliedMarkers);
        setupMarkers(mc.enemyMarkers);
    }

    private function setupMarkers(markers)
    {
        if (markers.$createItemRenderer == null)
        {
            markers.$createItemRenderer = markers.createItemRenderer;
            markers.createItemRenderer = wrapper_createItemRenderer;
            markers.drawRenderers(true);
        }
    }

    // CONTEXT: alliedMarkers, enemyMarkers
    private function wrapper_createItemRenderer(data, resetPrevData)
    {
        var markers = TeamCounterMarkersList(this);
        //Logger.addObject(markers);

        var renderer = markers.$createItemRenderer.apply(markers, arguments);

        var type = markers.markerType == "vm_ally" ? "ally" : "enemy";
        var color = Config.config.markers.useStandardMarkers
            ? net.wargaming.managers.ColorSchemeManager.instance.getRGB("vm_" + type)
            : ColorsManager.getSystemColor(type, !data.isAlive);

        GraphicsUtil.colorize(data.isAlive ? renderer.marker : renderer.markerDead, color,
            Config.config.consts.VM_COEFF_FC / (data.isAlive ? 1 : 2)); // darker to improve appearance
        //Logger.addObject(arguments[0], 1, color);
        //Logger.addObject(renderer, 1, "renderer");
        return renderer;
    }
}
