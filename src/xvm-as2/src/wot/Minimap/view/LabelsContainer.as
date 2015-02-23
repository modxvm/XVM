import com.xvm.*;
import com.xvm.DataTypes.BattleStateData;
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

    public static function init():Void
    {
        instance._init();
    }

    // MinimapEntry requests a label
    public static function getLabel(playerId:Number):MovieClip
    {
        //Logger.add("LabelsContainer.getLabel(" + playerId + ")");
        return instance._getLabel(playerId);
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
        holderMc = IconsProxy.createEmptyMovieClip(CONTAINER_NAME, MinimapConstants.LABELS_ZINDEX);

        GlobalEventDispatcher.addEventListener(MinimapEvent.REFRESH, this, onRefreshEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_INITED, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_UPDATED, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_LOST, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(Defines.E_PLAYER_DEAD, this, onPlayerDeadEvent);
    }

    private function _init()
    {
        // empty function required for instance creation
    }

    private function onMinimapEvent(e:MinimapEvent)
    {
        //Logger.add("e.value = " + e.value);
        //if (isNaN(e.value))
        //    Logger.addObject(e, 2, "onMinimapEvent: null value");
        invalidateList[e.value] = INVALIDATE_TYPE_DEFAULT;
        invalidate();
    }

    private function onPlayerDeadEvent(e:Object)
    {
        //Logger.add("(dead) e.value = " + e.value);
        //if (isNaN(e.value))
        //    Logger.addObject(e, 2, "onPlayerDeadEvent: null value");
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
        Cmd.profMethodStart("Minimap.Labels.draw()");

        //Logger.add("LabelsContainer.updateLabelsStyle()");
        for (var playerIdStr:String in invalidateList)
        {
            var playerId:Number = Number(playerIdStr);
            var force:Boolean = invalidateList[playerIdStr] == INVALIDATE_TYPE_FORCE;
            var labelMc:MovieClip = _getLabel(playerId);
            var previousStatus:Number = labelMc[STATUS_FIELD_NAME];
            var actualStatus:Number = getPresenceStatus(playerId);

            //Logger.add(playerId + " " + force + " " + previousStatus + " " + actualStatus);

            if (previousStatus != actualStatus || force)
            {
                labelMc[STATUS_FIELD_NAME] = actualStatus;
                LabelViewBuilder.removeTextField(labelMc);
                LabelViewBuilder.createTextField(labelMc);
                updateLabelDepth(labelMc);
            }
            else
            {
                LabelViewBuilder.updateTextField(labelMc);
            }
        }
        invalidateList = { };

        Cmd.profMethodStart("Minimap.Labels.draw()");
    }

    private function _getLabel(playerId:Number):MovieClip
    {

        if (holderMc[playerId] == null)
            createLabel(playerId);
        return holderMc[playerId];
    }

    private function createLabel(playerId:Number):Void
    {
        //Logger.add("LabelsContainer.createLabel()");

        var entry:MinimapEntry = IconsProxy.entry(playerId);
        var entryName = entry.wrapper.entryName;
        var vehicleClass = entry.wrapper.vehicleClass;

        var depth:Number = getFreeDepth(ALIVE_DEPTH_START);
        var labelMc:MovieClip = holderMc.createEmptyMovieClip(playerId.toString(), depth);

        /**
         * References to labelMc properties.
         * Cannot extend MovieClip class due to AS2 being crap language\framework\API.
         */
        var playerInfo = PlayersPanelProxy.getPlayerInfo(playerId);
        labelMc[PLAYER_INFO_FIELD_NAME] = playerInfo;
        labelMc[ENTRY_NAME_FIELD_NAME] = entryName;
        labelMc[VEHICLE_CLASS_FIELD_NAME] = vehicleClass;
        labelMc[STATUS_FIELD_NAME] = Player.PLAYER_REVEALED;

        //Logger.addObject(labelMc, 3);

        Macros.RegisterMinimapMacros(playerInfo, getVehicleClassSymbol(vehicleClass));

        /**
         * Label stays at creation point some time before first move.
         * It makes unpleasant label positioning at map center.
         * Workaround.
         */
        var offmapPoint:Point = new Point(OFFMAP_COORDINATE, OFFMAP_COORDINATE);
        labelMc._x = offmapPoint.x;
        labelMc._y = offmapPoint.y;

        LabelViewBuilder.removeTextField(labelMc);
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

    private function getPresenceStatus(playerId:Number):Number
    {
        //Logger.add("LabelsContainer.getPresenceStatus()");
        var status:Number;

        if (IconsProxy.playerIds[playerId] != null)
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
            if (PlayersPanelProxy.isDead(playerId))
            {
                status = Player.PLAYER_DEAD;
            }
            else
            {
                status = Player.PLAYER_LOST;
            }
        }

        var player:Player = PlayersPanelProxy.getPlayerInfo(playerId);
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

    public static function getVehicleClassSymbol(vehicleClass:String):String
    {
        switch (vehicleClass)
        {
            case MinimapConstants.MINIMAP_ENTRY_VEH_CLASS_LIGHT:
                return MapConfig.lightSymbol;
            case MinimapConstants.MINIMAP_ENTRY_VEH_CLASS_MEDIUM:
                return MapConfig.mediumSymbol;
            case MinimapConstants.MINIMAP_ENTRY_VEH_CLASS_HEAVY:
                return MapConfig.heavySymbol;
            case MinimapConstants.MINIMAP_ENTRY_VEH_CLASS_TD:
                return MapConfig.tdSymbol;
            case MinimapConstants.MINIMAP_ENTRY_VEH_CLASS_SPG:
                return MapConfig.spgSymbol;
            case MinimapConstants.MINIMAP_ENTRY_VEH_CLASS_SUPER:
                return MapConfig.superSymbol;
            default:
                return "";
        }
    }
}
