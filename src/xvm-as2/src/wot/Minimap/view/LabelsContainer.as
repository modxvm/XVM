import flash.filters.*;
import com.xvm.*;
import com.xvm.DataTypes.*;
import flash.filters.*;
import wot.Minimap.*;
import wot.Minimap.dataTypes.cfg.*;
import wot.Minimap.model.externalProxy.*;

class wot.Minimap.view.LabelsContainer extends XvmComponent
{
    private static var PLAYER_ID_FIELD_NAME:String = "__uid";
    private static var INITIALIZED_FIELD_NAME:String = "__init";
    private static var BATTLE_STATE_FIELD_NAME:String = "__bs";

    private static var DEFAULT_TEXT_FIELD_WIDTH:Number = 100;
    private static var DEFAULT_TEXT_FIELD_HEIGHT:Number = 40;

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
        if (!invalidateList[e.value])
            invalidateList[e.value] = e.type == Defines.E_PLAYER_DEAD ? INVALIDATE_TYPE_FORCE : INVALIDATE_TYPE_DEFAULT;
        invalidate();
    }

    private function onEntryNameUpdated(e:MinimapEvent)
    {
        //Logger.addObject(e);
        var labelMc:MovieClip = _getLabel(Number(e.value));
        if (!labelMc[INITIALIZED_FIELD_NAME])
            return;
        var bs:BattleStateData = labelMc[BATTLE_STATE_FIELD_NAME];
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
        //Logger.addObject(e);
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
            if (!labelMc[INITIALIZED_FIELD_NAME])
            {
                if (!initLabel(labelMc, playerId))
                {
                    newInvalidateList[playerIdStr] = INVALIDATE_TYPE_FORCE;
                    invalidate();
                    continue;
                }
                labelMc[INITIALIZED_FIELD_NAME] = true;
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
            updateTextFields(labelMc);
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
        var depth:Number = getFreeDepth(ALIVE_DEPTH_START);
        var labelMc:MovieClip = holderMc.createEmptyMovieClip(playerId.toString(), depth);
        labelMc[PLAYER_ID_FIELD_NAME] = playerId;
        labelMc[INITIALIZED_FIELD_NAME] = false;
    }

    private function initLabel(labelMc:MovieClip, playerId:Number):Boolean
    {
        var bs:BattleStateData = BattleState.get(playerId);
        if (!bs || !bs.playerId)
            return false;

        //Logger.add("LabelsContainer.createLabel()");

        labelMc[BATTLE_STATE_FIELD_NAME] = bs;
        bs.entryName = IconsProxy.entry(playerId).entryName;
        bs.spottedStatus = Defines.SPOTTED_STATUS_SPOTTED;

        // Workaround: Label stays at creation point some time before first move.
        // It makes unpleasant label positioning at map center.
        labelMc._x = OFFMAP_COORDINATE;
        labelMc._y = OFFMAP_COORDINATE;

        createTextFields(labelMc);

        return true;
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
                createTextField(labelMc, formats[i], bs);
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

    private function createTextField(labelMc:MovieClip, global_cfg:LabelFieldCfg, bs:BattleStateData):Void
    {
        //if (bs.dead)
        //    Logger.add(bs.entryName + " " + (bs.spottedStatus == Defines.SPOTTED_STATUS_SPOTTED) + " " + (!bs.dead) + " => [" + cfg.flags.join(", ") + "] = " + isAllowedState(cfg.flags, bs));

        if (!isAllowedState(global_cfg.flags, bs))
            return;

        var cfg:LabelFieldCfg = new LabelFieldCfg(global_cfg);

        var playerName:String = bs.playerName;

        var x:Number = Macros.FormatNumber(playerName, cfg, "x", bs, 0, 0);
        var y:Number = Macros.FormatNumber(playerName, cfg, "y", bs, 0, 0);
        var width:Number = Macros.FormatNumber(playerName, cfg, "width", bs, DEFAULT_TEXT_FIELD_WIDTH, 0);
        var height:Number = Macros.FormatNumber(playerName, cfg, "height", bs, DEFAULT_TEXT_FIELD_HEIGHT, 0);

        var n:Number = labelMc.getNextHighestDepth();
        var textField:TextField = labelMc.createTextField("tf" + n, n, x, y, width, height);
        textField.cfg = cfg;
        textField.antiAliasType = cfg.antiAliasType;
        textField.html = true;
        textField.wordWrap = false;
        textField.multiline = true;
        textField.selectable = false;
        var align:String = cfg.align != null ? cfg.align : "left";
        var valign:String = cfg.valign != null ? cfg.valign : "none";
        textField.setNewTextFormat(new TextFormat("$FieldFont", 12, 0xFFFFFF, false, false, false, "", "", align));
        textField.autoSize = "none";
        textField.verticalAlign = valign;
        textField._alpha = Macros.FormatNumber(playerName, cfg, "alpha", bs, 100, 100);

        textField.border = cfg.borderColor != null;
        textField.borderColor = Macros.FormatNumber(playerName, cfg, "borderColor", bs, 0xCCCCCC, 0xCCCCCC, true);
        textField.background = cfg.bgColor != null;
        textField.backgroundColor = Macros.FormatNumber(playerName, cfg, "bgColor", bs, 0x000000, 0x000000, true);
        if (textField.background && !textField.border)
        {
            cfg.borderColor = cfg.bgColor;
            textField.border = true;
            textField.borderColor = textField.backgroundColor;
        }

        var shadow:Object = cfg.shadow;
        if (shadow && shadow.alpha && shadow.strength && shadow.blur)
        {
            var blur:Number = Macros.FormatNumber(playerName, shadow, "blur", bs, 2, 2);
            textField.filters = [
                new DropShadowFilter(
                    Macros.FormatNumber(playerName, shadow, "distance", bs, 0, 0),
                    Macros.FormatNumber(playerName, shadow, "angle", bs, 0, 0),
                    Macros.FormatNumber(playerName, shadow, "color", bs, 0x000000, 0x000000, true),
                    Macros.FormatNumber(playerName, shadow, "alpha", bs, 75, 75) / 100.0,
                    blur,
                    blur,
                    Macros.FormatNumber(playerName, shadow, "strength", bs, 1, 1))
            ];
        }

        cleanupFormat(textField, cfg);
        alignField(textField);
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

    // cleanup formats without macros to remove extra checks
    private function cleanupFormat(field, cfg:LabelFieldCfg)
    {
        if (cfg.x != null && (typeof cfg.x != "string" || cfg.x.indexOf("{{") < 0))
            delete cfg.x;
        if (cfg.y != null && (typeof cfg.y != "string" || cfg.y.indexOf("{{") < 0))
            delete cfg.y;
        if (cfg.width != null && (typeof cfg.width != "string" || cfg.width.indexOf("{{") < 0))
            delete cfg.width;
        if (cfg.height != null && (typeof cfg.height != "string" || cfg.height.indexOf("{{") < 0))
            delete cfg.height;
        if (cfg.alpha != null && (typeof cfg.alpha != "string" || cfg.alpha.indexOf("{{") < 0))
            delete cfg.alpha;
        if (cfg.borderColor != null && (typeof cfg.borderColor != "string" || cfg.borderColor.indexOf("{{") < 0))
            delete cfg.borderColor;
        if (cfg.bgColor != null && (typeof cfg.bgColor != "string" || cfg.bgColor.indexOf("{{") < 0))
            delete cfg.bgColor;
    }

    private function updateTextField(textField:TextField, bs:BattleStateData):Void
    {
        var value;
        var needAlign:Boolean = false;
        var cfg:LabelFieldCfg = textField.cfg;
        var playerName:String = bs.playerName;

        if (cfg.x != null)
        {
            value = Macros.FormatNumber(playerName, cfg, "x", bs, 0, 0);
            if (textField._x != value)
            {
                textField._x = value;
                needAlign = true;
            }
        }

        if (cfg.y != null)
        {
            value = Macros.FormatNumber(playerName, cfg, "y", bs, 0, 0);
            if (textField._y != value)
            {
                textField._y = value;
                needAlign = true;
            }
        }

        if (cfg.width != null)
        {
            value = Macros.FormatNumber(playerName, cfg, "width", bs, 0, 0);
            if (textField._width != value)
            {
                textField._width = value;
                needAlign = true;
            }
        }

        if (cfg.height != null)
        {
            value = Macros.FormatNumber(playerName, cfg, "height", bs, 0, 0);
            if (textField._height != value)
            {
                textField._height = value;
                needAlign = true;
            }
        }

        if (needAlign)
            alignField(textField);

        if (cfg.alpha != null)
        {
            Logger.add(playerName + ": " + cfg.alpha + "=" + Macros.FormatNumber(playerName, cfg, "alpha", bs, 100, 100) + "  " + Macros.Format(playerName, "{{a:hp-ratio}}", bs));
            value = Macros.FormatNumber(playerName, cfg, "alpha", bs, 100, 100);
            if (textField._alpha != value)
                textField._alpha = value;
        }

        if (cfg.borderColor != null)
        {
            value = Macros.FormatNumber(playerName, cfg, "borderColor", bs, 0, 0, true);
            if (textField.borderColor != value)
                textField.borderColor = value;
        }

        if (cfg.bgColor != null)
        {
            value = Macros.FormatNumber(playerName, cfg, "bgColor", bs, 0, 0, true);
            if (textField.backgroundColor != value)
                textField.backgroundColor = value;
        }

        if (cfg.format != null)
        {
            value = Macros.Format(playerName, cfg.format, bs);
            //Logger.add(playerName + ": " + value + " <= " + cfg.format);
            textField.htmlText = value;
        }
    }

    private function alignField(textField:TextField)
    {
        var align:String = textField.cfg.align;
        var valign:String = textField.cfg.valign;
        if (align == "right")
            textField._x -= textField._width;
        else if (align == "center")
            textField._x -= textField._width / 2;
        if (valign == "bottom")
            textField._y -= textField._height;
        else if (valign == "center")
            textField._y -= textField._height / 2;
    }
}
