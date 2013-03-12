import wot.Minimap.Minimap;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.utils.Logger;

/**
 * Handles minimap windows zoom and center positioning
 * by key pressing
 */
class wot.Minimap.Zoom
{
    /** This is the subject of resize reposition */
    var minimap:Minimap;
    
    /** Temporary place to store last normal map size value before resize procedure by zoom */
    var prevSizeIndex:Number;
    
    /** Stores state for switcher */
    var currentState:Boolean;
    
    public function Zoom(minimap:Minimap) 
    {
        this.minimap = minimap;
        currentState = true;
    }
    
    public function onZoomKeyClick(event)
    {
        /**
         * Zoom while key is on hold
         * or switch zoom when key is pressed
         */
        var isKeyDown:Boolean = event.details.value == "keyDown";
        
        Logger.addObject(event, "event", 3);
        
        if (MapConfig.zoomHold)
        {
            holdBehaviour(isKeyDown);
        }
        else if (isKeyDown)
        {
            switchBehaviour();
        }
    }
    
    // -- Private
    
    private function holdBehaviour(isKeyDown:Boolean):Void
    {
        if (isKeyDown)
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
        if (MapConfig.zoomCentered)
        {
            centerPosition();
        }
    }
    
    private function zoomOut():Void
    {
        bottomRightPosition();
        restoreSize();
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
        prevSizeIndex = minimap.m_sizeIndex;
        
        /** Set maximum size fitting on screen */
        while (minimap.height < Stage.height)
        {
            minimap.sizeUp();
        }
        
        /**
         * Decrease size by a few steps.
         * Client decides number of steps.
         * Makes maximized map no so huge.
         */
        for (var i:Number = MapConfig.zoomStepsBack; i != 0; i--)
        {
            minimap.sizeDown();
        }
    }
    
    private function restoreSize():Void
    {
        minimap.setupSize(prevSizeIndex, Stage.height);
    }
}
