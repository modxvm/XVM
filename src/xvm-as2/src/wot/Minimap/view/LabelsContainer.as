import com.xvm.*;
import flash.geom.*;
import wot.Minimap.*;
import wot.Minimap.dataTypes.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.view.*;
import wot.PlayersPanel.*;

class wot.Minimap.view.LabelsContainer extends XvmComponent
{
    private static var _instance:LabelsContainer;

    /**
     * References to labelMc properties.
     * Cannot extend MovieClip class due to AS2 being crap language\framework\API.
     */
    public static var STATUS_FIELD_NAME:String = "lastStatus";
    public static var PLAYER_INFO_FIELD_NAME:String = "playerInfo";
    public static var ENTRY_NAME_FIELD_NAME:String = "entryName";
    public static var VEHICLE_CLASS_FIELD_NAME:String = "vehicleClass";

    // MinimapEntry requests a label
    public static function getLabel(uid:Number):MovieClip
    {
        //Logger.add("LabelsContainer.getLabel()");
        return instance._getLabel(uid);
    }

    // PRIVATE

    private static var CONTAINER_NAME:String = "labelsContainer";
    private static var OFFMAP_COORDINATE:Number = 500;
    private static var DEAD_DEPTH_START:Number = 100;
    private static var LOST_DEPTH_START:Number = 200;
    private static var ALIVE_DEPTH_START:Number = 300;

    private static var INVALIDATE_TYPE_DEFAULT:Number = 1;
    private static var INVALIDATE_TYPE_FORCE:Number = 2;

    private var holderMc:MovieClip;

    private var invalidateList:Object = {};

    private static function get instance():LabelsContainer
    {
        if (!_instance)
            _instance = new LabelsContainer();
        return _instance;
    }

    private function LabelsContainer()
    {
        var icons:MovieClip = MinimapProxy.wrapper.icons;
        holderMc = icons.createEmptyMovieClip(CONTAINER_NAME, wot.Minimap.Minimap.LABELS);

        GlobalEventDispatcher.addEventListener(MinimapEvent.REFRESH, this, onRefreshEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_REVEALED, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_LOST, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(Defines.E_PLAYER_DEAD, this, onMinimapEvent);
    }

    private function onMinimapEvent(e)
    {
        invalidateList[e.value] = INVALIDATE_TYPE_DEFAULT;
        invalidate();
    }

    private function onRefreshEvent(e)
    {
        for (var i:String in holderMc)
        {
            if (typeof(holderMc[i]) == "movieclip")
                invalidateList[i] = INVALIDATE_TYPE_FORCE;
        }
        invalidate();
    }

    // override
    function draw()
    {
        //Logger.add("LabelsContainer.updateLabelsStyle()");
        for (var uidStr:String in invalidateList)
        {
            var uid:Number = Number(uidStr);
            var force:Boolean = invalidateList[uidStr] == INVALIDATE_TYPE_FORCE;
            var labelMc:MovieClip = _getLabel(uid);
            var previousStatus:Number = labelMc[STATUS_FIELD_NAME];
            var actualStatus:Number = getPresenceStatus(uid);

            if (previousStatus != actualStatus || force)
            {
                labelMc[STATUS_FIELD_NAME] = actualStatus;
                recreateTextField(labelMc);
                updateLabelDepth(labelMc);
            }
        }
        invalidateList = { };
    }

    private function _getLabel(uid:Number):MovieClip
    {
        if (holderMc[uid] == null)
            createLabel(uid);
        return holderMc[uid];
    }

    private function createLabel(uid:Number):Void
    {
        //Logger.add("LabelsContainer.createLabel()");

        var entry:MinimapEntry = IconsProxy.entry(uid);
        var entryName = entry.wrapper.entryName;
        var vehicleClass = entry.wrapper.vehicleClass;

        var depth:Number = getFreeDepth(ALIVE_DEPTH_START);
        var labelMc:MovieClip = holderMc.createEmptyMovieClip(uid.toString(), depth);

        /**
         * References to labelMc properties.
         * Cannot extend MovieClip class due to AS2 being crap language\framework\API.
         */
        var playerInfo = PlayersPanelProxy.getPlayerInfo(uid);
        labelMc[PLAYER_INFO_FIELD_NAME] = playerInfo;
        labelMc[ENTRY_NAME_FIELD_NAME] = entryName;
        labelMc[VEHICLE_CLASS_FIELD_NAME] = vehicleClass;
        labelMc[STATUS_FIELD_NAME] = Player.PLAYER_REVEALED;
        Macros.RegisterMinimapMacros(playerInfo, MinimapEntry.getVehicleClassSymbol(vehicleClass));

        /**
         * Label stays at creation point some time before first move.
         * It makes unpleasant label positioning at map center.
         * Workaround.
         */
        var offmapPoint:Point = new Point(OFFMAP_COORDINATE, OFFMAP_COORDINATE);
        labelMc._x = offmapPoint.x;
        labelMc._y = offmapPoint.y;

        recreateTextField(labelMc);
    }

    private function recreateTextField(labelMc:MovieClip):Void
    {
        //Logger.add("LabelsContainer.recreateTextField()");

        var tf:TextField = labelMc[LabelViewBuilder.TEXT_FIELD_NAME];
        tf.removeTextField();

        LabelViewBuilder.createTextField(labelMc);
    }

    private function updateLabelDepth(labelMc:MovieClip):Void
    {
        //Logger.add("LabelsContainer.updateLabelDepth()");
        var status:Number = labelMc[STATUS_FIELD_NAME];
        var depth:Number;
        if (Math.abs(status) == Player.PLAYER_DEAD)
            depth = getFreeDepth(DEAD_DEPTH_START);
        else if (Math.abs(status) == Player.PLAYER_LOST)
            depth = getFreeDepth(LOST_DEPTH_START);
        else
            depth = getFreeDepth(ALIVE_DEPTH_START);

        labelMc.swapDepths(depth);
    }

    private function getFreeDepth(start:Number):Number
    {
        var depth:Number = start;
        while (holderMc.getInstanceAtDepth(depth))
        {
            depth++
        }

        return depth;
    }

    private function getPresenceStatus(uid:Number):Number
    {
        //Logger.add("LabelsContainer.getPresenceStatus()");
        var status:Number;

        if (IconsProxy.isIconIsPresentAtMinimap(uid))
        {
            status = Player.PLAYER_REVEALED;
        }
        else
        {
            /**
             * Guy is not present on minimap.
             * He is either dead or lost.
             * Uids that has never been seen are not passed to this method.
             */
            if (PlayersPanelProxy.isDead(uid))
            {
                status = Player.PLAYER_DEAD;
            }
            else
            {
                status = Player.PLAYER_LOST;
            }
        }

        var player:Player = PlayersPanelProxy.getPlayerInfo(uid);
        if (player.teamKiller)
        {
            /**
             * Set below zero.
             * Later this will be recognized at MapConfig too.
             */
            status *= Player.TEAM_KILLER_FLAG;
        }

        return status;
    }
}
