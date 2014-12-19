/**
 * @author ilitvinov87(at)gmail.com
 * @author m.schedriviy(at)gmail.com
 */

import com.xvm.*;
import gfx.io.*;
import net.wargaming.ingame.Minimap;
import wot.Minimap.*;
import wot.Minimap.model.*;
import wot.Minimap.model.externalProxy.*;

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

    function scaleMarkers()
    {
        return this.scaleMarkersImpl.apply(this, arguments);
    }

    function correctSizeIndex()
    {
        return this.correctSizeIndexImpl.apply(this, arguments);
    }

    function draw()
    {
        return this.drawImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    public function MinimapCtor()
    {
        Utils.TraceXvmModule("Minimap");

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_MOVING_STATE_CHANGED, this, onMovingStateChanged);
        GlobalEventDispatcher.addEventListener(Defines.E_STEREOSCOPE_TOGGLED, this, onStereoscopeToggled);
    }

    function scaleMarkersImpl(factor:Number)
    {
        //Logger.add("scaleMarkers");
        if (MapConfig.enabled)
        {
            Features.instance.scaleMarkers();
        }
        else
        {
            // Original WG scaling behavior
            base.scaleMarkers(factor);
        }
    }

    function correctSizeIndexImpl(sizeIndex:Number, stageHeight:Number):Number
    {
        if (sizeIndex < MinimapConstants.MAP_MIN_ZOOM_INDEX)
            sizeIndex = MinimapConstants.MAP_MIN_ZOOM_INDEX;
        if (sizeIndex > MinimapConstants.MAP_MAX_ZOOM_INDEX)
            sizeIndex = MinimapConstants.MAP_MAX_ZOOM_INDEX;
        return sizeIndex;
    }

    function drawImpl()
    {
        var sizeIsInvalid:Boolean = wrapper.sizeIsInvalid;
        base.draw();
        if (sizeIsInvalid)
            GlobalEventDispatcher.dispatchEvent( { type: MinimapEvent.REFRESH } );
    }

    // -- Private

    private function onConfigLoaded()
    {
        if (Config.config.minimap.enabled && Config.config.minimapAlt.enabled)
            GlobalEventDispatcher.addEventListener(Defines.E_MM_ALT_MODE, this, setAltMode);

        if (MapConfig.enabled)
            checkLoading();
    }

    private function checkLoading():Void
    {
        var $this = this;
        wrapper.icons.onEnterFrame = function():Void
        {
            if (this.MinimapEntry0)
            {
                delete this.onEnterFrame;
                GlobalEventDispatcher.dispatchEvent( { type: MinimapEvent.REFRESH } );
            }
        }
    }

    // Dynamic circles

    private var stereoscope_exists:Boolean = false;
    private var stereoscope_enabled:Boolean = false;
    private var is_moving:Boolean = false;

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
