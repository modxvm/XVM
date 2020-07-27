package net.wg.gui.battle.views.epicRandomScorePanel
{
    import net.wg.infrastructure.base.meta.impl.EpicRandomScorePanelMeta;
    import net.wg.infrastructure.base.meta.IEpicRandomScorePanelMeta;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
    import net.wg.data.constants.InvalidationType;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.battle.views.epicRandomScorePanel.components.ERScoreHealthBarPanel;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
    import net.wg.data.constants.PersonalStatus;
    import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
    import scaleform.gfx.TextFieldEx;

    public class EpicRandomScorePanel extends EpicRandomScorePanelMeta implements IEpicRandomScorePanelMeta, IBattleComponentDataController
    {

        private static const FRAG_CORRELATION_WIN:String = "FragCorrelationWin";

        private static const FRAG_CORRELATION_LOSE:String = "FragCorrelationLoose";

        private static const RED:String = "red";

        private static const FRAG_EQUAL:int = 0;

        private static const FRAG_WIN:int = 1;

        private static const FRAG_LOSE:int = 2;

        private static const INVALID_FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        private static const INVALID_COLOR_SCHEME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private static const VEHICLE_SHOWN_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

        private static const SEPARATOR_STR:String = ":";

        public var allyTeamFragsField:TextField = null;

        public var enemyTeamFragsField:TextField = null;

        public var greenBackground:Sprite = null;

        public var redBackground:Sprite = null;

        public var purpleBackground:Sprite = null;

        public var teamFragsSeparatorField:TextField = null;

        public var hpBarPanel:ERScoreHealthBarPanel = null;

        private var _allyTeamFragsStr:String = "0";

        private var _enemyTeamFragsStr:String = "0";

        private var _lastTeamSeparatorState:int = 0;

        private var _currentTeamSeparatorState:int = 0;

        private var _winColorScheme:IColorScheme = null;

        private var _loseColorScheme:IColorScheme = null;

        private var _colorSchemeMgr:IColorSchemeManager;

        private var _rightBg:Sprite = null;

        private var _isVehicleCounterShown:Boolean = true;

        private var _isColorblind:Boolean = false;

        public function EpicRandomScorePanel()
        {
            this._colorSchemeMgr = App.colorSchemeMgr;
            super();
            this._rightBg = this.redBackground;
            TextFieldEx.setNoTranslate(this.allyTeamFragsField,true);
            TextFieldEx.setNoTranslate(this.enemyTeamFragsField,true);
            TextFieldEx.setNoTranslate(this.teamFragsSeparatorField,true);
            this._winColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN);
            this._loseColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE);
            mouseChildren = mouseEnabled = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_COLOR_SCHEME))
            {
                this.greenBackground.filters = [this._winColorScheme.adjustOffset];
                this._isColorblind = this._loseColorScheme.aliasColor != RED;
                this._rightBg.visible = false;
                this._rightBg = this._isColorblind?this.purpleBackground:this.redBackground;
                this._rightBg.filters = [this._loseColorScheme.adjustOffset];
                this._rightBg.visible = this._currentTeamSeparatorState == FRAG_LOSE;
                this.hpBarPanel.updateColorBlind(this._isColorblind);
            }
            if(isInvalid(INVALID_FRAGS))
            {
                this.allyTeamFragsField.text = this._allyTeamFragsStr;
                this.enemyTeamFragsField.text = this._enemyTeamFragsStr;
                if(this._currentTeamSeparatorState != this._lastTeamSeparatorState)
                {
                    this._lastTeamSeparatorState = this._currentTeamSeparatorState;
                    this.greenBackground.visible = this._currentTeamSeparatorState == FRAG_WIN;
                    this._rightBg.visible = this._currentTeamSeparatorState == FRAG_LOSE;
                    this.teamFragsSeparatorField.visible = this._currentTeamSeparatorState == FRAG_EQUAL;
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

        public function resetFrags() : void
        {
        }

        override protected function onDispose() : void
        {
            this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            this._colorSchemeMgr = null;
            this.allyTeamFragsField = null;
            this.enemyTeamFragsField = null;
            this.greenBackground = null;
            this.redBackground = null;
            this.purpleBackground = null;
            this.teamFragsSeparatorField = null;
            this.hpBarPanel.dispose();
            this.hpBarPanel = null;
            this._winColorScheme.dispose();
            this._winColorScheme = null;
            this._loseColorScheme.dispose();
            this._loseColorScheme = null;
            this._rightBg = null;
            super.onDispose();
        }

        public function addVehiclesInfo(param1:IDAAPIDataClass) : void
        {
        }

        public function as_setTeamHealthPercentages(param1:int, param2:int) : void
        {
            this.hpBarPanel.updateData(param1,param2);
        }

        public function setArenaInfo(param1:IDAAPIDataClass) : void
        {
        }

        public function setFrags(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
            if(_loc2_.totalStats)
            {
                this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
            }
        }

        public function setPersonalStatus(param1:uint) : void
        {
            var _loc2_:Boolean = PersonalStatus.isVehicleCounterShown(param1);
            if(this._isVehicleCounterShown != _loc2_)
            {
                this._isVehicleCounterShown = _loc2_;
                invalidate(VEHICLE_SHOWN_FLAG);
            }
        }

        public function setQuestStatus(param1:IDAAPIDataClass) : void
        {
        }

        public function setUserTags(param1:IDAAPIDataClass) : void
        {
        }

        public function setVehiclesData(param1:IDAAPIDataClass) : void
        {
        }

        public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
        {
        }

        public function updatePersonalStatus(param1:uint, param2:uint) : void
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

        public function updatePlayerStatus(param1:IDAAPIDataClass) : void
        {
        }

        public function updateUserTags(param1:IDAAPIDataClass) : void
        {
        }

        public function updateVehicleStatus(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
            if(_loc2_.totalStats)
            {
                this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
            }
        }

        public function updateVehiclesData(param1:IDAAPIDataClass) : void
        {
        }

        public function updateVehiclesStat(param1:IDAAPIDataClass) : void
        {
        }

        public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
        {
        }

        private function updateFrags(param1:int, param2:int) : void
        {
            this._allyTeamFragsStr = param1.toString();
            this._enemyTeamFragsStr = param2.toString();
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
            invalidate(INVALID_FRAGS);
        }

        public function get panelHeight() : int
        {
            return this.hpBarPanel.height;
        }

        private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
        {
            this._winColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_WIN);
            this._loseColorScheme = this._colorSchemeMgr.getScheme(FRAG_CORRELATION_LOSE);
            invalidate(INVALID_COLOR_SCHEME);
        }
    }
}
