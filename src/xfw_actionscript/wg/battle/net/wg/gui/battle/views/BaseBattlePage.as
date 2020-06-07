package net.wg.gui.battle.views
{
    import net.wg.infrastructure.base.meta.impl.BattlePageMeta;
    import net.wg.infrastructure.base.meta.IBattlePageMeta;
    import flash.geom.Point;
    import net.wg.gui.battle.battleloading.BaseBattleLoading;
    import net.wg.gui.battle.interfaces.IPrebattleTimerBase;
    import net.wg.gui.battle.views.damagePanel.DamagePanel;
    import net.wg.gui.battle.views.dualGunPanel.DualGunPanel;
    import net.wg.gui.battle.views.minimap.BaseMinimap;
    import net.wg.infrastructure.base.meta.impl.BattleTimerMeta;
    import net.wg.gui.battle.views.ribbonsPanel.RibbonsPanel;
    import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
    import net.wg.gui.battle.views.vehicleMessages.VehicleMessages;
    import net.wg.gui.battle.views.messages.MessageListDAAPI;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
    import flash.display.Sprite;
    import net.wg.gui.battle.views.gameMessagesPanel.events.GameMessagesPanelEvent;
    import net.wg.gui.battle.views.minimap.events.MinimapEvent;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.data.constants.Linkages;
    import flash.events.Event;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;
    import net.wg.gui.lobby.settings.config.ControlsFactory;
    import net.wg.infrastructure.interfaces.entity.IDisplayable;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
    import net.wg.data.constants.Errors;

    public class BaseBattlePage extends BattlePageMeta implements IBattlePageMeta
    {

        protected static const VEHICLE_MESSAGES_LIST_OFFSET:Point = new Point(500,76);

        protected static const VEHICLE_MESSAGES_LIST_POSTMORTEM_Y_OFFSET:int = 20;

        protected static const VEHICLE_ERRORS_LIST_OFFSET:Point = new Point(300,30);

        protected static const PLAYER_MESSAGES_LIST_OFFSET:Point = new Point(350,-38);

        protected static const MESSENGER_Y_OFFSET:int = 2;

        private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 150;

        private static const RIBBONS_MIN_BOTTOM_PADDING_Y:int = 116;

        public var battleLoading:BaseBattleLoading = null;

        public var prebattleTimer:IPrebattleTimerBase = null;

        public var damagePanel:DamagePanel = null;

        public var dualGunPanel:DualGunPanel = null;

        public var minimap:BaseMinimap = null;

        public var battleTimer:BattleTimerMeta = null;

        public var ribbonsPanel:RibbonsPanel = null;

        public var gameMessagesPanel:GameMessagesPanel = null;

        protected var vehicleMessageList:VehicleMessages;

        protected var vehicleErrorMessageList:MessageListDAAPI;

        protected var playerMessageList:MessageListDAAPI;

        public function get xfw_battleStatisticDataController():BattleStatisticDataController
        {
            return battleStatisticDataController;
        }

        protected var battleStatisticDataController:BattleStatisticDataController;

        protected var postmortemTips:PostmortemPanel = null;

        protected var isPostMortem:Boolean = false;

        private var _messagesContainer:Sprite = null;

        private var _componentsStorage:Object;

        public function BaseBattlePage()
        {
            this._componentsStorage = {};
            super();
            this.battleStatisticDataController = this.createStatisticsController();
            this.initializeStatisticsController(this.battleStatisticDataController);
            this.initializeMessageLists();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            var _loc3_:Number = param1 >> 1;
            var _loc4_:Number = param2 >> 1;
            _originalWidth = param1;
            _originalHeight = param2;
            setSize(param1,param2);
            this.prebattleTimer.updateStage(param1,param2);
            this.prebattleTimer.y = 0;
            this.prebattleTimer.x = _loc3_;
            this.damagePanel.x = 0;
            this.damagePanel.y = param2 - this.damagePanel.initedHeight;
            this.battleTimer.x = param1 - this.battleTimer.initedWidth;
            this.battleTimer.y = 0;
            if(this.dualGunPanel)
            {
                this.dualGunPanel.updateStage(param1,param2);
            }
            this.ribbonsPanel.x = _loc3_ + this.ribbonsPanel.offsetX;
            var _loc5_:int = this.getRibbonsCenterOffset();
            var _loc6_:Number = _loc4_ - _loc5_ - RIBBONS_MIN_BOTTOM_PADDING_Y;
            this.ribbonsPanel.setFreeWorkingHeight(_loc6_);
            var _loc7_:int = _loc4_ + (_loc6_ - this.ribbonsPanel.freeHeightForRenderers >> 1) + _loc5_;
            this.ribbonsPanel.y = _loc7_;
            this.minimap.x = param1 - this.minimap.currentWidth;
            this.minimap.y = param2 - this.minimap.currentHeight;
            if(this.postmortemTips)
            {
                this.updatePostmortemTipsPosition();
                this.updateBattleDamageLogPosInPostmortem();
            }
            this.vehicleErrorMessageList.setLocation(param1 - VEHICLE_ERRORS_LIST_OFFSET.x >> 1,(param2 >> 2) + VEHICLE_ERRORS_LIST_OFFSET.y);
            this.playerMessageListPositionUpdate();
            this.vehicleMessageList.updateStage();
            this.vehicleMessageListPositionUpdate();
            this.battleLoading.updateStage(param1,param2);
            this.gameMessagesPanel.x = _loc3_;
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.gameMessagesPanel.addEventListener(GameMessagesPanelEvent.MESSAGES_STARTED_PLAYING,this.onMessagesStartedPlayingHandler);
            this.gameMessagesPanel.addEventListener(GameMessagesPanelEvent.MESSAGES_ENDED_PLAYING,this.onMessagesEndedPlayingHandler);
            this.gameMessagesPanel.addEventListener(GameMessagesPanelEvent.ALL_MESSAGES_ENDED_PLAYING,this.onAllMessagesEndedPlayingHandler);
        }

        override protected function configUI() : void
        {
            this.updateStage(App.appWidth,App.appHeight);
            this.minimap.addEventListener(MinimapEvent.TRY_SIZE_CHANGED,this.onMiniMapTrySizeChangeHandler);
            this.minimap.addEventListener(MinimapEvent.SIZE_CHANGED,this.onMiniMapChangeHandler);
            this.minimap.addEventListener(MinimapEvent.VISIBILITY_CHANGED,this.onMiniMapChangeHandler);
            super.configUI();
        }

        override protected function onPopulate() : void
        {
            this.registerComponent(this.battleLoading,BATTLE_VIEW_ALIASES.BATTLE_LOADING);
            this.registerComponent(this.minimap,BATTLE_VIEW_ALIASES.MINIMAP);
            this.registerComponent(this.prebattleTimer,BATTLE_VIEW_ALIASES.PREBATTLE_TIMER);
            this.registerComponent(this.damagePanel,BATTLE_VIEW_ALIASES.DAMAGE_PANEL);
            this.registerComponent(this.battleTimer,BATTLE_VIEW_ALIASES.BATTLE_TIMER);
            this.registerComponent(this.ribbonsPanel,BATTLE_VIEW_ALIASES.RIBBONS_PANEL);
            this.registerComponent(this.vehicleMessageList,BATTLE_VIEW_ALIASES.VEHICLE_MESSAGES);
            this.registerComponent(this.vehicleErrorMessageList,BATTLE_VIEW_ALIASES.VEHICLE_ERROR_MESSAGES);
            this.registerComponent(this.playerMessageList,BATTLE_VIEW_ALIASES.PLAYER_MESSAGES);
            this.registerComponent(this.gameMessagesPanel,BATTLE_VIEW_ALIASES.GAME_MESSAGES_PANEL);
            if(this.dualGunPanel)
            {
                this.registerComponent(this.dualGunPanel,BATTLE_VIEW_ALIASES.DUAL_GUN_PANEL);
            }
            this.postmortemTips = App.utils.classFactory.getComponent(Linkages.POSTMORTEN_PANEL,PostmortemPanel);
            this.postmortemTips.setCompVisible(false);
            this.updatePostmortemTipsPosition();
            addChild(this.postmortemTips);
            this.ribbonsPanel.addEventListener(Event.CHANGE,this.onRibbonsPanelChangeHandler);
            this.registerComponent(this.postmortemTips,BATTLE_VIEW_ALIASES.POSTMORTEM_PANEL);
            this.onRegisterStatisticController();
            super.onPopulate();
        }

        override protected function onDispose() : void
        {
            this.battleLoading = null;
            this.prebattleTimer = null;
            this.damagePanel = null;
            this.battleTimer = null;
            this.ribbonsPanel.removeEventListener(Event.CHANGE,this.onRibbonsPanelChangeHandler);
            this.ribbonsPanel = null;
            this.dualGunPanel = null;
            this.gameMessagesPanel.removeEventListener(GameMessagesPanelEvent.MESSAGES_STARTED_PLAYING,this.onMessagesStartedPlayingHandler);
            this.gameMessagesPanel.removeEventListener(GameMessagesPanelEvent.MESSAGES_ENDED_PLAYING,this.onMessagesEndedPlayingHandler);
            this.gameMessagesPanel.removeEventListener(GameMessagesPanelEvent.ALL_MESSAGES_ENDED_PLAYING,this.onAllMessagesEndedPlayingHandler);
            this.gameMessagesPanel = null;
            this.minimap.removeEventListener(MinimapEvent.TRY_SIZE_CHANGED,this.onMiniMapTrySizeChangeHandler);
            this.minimap.removeEventListener(MinimapEvent.SIZE_CHANGED,this.onMiniMapChangeHandler);
            this.minimap.removeEventListener(MinimapEvent.VISIBILITY_CHANGED,this.onMiniMapChangeHandler);
            this.minimap = null;
            MinimapEntryController.instance.dispose();
            ControlsFactory.instance.dispose();
            if(this._messagesContainer)
            {
                this._messagesContainer = null;
            }
            this.vehicleMessageList = null;
            this.vehicleErrorMessageList = null;
            this.playerMessageList = null;
            this.battleStatisticDataController = null;
            this.postmortemTips = null;
            App.utils.data.cleanupDynamicObject(this._componentsStorage);
            this._componentsStorage = null;
            super.onDispose();
        }

        override protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
        {
            var _loc3_:String = null;
            for each(_loc3_ in param1)
            {
                this.showComponent(_loc3_,true);
            }
            for each(_loc3_ in param2)
            {
                this.showComponent(_loc3_,false);
            }
        }

        public function as_checkDAAPI() : void
        {
        }

        public function as_getComponentsVisibility() : Array
        {
            var _loc2_:String = null;
            var _loc3_:IDisplayable = null;
            var _loc1_:Array = [];
            for(_loc2_ in this._componentsStorage)
            {
                _loc3_ = this._componentsStorage[_loc2_];
                if(_loc3_.visible)
                {
                    _loc1_.push(_loc2_);
                }
            }
            return _loc1_;
        }

        public function as_isComponentVisible(param1:String) : Boolean
        {
            var _loc2_:IDisplayable = null;
            _loc2_ = this._componentsStorage[param1];
            App.utils.asserter.assertNotNull(_loc2_,"can\'t find component " + param1 + " in Battle Page");
            return _loc2_.visible;
        }

        public function as_setPostmortemTipsVisible(param1:Boolean) : void
        {
            this.postmortemTips.visible = param1;
            this.vehicleMessageListPositionUpdate();
            this.isPostMortem = param1;
            if(this.isPostMortem)
            {
                this.updateBattleDamageLogPosInPostmortem();
            }
        }

        public function as_toggleCtrlPressFlag(param1:Boolean) : void
        {
            App.toolTipMgr.hide();
        }

        protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
        {
        }

        protected function onMessagesStartedPlaying(param1:String) : void
        {
        }

        protected function onMessagesEndedPlaying(param1:String) : void
        {
        }

        protected function onAllMessagesEndedPlaying(param1:String) : void
        {
        }

        protected function createStatisticsController() : BattleStatisticDataController
        {
            return null;
        }

        protected function updateBattleDamageLogPosInPostmortem() : void
        {
        }

        protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
        {
        }

        protected function initializeMessageLists() : void
        {
            this._messagesContainer = new Sprite();
            this._messagesContainer.mouseEnabled = this._messagesContainer.mouseChildren = false;
            addChild(this._messagesContainer);
            swapChildren(this._messagesContainer,this.battleLoading);
            this.vehicleMessageList = new VehicleMessages(this._messagesContainer);
            this.vehicleErrorMessageList = new MessageListDAAPI(this._messagesContainer);
            this.playerMessageList = new MessageListDAAPI(this._messagesContainer);
        }

        protected function onRegisterStatisticController() : void
        {
        }

        protected function getAllowedMinimapSizeIndex(param1:Number) : Number
        {
            return param1;
        }

        protected function playerMessageListPositionUpdate() : void
        {
            this.playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_originalHeight - this.minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y);
        }

        public function xfw_registerComponent(param1:IDAAPIModule, param2:String) : void
        {
            registerComponent(param1,param2);
        }

        protected function registerComponent(param1:IDAAPIModule, param2:String) : void
        {
            this._componentsStorage[param2] = param1;
            registerFlashComponentS(param1,param2);
        }

        protected function getRibbonsCenterOffset() : int
        {
            return RIBBONS_CENTER_SCREEN_OFFSET_Y;
        }

        protected function getComponent(param1:String) : IDAAPIModule
        {
            return this._componentsStorage[param1];
        }

        private function showComponent(param1:String, param2:Boolean) : void
        {
            var _loc3_:IDisplayableComponent = null;
            _loc3_ = this._componentsStorage[param1];
            App.utils.asserter.assertNotNull(_loc3_,param1 + " " + Errors.CANT_NULL);
            _loc3_.setCompVisible(param2);
            this.onComponentVisibilityChanged(param1,param2);
        }

        private function updateMinimapSizeIndex(param1:Number) : void
        {
            this.minimap.setAllowedSizeIndex(this.getAllowedMinimapSizeIndex(param1));
        }

        private function vehicleMessageListPositionUpdate() : void
        {
            if(this.postmortemTips && this.postmortemTips.visible)
            {
                this.vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,this.postmortemTips.y - VEHICLE_MESSAGES_LIST_OFFSET.y - VEHICLE_MESSAGES_LIST_POSTMORTEM_Y_OFFSET | 0);
            }
            else
            {
                this.vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET.y | 0);
            }
        }

        private function updatePostmortemTipsPosition() : void
        {
            this.postmortemTips.x = width >> 1;
            this.postmortemTips.y = height;
            this.postmortemTips.updateElementsPosition();
        }

        protected function get isQuestProgress() : Boolean
        {
            return false;
        }

        public function xfw_onMiniMapChangeHandler(param1:MinimapEvent) : void
        {
            onMiniMapChangeHandler(param1);
        }

        protected function onMiniMapChangeHandler(param1:MinimapEvent) : void
        {
            this.playerMessageListPositionUpdate();
        }

        private function onMessagesStartedPlayingHandler(param1:GameMessagesPanelEvent) : void
        {
            this.onMessagesStartedPlaying(param1.messageType);
        }

        private function onMessagesEndedPlayingHandler(param1:GameMessagesPanelEvent) : void
        {
            this.onMessagesEndedPlaying(param1.messageType);
        }

        private function onAllMessagesEndedPlayingHandler(param1:GameMessagesPanelEvent) : void
        {
            this.onAllMessagesEndedPlaying(param1.messageType);
        }

        private function onRibbonsPanelChangeHandler(param1:Event) : void
        {
            this.ribbonsPanel.x = (_originalWidth >> 1) + this.ribbonsPanel.offsetX;
        }

        public function xfw_onMiniMapTrySizeChangeHandler(param1:MinimapEvent) : void
        {
            onMiniMapTrySizeChangeHandler(param1);
        }

        private function onMiniMapTrySizeChangeHandler(param1:MinimapEvent) : void
        {
            this.updateMinimapSizeIndex(param1.sizeIndex);
        }
    }
}
