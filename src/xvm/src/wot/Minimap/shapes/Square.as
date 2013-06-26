import com.xvm.Logger;
import com.xvm.VehicleInfo;
import wot.Minimap.Minimap;
import wot.PlayersPanel.PlayersPanelProxy;
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

    public function Square()
    {
        /** Disable square mod if user is artillery class*/
        if (!MapConfig.artiEnabled && isArtillery())
        {
            return;
        }

        super();

        var mc:MovieClip = createSquareClip();
        defineStyle(mc);
        drawLines(mc);
        updatePosition(mc);
    }

    //--Private

    private function createSquareClip():MovieClip
    {
        return IconsProxy.createEmptyMovieClip("square", Minimap.SQUARE_1KM_INDEX);
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
        IconsProxy.setOnEnterFrame(function()
        {
            var selfMC:MovieClip = IconsProxy.selfEntry.wrapper;
            this.square._x = selfMC._x;
            this.square._y = selfMC._y;
        });
    }

    private function isArtillery():Boolean
    {
        var vi2 = VehicleInfo.getInfo2(PlayersPanelProxy.self.icon);
        return vi2 == null ? false : vi2.type == "SPG";
    }
}
