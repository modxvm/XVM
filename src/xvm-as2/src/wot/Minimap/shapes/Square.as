import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.shapes.*;

class wot.Minimap.shapes.Square extends ShapeAttach
{
    /**
     * Draw 1km x 1km rectangle.
     * Represents maximum draw distance.
     * Game engine limitation.
     */

    private static var SQUARE_SIDE_IN_METERS:Number = 1000;

    private var squareClip:MovieClip = null;

    public function Square()
    {
        // Disable square mod if user is artillery class
        if (!Minimap.config.square.artilleryEnabled && isArtillery())
            return;

        super();

        if (isSelfDead)
            return;

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
        return IconsProxy.createEmptyMovieClip("square", MinimapConstants.SQUARE_1KM_ZINDEX);
    }

    private function defineStyle():Void
    {
        var cfg:Object = Minimap.config.square;
        squareClip.lineStyle(cfg.thickness, parseInt(cfg.color, 16), cfg.alpha, null, null, "none");
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
            var selfMC:MovieClip = IconsProxy.selfEntry;
            this.square._x = selfMC._x;
            this.square._y = selfMC._y;
        });
    }

    private function isArtillery():Boolean
    {
        var bs:BattleStateData = BattleState.getSelfUserData();
        var vdata:VehicleData = VehicleInfo.get(bs.vehId);
        return vdata == null ? false : vdata.vclass == "SPG";
    }

    // override
    private function postmortemMod(event)
    {
        squareClip._visible = false;
        super.postmortemMod(event);
    }
}
