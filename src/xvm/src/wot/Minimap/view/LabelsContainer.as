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
        GlobalEventDispatcher.addEventListener(MinimapEvent.TICK, this, onTimerTick);
    }
    
    public function getLabel(uid:Number, entryName:String, vehicleClass:String):MovieClip
    {
        if (!holderMc[uid])
        {
            createLabel(uid, entryName, vehicleClass);
        }
        else
        {
            // getLabel()
            // changeLabelViewToNormal()
            // TODO: check if 300ms delay is bad
            //       Attached label could be some time with Lost style
        }
        
        return holderMc[uid];
    }
    
    // -- Private
    
    private function createLabel(uid:Number, entryName:String, vehicleClass:String):Void
    {
        var depth:Number = holderMc.getNextHighestDepth();
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
        var tf:TextField = labelMc[LabelViewBuilder.TEXT_FIELD_NAME];
        tf.removeTextField();
        
        LabelViewBuilder.createTextField(labelMc);
    }
    
    private function onTimerTick(event:MinimapEvent):Void
    {
        updateLabelsStyle();
    }

    private function updateLabelsStyle():Void
    {
        for (var uidStr:String in holderMc)
        {
            var uid:Number = parseInt(uidStr);
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
                }
            }
        }
    }
    
    private function getPresenceStatus(uid:Number):Number
    {
        if (IconsProxy.isIconIsPresentAtMinimap(uid))
        {
            return Player.PLAYER_REVEALED;
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
                return Player.PLAYER_DEAD;
            }
            else 
            {
                return Player.PLAYER_LOST;
            }
        }
    }
}
