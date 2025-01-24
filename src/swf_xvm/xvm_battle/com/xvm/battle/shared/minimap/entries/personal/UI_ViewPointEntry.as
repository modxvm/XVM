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
    import com.xvm.extraFields.*;
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.views.minimap.constants.*;

    public class UI_ViewPointEntry extends ViewPointEntry implements IMinimapVehicleEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        CLIENT::WG {
            private static const DEFAULT_VEHICLE_ICON_WIDTH:Number = 188;
            private static const DEFAULT_VEHICLE_ICON_HEIGHT:Number = 226;
        }
        CLIENT::LESTA {
            private static const DEFAULT_VEHICLE_ICON_WIDTH:Number = 24;
            private static const DEFAULT_VEHICLE_ICON_HEIGHT:Number = 24;
        }
        private static const DEFAULT_VEHICLE_ICON_SCALE:Number = 0.5;

        private var _entryDeleted:Boolean = false;

        private var _vehicleID:Number;

        private var _leftYawLimit:Number = NaN;
        private var _rightYawLimit:Number = NaN;
        private var _isLimitUpdated:Boolean = false;

        private var _linesEnabled:Boolean;

        private var _vehicleLine:Sprite = null;
        private var _vehicleLineAlt:Sprite = null;
        private var _traverseAngle1Line:Sprite = null;
        private var _traverseAngle1LineAlt:Sprite = null;
        private var _traverseAngle2Line:Sprite = null;
        private var _traverseAngle2LineAlt:Sprite = null;

        private var _extraFields:ExtraFieldsGroup = null;
        private var _extraFieldsAlt:ExtraFieldsGroup = null;

        public function UI_ViewPointEntry()
        {
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            _vehicleID = BattleGlobalData.playerVehicleID;

            _linesEnabled = Config.config.minimap.linesEnabled;
            if (_linesEnabled)
            {
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_SIZE_CHANGED, updateLinesScale);
                sectorLeft.visible = false;
                sectorRight.visible = false;
                try
                {
                    _vehicleLine = MinimapEntriesLinesHelper.createLines(Config.config.minimap.lines.parsedVehicle);
                    _vehicleLineAlt = MinimapEntriesLinesHelper.createLines(Config.config.minimapAlt.lines.parsedVehicle);
                    _traverseAngle1Line = MinimapEntriesLinesHelper.createLines(Config.config.minimap.lines.parsedTraverseAngle);
                    _traverseAngle1LineAlt = MinimapEntriesLinesHelper.createLines(Config.config.minimapAlt.lines.parsedTraverseAngle);
                    _traverseAngle2Line = MinimapEntriesLinesHelper.createLines(Config.config.minimap.lines.parsedTraverseAngle);
                    _traverseAngle2LineAlt = MinimapEntriesLinesHelper.createLines(Config.config.minimapAlt.lines.parsedTraverseAngle);
                    var idx:int = getChildIndex(sectorRight);
                    addChildAt(_vehicleLine, idx + 1);
                    addChildAt(_vehicleLineAlt, idx + 2);
                    addChildAt(_traverseAngle1Line, idx + 3);
                    addChildAt(_traverseAngle1LineAlt, idx + 4);
                    addChildAt(_traverseAngle2Line, idx + 5);
                    addChildAt(_traverseAngle2LineAlt, idx + 6);
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }

            MinimapEntriesLabelsHelper.init(this);
        }

        /* !!!TODO!!!
        override public function dispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.dispose();
        }
        */

        override public function setYawLimit(leftYawLimit:Number, rightYawLimit:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: setYawLimit() on deleted VehicleEntry");
                return;
            }

            super.setYawLimit(leftYawLimit, rightYawLimit);

            _leftYawLimit = leftYawLimit;
            _rightYawLimit = rightYawLimit;
            _isLimitUpdated = true;
            invalidate(INVALID_UPDATE_XVM);
        }

        override public function clearYawLimit():void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: crearYawLimit() on deleted VehicleEntry");
                return;
            }

            super.clearYawLimit();

            _leftYawLimit = NaN;
            _rightYawLimit = NaN;
            _isLimitUpdated = true;
            invalidate(INVALID_UPDATE_XVM);
        }

        override protected function draw():void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: draw() on deleted ViewPointEntry");
                return;
            }

            super.draw();

            try
            {
                if (isInvalid(INVALID_UPDATE_XVM))
                {
                    var playerState:VOPlayerState = BattleState.get(_vehicleID);
                    if (playerState)
                    {
                        updateVehicleIcon(playerState);
                        updateLines(playerState);
                        updateLabels(playerState);
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

            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_SIZE_CHANGED, updateLinesScale);

            if (_vehicleLine)
            {
                removeChild(_vehicleLine);
                _vehicleLine = null;
            }

            if (_vehicleLineAlt)
            {
                removeChild(_vehicleLineAlt);
                _vehicleLineAlt = null;
            }

            if (_traverseAngle1Line)
            {
                removeChild(_traverseAngle1Line);
                _traverseAngle1Line = null;
            }

            if (_traverseAngle1LineAlt)
            {
                removeChild(_traverseAngle1LineAlt);
                _traverseAngle1LineAlt = null;
            }

            if (_traverseAngle2Line)
            {
                removeChild(_traverseAngle2Line);
                _traverseAngle2Line = null;
            }

            if (_traverseAngle2LineAlt)
            {
                removeChild(_traverseAngle2LineAlt);
                _traverseAngle2LineAlt = null;
            }

            MinimapEntriesLabelsHelper.dispose(this);
        }

        public function xvm_setVehicleID(vehicleID:Number):void
        {
            if (_vehicleID != vehicleID)
            {
                _vehicleID = vehicleID;
                invalidate(INVALID_UPDATE_XVM);
            }
        }

        // IMinimapVehicleEntry

        public function get extraFields():ExtraFieldsGroup
        {
            return _extraFields;
        }

        public function set extraFields(value:ExtraFieldsGroup):void
        {
            _extraFields = value;
        }

        public function get extraFieldsAlt():ExtraFieldsGroup
        {
            return _extraFieldsAlt;
        }

        public function set extraFieldsAlt(value:ExtraFieldsGroup):void
        {
            _extraFieldsAlt = value;
        }

        public function playerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == _vehicleID)
            {
                update();
            }
        }

        public function update():void
        {
            invalidate(INVALID_UPDATE_XVM);
        }

        public function onEnterFrame():void
        {
            MinimapEntriesLabelsHelper.onEnterFrameHandler(this);
        }

        // PRIVATE

        private function updateVehicleIcon(playerState:VOPlayerState):void
        {
            GraphicsUtil.colorize(arrowPlaceholder, Macros.FormatNumber(UI_Minimap.cfg.selfIconColor, playerState));
            arrowPlaceholder.alpha = Macros.FormatNumber(UI_Minimap.cfg.selfIconAlpha, playerState, 100) / 100.0;
            var iconScale:Number = Macros.FormatNumber(UI_Minimap.cfg.selfIconScale, playerState, 1);
            CLIENT::WG {
                arrowPlaceholder.x = -DEFAULT_VEHICLE_ICON_WIDTH * iconScale / 4.0;
                arrowPlaceholder.y = -DEFAULT_VEHICLE_ICON_HEIGHT * iconScale / 2.0 + 11 * iconScale;
            }
            CLIENT::LESTA {
                arrowPlaceholder.x = (-DEFAULT_VEHICLE_ICON_WIDTH * iconScale) >> 1;
                arrowPlaceholder.y = (-DEFAULT_VEHICLE_ICON_HEIGHT * iconScale) >> 1;
            }
            arrowPlaceholder.scaleX = arrowPlaceholder.scaleY = DEFAULT_VEHICLE_ICON_SCALE * iconScale;
        }

        private function updateLines(playerState:VOPlayerState):void
        {
            if (_linesEnabled)
            {
                sectorLeft.visible = false;
                sectorRight.visible = false;
                if (_vehicleID == BattleGlobalData.playerVehicleID)
                {
                    if (_isLimitUpdated)
                    {
                        if (!isNaN(_leftYawLimit))
                        {
                            if (!isNaN(_rightYawLimit))
                            {
                                _traverseAngle1Line.rotation = _traverseAngle1LineAlt.rotation = _leftYawLimit;
                                _traverseAngle2Line.rotation = _traverseAngle2LineAlt.rotation = _rightYawLimit;
                                this._isLimitUpdated = false;
                            }
                        }
                    }
                    var showVehicleLine:Boolean = playerState.isAlive;
                    var showTraverseAngleLine:Boolean = playerState.isAlive && !isNaN(_leftYawLimit) && !isNaN(_rightYawLimit);
                    var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
                    _vehicleLine.visible = showVehicleLine && !isAltMode;
                    _vehicleLineAlt.visible = showVehicleLine && isAltMode;
                    _traverseAngle1Line.visible = _traverseAngle2Line.visible = showTraverseAngleLine && !isAltMode;
                    _traverseAngle1LineAlt.visible = _traverseAngle2LineAlt.visible = showTraverseAngleLine && isAltMode;
                }
                else
                {
                    _vehicleLine.visible =
                        _vehicleLineAlt.visible =
                        _traverseAngle1Line.visible =
                        _traverseAngle1LineAlt.visible =
                        _traverseAngle2Line.visible =
                        _traverseAngle2LineAlt.visible = false;
                }
            }
        }

        private function updateLinesScale():void
        {
            var idx:int = UI_Minimap.instance.currentSizeIndex;
            _vehicleLine.scaleX = _vehicleLine.scaleY = _vehicleLineAlt.scaleX = _vehicleLineAlt.scaleY =
            _traverseAngle1Line.scaleX = _traverseAngle1Line.scaleY = _traverseAngle1LineAlt.scaleX = _traverseAngle1LineAlt.scaleY =
            _traverseAngle2Line.scaleX = _traverseAngle2Line.scaleY = _traverseAngle2LineAlt.scaleX = _traverseAngle2LineAlt.scaleY =
                MinimapSizeConst.ENTRY_INTERNAL_CONTENT_CONTR_SCALES[idx] * MinimapSizeConst.MAP_SIZE[idx].width / MinimapSizeConst.MAP_SIZE[0].width;
        }

        private function updateLabels(playerState:VOPlayerState):void
        {
            MinimapEntriesLabelsHelper.updateLabels(this, playerState);
        }
   }
}
