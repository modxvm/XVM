import com.xvm.Logger;
import com.xvm.AutoUpdate;
import com.xvm.GlobalEventDispatcher;
import flash.geom.Point;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.MinimapEvent;
import wot.Minimap.MinimapProxy;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.Minimap.view.LabelViewBuilder;
import wot.PlayersPanel.PlayersPanelProxy;

class wot.Minimap.view.LabelsContainer
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

    private static var CONTAINER_NAME:String = "labelsContainer";
    private static var OFFMAP_COORDINATE:Number = 500;
    private static var DEAD_DEPTH_START:Number = 100;
    private static var LOST_DEPTH_START:Number = 200;
	private static var ALIVE_DEPTH_START:Number = 300;

    public var holderMc:MovieClip;

    public static function get instance():LabelsContainer
    {
        if (!_instance)
        {
            _instance = new LabelsContainer();
        }

        return _instance;
    }

    public function LabelsContainer()
    {
        var icons:MovieClip = MinimapProxy.wrapper.icons;
        holderMc = icons.createEmptyMovieClip(CONTAINER_NAME, wot.Minimap.Minimap.LABELS);
        GlobalEventDispatcher.addEventListener(AutoUpdate.UPDATE_BY_TIMER_EVENT, this, onTimerTick);
    }

	/** MinimapEntry requests a label */
    public function getLabel(uid:Number, entryName:String, vehicleClass:String):MovieClip
    {
        //Logger.add("LabelsContainer.getLabel()");

        if (!holderMc[uid])
        {
            createLabel(uid, entryName, vehicleClass);
        }

        return holderMc[uid];
    }

    // -- Private

    private function createLabel(uid:Number, entryName:String, vehicleClass:String):Void
    {
        //Logger.add("LabelsContainer.createLabel()");

        var depth:Number = getFreeDepth(ALIVE_DEPTH_START);
        var labelMc:MovieClip = holderMc.createEmptyMovieClip("" + uid, depth);

        /**
         * References to labelMc properties.
         * Cannot extend MovieClip class due to AS2 being crap language\framework\API.
         */
        var playerInfo = PlayersPanelProxy.getPlayerInfo(uid);
        labelMc[PLAYER_INFO_FIELD_NAME] = playerInfo;
        labelMc[ENTRY_NAME_FIELD_NAME] = entryName;
        labelMc[VEHICLE_CLASS_FIELD_NAME] = vehicleClass;
        labelMc[STATUS_FIELD_NAME] = Player.PLAYER_REVEALED;

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

    private function onTimerTick(event:MinimapEvent):Void
    {
        //Logger.add("LabelsContainer.onTimerTick()");
        updateLabelsStyle();
    }

    private function updateLabelsStyle():Void
    {
        //Logger.add("LabelsContainer.updateLabelsStyle()");
        for (var uidStr:String in holderMc)
        {
            var uid:Number = Number(uidStr);
            /**
             * Have to check for uid value consistency
             * because we are iterating through MovieClip props not Array.
             * There are four keys except movie clips named by uid:
             * enabled, tweenFrom, tweenEnd, tweenTo.
             */
            if (uid)
            {
                var labelMc:MovieClip = holderMc[uidStr];
                var previousStatus:Number = labelMc[STATUS_FIELD_NAME];
                var actualStatus:Number = getPresenceStatus(uid);

                if (previousStatus != actualStatus)
                {
                    labelMc[STATUS_FIELD_NAME] = actualStatus;
                    recreateTextField(labelMc);
                    updateLabelDepth(labelMc);
                }
            }
        }
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
