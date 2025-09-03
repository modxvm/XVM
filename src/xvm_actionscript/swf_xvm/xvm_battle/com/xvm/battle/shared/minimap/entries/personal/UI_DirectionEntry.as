/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.minimap.*;
    import com.xvm.battle.shared.minimap.entries.*;
    import com.xvm.battle.vo.*;
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.views.minimap.constants.*;

    public class UI_DirectionEntry extends DirectionEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        private var _entryDeleted:Boolean = false;

        private var _linesEnabled:Boolean;

        private var _cameraLine:Sprite = null;
        private var _cameraLineAlt:Sprite = null;

        public function UI_DirectionEntry()
        {
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            Xvm.addEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);

            _linesEnabled = Config.config.minimap.linesEnabled;
            if (_linesEnabled)
            {
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_SIZE_CHANGED, updateLinesScale);
                directionLinePlaceholder.visible = false;
                try
                {
                    _cameraLine = MinimapEntriesLinesHelper.createLines(Config.config.minimap.lines.parsedCamera);
                    _cameraLineAlt = MinimapEntriesLinesHelper.createLines(Config.config.minimapAlt.lines.parsedCamera);
                    var idx:int = getChildIndex(directionLinePlaceholder);
                    addChildAt(_cameraLine, idx + 1);
                    addChildAt(_cameraLineAlt, idx + 2);
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
        }

        override protected function onDispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: draw() on deleted DirectionEntry");
                return;
            }

            super.draw();

            try
            {
                if (isInvalid(INVALID_UPDATE_XVM))
                {
                    var playerState:VOPlayerState = BattleState.get(BattleGlobalData.playerVehicleID);
                    if (playerState)
                    {
                        updateDirectionAlpha(playerState);
                        updateDirectionLineVisibility(playerState);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;

            Xvm.removeEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_SIZE_CHANGED, updateLinesScale);
            if (_cameraLine)
            {
                removeChild(_cameraLine);
                _cameraLine = null;
            }
            if (_cameraLineAlt)
            {
                removeChild(_cameraLineAlt);
                _cameraLineAlt = null;
            }
        }

        // PRIVATE

        private function update():void
        {
            invalidate(INVALID_UPDATE_XVM);
        }

        private function playerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == BattleGlobalData.playerVehicleID)
            {
                update();
            }
        }

        private function updateDirectionAlpha(playerState:VOPlayerState):void
        {
            directionPlaceholder.alpha = Macros.FormatNumber(UI_Minimap.cfg.directionTriangleAlpha, playerState, 100) / 100.0;
            if (!_linesEnabled)
            {
                directionLinePlaceholder.alpha = Macros.FormatNumber(UI_Minimap.cfg.directionLineAlpha, playerState, 100) / 100.0;
            }
        }

        private function updateDirectionLineVisibility(playerState:VOPlayerState):void
        {
            var showCameraLine:Boolean = playerState.isAlive || Macros.FormatBoolean(UI_Minimap.cfg.showDirectionLineAfterDeath, playerState);
            if (!_linesEnabled)
            {
                if (playerState.isDead)
                {
                    directionLinePlaceholder.visible = showCameraLine;
                }
            }
            else
            {
                var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
                _cameraLine.visible = showCameraLine && !isAltMode;
                _cameraLineAlt.visible = showCameraLine && isAltMode;
            }
        }

        private function updateLinesScale():void
        {
            var idx:int = UI_Minimap.instance.currentSizeIndex;
            _cameraLine.scaleX = _cameraLine.scaleY = _cameraLineAlt.scaleX = _cameraLineAlt.scaleY =
                MinimapSizeConst.ENTRY_INTERNAL_CONTENT_CONTR_SCALES[idx] * MinimapSizeConst.MAP_SIZE[idx].width / MinimapSizeConst.MAP_SIZE[0].width;
        }
    }
}
