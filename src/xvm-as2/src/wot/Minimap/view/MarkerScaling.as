import com.xvm.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;

class wot.Minimap.view.MarkerScaling
{

    private static var ORIGINAL_MARKERS_SCALING_FACTOR:Number = 0.5;

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
        MinimapProxy.base.scaleMarkers(ORIGINAL_MARKERS_SCALING_FACTOR);
    }

    private function alternateVehicleScaling():Void
    {
        /**
         * Modified WG scaling cut-pasted algorithm.
         * Static entries are omitted in scale alteration.
         *
         * icons._xscale is changed by minimap resize
         */
        var scaleFactor:Number = 10000 / icons._xscale;
        scaleFactor = scaleFactor + (100 - scaleFactor);
        scaleFactor = scaleFactor * MapConfig.iconScale;

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

        /**
         * Attached MovieClips scaling is also affected.
         * Have to be compensated.
         *
         * TODO: can be fixed by detaching attachments to separate MovieClips
         * plus displacing onEnterFrame()
         */
        //rescaleAttachments();
    }

    private function rescaleAttachments():Void
    {
        var entries:Array = IconsProxy.allEntries;
        for (var i in entries)
        {
            var entry:MinimapEntry = entries[i];
            entry.rescaleAttachments();
        }
    }

    private function get icons():MovieClip
    {
        return MinimapProxy.wrapper.icons;
    }
}
