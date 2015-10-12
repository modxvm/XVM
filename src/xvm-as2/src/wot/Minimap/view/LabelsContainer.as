import com.xvm.*;
import flash.geom.*;
import flash.filters.*;
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
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_NAME_UPDATED, this, onEntryNameUpdated);
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

        if (!invalidateList[e.value])
            invalidateList[e.value] = INVALIDATE_TYPE_DEFAULT;
        invalidate();
    }

    private function onEntryNameUpdated(e:MinimapEvent)
    {
        var labelMc:MovieClip = _getLabel(Number(e.value));
        var entryName:String = e.entry.entryName;
        if (labelMc[ENTRY_NAME_FIELD_NAME] != entryName)
        {
            labelMc[ENTRY_NAME_FIELD_NAME] = entryName;
            invalidateList[e.value] = INVALIDATE_TYPE_FORCE;
            invalidate();
        }
    }

    private function onPlayerDeadEvent(e:Object)
    {
        //Logger.add("(dead) e.value = " + e.value);
        //if (isNaN(e.value))
        //    Logger.addObject(e, 2, "onPlayerDeadEvent: null value");
        if (!invalidateList[e.value])
            invalidateList[e.value] = INVALIDATE_TYPE_DEFAULT;
        invalidate();
    }

    private function onRefreshEvent(e:MinimapEvent)
    {
        for (var i:String in holderMc)
        {
            if (typeof(holderMc[i]) == "movieclip")
            {
                var labelMc:MovieClip = holderMc[i];
                invalidateList[i] = INVALIDATE_TYPE_FORCE;
            }
        }
        invalidate();
    }

    // override
    function draw()
    {
        Cmd.profMethodStart("Minimap.Labels.draw()");

        for (var playerIdStr:String in invalidateList)
        {
            var playerId:Number = Number(playerIdStr);
            var force:Boolean = invalidateList[playerIdStr] == INVALIDATE_TYPE_FORCE;
            var labelMc:MovieClip = _getLabel(playerId);
            var previousStatus:Number = labelMc[STATUS_FIELD_NAME];
            var actualStatus:Number = getPresenceStatus(playerId);

            //Logger.add(IconsProxy.entry(playerId).entryName + ": " + playerId + " " + force + " " + previousStatus + " " + actualStatus);

            if ((previousStatus != actualStatus) || force)
            {
                labelMc[STATUS_FIELD_NAME] = actualStatus;
                this.createTextField(labelMc);
                updateLabelDepth(labelMc);
            }
            else
            {
                this.updateTextField(labelMc);
            }
        }
        invalidateList = { };

        Cmd.profMethodEnd("Minimap.Labels.draw()");
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

        var entry:net.wargaming.ingame.MinimapEntry = IconsProxy.entry(playerId);
        var entryName = entry.entryName;

        var depth:Number = getFreeDepth(ALIVE_DEPTH_START);
        var labelMc:MovieClip = holderMc.createEmptyMovieClip(playerId.toString(), depth);

        /**
         * References to labelMc properties.
         * Cannot extend MovieClip class due to AS2 being crap language\framework\API.
         */
        var playerInfo = PlayersPanelProxy.getPlayerInfo(playerId);
        labelMc[PLAYER_INFO_FIELD_NAME] = playerInfo;
        labelMc[ENTRY_NAME_FIELD_NAME] = entryName;
        labelMc[STATUS_FIELD_NAME] = Player.PLAYER_SPOTTED;

        //Logger.addObject(labelMc, 3);

        /**
         * Label stays at creation point some time before first move.
         * It makes unpleasant label positioning at map center.
         * Workaround.
         */
        labelMc._x = OFFMAP_COORDINATE;
        labelMc._y = OFFMAP_COORDINATE;

        this.createTextField(labelMc);
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
            status = Player.PLAYER_SPOTTED;
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
            status |= Player.TEAM_KILLER_FLAG;
        }

        return status;
    }



    public static var TEXT_FIELD_NAME:String = "textField";

    private static var TF_DEPTH:Number = 100;

    public function createTextField(label:MovieClip, cfg:Object):Void
    {
        this.removeTextField(label);

        var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        var playerInfo:Player = label[LabelsContainer.PLAYER_INFO_FIELD_NAME];
        var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];

        var offset:Point = unitLabelOffset(entryName, status);

        var textField:TextField = label.createTextField(TEXT_FIELD_NAME, TF_DEPTH, offset.x, offset.y, 100, 40);
        label[TEXT_FIELD_NAME] = textField;
        textField.antiAliasType = Config.config.minimap.labels.units.antiAliasType;
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;

        var tf:TextFormat = new TextFormat("$FieldFont", 12, 0xFFFFFF, false, false, false, null, null, cfg.align);
        textField.setNewTextFormat(tf);

        if (unitShadowEnabled(entryName, status))
        {
            textField.filters = [unitShadow(entryName, status)];
        }

        textField._alpha = unitLabelAlpha(entryName, status);

        updateTextField(label);
    }

    public function updateTextField(label:MovieClip):Void
    {
        var textField:TextField = label[TEXT_FIELD_NAME];
        if (textField == null)
            return;

        var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        var playerInfo:Player = label[LabelsContainer.PLAYER_INFO_FIELD_NAME];
        var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];

        var format:String = unitLabelFormat(entryName, status);

        var obj = { };
        var playerState = BattleState.getUserData(playerInfo.userName);
        for (var i in playerInfo)
            obj[i] = playerInfo[i];
        for (var i in playerState)
            obj[i] = playerState[i];
        var text:String = Macros.Format(playerInfo.userName, format, obj);
        //Logger.add(playerInfo.userName + ": " + text);
        textField.htmlText = text;
    }

    public function removeTextField(label:MovieClip):Void
    {
        var textField:TextField = label[TEXT_FIELD_NAME];
        if (textField == null)
            return;
        textField.removeTextField();
        label[TEXT_FIELD_NAME] = null;
    }

    // PRIVATE

    // TODO: REFACTOR AND REMOVE


    /** Translate internal WG entryName and unit status(dead\tk) to minimap config file entry */
    private function defineCfgProperty(wgEntryName:String, status:Number):String
    {
        /** Prefix: lost dead or alive */
        var xvmPrefix:String;

        if ((status & Player.STATUS_MASK) == Player.PLAYER_LOST)
            xvmPrefix = "lost";
        else if ((status & Player.STATUS_MASK) == Player.PLAYER_DEAD)
            xvmPrefix = "dead";
        else
            xvmPrefix = "";

        /** Postfix: ally, enemy, tk or squad */
        var xvmPostfix:String;

        if (wgEntryName == "squadman")
            xvmPostfix = "squad"; /** Translate squad WG entry name to squad XVM entry name */
        else
            xvmPostfix = wgEntryName;

        if ((status & Player.TEAM_KILLER_FLAG) && wgEntryName == "ally") /** <- Skip enemy and squad TK */
            xvmPostfix = "teamkiller";

        /** Result */
        var xvmFullEntry:String;

        if (wgEntryName == "player")
            xvmFullEntry = "oneself";
        else
            xvmFullEntry = xvmPrefix + xvmPostfix;

        if (xvmFullEntry == "lostenemy")
            xvmFullEntry = "lost"; // Backwards config compatibility

        return xvmFullEntry;
    }

    private function unitLabelOffset(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return new Point(Config.config.minimap.labels.units.offset[unitType].x, Config.config.minimap.labels.units.offset[unitType].y);
    }

    private function unitShadowEnabled(entryName:String, status:Number):Boolean
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.shadow[unitType].enabled;
    }

    private function unitShadow(entryName:String, status:Number):DropShadowFilter
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Utils.extractShadowFilter(Config.config.minimap.labels.units.shadow[unitType]);
    }

    private function unitLabelAlpha(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.alpha[unitType];
    }

    private function unitLabelFormat(entryName:String, status:Number)
    {
        var unitType:String = defineCfgProperty(entryName, status);
        return Config.config.minimap.labels.units.format[unitType];
    }

}
