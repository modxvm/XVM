import com.xvm.*;
import net.wargaming.ingame.MinimapEntry;
import wot.Minimap.MinimapProxy;
import wot.Minimap.model.externalProxy.*;

class wot.Minimap.view.MarkerScaling
{
    // PUBLIC

    /**
     * This behaviour allows to keep original sizes
     * of static entries and modify dynamic entries scaling.
     *
     * Writing alternative implemention
     * of original size scaling attempt failed.
     * This is why original WG algorithm is invoked first.
     *
     * Static entry: capture base, respawn point
     * Dynamic entry: tank
     */
    public function scale():Void
    {
        scaleAllMarkersToOriginalSizes();
        alternateVehicleScaling();
    }

    /**
     * Scale single entry
     * @param entry
     * @param scaleFactor
     */
    public function scaleEntry(entry:MinimapEntry, scaleFactor:Number):Void
    {
        //Logger.add("scaleEntry: " + entry.entryName + " " + MapConfig.iconScale);

        if (isNaN(scaleFactor))
            scaleFactor = 100 * Config.config.minimap.iconScale;

        if (entry._currentframe == 5 || entry._currentframe == 6) // cursors
            return;

        var icon:MovieClip = entry.selfIcon || entry.player.litIcon || entry.player.icon || entry.player.selfIcon;
        if (icon)
        {
            // FIXIT: dirty hack to fix unexpected behavior
            if (icon == entry.player.selfIcon)
                scaleFactor *= 2;
            // /FIXIT
            icon._xscale = icon._yscale = scaleFactor;
        }
    }

    // PRIVATE

    /**
     * Original WG scaling behaviour invocation
     */
    private function scaleAllMarkersToOriginalSizes():Void
    {
        MinimapProxy.base.scaleMarkers(net.wargaming.ingame.Minimap.MARKERS_SCALING);
    }

    /**
     * Modified WG scaling cut-pasted algorithm.
     * Static entries are omitted in scale alteration.
     *
     * icons._xscale is changed by minimap resize
     */
    private function alternateVehicleScaling():Void
    {
        //Logger.add("alternateVehicleScaling: " + MapConfig.iconScale);

        var scaleFactor:Number = 100 * Config.config.minimap.iconScale;
        var icons = MinimapProxy.wrapper.icons;
        for (var i in icons)
        {
            if (icons[i] instanceof net.wargaming.ingame.MinimapEntry)
                scaleEntry(icons[i], scaleFactor);
        }
    }
}
