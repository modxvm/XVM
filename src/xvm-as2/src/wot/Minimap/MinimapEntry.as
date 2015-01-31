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
 * @author m.schedriviy(at)gmail.com
 */

import com.xvm.*;
import net.wargaming.ingame.MinimapEntry;
import wot.Minimap.*;
import wot.Minimap.dataTypes.*;
import wot.Minimap.model.*;
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

    function draw()
    {
        return this.drawImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private static var _minimap_initialized:Boolean = false;

    public var playerId:Number;

    // Used only for camera entry to define if entry is processed with Lines class
    public var cameraExtendedToken:Boolean;

    private var labelMc:MovieClip;

    function MinimapEntryCtor()
    {
        Utils.TraceXvmModule("Minimap");
    }

    function init_xvmImpl(playerId:Number, isLit:Boolean)
    {
        //Logger.add("init_xvmImpl: id:" + playerId + " lit:" + isLit);

        MarkerColor.setColor(wrapper);

        if (playerId <= 0)
            return;

        this.playerId = playerId;

        if (IconsProxy.playerIds[playerId])
        {
            delete IconsProxy.playerIds[playerId];
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENTRY_LOST, this, playerId));
        }

        if (isLit)
            return;

        IconsProxy.playerIds[playerId] = this;

        //Logger.add("add:   " + playerId);
        GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENTRY_INITED, this, playerId));

        this.onEntryRevealed();

        this.wrapper["_xvm_removeMovieClip"] = this.wrapper.removeMovieClip;
        this.wrapper.removeMovieClip = function()
        {
            //Logger.add("remove: " + playerId);
            delete IconsProxy.playerIds[playerId];
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENTRY_LOST, this.xvm_worker, playerId));
            this["_xvm_removeMovieClip"]()
        }
    }

    function drawImpl()
    {
        //Logger.add('draw: ' + playerId + " " + wrapper.entryName + " " + wrapper.m_type + " " + wrapper.vehicleClass);

        base.draw();

        MarkerColor.setColor(wrapper);

        if (!_minimap_initialized && wrapper._name == "MinimapEntry1")
        {
            _minimap_initialized = true;
            //Logger.addObject(wrapper, 2);
            GlobalEventDispatcher.dispatchEvent( { type: MinimapEvent.REFRESH } );
        }

        if (playerId)
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENTRY_UPDATED, this, playerId));
        else if (this.wrapper._name == "MinimapEntry0")
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.CAMERA_UPDATED, this));

        rescaleAttachments();
    }

    // INTERNAL

    /**
     * All attachments container: TextFiels(Labels), Shapes.
     */
    public function get attachments():MovieClip
    {
        if (wrapper.xvm_attachments == null)
            wrapper.createEmptyMovieClip("xvm_attachments", wrapper.getNextHighestDepth());
        return wrapper.xvm_attachments;
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

    private function onEntryRevealed()
    {
        if (!MapConfig.enabled || !MapConfig.revealedEnabled)
            return;

        this.labelMc = LabelsContainer.getLabel(playerId);
        if (wrapper.entryName == MinimapConstants.STATIC_ICON_BASE)
        {
            if (wrapper.orig_entryName == null)
                wrapper.orig_entryName = wrapper.entryName;
            wrapper.setEntryName(MinimapConstants.STATIC_ICON_CONTROL);
        }

        setLabelToMimicEntryMoves();
    }

    private function setLabelToMimicEntryMoves():Void
    {
        this.wrapper.onEnterFrame = function()
        {
            // Seldom error workaround. Wreck sometimes is placed at map center.
            if (isNaN(this._x) || isNaN(this._y))
                return;

            this.xvm_worker.labelMc._x = this._x;
            this.xvm_worker.labelMc._y = this._y;
        };
    }
}
