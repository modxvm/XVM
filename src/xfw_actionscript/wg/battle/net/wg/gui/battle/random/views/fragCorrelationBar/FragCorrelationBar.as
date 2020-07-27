package net.wg.gui.battle.random.views.fragCorrelationBar
{
    import net.wg.infrastructure.base.meta.impl.FragCorrelationBarMeta;
    import net.wg.infrastructure.base.meta.IFragCorrelationBarMeta;
    import net.wg.data.constants.InvalidationType;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
    import net.wg.data.constants.PersonalStatus;
    import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import scaleform.gfx.TextFieldEx;

    public class FragCorrelationBar extends FragCorrelationBarMeta implements IFragCorrelationBarMeta
    {

        private static const FRAG_CORRELATION_WIN:String = "FragCorrelationWin";

        private static const FRAG_CORRELATION_LOSE:String = "FragCorrelationLoose";

        private static const RED:String = "red";

        private static const FRAG_EQUAL:int = 0;

        private static const FRAG_WIN:int = 1;

        private static const FRAG_LOSE:int = 2;

        private static const INVALID_COLOR_SCHEME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private static const VEHICLE_SHOWN_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

        private static const SEPARATOR_STR:String = ":";

        public var greenBackground:Sprite = null;

        public var redBackground:Sprite = null;

        public var purpleBackground:Sprite = null;

        public var teamFragsSeparatorField:TextField = null;

        private var _lastTeamSeparatorState:int = 0;

        private var _currentTeamSeparatorState:int = 0;

        private var _winColorScheme:IColorScheme = null;

        private var _loseColorScheme:IColorScheme = null;

        private var _allyVehicleMarkersList:VehicleMarkersList;

        private var _enemyVehicleMarkersList:VehicleMarkersList;

        private var _colorSchemeMgr:IColorSchemeManager;

        private var _rightBg:Sprite = null;

        private var _isVehicleCounterShown:Boolean = true;

        public function FragCorrelationBar()
        {
            this._colorSchemeMgr = App.colorSchemeMgr;
            super();
            this._rightBg = this.redBackground;
            TextFieldEx.setNoTranslate(this.teamFragsSeparatorField,true);
            this._winColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN);
            this._loseColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE);
            this._allyVehicleMarkersList = this.createVehicleMarkersLists(this,false,this._winColorScheme.aliasColor);
            this._enemyVehicleMarkersList = this.createVehicleMarkersLists(this,true,this._loseColorScheme.aliasColor);
        }

        protected function createVehicleMarkersLists(param1:MovieClip, param2:Boolean, param3:String) : VehicleMarkersList
        {
            return new VehicleMarkersList(param1,param2,param3);
        }

        override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            if(_loc2_.rightVehicleInfos)
            {
                this._enemyVehicleMarkersList.addVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
            }
            if(_loc2_.leftVehicleInfos)
            {
                this._allyVehicleMarkersList.addVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
            }
        }

        override public function setPersonalStatus(param1:uint) : void
        {
            var _loc2_:Boolean = PersonalStatus.isVehicleCounterShown(param1);
            if(this._isVehicleCounterShown != _loc2_)
            {
                this._isVehicleCounterShown = _loc2_;
                invalidate(VEHICLE_SHOWN_FLAG);
            }
        }

        override public function setVehiclesData(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            this._enemyVehicleMarkersList.updateMarkers(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
            this._allyVehicleMarkersList.updateMarkers(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
        }

        override public function updatePersonalStatus(param1:uint, param2:uint) : void
        {
            if(PersonalStatus.IS_VEHICLE_COUNTER_SHOWN == param1)
            {
                this._isVehicleCounterShown = true;
                invalidate(VEHICLE_SHOWN_FLAG);
            }
            else if(PersonalStatus.IS_VEHICLE_COUNTER_SHOWN == param2)
            {
                this._isVehicleCounterShown = false;
                invalidate(VEHICLE_SHOWN_FLAG);
            }
        }

        override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
            if(_loc2_.isEnemy)
            {
                this._enemyVehicleMarkersList.updateVehicleStatus(_loc2_.vehicleID,_loc2_.status,_loc2_.rightCorrelationIDs);
            }
            else
            {
                this._allyVehicleMarkersList.updateVehicleStatus(_loc2_.vehicleID,_loc2_.status,_loc2_.leftCorrelationIDs);
            }
            super.updateVehicleStatus(param1);
        }

        override public function updateVehiclesData(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            if(_loc2_.leftVehicleInfos)
            {
                this._allyVehicleMarkersList.updateVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
            }
            if(_loc2_.rightVehicleInfos)
            {
                this._enemyVehicleMarkersList.updateVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_COLOR_SCHEME))
            {
                this.greenBackground.filters = [this._winColorScheme.adjustOffset];
                this._rightBg.visible = false;
                this._rightBg = this._loseColorScheme.aliasColor == RED?this.redBackground:this.purpleBackground;
                this._rightBg.filters = [this._loseColorScheme.adjustOffset];
                this._rightBg.visible = this._currentTeamSeparatorState == FRAG_LOSE;
            }
            if(isInvalid(INVALID_FRAGS))
            {
                if(this._currentTeamSeparatorState != this._lastTeamSeparatorState)
                {
                    this._lastTeamSeparatorState = this._currentTeamSeparatorState;
                    this.greenBackground.visible = this._currentTeamSeparatorState == FRAG_WIN;
                    this._rightBg.visible = this._currentTeamSeparatorState == FRAG_LOSE;
                    this.teamFragsSeparatorField.visible = this._currentTeamSeparatorState == FRAG_EQUAL;
                }
            }
            if(isInvalid(VEHICLE_SHOWN_FLAG))
            {
                if(this._isVehicleCounterShown)
                {
                    this._allyVehicleMarkersList.showVehicleMarkers();
                    this._enemyVehicleMarkersList.showVehicleMarkers();
                }
                else
                {
                    this._allyVehicleMarkersList.hideVehicleMarkers();
                    this._enemyVehicleMarkersList.hideVehicleMarkers();
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.greenBackground.visible = false;
            this.redBackground.visible = false;
            this.purpleBackground.visible = false;
            this.teamFragsSeparatorField.text = SEPARATOR_STR;
            this.teamFragsSeparatorField.cacheAsBitmap = true;
            this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
        }

        override protected function onDispose() : void
        {
            this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            this._colorSchemeMgr = null;
            this.greenBackground = null;
            this.redBackground = null;
            this.purpleBackground = null;
            this.teamFragsSeparatorField = null;
            this._winColorScheme.dispose();
            this._winColorScheme = null;
            this._loseColorScheme.dispose();
            this._loseColorScheme = null;
            this._allyVehicleMarkersList.dispose();
            this._allyVehicleMarkersList = null;
            this._enemyVehicleMarkersList.dispose();
            this._enemyVehicleMarkersList = null;
            this._rightBg = null;
            super.onDispose();
        }

        override public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
        {
        }

        override protected function updateFrags(param1:int, param2:int) : void
        {
            if(param1 == param2)
            {
                this._currentTeamSeparatorState = FRAG_EQUAL;
            }
            else if(param1 > param2)
            {
                this._currentTeamSeparatorState = FRAG_WIN;
            }
            else
            {
                this._currentTeamSeparatorState = FRAG_LOSE;
            }
            super.updateFrags(param1,param2);
        }

        private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
        {
            this._winColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN);
            this._loseColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE);
            this._allyVehicleMarkersList.color = this._winColorScheme.aliasColor;
            this._enemyVehicleMarkersList.color = this._loseColorScheme.aliasColor;
            invalidate(INVALID_COLOR_SCHEME);
        }

        protected function get enemyVehicleMarkersList() : VehicleMarkersList
        {
            return this._enemyVehicleMarkersList;
        }

        protected function get allyVehicleMarkersList() : VehicleMarkersList
        {
            return this._allyVehicleMarkersList;
        }
    }
}
