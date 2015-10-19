import com.xvm.*;
import com.xvm.DataTypes.*;
import net.wargaming.ingame.MinimapEntry;
import wot.Minimap.Minimap;
import wot.Minimap.MinimapProxy;

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
    public function scaleEntry(entry:net.wargaming.ingame.MinimapEntry, scaleFactor:Number):Void
    {
        //Logger.add("scaleEntry: " + entry.entryName + " " + MapConfig.iconScale);

        if (isNaN(scaleFactor))
            scaleFactor = 100 * Minimap.config.iconScale;

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

            // Set icon alpha
            icon._alpha = entry.selfIcon ? Minimap.config.selfIconAlpha : Minimap.config.iconAlpha;
            icon._visible = icon._alpha > 0;
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

        var scaleFactor:Number = 100 * Minimap.config.iconScale;
        var icons = MinimapProxy.wrapper.icons;
        for (var i in icons)
        {
            if (icons[i] instanceof net.wargaming.ingame.MinimapEntry)
                scaleEntry(icons[i], scaleFactor);
        }
    }
}
