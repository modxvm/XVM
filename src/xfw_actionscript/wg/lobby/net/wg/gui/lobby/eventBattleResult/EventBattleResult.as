package net.wg.gui.lobby.eventBattleResult
{
    import net.wg.infrastructure.base.meta.impl.EventBattleResultScreenMeta;
    import net.wg.infrastructure.base.meta.IEventBattleResultScreenMeta;
    import net.wg.gui.lobby.eventBattleResult.components.ResultTabs;
    import net.wg.gui.lobby.eventBattleResult.components.ResultStatus;
    import net.wg.gui.lobby.eventBattleResult.components.TankStatus;
    import net.wg.gui.lobby.eventBattleResult.components.ResultBuddies;
    import net.wg.gui.lobby.eventBattleResult.components.ResultStats;
    import net.wg.gui.lobby.eventBattleResult.components.ResultReward;
    import net.wg.gui.lobby.eventBattleResult.components.ResultMissions;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import net.wg.utils.IScheduler;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.InputEvent;

    public class EventBattleResult extends EventBattleResultScreenMeta implements IEventBattleResultScreenMeta
    {

        private static const CONTENT_DELAY:int = 400;

        private static const MISSIONS_DELAY:int = 2500;

        private static const MIN_WIDTH:int = 1200;

        private static const MIN_HEIGHT:int = 900;

        private static const TANK_STATUS_OFFSET:int = 20;

        private static const TANK_STATS_OFFSET:int = 20;

        private static const REWARDS_MIN_OFFSET:int = 56;

        private static const REWARD_OFFSET:int = 10;

        private static const RESULTSTATUS_OFFSET:int = 86;

        private static const RESULTSTATUS_MIN_OFFSET:int = 50;

        private static const CLOSEBTN_MIN_OFFSET:int = 16;

        private static const CLOSEBTN_OFFSET:int = 30;

        private static const TAB_MIN_OFFSET:int = 24;

        private static const TAB_OFFSET:int = 36;

        private static const NORMAL_FRAME:int = 1;

        private static const MIN_FRAME:int = 2;

        private static const BG_WIDTH:int = 3440;

        private static const BG_HEIGHT:int = 1930;

        public var tab:ResultTabs = null;

        public var resultStatus:ResultStatus = null;

        public var tankStatus:TankStatus = null;

        public var buddies:ResultBuddies = null;

        public var resultStats:ResultStats = null;

        public var reward:ResultReward = null;

        public var missions:ResultMissions = null;

        public var messengerBg:Sprite = null;

        public var buddiesBg:Sprite = null;

        public var bg:UILoaderAlt = null;

        private var _data:ResultDataVO = null;

        private var _canInvite:Boolean = false;

        private var _friends:Array = null;

        private var _scheduler:IScheduler;

        public function EventBattleResult()
        {
            this._scheduler = App.utils.scheduler;
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            setSize(param1,param2);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = _width < MIN_WIDTH || _height < MIN_HEIGHT;
                _loc2_ = _loc1_?MIN_FRAME:NORMAL_FRAME;
                closeBtn.y = _loc1_?CLOSEBTN_MIN_OFFSET:CLOSEBTN_OFFSET;
                this.resultStatus.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.reward.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.buddies.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.missions.setIsMin(_loc1_);
                _loc3_ = _width >> 1;
                _loc4_ = _height >> 1;
                this.resultStatus.x = _loc3_;
                this.resultStatus.y = _loc1_?RESULTSTATUS_MIN_OFFSET:RESULTSTATUS_OFFSET;
                this.tab.x = _loc3_;
                this.tab.y = _loc1_?TAB_MIN_OFFSET:TAB_OFFSET;
                _loc5_ = _loc1_?REWARDS_MIN_OFFSET:Values.ZERO;
                this.resultStats.x = _loc3_;
                this.resultStats.y = _loc4_ - TANK_STATS_OFFSET - _loc5_;
                this.buddies.x = _loc3_;
                this.buddies.y = _loc4_ - (this.buddies.height >> 1);
                this.reward.x = _loc3_;
                this.reward.y = _loc4_ + (this.reward.height >> 1) - REWARD_OFFSET - _loc5_;
                this.tankStatus.x = _width - TANK_STATUS_OFFSET;
                this.tankStatus.y = _loc4_ - TANK_STATUS_OFFSET - _loc5_;
                this.missions.x = _loc3_;
                this.missions.y = this.reward.y + this.reward.height >> 0;
                _loc6_ = _height + this.messengerBg.height >> 0;
                if(_width / _loc6_ > BG_WIDTH / BG_HEIGHT)
                {
                    _loc7_ = _width / BG_WIDTH;
                }
                else
                {
                    _loc7_ = _loc6_ / BG_HEIGHT;
                }
                this.bg.scaleX = this.bg.scaleY = _loc7_;
                this.bg.x = _width - BG_WIDTH * _loc7_ >> 1;
                this.bg.y = _loc6_ - BG_HEIGHT * _loc7_ >> 1;
                this.messengerBg.y = _height;
                this.messengerBg.width = _width;
                this.buddiesBg.width = _width;
                this.buddiesBg.height = _height;
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.resultStatus.setData(this._data);
                this.reward.setData(this._data.reward);
                this.buddies.setData(this._data,this._canInvite,this._friends);
                this.resultStats.setData(this._data);
                this.tankStatus.setData(this._data);
                this.missions.setData(this._data.missions);
                this.bg.source = this._data.background;
            }
        }

        override protected function setVictoryData(param1:ResultDataVO, param2:Boolean, param3:Array) : void
        {
            this._data = param1;
            this._canInvite = param2;
            this._friends = param3;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = EVENT.RESULTSCREEN_CLOSE;
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true,null,getFocusIndex());
            this.tab.addEventListener(EventBattleResultEvent.TAB_CHANGED,this.onTabChangedHandler);
            addEventListener(EventBattleResultEvent.SEND_FRIEND,this.onSendFriendHandler);
            addEventListener(EventBattleResultEvent.SEND_SQUAD,this.onSendSquadHandler);
            this.buddies.visible = false;
            this.buddiesBg.visible = false;
        }

        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            this._scheduler.cancelTask(this.showContent);
            this._scheduler.cancelTask(this.showMissions);
            this.resultStatus.immediateAppear();
            this.tankStatus.immediateAppear();
            this.reward.immediateAppear();
            this.resultStats.immediateAppear();
            this.missions.immediateAppear();
        }

        private function onTabChangedHandler(param1:EventBattleResultEvent) : void
        {
            this.buddiesBg.visible = this.buddies.visible = this.tab.selectedTab != 0;
            this.missions.visible = this.tankStatus.visible = this.resultStats.visible = this.reward.visible = this.tab.selectedTab == 0;
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onBeforeDispose() : void
        {
            this._scheduler.cancelTask(this.showContent);
            this._scheduler.cancelTask(this.showMissions);
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
            this.tab.removeEventListener(EventBattleResultEvent.TAB_CHANGED,this.onTabChangedHandler);
            this.reward.removeEventListener(EventBattleResultEvent.VALUES_ANIMATION_STARTED,this.onValuesAnimationStartedHandler);
            this.missions.removeEventListener(EventBattleResultEvent.MISSION_REWARD_APPEAR,this.onMissionRewardAppearHandler);
            this.missions.removeEventListener(EventBattleResultEvent.MISSION_PROGRESSBAR_APPEAR,this.onMissionProgressbarAppearHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            removeEventListener(EventBattleResultEvent.SEND_FRIEND,this.onSendFriendHandler);
            removeEventListener(EventBattleResultEvent.SEND_SQUAD,this.onSendSquadHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.tab.dispose();
            this.tab = null;
            this.resultStatus.dispose();
            this.resultStatus = null;
            this.tankStatus.dispose();
            this.tankStatus = null;
            this.missions.dispose();
            this.missions = null;
            this.buddies.dispose();
            this.buddies = null;
            this.resultStats.dispose();
            this.resultStats = null;
            this.reward.dispose();
            this.reward = null;
            this.bg.dispose();
            this.bg = null;
            this.buddiesBg = null;
            this.messengerBg = null;
            this._data = null;
            this._friends = null;
            this._scheduler = null;
            super.onDispose();
        }

        public function as_playAnimation() : void
        {
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            this.resultStatus.appear();
            this.tankStatus.appear();
            this._scheduler.scheduleTask(this.showContent,CONTENT_DELAY);
            this._scheduler.scheduleTask(this.showMissions,MISSIONS_DELAY);
        }

        private function showContent() : void
        {
            this.reward.appear();
            this.resultStats.appear();
            playSliderSoundS();
            this.reward.addEventListener(EventBattleResultEvent.VALUES_ANIMATION_STARTED,this.onValuesAnimationStartedHandler);
        }

        private function onValuesAnimationStartedHandler(param1:EventBattleResultEvent) : void
        {
            playPointsSoundS();
        }

        private function showMissions() : void
        {
            if(this._data.missions.length > 0)
            {
                this.missions.appear();
                playQuestSoundS();
                this.missions.addEventListener(EventBattleResultEvent.MISSION_REWARD_APPEAR,this.onMissionRewardAppearHandler);
                this.missions.addEventListener(EventBattleResultEvent.MISSION_PROGRESSBAR_APPEAR,this.onMissionProgressbarAppearHandler);
            }
        }

        private function onMissionRewardAppearHandler(param1:EventBattleResultEvent) : void
        {
            playRewardSoundS();
        }

        private function onMissionProgressbarAppearHandler(param1:EventBattleResultEvent) : void
        {
            playProgressBarSoundS();
        }

        private function onEscapeKeyDownHandler(param1:InputEvent) : void
        {
            closeViewS();
        }

        private function onSendFriendHandler(param1:EventBattleResultEvent) : void
        {
            addToFriendS(param1.id,param1.userName);
        }

        private function onSendSquadHandler(param1:EventBattleResultEvent) : void
        {
            addToSquadS(param1.id);
        }

        public function as_addToSquadResult(param1:Boolean, param2:Number) : void
        {
            if(!param1)
            {
                this.buddies.restoreSquadButton(param2);
            }
        }

        public function as_addToFriendResult(param1:Boolean, param2:Number) : void
        {
            if(!param1)
            {
                this.buddies.restoreFriendButton(param2);
            }
        }
    }
}
