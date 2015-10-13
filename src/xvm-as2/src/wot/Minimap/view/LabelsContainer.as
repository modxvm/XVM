import com.xvm.*;
import com.xvm.DataTypes.*;
import flash.geom.*;
import flash.filters.*;
import wot.Minimap.*;
import wot.Minimap.dataTypes.*;
import wot.Minimap.dataTypes.cfg.LabelFieldCfg;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.view.*;
import wot.PlayersPanel.*;

class wot.Minimap.view.LabelsContainer extends XvmComponent
{
    /**
     * References to labelMc properties.
     * Cannot extend MovieClip class due to AS2 being crap language\framework\API.
     */
    public static var PLAYER_ID_FIELD_NAME:String = "playerId";

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

    // INSTANCE

    private static var _instance:LabelsContainer;
    private static function get instance():LabelsContainer
    {
        if (!_instance)
            _instance = new LabelsContainer();
        return _instance;
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

    private function LabelsContainer()
    {
        holderMc = IconsProxy.createEmptyMovieClip(CONTAINER_NAME, MinimapConstants.LABELS_ZINDEX);

        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_INITED, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_UPDATED, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_LOST, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(Defines.E_PLAYER_DEAD, this, onMinimapEvent);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_NAME_UPDATED, this, onEntryNameUpdated);
        GlobalEventDispatcher.addEventListener(MinimapEvent.REFRESH, this, onRefresh);
    }

    private function _init()
    {
        // empty function required for instance creation
    }

    // EVENT HANDLERS

    private function onMinimapEvent(e:Object)
    {
        //Logger.addObject(e);
        //if (isNaN(e.value))
        //    Logger.addObject(e, 2, "onMinimapEvent: null value");

        if (!invalidateList[e.value])
            invalidateList[e.value] = INVALIDATE_TYPE_DEFAULT;
        invalidate();
    }

    private function onEntryNameUpdated(e:MinimapEvent)
    {
        var bs:BattleStateData = BattleState.getUserDataByPlayerId(Number(e.value));
        var entryName:String = e.entry.entryName;
        if (bs.entryName != entryName)
        {
            bs.entryName = entryName;
            invalidateList[e.value] = INVALIDATE_TYPE_FORCE;
            invalidate();
        }
    }

    private function onRefresh(e:MinimapEvent)
    {
        for (var i:String in holderMc)
        {
            if (typeof(holderMc[i]) == "movieclip")
            {
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
            var bs:BattleStateData = BattleState.getUserDataByPlayerId(playerId);
            var labelMc:MovieClip = _getLabel(playerId);

            //Logger.add("LabelsContainer.getPresenceStatus()");
            var prevSpottedStatus = bs.spottedStatus;
            var currSpottedStatus:Number;
            if (IconsProxy.playerIds[playerId] != null)
            {
                currSpottedStatus = SpottedStatusType.SPOTTED;
            }
            else
            {
                currSpottedStatus = prevSpottedStatus == SpottedStatusType.SPOTTED ? SpottedStatusType.LOST : prevSpottedStatus;
            }
            var force:Boolean = invalidateList[playerIdStr] == INVALIDATE_TYPE_FORCE;

            //Logger.add(bs.entryName + ": " + playerId + " " + prevSpottedStatus + " " + currSpottedStatus + " " + force);

            if ((prevSpottedStatus != currSpottedStatus) || force)
            {
                bs.spottedStatus = currSpottedStatus;
                createTextFields(labelMc);
                updateLabelDepth(labelMc);
            }
            else
            {
                this.updateTextFields(labelMc);
            }
        }
        invalidateList = { };

        Cmd.profMethodEnd("Minimap.Labels.draw()");
    }

    // PRIVATE

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
        labelMc[PLAYER_ID_FIELD_NAME] = playerId;
        var bs:BattleStateData = BattleState.getUserDataByPlayerId(playerId);
        bs.entryName = entryName;
        bs.spottedStatus = SpottedStatusType.SPOTTED;

        //Logger.addObject(labelMc, 3);

        /**
         * Label stays at creation point some time before first move.
         * It makes unpleasant label positioning at map center.
         * Workaround.
         */
        labelMc._x = OFFMAP_COORDINATE;
        labelMc._y = OFFMAP_COORDINATE;

        this.createTextFields(labelMc);
    }

    private function updateLabelDepth(labelMc:MovieClip):Void
    {
        //Logger.add("LabelsContainer.updateLabelDepth()");
        var bs:BattleStateData = BattleState.getUserDataByPlayerId(labelMc[PLAYER_ID_FIELD_NAME]);
        var depth:Number;
        if (bs.dead)
            depth = getFreeDepth(DEAD_DEPTH_START);
        else if (bs.spottedStatus == SpottedStatusType.LOST)
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
            depth++;
        }

        return depth;
    }

    public function createTextFields(labelMc:MovieClip):Void
    {
        this.removeTextFields(labelMc);

        var fields:Array = Config.config.minimap.labels.fields;
        if (fields)
        {
            var len:Number = fields.length;
            for (var i:Number = 0; i < fields.length; ++i)
            {
                createTextField(labelMc, i, fields[i]);
            }
        }
    }

    public function removeTextFields(labelMc:MovieClip):Void
    {
        for (var name in labelMc)
        {
            if (labelMc[name] instanceof TextField)
            {
                labelMc[name].removeTextField();
                delete labelMc[name];
            }
        }
    }

    public function updateTextFields(labelMc:MovieClip):Void
    {
        var fields:Array = Config.config.minimap.labels.fields;
        if (fields)
        {
            var len:Number = fields.length;
            for (var i:Number = 0; i < fields.length; ++i)
            {
                updateTextField(labelMc["tf" + i], fields[i]);
            }
        }
    }

    public function createTextField(labelMc:MovieClip, n:Number, cfg:Object):Void
    {
        //var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        //var bs:BattleStateData = BattleState.getUserDataByPlayerId(label[LabelsContainer.PLAYER_ID_FIELD_NAME]);
        //var entryName:String = label[LabelsContainer.ENTRY_NAME_FIELD_NAME];

        //var offset:Point = unitLabelOffset(entryName, status);

        //var textField:TextField = labelMc.createTextField("tf" + n, n, offset.x, offset.y, 100, 40);
        //label[TEXT_FIELD_NAME] = textField;
        //textField.antiAliasType = Config.config.minimap.labels.units.antiAliasType;
        //textField.html = true;
        //textField.multiline = true;
        //textField.selectable = false;

        //var tf:TextFormat = new TextFormat("$FieldFont", 12, 0xFFFFFF, false, false, false, null, null, cfg.align);
        //textField.setNewTextFormat(tf);

        //if (unitShadowEnabled(entryName, status))
        //{
            //textField.filters = [unitShadow(entryName, status)];
        //}

        //textField._alpha = unitLabelAlpha(entryName, status);

        //updateTextField(textField, cfg);
    }

    public function updateTextField(textField:TextField, cfg:LabelFieldCfg):Void
    {
        /*
        var status:Number = label[LabelsContainer.STATUS_FIELD_NAME];
        var bs:BattleStateData = BattleState.getUserDataByPlayerId(label[LabelsContainer.PLAYER_ID_FIELD_NAME]);
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
        */
    }

    // PRIVATE

    // TODO: REFACTOR AND REMOVE

    /*
    private function defineCfgProperty(wgEntryName:String, status:Number):String
    {
        var xvmPrefix:String;

        if ((status & Player.STATUS_MASK) == Player.PLAYER_LOST)
            xvmPrefix = "lost";
        else if ((status & Player.STATUS_MASK) == Player.PLAYER_DEAD)
            xvmPrefix = "dead";
        else
            xvmPrefix = "";

        var xvmPostfix:String;

        if (wgEntryName == "squadman")
            xvmPostfix = "squad";
        else
            xvmPostfix = wgEntryName;

        if ((status & Player.TEAM_KILLER_FLAG) && wgEntryName == "ally")
            xvmPostfix = "teamkiller";

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
    }*/
}
