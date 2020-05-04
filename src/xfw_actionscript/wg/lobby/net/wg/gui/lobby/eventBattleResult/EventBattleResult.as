package net.wg.gui.lobby.eventBattleResult
{
    import net.wg.infrastructure.base.meta.impl.EventBattleResultScreenMeta;
    import net.wg.infrastructure.base.meta.IEventBattleResultScreenMeta;
    import net.wg.gui.lobby.eventBattleResult.components.ResultTabs;
    import net.wg.gui.lobby.eventBattleResult.components.ResultStatus;
    import net.wg.gui.lobby.eventBattleResult.components.BottomStatus;
    import net.wg.gui.lobby.eventBattleResult.components.ResultBuddies;
    import net.wg.gui.lobby.eventBattleResult.components.ResultStats;
    import net.wg.gui.lobby.eventBattleResult.components.ResultPointsBonusAnim;
    import net.wg.gui.lobby.eventBattleResult.components.ResultPointsNoBonusAnim;
    import net.wg.gui.lobby.eventBattleResult.components.ResultMissions;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import net.wg.utils.IScheduler;
    import net.wg.gui.login.ISparksManager;
    import flash.display.DisplayObjectContainer;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.notification.events.NotificationLayoutEvent;
    import flash.geom.Point;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.wg.data.constants.Linkages;
    import flash.geom.Rectangle;
    import scaleform.clik.events.InputEvent;

    public class EventBattleResult extends EventBattleResultScreenMeta implements IEventBattleResultScreenMeta
    {

        private static const STATS_DELAY:int = 600;

        private static const BONUS_DELAY:int = 400;

        private static const MISSIONS_DELAY:int = 1300;

        private static const MISSIONS_NO_BONUS_DELAY:int = 500;

        private static const MIN_HEIGHT:int = 870;

        private static const MISSIONS_OFFSET:int = 40;

        private static const MISSIONS_OFFSET_MIN:int = -21;

        private static const STATS_Y:int = -214;

        private static const STATS_Y_MIN:int = -166;

        private static const POINTS_Y:int = -42;

        private static const POINTS_Y_MIN:int = -63;

        private static const BUDDIES_Y:int = -128;

        private static const TAB_OFFSET:int = 165;

        private static const TAB_OFFSET_MIN:int = 110;

        private static const NORMAL_FRAME:int = 1;

        private static const MIN_FRAME:int = 2;

        private static const BUTTON_OFFSET:int = 100;

        private static const BUTTON_OFFSET_MIN:int = 56;

        private static const CLOSE_OFFSET:int = 30;

        private static const CLOSE_OFFSET_MIN:int = 20;

        private static const SM_PADDING_X:int = 4;

        private static const SM_PADDING_Y:int = 35;

        private static const BG_WIDTH:int = 1920;

        private static const BG_HEIGHT:int = 1200;

        private static const SPARK_QUANTITY:uint = 150;

        private static const SOUND_STAT_ITEM:String = "stat_item";

        private static const SOUND_MAIN_POINTS:String = "main_points";

        private static const SOUND_NO_BONUS_POINTS:String = "no_bonus_points";

        private static const SOUND_BONUS:String = "bonus";

        private static const SOUND_NO_BONUS:String = "no_bonus";

        private static const SOUND_BANNER:String = "banner";

        private static const SOUND_PROGRESS_BAR:String = "progress_bar";

        public var tab:ResultTabs = null;

        public var resultStatus:ResultStatus = null;

        public var tankStatus:BottomStatus = null;

        public var gameStatus:BottomStatus = null;

        public var buddies:ResultBuddies = null;

        public var resultStats:ResultStats = null;

        public var pointsBonus:ResultPointsBonusAnim = null;

        public var pointsNoBonus:ResultPointsNoBonusAnim = null;

        public var missions:ResultMissions = null;

        public var messengerBg:Sprite = null;

        public var bg:UILoaderAlt = null;

        public var btnNext:ISoundButtonEx = null;

        public var sparksMc:MovieClip = null;

        private var _data:ResultDataVO = null;

        private var _canInvite:Boolean = false;

        private var _friends:Array = null;

        private var _scheduler:IScheduler;

        private var _sparksManager:ISparksManager = null;

        private var _systemMessages:DisplayObjectContainer = null;

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

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(InteractiveObject(this.btnNext));
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this._systemMessages.dispatchEvent(new NotificationLayoutEvent(NotificationLayoutEvent.UPDATE_LAYOUT,new Point(SM_PADDING_X,SM_PADDING_Y)));
                _loc1_ = _height < MIN_HEIGHT;
                _loc2_ = _loc1_?MIN_FRAME:NORMAL_FRAME;
                this.resultStatus.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.tankStatus.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.gameStatus.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.pointsBonus.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.pointsNoBonus.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                this.resultStats.setSizeFrame(_loc2_);
                if(_baseDisposed)
                {
                    return;
                }
                _loc3_ = _width >> 1;
                this.btnNext.x = _width - this.btnNext.width >> 1;
                this.btnNext.y = _height - (_loc1_?BUTTON_OFFSET_MIN:BUTTON_OFFSET);
                closeBtn.y = _loc1_?CLOSE_OFFSET_MIN:CLOSE_OFFSET;
                this.resultStatus.x = _loc3_;
                this.resultStatus.setWidth(_width);
                this.tab.x = _loc3_;
                this.tab.y = _loc1_?TAB_OFFSET_MIN:TAB_OFFSET;
                _loc4_ = this.tab.y + this.tab.hover.height + (this.btnNext.y - this.tab.y - this.tab.hover.height >> 1) | 0;
                this.pointsBonus.x = this.pointsNoBonus.x = _loc3_;
                this.pointsBonus.y = this.pointsNoBonus.y = _loc4_ + (_loc1_?POINTS_Y_MIN:POINTS_Y);
                this.resultStats.x = _loc3_;
                this.resultStats.y = _loc4_ + (_loc1_?STATS_Y_MIN:STATS_Y);
                this.tankStatus.x = _width;
                this.tankStatus.y = _height;
                this.gameStatus.y = _height;
                this.missions.x = _loc3_;
                this.missions.y = _loc4_ + (_loc1_?MISSIONS_OFFSET_MIN:MISSIONS_OFFSET);
                this.buddies.x = _loc3_;
                this.buddies.y = _loc4_ + BUDDIES_Y;
                _loc5_ = _height + this.messengerBg.height >> 0;
                if(_width / _loc5_ > BG_WIDTH / BG_HEIGHT)
                {
                    _loc6_ = _width / BG_WIDTH;
                }
                else
                {
                    _loc6_ = _loc5_ / BG_HEIGHT;
                }
                this.bg.scaleX = this.bg.scaleY = _loc6_;
                this.bg.x = _width - BG_WIDTH * _loc6_ >> 1;
                this.bg.y = _loc5_ - BG_HEIGHT * _loc6_ >> 1;
                this.messengerBg.y = _height;
                this.messengerBg.width = _width;
                if(this._sparksManager != null)
                {
                    this._sparksManager.resetZone(this.getSparkZone());
                }
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.resultStatus.setData(this._data.captureStatus);
                this.pointsBonus.visible = this._data.points.isBonus;
                this.pointsNoBonus.visible = !this.pointsBonus.visible;
                if(this._data.points.isBonus)
                {
                    this.pointsBonus.setData(this._data.points);
                }
                else
                {
                    this.pointsNoBonus.setData(this._data.points);
                }
                this.buddies.setData(this._data,this._canInvite,this._friends);
                this.resultStats.setData(this._data);
                this.tankStatus.setData(this._data.tankStatus);
                this.gameStatus.setData(this._data.gameStatus);
                this.missions.setData(this._data.personalMission,this._data.crewMission);
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
            this._systemMessages = App.systemMessages;
            this.tab.visible = false;
            this.btnNext.visible = false;
            closeBtn.label = EVENT.RESULTSCREEN_CLOSE;
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true,null,getFocusIndex());
            this.tab.addEventListener(EventBattleResultEvent.TAB_CHANGED,this.onTabChangedHandler);
            addEventListener(EventBattleResultEvent.SEND_FRIEND,this.onSendFriendHandler);
            addEventListener(EventBattleResultEvent.SEND_SQUAD,this.onSendSquadHandler);
            this.bg.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoadCompleteHandler);
            this.buddies.visible = false;
            this.btnNext.addEventListener(ButtonEvent.CLICK,this.onBtnNextClickHandler);
            this.btnNext.label = EVENT.RESULTSCREEN_NEXT;
            this.sparksMc.mouseChildren = this.sparksMc.mouseEnabled = false;
            this.resultStats.mouseChildren = this.pointsBonus.mouseChildren = this.pointsNoBonus.mouseChildren = this.missions.mouseChildren = false;
            this.createSparks();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onBeforeDispose() : void
        {
            this._scheduler.cancelTask(this.showStats);
            this._scheduler.cancelTask(this.showMissions);
            this._scheduler.cancelTask(this.showBonus);
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
            this.tab.removeEventListener(EventBattleResultEvent.TAB_CHANGED,this.onTabChangedHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            removeEventListener(EventBattleResultEvent.SEND_FRIEND,this.onSendFriendHandler);
            removeEventListener(EventBattleResultEvent.SEND_SQUAD,this.onSendSquadHandler);
            this.btnNext.removeEventListener(ButtonEvent.CLICK,this.onBtnNextClickHandler);
            this.bg.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoadCompleteHandler);
            this.resultStats.removeEventListener(Event.COMPLETE,this.onStatsAnimationCompleteHandler);
            this.resultStats.removeEventListener(EventBattleResultEvent.STAT_APPEAR,this.onStatAppearHandler);
            this.missions.removeEventListener(Event.COMPLETE,this.onMissionsAnimationCompleteHandler);
            this.missions.removeEventListener(EventBattleResultEvent.PROGRESS_BAR_APPEAR,this.onMissionsProgressBarAppearHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.btnNext.dispose();
            this.btnNext = null;
            this.tab.dispose();
            this.tab = null;
            this.resultStatus.dispose();
            this.resultStatus = null;
            this.tankStatus.dispose();
            this.tankStatus = null;
            this.gameStatus.dispose();
            this.gameStatus = null;
            this.missions.dispose();
            this.missions = null;
            this.buddies.dispose();
            this.buddies = null;
            this.resultStats.dispose();
            this.resultStats = null;
            this.pointsBonus.dispose();
            this.pointsBonus = null;
            this.pointsNoBonus.dispose();
            this.pointsNoBonus = null;
            this.bg.dispose();
            this.bg = null;
            this.messengerBg = null;
            this.sparksMc = null;
            if(this._sparksManager != null)
            {
                this._sparksManager.dispose();
                this._sparksManager = null;
            }
            this._data = null;
            this._friends = null;
            this._scheduler = null;
            this._systemMessages = null;
            super.onDispose();
        }

        public function as_addToFriendResult(param1:Boolean, param2:Number) : void
        {
            if(!param1)
            {
                this.buddies.restoreFriendButton(param2);
            }
        }

        public function as_addToSquadResult(param1:Boolean, param2:Number) : void
        {
            if(!param1)
            {
                this.buddies.restoreSquadButton(param2);
            }
        }

        public function as_playAnimation() : void
        {
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            this.resultStatus.appear();
            this._scheduler.scheduleTask(this.showStats,STATS_DELAY);
        }

        private function createSparks() : void
        {
            if(this._sparksManager == null)
            {
                this._sparksManager = ISparksManager(App.utils.classFactory.getObject(Linkages.SPARKS_MGR));
                this._sparksManager.zone = this.getSparkZone();
                this._sparksManager.scope = this.sparksMc;
                this._sparksManager.sparkQuantity = SPARK_QUANTITY;
                this._sparksManager.createSparks();
            }
        }

        private function getSparkZone() : Rectangle
        {
            return new Rectangle(0,0,_width,_height);
        }

        private function showStats() : void
        {
            this.resultStats.appear();
            this.resultStats.addEventListener(Event.COMPLETE,this.onStatsAnimationCompleteHandler);
            this.resultStats.addEventListener(EventBattleResultEvent.STAT_APPEAR,this.onStatAppearHandler);
            if(this._data.points.points > 0)
            {
                playSoundFeedbackS(this._data.points.isBonus?SOUND_MAIN_POINTS:SOUND_NO_BONUS_POINTS);
            }
            if(this._data.points.isBonus)
            {
                this.pointsBonus.appear();
            }
            else
            {
                this.pointsNoBonus.appear();
            }
        }

        private function onStatsAnimationCompleteHandler(param1:Event) : void
        {
            this.resultStats.mouseChildren = true;
            this._scheduler.scheduleTask(this.showBonus,BONUS_DELAY);
        }

        private function onStatAppearHandler(param1:EventBattleResultEvent) : void
        {
            playSoundFeedbackS(SOUND_STAT_ITEM);
        }

        private function onMissionsAnimationCompleteHandler(param1:Event) : void
        {
            this.missions.mouseChildren = true;
        }

        private function onMissionsProgressBarAppearHandler(param1:EventBattleResultEvent) : void
        {
            playSoundFeedbackS(SOUND_PROGRESS_BAR);
        }

        private function showBonus() : void
        {
            if(this._data.points.isBonus)
            {
                this.pointsBonus.appearBonus();
                if(_baseDisposed)
                {
                    return;
                }
                playSoundFeedbackS(SOUND_BONUS);
                this._scheduler.scheduleTask(this.showMissions,MISSIONS_DELAY);
            }
            else if(this._data.points.points > 0)
            {
                this.pointsNoBonus.appearBonus();
                if(_baseDisposed)
                {
                    return;
                }
                playSoundFeedbackS(SOUND_NO_BONUS);
                this._scheduler.scheduleTask(this.showMissions,MISSIONS_NO_BONUS_DELAY);
            }
            else
            {
                this.showMissions();
            }
        }

        private function showMissions() : void
        {
            this.pointsBonus.mouseChildren = this.pointsNoBonus.mouseChildren = true;
            this.tab.visible = true;
            this.missions.addEventListener(Event.COMPLETE,this.onMissionsAnimationCompleteHandler);
            this.missions.addEventListener(EventBattleResultEvent.PROGRESS_BAR_APPEAR,this.onMissionsProgressBarAppearHandler);
            playSoundFeedbackS(SOUND_BANNER);
            this.missions.appear();
            this.tankStatus.appear();
            this.gameStatus.appear();
            this.btnNext.visible = true;
        }

        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            if(!this.btnNext.visible)
            {
                this._scheduler.cancelTask(this.showStats);
                this._scheduler.cancelTask(this.showBonus);
                this._scheduler.cancelTask(this.showMissions);
                this.resultStatus.immediateAppear();
                this.tankStatus.immediateAppear();
                this.gameStatus.immediateAppear();
                this.resultStats.removeEventListener(Event.COMPLETE,this.onStatsAnimationCompleteHandler);
                this.resultStats.removeEventListener(EventBattleResultEvent.STAT_APPEAR,this.onStatAppearHandler);
                this.resultStats.immediateAppear();
                this.missions.removeEventListener(Event.COMPLETE,this.onMissionsAnimationCompleteHandler);
                this.missions.removeEventListener(EventBattleResultEvent.PROGRESS_BAR_APPEAR,this.onMissionsProgressBarAppearHandler);
                this.missions.immediateAppear();
                if(this._data.points.isBonus)
                {
                    this.pointsBonus.immediateAppear();
                }
                else
                {
                    this.pointsNoBonus.immediateAppear();
                }
                this.tab.visible = true;
                this.btnNext.visible = true;
                this.resultStats.mouseChildren = this.pointsBonus.mouseChildren = this.pointsNoBonus.mouseChildren = this.missions.mouseChildren = true;
            }
        }

        private function onTabChangedHandler(param1:EventBattleResultEvent) : void
        {
            var _loc2_:* = this.tab.selectedTab == 0;
            this.buddies.visible = !_loc2_;
            this.missions.visible = this.resultStats.visible = _loc2_;
            this.pointsBonus.visible = this._data.points.isBonus && _loc2_;
            this.pointsNoBonus.visible = !this._data.points.isBonus && _loc2_;
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

        private function onBtnNextClickHandler(param1:ButtonEvent) : void
        {
            closeViewS();
        }

        private function onBgLoadCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
    }
}
