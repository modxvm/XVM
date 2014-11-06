import com.xvm.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;

class wot.Minimap.view.MarkerScaling
{

    public function MarkerScaling()
    {
        /**
         * TODO: Check if this is correctrly invoked right on battle start.
         */
    }

    public function scale():Void
    {
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
        scaleAllMarkersToOriginalSizes();
        alternateVehicleScaling();
    }

    // -- Private

    private function scaleAllMarkersToOriginalSizes():Void
    {
        /** Original WG scaling behaviour invocation */
        MinimapProxy.base.scaleMarkers(net.wargaming.ingame.Minimap.MARKERS_SCALING);
    }

    private function alternateVehicleScaling():Void
    {
        /**
         * Modified WG scaling cut-pasted algorithm.
         * Static entries are omitted in scale alteration.
         *
         * icons._xscale is changed by minimap resize
         */
        var scaleFactor = 100 * MapConfig.iconScale;

        for (var i in icons)
        {
            if (icons[i] instanceof net.wargaming.ingame.MinimapEntry)
            {
                var entry = icons[i];
                if (entry._currentframe == 5 || entry._currentframe == 6) // cursors
                    continue;

                if (entry.player != null)
                {
                    entry.player.litIcon._xscale = entry.player.litIcon._yscale = scaleFactor;
                }
                else if (entry.selfIcon != null)
                {
                    entry.selfIcon._xscale = entry.selfIcon._yscale = scaleFactor;
                }
            }
        }
    }

    private function get icons():MovieClip
    {
        return MinimapProxy.wrapper.icons;
    }
}
