/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.minimap.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import flash.events.*;

    public class MinimapEntriesLabelsHelper
    {
        private static var _viewPointEntryX:Number = 0;
        private static var _viewPointEntryY:Number = 0;

        public static function get viewPointEntryX():Number
        {
            return _viewPointEntryX;
        }

        public static function get viewPointEntryY():Number
        {
            return _viewPointEntryY;
        }

        public static function init(entry:IMinimapVehicleEntry):void
        {
            // Workaround: Label stays at creation point some time before first move.
            // It makes unpleasant label positioning at map center.
            entry.x = MinimapEntriesConstants.OFFMAP_COORDINATE;
            entry.y = MinimapEntriesConstants.OFFMAP_COORDINATE;

            if (Config.config.minimap.labelsEnabled)
            {
                Xvm.addEventListener(PlayerStateEvent.CHANGED, entry.playerStateChanged);
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, entry.update);
                entry.addEventListener(Event.ENTER_FRAME, entry.onEnterFrame, false, 0, true);
                createExtraFields(entry);
            }
        }

        public static function dispose(entry:IMinimapVehicleEntry):void
        {
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, entry.playerStateChanged);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, entry.update);
            entry.removeEventListener(Event.ENTER_FRAME, entry.onEnterFrame);
            disposeExtraFields(entry);
        }

        public static function onEnterFrameHandler(entry:IMinimapVehicleEntry):void
        {
            if (entry is ViewPointEntry)
            {
                _viewPointEntryX = entry.x;
                _viewPointEntryY = entry.y;
            }

            if (entry.extraFields)
            {
                entry.extraFields.x = entry.x;
                entry.extraFields.y = entry.y;
            }
            if (entry.extraFieldsAlt)
            {
                entry.extraFieldsAlt.x = entry.x;
                entry.extraFieldsAlt.y = entry.y;
            }
        }

        public static function updateLabels(entry:IMinimapVehicleEntry, playerState:VOPlayerState):void
        {
            updateExtraFields(entry, playerState);
        }

        // PRIVATE

        private static function createExtraFields(entry:IMinimapVehicleEntry):void
        {
            var formats:Array = Config.config.minimap.labels.formats;
            if (formats)
            {
                if (formats.length)
                {
                    entry.extraFields = new ExtraFieldsGroup(UI_Minimap.instance, formats);
                }
            }
            formats = Config.config.minimapAlt.labels.formats;
            if (formats)
            {
                if (formats.length)
                {
                    entry.extraFieldsAlt = new ExtraFieldsGroup(UI_Minimap.instance, formats);
                }
            }
        }

        private static function disposeExtraFields(entry:IMinimapVehicleEntry):void
        {
            if (entry.extraFields)
            {
                entry.extraFields.dispose();
                entry.extraFields = null;
            }
            if (entry.extraFieldsAlt)
            {
                entry.extraFieldsAlt.dispose();
                entry.extraFieldsAlt = null;
            }
        }

        private static function updateExtraFields(entry:IMinimapVehicleEntry, playerState:VOPlayerState):void
        {
            var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
            if (entry.extraFields)
            {
                entry.extraFields.visible = !isAltMode;
                if (!isAltMode)
                {
                    entry.extraFields.update(playerState);
                }
            }
            if (entry.extraFieldsAlt)
            {
                entry.extraFieldsAlt.visible = isAltMode;
                if (isAltMode)
                {
                    entry.extraFieldsAlt.update(playerState);
                }
            }
        }
    }
}
