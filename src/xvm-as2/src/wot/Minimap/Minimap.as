/**
 * @author ilitvinov87(at)gmail.com
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

import com.xvm.*;
import com.xvm.DataTypes.*;
import com.xvm.events.*;
import wot.Minimap.*;

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

    private static var _isAltMode:Boolean = false;

    public static function get config():Object
    {
        return _isAltMode ? Config.config.minimapAlt : Config.config.minimap;
    }

    private var minimap_path:Array;
    private var minimap_path_mc:MovieClip;

    public function MinimapCtor()
    {
        Utils.TraceXvmModule("Minimap");

        GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, this, onConfigLoaded);
        GlobalEventDispatcher.addEventListener(Events.E_MOVING_STATE_CHANGED, this, onMovingStateChanged);
        GlobalEventDispatcher.addEventListener(Events.E_STEREOSCOPE_TOGGLED, this, onStereoscopeToggled);
        GlobalEventDispatcher.addEventListener(Events.XMQP_MINIMAP_CLICK, this, onXmqpMinimapClickEvent);

        Mouse.addListener(this);
    }

    function scaleMarkersImpl(factor:Number)
    {
        //Logger.add("scaleMarkers");
        if (Minimap.config.enabled)
        {
            Features.scaleMarkers();
        }
        else
        {
            // Original WG scaling behavior
            base.scaleMarkers(factor);
        }
    }

    function correctSizeIndexImpl(sizeIndex:Number, stageHeight:Number, stageWidth:Number):Number
    {
        if (sizeIndex < MinimapConstants.MAP_MIN_ZOOM_INDEX)
            sizeIndex = MinimapConstants.MAP_MIN_ZOOM_INDEX;
        if (sizeIndex > MinimapConstants.MAP_MAX_ZOOM_INDEX)
            sizeIndex = MinimapConstants.MAP_MAX_ZOOM_INDEX;
        return sizeIndex;
    }

    function drawImpl()
    {
        //Cmd.profMethodStart("Minimap.draw()");

        var sizeIsInvalid:Boolean = wrapper.sizeIsInvalid;
        base.draw();
        if (sizeIsInvalid)
            GlobalEventDispatcher.dispatchEvent( { type: Events.MM_REFRESH } );

        //Cmd.profMethodEnd("Minimap.draw()");
    }

    // -- Private

    private function onConfigLoaded()
    {
        if (Config.config.minimap.enabled)
        {
            if (Config.config.minimapAlt.enabled)
                GlobalEventDispatcher.addEventListener(Events.E_MM_ALT_MODE, this, setAltMode);
            Features.init();
        }
    }

    // Dynamic circles and alt mode

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
            _isAltMode = e.isDown;
        else if (e.isDown)
            _isAltMode = !_isAltMode;
        else
            return;

        GlobalEventDispatcher.dispatchEvent( { type: Events.MM_REFRESH } );

        if (stereoscope_exists)
        {
            var en:Boolean = stereoscope_enabled;
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_STEREOSCOPE_TOGGLED, value: true } );
            if (en == false)
                GlobalEventDispatcher.dispatchEvent( { type: Events.E_STEREOSCOPE_TOGGLED, value: false } );
        }
        GlobalEventDispatcher.dispatchEvent( { type: Events.E_MOVING_STATE_CHANGED, value: is_moving } );
    }

    private function onMouseDown(button:Number, target, mouseIdx:Number, x:Number, y:Number, dblClick:Boolean)
    {
        if (target == wrapper.mapHit && !dblClick && button == Mouse.LEFT && _root.g_cursorVisible && Config.networkServicesSettings.xmqp)
        {
            //Logger.addObject(arguments, 1, "onMouseDown");
            x = int(wrapper.mapHit._xmouse);
            y = int(wrapper.mapHit._ymouse);
            minimap_path = [[x, y]];
            if (minimap_path_mc != null)
                minimap_path_mc.removeMovieClip();
            minimap_path_mc = wrapper.mapHit.createEmptyMovieClip("xmqp_mc_path", wrapper.mapHit.getNextHighestDepth());
            minimap_path_mc.lineStyle(1, Config.networkServicesSettings.x_minimap_clicks_color, 30);
            minimap_path_mc.moveTo(x, y);
            minimap_path_mc.lineTo(x + 0.1, y + 0.1);
        }
    }

    private function onMouseMove(mouseIdx:Number, x:Number, y:Number)
    {
        if (minimap_path != null && minimap_path.length < 20 && y != undefined)
        {
            //Logger.addObject(arguments, 1, "onMouseMove");
            if (wrapper.mapHit.hitTest(_root._xmouse, _root._ymouse))
            {
                x = int(wrapper.mapHit._xmouse);
                y = int(wrapper.mapHit._ymouse);

                var lastpos:Array = minimap_path[minimap_path.length - 1];
                var distance:Number = Math.sqrt(Math.pow(lastpos[0] - x, 2) + Math.pow(lastpos[1] - y, 2));
                if (distance > 20)
                {
                    minimap_path.push([x, y]);
                    minimap_path_mc.lineTo(x, y);
                }
            }
        }
    }

    private function onMouseUp(button:Number, target, mouseIdx:Number, x:Number, y:Number)
    {
        if (minimap_path != null)
        {
            if (button == Mouse.LEFT)
            {
                //Logger.addObject(arguments, 1, "onMouseUp");
                DAAPI.py_xvm_minimapClick(minimap_path);
                minimap_path = null;
                minimap_path_mc.removeMovieClip();
            }
        }
    }

    private function onXmqpMinimapClickEvent(e:Object)
    {
        //Logger.addObject(e, 3, "onXmqpMinimapClickEvent");
        var color:Number;
        if (!Config.config.xmqp.minimapClicksColor || Config.config.xmqp.minimapClicksColor == "")
        {
            color = e.data.color;
        }
        else
        {
            color = Number(Macros.FormatByPlayerId(e.value, Config.config.xmqp.minimapClicksColor).split("#").join("0x")) || e.data.color;
        }

        var depth:Number = wrapper.mapHit.getNextHighestDepth();
        var mc:MovieClip = wrapper.mapHit.createEmptyMovieClip("xmqp_mc_" + depth, depth);
        _global.setTimeout(function() { mc.removeMovieClip() }, Config.config.xmqp.minimapClicksTime * 1000);

        if (e.data.path != undefined)
        {
            var len:Number = e.data.path.length;
            if (len > 0)
            {
                var pos:Array;

                mc.lineStyle(3, color, 80);

                if (len > 1)
                {
                    pos = e.data.path[len - 1];
                    mc.moveTo(pos[0], pos[1]);
                    mc.lineTo(pos[0] + 0.1, pos[1] + 0.1);
                }

                pos = e.data.path[0];
                mc.moveTo(pos[0], pos[1]);
                mc.lineTo(pos[0] + 0.1, pos[1] + 0.1);

                mc.lineStyle(1, color, 80);
                for (var i:Number = 1; i < len; ++i)
                {
                    mc.lineTo(e.data.path[i][0], e.data.path[i][1]);
                }
            }
        }
    }
}
