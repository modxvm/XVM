package net.wg.gui.battle
{
    import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;
    import net.wg.infrastructure.base.meta.IStatsBaseMeta;
    import net.wg.gui.battle.interfaces.IFullStats;
    import flash.display.Sprite;
    import net.wg.gui.battle.components.FullStatsHeader;
    import net.wg.gui.battle.components.FullStatsTitle;
    import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
    import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
    import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
    import net.wg.infrastructure.events.VoiceChatEvent;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
    import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
    import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
    import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
    import net.wg.data.constants.LobbyMetrics;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
    import net.wg.data.constants.PersonalStatus;
    import net.wg.data.constants.Values;

    public class StatsBase extends StatsBaseMeta implements IStatsBaseMeta, IFullStats
    {

        protected static const MIN_HEIGHT:int = 880;

        private static const TABLE_SMALL_Y_SHIFT:int = -30;

        private static const STATS_TABLE_Y_SHIFT:int = 103;

        private static const FN_NAME_GET_TABLE_CTRL:String = "getTableCtrl";

        public var modalBgSpr:Sprite = null;

        public var header:FullStatsHeader = null;

        public var statsTable:Sprite = null;

        public var title:FullStatsTitle = null;

        protected var tableCtrl:ITabbedFullStatsTableController = null;

        protected var emptyStatusVO:DAAPIQuestStatusVO = null;

        private var _arenaData:DAAPIArenaInfoVO = null;

        private var _isInteractive:Boolean = false;

        private var _personalStatus:uint = 0;

        public function StatsBase()
        {
            super();
            this.header.setMinHeight(MIN_HEIGHT);
            this.tableCtrl = this.getTableCtrl();
            this.emptyStatusVO = new DAAPIQuestStatusVO({"status":Values.EMPTY_STR});
        }

        override public function setCompVisible(param1:Boolean) : void
        {
            super.setCompVisible(param1);
            this.tableCtrl.isRenderingAvailable = param1;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.initTitle();
            App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatMgrStartSpeakingHandler);
            App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatMgrStopSpeakingHandler);
            App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
        }

        override protected function onDispose() : void
        {
            App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatMgrStartSpeakingHandler);
            App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatMgrStopSpeakingHandler);
            App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            IDisposable(this.statsTable).dispose();
            this.statsTable = null;
            this.header.dispose();
            this.header = null;
            this.title.dispose();
            this.title = null;
            this.modalBgSpr = null;
            this._arenaData = null;
            this.tableCtrl.dispose();
            this.tableCtrl = null;
            this.emptyStatusVO.dispose();
            this.emptyStatusVO = null;
            super.onDispose();
        }

        public function addVehiclesInfo(param1:IDAAPIDataClass) : void
        {
        }

        public function as_setIsInteractive(param1:Boolean) : void
        {
            this._isInteractive = param1;
            this.applyInteractivity();
        }

        public function getStatsProgressView() : IQuestProgressView
        {
            return null;
        }

        public function getTableCtrl() : ITabbedFullStatsTableController
        {
            throw new AbstractException(FN_NAME_GET_TABLE_CTRL + Errors.ABSTRACT_INVOKE);
        }

        public function resetFrags() : void
        {
        }

        public function setArenaInfo(param1:IDAAPIDataClass) : void
        {
            if(this._arenaData != param1 && param1 != null)
            {
                this._arenaData = DAAPIArenaInfoVO(param1);
                this.tableCtrl.setTeamsInfo(this._arenaData.allyTeamName,this._arenaData.enemyTeamName);
                this.header.update(this._arenaData);
            }
        }

        public function setFrags(param1:IDAAPIDataClass) : void
        {
            this.updateFrags(param1);
        }

        public function setPersonalStatus(param1:uint) : void
        {
            this._personalStatus = param1;
            this.applyPersonalStatus();
        }

        public function setQuestStatus(param1:IDAAPIDataClass) : void
        {
        }

        public function setUserTags(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
            this.tableCtrl.setUserTags(false,_loc2_.leftUserTags);
            this.tableCtrl.setUserTags(true,_loc2_.rightUserTags);
        }

        public function setVehiclesData(param1:IDAAPIDataClass) : void
        {
        }

        public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
            this.tableCtrl.updateInvitationsStatuses(false,_loc2_.leftItems);
            this.tableCtrl.updateInvitationsStatuses(true,_loc2_.rightItems);
        }

        public function updatePersonalStatus(param1:uint, param2:uint) : void
        {
            if(param1 > 0)
            {
                this._personalStatus = this._personalStatus | param1;
            }
            if(param2 > 0)
            {
                this._personalStatus = this._personalStatus & ~param2;
            }
            this.applyPersonalStatus();
        }

        public function updatePlayerStatus(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
            this.tableCtrl.setPlayerStatus(_loc2_.isEnemy,_loc2_.vehicleID,_loc2_.status);
        }

        public function updateStageSize(param1:Number, param2:Number) : void
        {
            this.modalBgSpr.visible = false;
            var _loc3_:* = param1 >> 1;
            var _loc4_:* = 0;
            x = _loc3_;
            y = _loc4_;
            this.modalBgSpr.x = -_loc3_;
            this.modalBgSpr.y = _loc4_;
            this.modalBgSpr.width = param1;
            this.modalBgSpr.height = param2;
            this.modalBgSpr.visible = true;
            this.doUpdateSizeTop(param1,param2);
            this.doUpdateSizeTable(param1,param2);
        }

        public function updateUserTags(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
            this.tableCtrl.setUserTags(_loc2_.isEnemy,new <DAAPIVehicleUserTagsVO>[_loc2_]);
        }

        public function updateVehicleStatus(param1:IDAAPIDataClass) : void
        {
        }

        public function updateVehiclesData(param1:IDAAPIDataClass) : void
        {
        }

        public function updateVehiclesStat(param1:IDAAPIDataClass) : void
        {
        }

        protected function updateFrags(param1:IDAAPIDataClass) : void
        {
        }

        protected function doUpdateSizeTop(param1:Number, param2:Number) : void
        {
            this.header.updateSize(param1,param2);
        }

        protected function doUpdateSizeTable(param1:Number, param2:Number) : void
        {
            this.title.y = this.getTitleY();
            var _loc3_:int = param2 < MIN_HEIGHT?TABLE_SMALL_Y_SHIFT:0;
            this.statsTable.y = this.title.y + STATS_TABLE_Y_SHIFT + _loc3_;
        }

        protected function getTitleY() : int
        {
            var _loc1_:* = height - LobbyMetrics.MIN_STAGE_HEIGHT >> 2;
            return this.header.y + this.header.height + 10 + _loc1_;
        }

        protected function initTitle() : void
        {
            this.title.setStatus(this.emptyStatusVO);
            this.setTitle();
        }

        protected function setTitle() : void
        {
            this.title.setTitle(App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_LINE_UP_TITLE)));
        }

        private function applyInteractivity() : void
        {
            var _loc1_:Boolean = this._isInteractive && !PersonalStatus.isSquadRestrictions(this._personalStatus);
            var _loc2_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToAlly(this._personalStatus);
            var _loc3_:Boolean = _loc1_ && PersonalStatus.isCanSendInviteToEnemy(this._personalStatus);
            this.tableCtrl.setInteractive(_loc2_,_loc3_);
        }

        private function applyPersonalStatus() : void
        {
            this.tableCtrl.setIsInviteShown(PersonalStatus.isShowAllyInvites(this._personalStatus),PersonalStatus.isShowEnemyInvites(this._personalStatus));
            this.applyInteractivity();
        }

        private function onVoiceChatMgrStartSpeakingHandler(param1:VoiceChatEvent) : void
        {
            this.tableCtrl.setSpeaking(param1.getAccountDBID(),true);
        }

        private function onVoiceChatMgrStopSpeakingHandler(param1:VoiceChatEvent) : void
        {
            this.tableCtrl.setSpeaking(param1.getAccountDBID(),false);
        }

        private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
        {
            this.tableCtrl.updateColorBlind();
        }
    }
}
