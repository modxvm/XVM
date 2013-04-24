import wot.Minimap.dataTypes.Player;
import com.xvm.VehicleInfo;
import com.xvm.VehicleInfoData2;
import wot.Minimap.model.externalProxy.PlayersPanelProxy;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.Minimap.shapes.ShapeAttach;
import wot.Minimap.model.externalProxy.MapConfig;

class wot.Minimap.shapes.Square extends ShapeAttach
{
    /**
     * Draw 1km x 1km box.
     * Represents maximun draw distance.
     * Game engine limitation.
     */

    private static var SQUARE_SIDE_IN_METERS:Number = 1000;

    public function Square(mapSizeInMeters:Number)
    {
        /** Disable square mod if user is artillery class*/
        if (!MapConfig.artiEnabled && isArtillery())
        {
            return;
        }

        super(mapSizeInMeters);

        var mc:MovieClip = createSquareClip();
        defineStyle(mc);
        drawLines(mc);
        updatePosition(mc);
    }

    //--Private

    private function createSquareClip():MovieClip
    {
        return icons.createEmptyMovieClip("square", wot.Minimap.Minimap.SQUARE_1KM_INDEX);
    }

    private function defineStyle(mc:MovieClip):Void
    {
        var config:Object = MapConfig.squareConfig;

        mc.lineStyle(config.thickness, parseInt(config.color, 16), config.alpha, null, null, "none");
    }

    private function drawLines(mc:MovieClip):Void
    {
        var offset:Number = scaleFactor * SQUARE_SIDE_IN_METERS / 2;

        /** Top line */
        mc.moveTo(-offset, -offset);
        mc.lineTo( offset, -offset);

        /** Right line */
        mc.moveTo( offset, -offset);
        mc.lineTo( offset,  offset);

        /** Bottom line */
        mc.moveTo( offset,  offset);
        mc.lineTo(-offset,  offset);

        /** Uper line */
        mc.moveTo(-offset,  offset);
        mc.lineTo( -offset, -offset);
    }

    private function updatePosition(mc:MovieClip):Void
    {
        icons.onEnterFrame = function()
        {
            var self:MovieClip = IconsProxy.getSelf();
            this.square._x = self._x;
            this.square._y = self._y;
        }
    }

    private function isArtillery():Boolean
    {
        var self:Player = PlayersPanelProxy.getSelf();
        var systemVehType:String =  VehicleInfo.getName2(self.icon);

        return VehicleInfoData2.data[systemVehType].type == "SPG"
    }

    private function get icons():MovieClip
    {
        return IconsProxy.getIcons();
    }
}
