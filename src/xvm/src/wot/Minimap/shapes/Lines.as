import flash.geom.Point;
import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
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
        
        attachCameraLines();
        attachVehicleDirectionLines();
        if (rightAngle != 1)
        {
            /**
             * Tanks without hull gun constraints has 1 angle degree for each side.
             * No need to attach traverse angle
             */
            attachVehicleTraverseAngle();
        }
        
        /**
         * Warning! Workaround!
         * Camera entry (MinimapEntry0) is reinitialized spontaniously many times in a round.
         */
        GlobalEventDispatcher.addEventListener(MinimapEvent.ON_ENTRY_INITED, this, onEntryInited);
    }
    
    // -- Private
    
    private function attachVehicleDirectionLines():Void
    {
        var depth:Number = attachments.getNextHighestDepth();
        var vehLines:MovieClip = attachments.createEmptyMovieClip("vehLine" + depth, depth);
        attachLines(vehLines, MapConfig.linesVehicle, 0);
    }
    
    private function attachVehicleTraverseAngle():Void
    {
        var depth:Number = attachments.getNextHighestDepth();
        var traverseAgnle:MovieClip = attachments.createEmptyMovieClip("traverseAgnle" + depth, depth);
        attachLines(traverseAgnle, MapConfig.linesTraverseAngle, rightAngle);
        attachLines(traverseAgnle, MapConfig.linesTraverseAngle, -leftAngle);
    }
    
    private function attachCameraLines():Void
    {
        var cameraEntry:MinimapEntry = IconsProxy.getCamera();
        cameraEntry.cameraExtendedToken = true;
        var depth:Number = cameraEntry.getNextHighestDepth();
        var vehLines:MovieClip = cameraEntry.createEmptyMovieClip("cameraLine" + depth, 10000);
        attachLines(vehLines, MapConfig.linesCamera, 0);
    }
    
    private function attachLines(mc:MovieClip, linesCfg:Array, angle:Number):Void
    {
        for (var i in linesCfg)
        {
            var lineCfg:LineCfg = linesCfg[i];
            
            if (lineCfg.enabled)
            {
                var from:Point = horAnglePoint(lineCfg.from, angle);
                var to  :Point = horAnglePoint(lineCfg.to, angle);
                
                /** Translate absolute minimap distance in points to game meters */
                if (lineCfg.inmeters)
                {
                    from.y *= scaleFactor;
                    to.y   *= scaleFactor;
                    from.x *= scaleFactor;
                    to.x   *= scaleFactor;
                }
                
                drawLine(mc, from, to, lineCfg.thickness, lineCfg.color, lineCfg.alpha);
            }
        }
    }
    
    private function horAnglePoint(R:Number, angle:Number):Point
    {
        angle = angle * (Math.PI / 180);
        return new Point(R * Math.sin(angle), R * Math.cos(angle));
    }
    
    private function drawLine(mc:MovieClip, from:Point, to:Point, thickness:Number, color:Number, alpha:Number):Void
    {
        mc.lineStyle(thickness, color, alpha);
        
        mc.moveTo(from.x, -from.y);
        mc.lineTo(to.x, -to.y);
    }
    
    private function onEntryInited(event:MinimapEvent):Void
    {
        /**
         * Check if camera has lines attached.
         * Camera object reconstruction occurs sometimes and all its previous props are lost.
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
