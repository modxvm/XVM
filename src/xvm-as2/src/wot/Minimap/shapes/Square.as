import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.shapes.*;
import wot.PlayersPanel.*;

class wot.Minimap.shapes.Square extends ShapeAttach
{
    /**
     * Draw 1km x 1km box.
     * Represents maximun draw distance.
     * Game engine limitation.
     */

    private static var SQUARE_SIDE_IN_METERS:Number = 1000;

    private var squareClip:MovieClip = null;

    public function Square()
    {
        /** Disable square mod if user is artillery class*/
        if (!MapConfig.artiEnabled && isArtillery())
        {
            return;
        }

        super();

        squareClip = createSquareClip();
        defineStyle();
        drawLines();
        updatePosition();
    }

    public function Dispose()
    {
        if (squareClip != null)
        {
            squareClip.removeMovieClip();
            delete squareClip;
        }
    }

    //--Private

    private function createSquareClip():MovieClip
    {
        return IconsProxy.createEmptyMovieClip("square", Minimap.SQUARE_1KM_INDEX);
    }

    private function defineStyle():Void
    {
        var config:Object = MapConfig.squareConfig;

        squareClip.lineStyle(config.thickness, parseInt(config.color, 16), config.alpha, null, null, "none");
    }

    private function drawLines():Void
    {
        var offset:Number = scaleFactor * SQUARE_SIDE_IN_METERS / 2;

        /** Top line */
        squareClip.moveTo(-offset, -offset);
        squareClip.lineTo( offset, -offset);

        /** Right line */
        squareClip.moveTo( offset, -offset);
        squareClip.lineTo( offset,  offset);

        /** Bottom line */
        squareClip.moveTo( offset,  offset);
        squareClip.lineTo(-offset,  offset);

        /** Uper line */
        squareClip.moveTo(-offset,  offset);
        squareClip.lineTo( -offset, -offset);
    }

    private function updatePosition():Void
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
        var vdata:VehicleData = VehicleInfo.getByIcon(PlayersPanelProxy.self.icon);
        return vdata == null ? false : vdata.vclass == "SPG";
    }

    /** overwrite */
    private function postmortemMod(event) {
        squareClip._visible = false;
        super.postmortemMod.apply(arguments);
    }
}
