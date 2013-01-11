import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.Minimap.MinimapEntry;
import wot.Minimap.model.IconsProxy;
import wot.Minimap.model.MapConfig;
import wot.Minimap.ShapeAttach;
import wot.Minimap.dto.LineCfg;

/**
 * Draws lines of sight and horizontal focusing angles
 */

class wot.Minimap.Lines extends ShapeAttach
{
    public function Lines(mapSizeInMeters:Number) 
    {
        super(mapSizeInMeters);
        
        attachVehicleLines();
        attachCameraLines();
        
        /**
         * Warning! Workaround!
         * Camera entry (MinimapEntry0) is reinitialized spontaniously many times in a round.
         */
        GlobalEventDispatcher.addEventListener(MinimapEvent.ON_ENTRY_INITED, this, onEntryInited);
    }
    
    // -- Private
    
    private function attachVehicleLines():Void
    {
        var depth:Number = icon.getNextHighestDepth();
        var self:MovieClip = icon.createEmptyMovieClip("vehLine" + depth, depth);
        attachLines(self, MapConfig.linesVehicle);
    }
    
    private function attachCameraLines():Void
    {
        var cameraEntry:MinimapEntry = IconsProxy.getCamera();
        cameraEntry.cameraExtendedToken = true;
        var depth:Number = cameraEntry.getNextHighestDepth();
        var vehLines:MovieClip = cameraEntry.createEmptyMovieClip("cameraLine" + depth, 10000);
        attachLines(vehLines, MapConfig.linesCamera);
    }
    
    private function attachLines(mc:MovieClip, linesCfg:Array):Void
    {
        for (var i in linesCfg)
        {
            var lineCfg:LineCfg = linesCfg[i];
            
            if (lineCfg.enabled)
            {
                var from:Number = lineCfg.from;
                var to  :Number = lineCfg.to;
                if (lineCfg.inmeters)
                {
                    from *= metersPerPoint;
                    to   *= metersPerPoint;
                }
                
                drawLine(mc, from, to, lineCfg.thickness, lineCfg.color, lineCfg.alpha);
            }
        }
    }
    
    private function drawLine(mc:MovieClip, from:Number, to:Number, thickness:Number, color:Number, alpha:Number):Void
    {
        mc.lineStyle(thickness, color, alpha);
        
        mc.moveTo(0, -from);
        mc.lineTo(0, -to);
    }
    
    private function onEntryInited(event:MinimapEvent):Void
    {
        /**
         * Check if camera has lines attached.
         * Camera entry could be reinitialized.
         * Reattach lines in that case.
         */
        var cam:Object = IconsProxy.getCamera();
        if (!cam.cameraExtendedToken)
        {
            attachCameraLines();
        }
    }
}
