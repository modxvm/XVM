import com.xvm.*;
import wot.Minimap.*;

/**
 * Handles minimap windows zoom and center positioning
 * by key pressing
 */
class wot.Minimap.view.Zoom
{
    // Stores state for switcher
    private static var currentState:Boolean = true;

    private static var DELAY_BEFORE_DEATH_LOG_FIX:Number = 10;

    private var timer;

    /**
     * #################
     * TODO: fix messages at right side while zoomed
     */

    public function Zoom()
    {
        GlobalEventDispatcher.addEventListener(Defines.E_MM_ZOOM, this, onZoomKeyClick)
    }

    public function Dispose()
    {
        GlobalEventDispatcher.removeEventListener(Defines.E_MM_ZOOM, this, onZoomKeyClick)
    }

    /**
     * Zoom while key is on hold
     * or switch zoom when key is clicked
     */
    public function onZoomKeyClick(e:Object):Void
    {
        if (!MinimapProxy.wrapper.visible)
            return;
        if (Config.config.hotkeys.minimapZoom.onHold)
        {
            holdBehaviour(e.isDown);
        }
        else if (e.isDown)
        {
            switchBehaviour();
        }
    }

    // -- Private

    private function holdBehaviour(isZoomKeyDown:Boolean):Void
    {
        if (isZoomKeyDown)
        {
            zoomIn();
        }
        else
        {
            zoomOut();
        }
    }

    private function switchBehaviour():Void
    {
        //Logger.add("sw: " + currentState);
        if (currentState)
        {
            zoomIn();
            currentState = !currentState;
        }
        else
        {
            zoomOut();
            currentState = !currentState;
        }
    }

    private function zoomIn():Void
    {
        increaseSize();
        if (Minimap.config.zoom.centered)
        {
            centerPosition();
        }
        swapDepth();

        // Without timer fix is reverted immediately
        timer = _global.setInterval(this, "fixDeathLogPosition", DELAY_BEFORE_DEATH_LOG_FIX);
    }

    private function zoomOut():Void
    {
        bottomRightPosition();
        restoreSize();
        swapDepth();
    }

    private function centerPosition():Void
    {
        var wrapper:MovieClip = MinimapProxy.wrapper;

        // Position map bottom right corner at center
        wrapper._x = Stage.width / 2;
        wrapper._y = Stage.height / 2;

        // Offset position taking map center into account
        wrapper._x += wrapper.width / 2;
        wrapper._y += wrapper.height / 2;
    }

    private function bottomRightPosition():Void
    {
        var wrapper:MovieClip = MinimapProxy.wrapper;

        // Position map bottom right corner at bottom right of Stage
        wrapper._x = Stage.width;
        wrapper._y = Stage.height;
    }

    private function increaseSize():Void
    {
        var wrapper:MovieClip = MinimapProxy.wrapper;
        var side:Number = Stage.height - Minimap.config.zoom.pixelsBack;
        wrapper.setSize(side, side);
        wrapper.invalidateMarkers();
        wrapper.validateNow();
    }

    private function restoreSize():Void
    {
        var wrapper:MovieClip = MinimapProxy.wrapper;
        wrapper.setupSize(wrapper.m_sizeIndex, Stage.height);
        wrapper.invalidateMarkers();
        wrapper.validateNow();
    }

    /**
     * Moves zoomed minimap back and forth
     * relative to other overlapping clips.
     * Overlapping clips prevent minimap sector click.
     */
    private function swapDepth():Void
    {
        MinimapProxy.wrapper.swapDepths(battleStartTimerClip);
    }

    /**
     * Death log list position is moved to the top of minimap
     * each time minimap size changes.
     * List position becomes too high while minimap is zoomed.
     *
     * Fix is here.
     */
    private function fixDeathLogPosition():Void
    {
        _global.clearInterval(timer);
        _root.playerMessangersPanel._y = Stage.height;
    }

    private function get battleStartTimerClip():MovieClip
    {
        return _root.timerBig;
    }
}
