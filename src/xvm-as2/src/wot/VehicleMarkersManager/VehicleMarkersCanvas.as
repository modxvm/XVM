/**
 * Proxy class for vehicle marker canvas
 * Used only for config preloading in the begin of the battle
 */
import com.greensock.OverwriteManager;
import com.greensock.plugins.*;
import com.xvm.*;
import flash.external.*;
import wot.VehicleMarkersManager.*;

class wot.VehicleMarkersManager.VehicleMarkersCanvas
{
    public static var isAltMode:Boolean = false;

    /////////////////////////////////////////////////////////////////
    private var wrapper:net.wargaming.ingame.VehicleMarkersCanvas;
    private var base:net.wargaming.ingame.VehicleMarkersCanvas;

    public function VehicleMarkersCanvas(wrapper:net.wargaming.ingame.VehicleMarkersCanvas, base:net.wargaming.ingame.VehicleMarkersCanvas)
    {
        this.wrapper = wrapper;
        this.base = base;
        VehicleMarkersCanvasCtor();
    }

    function setShowExInfoFlag(flag)
    {
        return this.setShowExInfoFlagImpl.apply(this, arguments);
    }

    /////////////////////////////////////////////////////////////////

    /**
     * ctor()
     */
    private function VehicleMarkersCanvasCtor()
    {
        Utils.TraceXvmModule("VMM");

        // ScaleForm optimization
        _global.gfxExtensions = true;
        _global.noInvisibleAdvance = true;

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([AutoAlphaPlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin,
            CacheAsBitmapPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, EndArrayPlugin,
            FrameBackwardPlugin, FrameForwardPlugin, FrameLabelPlugin, FramePlugin, GlowFilterPlugin,
            HexColorsPlugin, QuaternionsPlugin, RemoveTintPlugin, RoundPropsPlugin, ScalePlugin, ScrollRectPlugin,
            SetSizePlugin, ShortRotationPlugin, TintPlugin, TransformMatrixPlugin, VisiblePlugin, VolumePlugin]);

        _root.xvm_onUpdateConfig = this.xvm_onUpdateConfig;

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, StatLoader.LoadData);
        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, onConfigLoaded);
    }

    public function xvm_onUpdateConfig():Void
    {
        Config.instance.GetConfigCallback.apply(Config.instance, arguments);
    }

    private function setShowExInfoFlagImpl(flag)
    {
        base.setShowExInfoFlag(flag);

        if (!Config.config.hotkeys.markersAltMode.enabled)
            return;
        if (Config.config.hotkeys.markersAltMode.onHold)
            isAltMode = flag;
        else if (flag)
            isAltMode = !isAltMode;
        else
            return;

        GlobalEventDispatcher.dispatchEvent(new VMMEvent(VMMEvent.ALT_STATE_INFORM, isAltMode));
    }

    private function onConfigLoaded()
    {
        for (var i in _root.vehicleMarkersCanvas)
        {
            var marker:net.wargaming.ingame.VehicleMarker = _root.vehicleMarkersCanvas[i];
            if (marker != null)
            {
                if (Config.config.markers.useStandardMarkers == true)
                    marker.marker.marker.icon["_xvm_colorized"] = false;
                marker.m_markerLabel = "";
                marker.updateMarkerLabel();
                marker.update();
            }
        }
    }
}
