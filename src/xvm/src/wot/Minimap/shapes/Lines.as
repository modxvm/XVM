import flash.geom.Point;
import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.Minimap.MinimapEntry;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.Minimap.shapes.ShapeAttach;
import wot.Minimap.dataTypes.cfg.LineCfg;

/**
 * Draws lines of sight and horizontal focusing angles
 */

class wot.Minimap.shapes.Lines extends ShapeAttach
{
    public function Lines(mapSizeInMeters:Number) 
    {
        super(mapSizeInMeters);
        
        attachVehicleDirectionLines();
        attachVehicleTraverseAngle();
        attachCameraLines();
        
        /**
         * Warning! Workaround!
         * Camera entry (MinimapEntry0) is reinitialized spontaniously many times in a round.
         */
        GlobalEventDispatcher.addEventListener(MinimapEvent.ON_ENTRY_INITED, this, onEntryInited);
    }
    
    // -- Private
    
    private function attachVehicleDirectionLines():Void
    {
        var depth:Number = icon.getNextHighestDepth();
        var self:MovieClip = icon.createEmptyMovieClip("vehLine" + depth, depth);
        attachLines(self, MapConfig.linesVehicle);
    }
    
    private function attachVehicleTraverseAngle():Void
    {
        Logger.add("attachVehicleTraverseAngle");
        var from:Point = horAnglePoint(50, leftAngle);
        var to:Point   = horAnglePoint(100, leftAngle);
        
        icon.lineStyle(2, 0x00FFFF, 90);
        
        icon.moveTo(from.x, -from.y);
        icon.lineTo(to.x, -to.y);
    }
    
    private function horAnglePoint(R:Number, angle:Number):Point
    {
        angle = (90 - angle) * (Math.PI / 180);
        return new Point(R * Math.cos(angle), R * Math.sin(angle));
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
    
    private function get leftAngle():Number
    {
        return _root.damagePanel.tankIndicator.hull.gunConstraints.left.angle._currentframe;
    }
    
    private function get rightAngle():Number
    {
        return _root.damagePanel.tankIndicator.hull.gunConstraints.right.angle._currentframe;
    }
}
