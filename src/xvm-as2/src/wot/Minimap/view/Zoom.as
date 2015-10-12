import com.xvm.*;
import net.wargaming.ingame.*;
import wot.Minimap.MinimapProxy;
import wot.Minimap.model.externalProxy.*;

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
        if (!minimap.visible)
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
        if (Config.config.minimap.zoom.centered)
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
        /** Position map bottom right corner at center */
        minimap._x = Stage.width / 2;
        minimap._y = Stage.height / 2;

        /** Offset position taking map center into account */
        minimap._x += minimap.width / 2;
        minimap._y += minimap.height / 2;
    }

    private function bottomRightPosition():Void
    {
        /** Position map bottom right corner at bottom right of Stage */
        minimap._x = Stage.width;
        minimap._y = Stage.height;
    }

    private function increaseSize():Void
    {
        var side:Number = Stage.height - Config.config.minimap.zoom.pixelsBack;
        minimap.setSize(side, side);
        minimap.invalidateMarkers();
        minimap.validateNow();
    }

    private function restoreSize():Void
    {
        minimap.setupSize(minimap.m_sizeIndex, Stage.height);
        minimap.invalidateMarkers();
        minimap.validateNow();
    }

    /**
     * Moves zoomed minimap back and forth
     * relative to other overlapping clips.
     * Overlapping clips prevent minimap sector click.
     */
    private function swapDepth():Void
    {
        minimap.swapDepths(battleStartTimerClip);
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

    private function get minimap():Minimap
    {
        return MinimapProxy.wrapper;
    }

    private function get battleStartTimerClip():MovieClip
    {
        return _root.timerBig;
    }
}
