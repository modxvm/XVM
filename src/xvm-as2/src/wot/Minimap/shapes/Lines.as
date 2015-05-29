import com.xvm.*;
import flash.geom.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.shapes.*;
import wot.Minimap.dataTypes.cfg.*;

/**
 * Draws lines of sight and horizontal focusing angles
 */

class wot.Minimap.shapes.Lines extends ShapeAttach
{
    private var camAttach:MovieClip = null;
    private var vehLines:MovieClip = null;
    private var traverseAngle:MovieClip = null;

    public function Lines()
    {
        super();

        attachCameraLines();
        attachVehicleDirectionLines();
        var angle = rightAngle;
        Logger.add("angle=" + angle);
        if (angle && angle != 1)
        {
            /**
             * Tanks without hull gun constraints has 1 angle degree for each side.
             * No need to attach traverse angle
             */
            attachVehicleTraverseAngle();
        }

        /**
         * Warning! Workaround!
         * Camera entry (MinimapEntry1) is reinitialized spontaniously many times in a round.
         */
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_INITED, this, onEntryInited);
        GlobalEventDispatcher.addEventListener(MinimapEvent.CAMERA_UPDATED, this, onEntryInited);
    }

    public function Dispose()
    {
        GlobalEventDispatcher.removeEventListener(MinimapEvent.ENTRY_INITED, this, onEntryInited);
        GlobalEventDispatcher.removeEventListener(MinimapEvent.CAMERA_UPDATED, this, onEntryInited);

        if (camAttach != null)
        {
            camAttach.removeMovieClip();
            delete camAttach;
        }

        if (vehLines != null)
        {
            vehLines.removeMovieClip();
            delete vehLines;
        }

        if (traverseAngle != null)
        {
            traverseAngle.removeMovieClip();
            delete traverseAngle;
        }

        super.Dispose();
    }

    // -- Private

    private function attachVehicleDirectionLines():Void
    {
        var depth:Number = selfAttachments.getNextHighestDepth();
        vehLines = selfAttachments.createEmptyMovieClip("vehLine" + depth, depth);
        attachLines(vehLines, MapConfig.linesVehicle, 0);
    }

    private function attachVehicleTraverseAngle():Void
    {
        var depth:Number = selfAttachments.getNextHighestDepth();
        traverseAngle = selfAttachments.createEmptyMovieClip("traverseAngle" + depth, depth);
        attachLines(traverseAngle, MapConfig.linesTraverseAngle, rightAngle);
        attachLines(traverseAngle, MapConfig.linesTraverseAngle, -leftAngle);
    }

    private function attachCameraLines():Void
    {
        //Logger.add("attachCameraLines");
        var cameraEntry:net.wargaming.ingame.MinimapEntry = IconsProxy.cameraEntry;
        cameraEntry.xvm_worker.cameraExtendedToken = true;
        if (!isSelfDead || Config.config.minimap.showCameraLineAfterDeath)
        {
            camAttach = cameraEntry.xvm_worker.attachments;
            var depth:Number = camAttach.getNextHighestDepth();
            var cameraLine:MovieClip = camAttach.createEmptyMovieClip("cameraLine" + depth, 10000);
            attachLines(cameraLine, MapConfig.linesCamera, 0);
        }
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

    private function onEntryInited(e:MinimapEvent):Void
    {
        //Logger.add("Lines.onEntryInited");
        /**
         * Check if camera has lines attached.
         * Camera object reconstruction occurs sometimes and all its previous props are lost.
         * Reattach lines in that case.
         */
        var entry = e.entry;
        if (entry == null)
            return;
        if (entry == IconsProxy.cameraEntry)
        {
            if (!entry.xvm_worker.cameraExtendedToken)
            {
                attachCameraLines();
            }
        }
    }

    private function get leftAngle():Number
    {
        return gunConstraints.left.angle._currentframe;
    }

    private function get rightAngle():Number
    {
        return gunConstraints.right.angle._currentframe;
    }

    private function get gunConstraints():Object
    {
        return net.wargaming.ingame.damagePanel.TankIndicator(_root.damagePanel.tankIndicator).hull.gunConstraints;
    }
}
