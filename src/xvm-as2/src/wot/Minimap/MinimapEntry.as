/**
 * MinimapEntry represent individual object on map.
 * One tank icon, base capture point, starting point or player himself.
 *
 * MinimapEntry object at Minimap is called icon.
 *
 * Extended behaviour:
 * ) Append extra text information about unit like level, type, nick etc.
 * ) Rescale child MovieClips to prevent inappropriate scale propagation.
 * ) Colorize icon.
 *
 * @author ilitvinov87(at)gmail.com
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

import com.xvm.*;
import com.xvm.DataTypes.*;
import com.xvm.events.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.view.*;

class wot.Minimap.MinimapEntry
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.ingame.MinimapEntry;
    private var base:net.wargaming.ingame.MinimapEntry;

    public function MinimapEntry(wrapper:net.wargaming.ingame.MinimapEntry, base:net.wargaming.ingame.MinimapEntry)
    {
        this.wrapper = wrapper;
        this.base = base;
        wrapper.xvm_worker = this;
        MinimapEntryCtor();
    }

    function init_xvm()
    {
        return this.init_xvmImpl.apply(this, arguments);
    }

    function setEntryName()
    {
        return this.setEntryNameImpl.apply(this, arguments);
    }

    function draw()
    {
        return this.drawImpl.apply(this, arguments);
    }

    function onEnterFrameHandler()
    {
        return this.onEnterFrameHandlerImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private static var _minimap_initialized:Boolean = false;

    private var _entry_initialized:Boolean = false;
    public var playerId:Number;

    // Used only for camera entry to define if entry is processed with Lines class
    public var cameraExtendedToken:Boolean;

    private var labelMc:MovieClip;
    private var lastCameraModeIsStrategic:Boolean = false;

    function MinimapEntryCtor()
    {
        Utils.TraceXvmModule("Minimap");
    }

    function init_xvmImpl(playerId:Number, isLit:Boolean, vehId:Number, entityName:String, entryName:String, vClass:String, isRespawn:Boolean)
    {
        //Logger.add("init_xvmImpl: id=" + playerId + " lit=" + isLit);
        Cmd.profMethodStart("MinimapEntry.init_xvm()");

        MarkerColor.setColor(wrapper);

        _entry_initialized = true;

        if (playerId <= 0)
        {
            Cmd.profMethodEnd("MinimapEntry.init_xvm()");
            return;
        }

        this.playerId = playerId;

        if (!Utils.isArenaGuiTypeWithPlayerPanels())
        {
            var bs:BattleStateData = BattleState.get(playerId);
            if (bs && bs.playerId)
            {
                bs.vehId = vehId;
                bs.dead = false;
                bs.entityName = entityName;
                Macros.RegisterPlayerData(bs.playerName,
                {
                    uid: playerId,
                    vid: bs.vehId,
                    label: bs.playerName + (bs.clanAbbrev == "" ? "" : "[" + bs.clanAbbrev + "]"),
                    squad: bs.squad,
                    maxHealth: bs.maxHealth
                }, bs.team);
            }
        }

        if (IconsProxy.playerIds[playerId])
        {
            delete IconsProxy.playerIds[playerId];
            GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_ENTRY_LOST, wrapper, playerId));
        }

        if (isLit)
        {
            Cmd.profMethodEnd("MinimapEntry.init_xvm()");
            return;
        }

        IconsProxy.playerIds[playerId] = this;

        if (entryName == "player")
        {
            var entry:net.wargaming.ingame.MinimapEntry = IconsProxy.entry(playerId);
            //Logger.add(entry.entryName);
            entry.vehicleClass = vClass;
        }

        if (isRespawn)
            GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_RESPAWNED, wrapper, playerId));

        //Logger.add("add:   " + playerId);
        GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_ENTRY_INITED, wrapper, playerId));

        this.onEntrySpotted();

        this.wrapper["_xvm_removeMovieClip"] = this.wrapper.removeMovieClip;
        this.wrapper.removeMovieClip = function()
        {
            //Logger.add("remove: " + playerId);
            delete IconsProxy.playerIds[playerId];
            GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_ENTRY_LOST, this, playerId));
            this["_xvm_removeMovieClip"]()
        }

        Cmd.profMethodEnd("MinimapEntry.init_xvm()");
    }

    function setEntryNameImpl(value:String)
    {
        var savedEntryName:String = wrapper.entryName;
        if (savedEntryName == "player" || savedEntryName == "normalWithSector" || value == savedEntryName)
            return;

        base.setEntryName(value);

        if (playerId)
        {
            GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_ENTRY_NAME_UPDATED, wrapper, playerId));
        }
    }

    function drawImpl()
    {
        Cmd.profMethodStart("MinimapEntry.draw()");

        //Logger.add('draw: playerId=' + playerId + " _name=" + wrapper._name + " entryName=" + wrapper.entryName + " m_type=" + wrapper.m_type +
        //    " markLabel=" + wrapper.markLabel + " vehicleClass=" + wrapper.vehicleClass + " _entry_initialized=" + _entry_initialized);

        base.draw();

        if (!_entry_initialized)
            return;

        MarkerColor.setColor(wrapper);

        if (playerId)
        {
            GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_ENTRY_UPDATED, wrapper, playerId));
        }
        else
        {
            var camera:net.wargaming.ingame.MinimapEntry = IconsProxy.cameraEntry;
            if (camera != null && camera == wrapper)
            {
                GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_CAMERA_UPDATED, wrapper));
            }
        }

        rescaleAttachments();

        Cmd.profMethodEnd("MinimapEntry.draw()");
    }

    function onEnterFrameHandlerImpl()
    {
        base.onEnterFrameHandler();

        setLabelToMimicEntryMoves();

        if (wrapper._name != "MinimapEntry0") // MinimapConstants.MAIN_PLAYER_ENTRY_NAME - resolved for performance
            return;

        labelMc._x = wrapper._x;
        labelMc._y = wrapper._y;

        var camera = IconsProxy.cameraStrategicEntry;
        if (camera != null)
        {
            lastCameraModeIsStrategic = true;
            GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_SET_STRATEGIC_POS, camera));
        }
        else
        {
            if (lastCameraModeIsStrategic)
            {
                lastCameraModeIsStrategic = false;
                GlobalEventDispatcher.dispatchEvent(new EMinimapEvent(Events.MM_SET_STRATEGIC_POS, null));
            }
        }
    }

    // INTERNAL

    /**
     * All attachments container: TextFiels(Labels), Shapes.
     */
    public function get attachments():MovieClip
    {
        if (wrapper["_xvm_attachments"] == null)
        {
            var mc:MovieClip = wrapper.createEmptyMovieClip("_xvm_attachments", wrapper.getNextHighestDepth());
            mc.cacheAsBitmap = true;
        }
        return wrapper["_xvm_attachments"];
    }

    /**
     * Minimap resize procedures break attachments scale.
     * Workaround.
     * Reverts parent entry scaling.
     * For example: icon scaling of 62% produces attachment scaling of 159
     * so resulting attachment size becomes as if both icons and attachments scale were 100%.
     * This makes attachments size virtually independent of icon scale.
     */
    public function rescaleAttachments():Void
    {
        var scale = (1 / (wrapper._xscale / 100)) * 100;
        if (attachments._xscale != scale)
            attachments._xscale = attachments._yscale = scale;
    }

    // -- Private

    private function onEntrySpotted()
    {
        if (!Minimap.config.enabled || Config.config.minimap.useStandardLabels || !Minimap.config.labels.enabled || !Minimap.config.labels.formats || Minimap.config.labels.formats.length == 0)
            return;

        setLabelToMimicEntryMoves();
    }

    private function setLabelToMimicEntryMoves():Void
    {
        // TODO: refactor (performance issue)
        if (playerId)
            this.labelMc = LabelsContainer.getLabel(playerId);
        wrapper.onEnterFrame = function()
        {
            // Seldom error workaround. Wreck sometimes is placed at map center.
            if (isNaN(this._x) || isNaN(this._y))
                return;

            var labelMc:MovieClip = this.xvm_worker.labelMc;
            labelMc._x = this._x;
            labelMc._y = this._y;
        };
    }
}
