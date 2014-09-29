import com.xvm.*;
import wot.Minimap.*;
import wot.Minimap.model.*;
import wot.Minimap.model.externalProxy.*;

/**
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.Minimap
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.ingame.Minimap;
    public var base:net.wargaming.ingame.Minimap;

    public function Minimap(wrapper:net.wargaming.ingame.Minimap, base:net.wargaming.ingame.Minimap)
    {
        this.wrapper = wrapper;
        this.base = base;
        MinimapProxy.setReferences(base, wrapper);
        wrapper.xvm_worker = this;
        MinimapCtor();
    }

    function onEntryInited()
    {
        return this.onEntryInitedImpl.apply(this, arguments);
    }

    function correctSizeIndex()
    {
        return this.correctSizeIndexImpl.apply(this, arguments);
    }

    function sizeUp()
    {
        return this.sizeUpImpl.apply(this, arguments);
    }

    function scaleMarkers()
    {
        return this.scaleMarkersImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    public function MinimapCtor()
    {
        Utils.TraceXvmModule("Minimap");

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, updateEntries);
        GlobalEventDispatcher.addEventListener(Defines.E_BATTLE_STATE_CHANGED, this, updateEntries);
        GlobalEventDispatcher.addEventListener(MinimapEvent.REFRESH, this, updateEntries);
        GlobalEventDispatcher.addEventListener(MinimapEvent.MINIMAP_READY, this, onReady);
        GlobalEventDispatcher.addEventListener(MinimapEvent.PANEL_READY, this, onReady);

        GlobalEventDispatcher.addEventListener(Defines.E_MOVING_STATE_CHANGED, this, onMovingStateChanged);
        GlobalEventDispatcher.addEventListener(Defines.E_STEREOSCOPE_TOGGLED, this, onStereoscopeToggled);

        checkLoading();
    }

    /**
     * icons Z indexes from Minimap.pyc:
     *  _BACK_ICONS_RANGE = (25, 49)
     *  _DEAD_VEHICLE_RANGE = (50, 99)
     *  _VEHICLE_RANGE = (101, 150)
     *  _FIXED_INDEXES = {'cameraNormal': 100,
     *  'self': 151,
     *  'cameraStrategic': 152,
     *  'cell': 153 }
     */
    public static var MAX_DEAD_ZINDEX:Number = 99;
    public static var LABELS:Number = MAX_DEAD_ZINDEX;
    public static var SQUARE_1KM_INDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var EXTERNAL_CUSTOM_INDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var CAMERA_NORMAL_ZINDEX:Number = 100;
    public static var SELF_ZINDEX:Number = 151;

    private var isMinimapReady:Boolean = false;
    private var isPanelReady:Boolean = false;
    private var loadComplete:Boolean = false;
    private var mapExtended:Boolean = false;
    private var stereoscope_exists:Boolean = false;
    private var stereoscope_enabled:Boolean = false;
    private var is_moving:Boolean = false;

    function scaleMarkersImpl(factor:Number)
    {
        if (!Config.config)
        {
            var me = this;
            _global.setTimeout(function() { me.scaleMarkersImpl(factor); }, 1);
            return;
        }

        if (MapConfig.enabled)
        {
            Features.instance.scaleMarkers();
        }
        else
        {
            /** Original WG scaling behaviour */
            base.scaleMarkers(factor);
        }
    }

    function onEntryInitedImpl()
    {
        base.onEntryInited();

        if (mapExtended)
        {
            //Logger.add("Minimap.onEntryInitedImpl()#extended");
            SyncModel.instance.updateIconUids();

            /**
             * Camera object reconstruction occurs sometimes and all its previous props are lost.
             * Check if alpha is set.
             */
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ON_ENTRY_INITED));
            Features.instance.setCameraAlpha();
        }
    }

    function correctSizeIndexImpl(sizeIndex:Number, stageHeight:Number):Number
    {
        var featureSizeIndex:Number = Features.instance.disableMapWindowSizeLimitation(sizeIndex);

        return featureSizeIndex;
    }

    /** Suitable for manual debug tracing by pushing "=" button */
    function sizeUpImpl()
    {
        base.sizeUp();
    }

    // -- Private

    private function onConfigLoaded()
    {
        if (Config.config.minimap.enabled && Config.config.minimapAlt.enabled)
            GlobalEventDispatcher.addEventListener(Defines.E_MM_ALT_MODE, this, setAltMode);
        updateEntries();
    }

    private function checkLoading():Void
    {
        wrapper.icons.onEnterFrame = function()
        {
            if (this.MinimapEntry0)
            {
                delete this.onEnterFrame;
                GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.MINIMAP_READY));
            }
        }
    }

    private function onReady(event:MinimapEvent):Void
    {
        switch (event.type)
        {
            case MinimapEvent.MINIMAP_READY:
                isMinimapReady = true;
                break;
            case MinimapEvent.PANEL_READY:
                isPanelReady = true;
                break;
        }

        loadComplete = isMinimapReady && isPanelReady;

        if (loadComplete && MapConfig.enabled && !mapExtended)
        {
            startExtendedProcedure();
            mapExtended = true;
        }
    }

    private function updateEntries():Void
    {
        var entries:Array = IconsProxy.allEntries;
        for (var i in entries)
            entries[i].invalidate();
    }

    private function startExtendedProcedure():Void
    {
        SyncModel.instance.updateIconUids();

        _global.setTimeout(function() { Features.instance.applyMajorMods(); }, 1);
    }

    private function onMovingStateChanged(event)
    {
        is_moving = event.value;
    }

    private function onStereoscopeToggled(event)
    {
        if (stereoscope_exists == false && event.value == true)
            stereoscope_exists = true;
        stereoscope_enabled = event.value;
    }

    private function setAltMode(e:Object):Void
    {
        if (!mapExtended)
            return;

        //Logger.add("setAltMode: " + e.isDown);
        if (Config.config.hotkeys.minimapAltMode.onHold)
            MapConfig.isAltMode = e.isDown;
        else if (e.isDown)
            MapConfig.isAltMode = !MapConfig.isAltMode;
        else
            return;

        GlobalEventDispatcher.dispatchEvent( { type: MinimapEvent.REFRESH } );
        if (stereoscope_exists)
        {
            var en:Boolean = stereoscope_enabled;
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_STEREOSCOPE_TOGGLED, value: true } );
            if (en == false)
                GlobalEventDispatcher.dispatchEvent( { type: Defines.E_STEREOSCOPE_TOGGLED, value: false } );
        }
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MOVING_STATE_CHANGED, value: is_moving } );
    }
}
