import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.*;
import wot.Minimap.dataTypes.cfg.*;
import wot.Minimap.model.externalProxy.*;

class wot.Minimap.view.LabelsContainer extends XvmComponent
{
    public static var BATTLE_STATE_FIELD_NAME:String = "__bs";

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
        var labelMc:MovieClip = _getLabel(Number(e.value));
        if (labelMc)
        {
            var bs:BattleStateData = labelMc[BATTLE_STATE_FIELD_NAME];
            var entryName:String = e.entry.entryName;
            if (bs.entryName != entryName)
            {
                bs.entryName = entryName;
                invalidateList[e.value] = INVALIDATE_TYPE_FORCE;
                invalidate();
            }
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

        var newInvalidateList = { };
        for (var playerIdStr:String in invalidateList)
        {
            var playerId:Number = Number(playerIdStr);

            var labelMc:MovieClip = _getLabel(playerId);
            if (!labelMc)
            {
                newInvalidateList[playerIdStr] = invalidateList[playerIdStr];
                invalidate();
                continue;
            }

            var bs:BattleStateData = labelMc[BATTLE_STATE_FIELD_NAME];
            var prevSpottedStatus = bs.spottedStatus;
            var currSpottedStatus:Number;
            if (IconsProxy.playerIds[playerId] != null)
            {
                currSpottedStatus = Defines.SPOTTED_STATUS_SPOTTED;
            }
            else
            {
                currSpottedStatus = prevSpottedStatus == Defines.SPOTTED_STATUS_SPOTTED ? Defines.SPOTTED_STATUS_LOST : prevSpottedStatus;
            }

            var force:Boolean = invalidateList[playerIdStr] == INVALIDATE_TYPE_FORCE;

            //Logger.add("(draw) " + bs.playerName + ": " + bs.entryName + ": " + prevSpottedStatus + " " + currSpottedStatus + " " + force);

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
        invalidateList = newInvalidateList;

        Cmd.profMethodEnd("Minimap.Labels.draw()");
    }

    // PRIVATE

    private function _getLabel(playerId:Number):MovieClip
    {
        if (!holderMc[playerId])
            createLabel(playerId);
        return holderMc[playerId];
    }

    private function createLabel(playerId:Number):Void
    {
        var bs:BattleStateData = BattleState.getUserDataByPlayerId(playerId);
        if (!bs)
            return;

        //Logger.add("LabelsContainer.createLabel()");

        var depth:Number = getFreeDepth(ALIVE_DEPTH_START);
        var labelMc:MovieClip = holderMc.createEmptyMovieClip(playerId.toString(), depth);
        labelMc[BATTLE_STATE_FIELD_NAME] = bs;

        bs.entryName = IconsProxy.entry(playerId).entryName;
        bs.spottedStatus = Defines.SPOTTED_STATUS_SPOTTED;

        // Workaround: Label stays at creation point some time before first move.
        // It makes unpleasant label positioning at map center.
        labelMc._x = OFFMAP_COORDINATE;
        labelMc._y = OFFMAP_COORDINATE;

        this.createTextFields(labelMc);
    }

    private function updateLabelDepth(labelMc:MovieClip):Void
    {
        //Logger.add("LabelsContainer.updateLabelDepth()");
        var bs:BattleStateData = labelMc[BATTLE_STATE_FIELD_NAME];
        var depth:Number;
        if (bs.dead)
            depth = getFreeDepth(DEAD_DEPTH_START);
        else if (bs.spottedStatus == Defines.SPOTTED_STATUS_LOST)
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

    private function createTextFields(labelMc:MovieClip):Void
    {
        this.removeTextFields(labelMc);

        var formats:Array = Minimap.config.labels.formats;
        if (formats)
        {
            var bs:BattleStateData = labelMc[BATTLE_STATE_FIELD_NAME];
            var len:Number = formats.length;
            for (var i:Number = 0; i < formats.length; ++i)
            {
                createTextField(labelMc, i, formats[i], bs);
            }
        }
    }

    private function removeTextFields(labelMc:MovieClip):Void
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

    private function updateTextFields(labelMc:MovieClip):Void
    {
        var bs:BattleStateData = labelMc[BATTLE_STATE_FIELD_NAME];
        for (var name in labelMc)
        {
            if (labelMc[name] instanceof TextField)
            {
                updateTextField(labelMc[name], bs);
            }
        }
    }

    private function createTextField(labelMc:MovieClip, n:Number, cfg:LabelFieldCfg, bs:BattleStateData):Void
    {
        //Logger.add(bs.entryName + " " + (bs.spottedStatus == Defines.SPOTTED_STATUS_SPOTTED) + " " + (!bs.dead) + " => [" + cfg.flags.join(", ") + "] = " + isAllowedState(cfg.flags, bs));

        if (!isAllowedState(cfg.flags, bs))
            return;

        var x:Number = isNaN(cfg.x) ? Macros.Format(bs.playerName, cfg.x, bs) : cfg.x;
        var y:Number = isNaN(cfg.y) ? Macros.Format(bs.playerName, cfg.y, bs) : cfg.y;
        var width:Number = isNaN(cfg.width) ? Macros.Format(bs.playerName, cfg.width, bs) : cfg.width;
        var height:Number = isNaN(cfg.height) ? Macros.Format(bs.playerName, cfg.height, bs) : cfg.height;

        var textField:TextField = labelMc.createTextField("tf" + n, n, x, y, width, height);
        textField.cfg = cfg;
        textField.antiAliasType = cfg.antiAliasType;
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;
        textField.setNewTextFormat(new TextFormat("$FieldFont", 12, 0xFFFFFF, false, false, false, "", "", cfg.align));
        if (cfg.shadow && cfg.shadow.enabled)
        {
            textField.filters = [ Utils.extractShadowFilter(cfg.shadow) ];
        }
        textField._alpha = isNaN(cfg.alpha) ? Macros.Format(bs.playerName, cfg.alpha, bs) : cfg.alpha;

        updateTextField(textField, bs);
    }

    private function isAllowedState(flags:Array, bs:BattleStateData):Boolean
    {
        if (!flags)
            return false;
        var entryName:String = bs.entryName;
        var stateOk:Boolean = false;
        var spottedFlags:Number = 0;
        var aliveFlags:Number = 0;
        var len:Number = flags.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var flag:String = flags[i];

            if (!stateOk)
            {
                if (entryName == flag)
                {
                    stateOk = true;
                    continue;
                }
            }

            switch (flag)
            {
                case "spotted":
                    spottedFlags |= Defines.SPOTTED_STATUS_SPOTTED;
                    break;
                case "lost":
                    spottedFlags |= Defines.SPOTTED_STATUS_LOST;
                    break;
                case "alive":
                    aliveFlags |= Defines.ALIVE_FLAG_ALIVE;
                    break;
                case "dead":
                    aliveFlags |= Defines.ALIVE_FLAG_DEAD;
                    break;
            }
        }

        if (!spottedFlags)
            spottedFlags = Defines.SPOTTED_STATUS_ANY;

        if (!aliveFlags)
            aliveFlags = Defines.ALIVE_FLAG_ANY;

        var aliveValue:Number = bs.dead ? Defines.ALIVE_FLAG_DEAD : Defines.ALIVE_FLAG_ALIVE;

        return stateOk && (bs.spottedStatus & spottedFlags != 0) && (aliveValue & aliveFlags != 0);
    }

    private function updateTextField(textField:TextField, bs:BattleStateData):Void
    {
        var text:String = Macros.Format(bs.playerName, textField.cfg.format, bs);
        Logger.add(bs.playerName + ": " + text + " <= " + textField.cfg.format);
        textField.htmlText = text;
    }
}
