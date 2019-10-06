package net.wg.gui.notification
{
    import net.wg.infrastructure.base.meta.impl.NotificationsListMeta;
    import net.wg.infrastructure.base.meta.INotificationsListMeta;
    import net.wg.utils.ICounterProps;
    import net.wg.infrastructure.managers.counter.CounterProps;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.advanced.ContentTabBar;
    import flash.text.TextField;
    import net.wg.gui.lobby.progressiveReward.ProgressiveRewardWidget;
    import flash.display.Sprite;
    import net.wg.utils.ICounterManager;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.notification.events.ServiceMessageEvent;
    import flash.events.Event;
    import net.wg.gui.components.controls.events.ScrollEvent;
    import net.wg.gui.lobby.progressiveReward.events.ProgressiveRewardEvent;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.data.TabDataVO;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.data.constants.generated.NOTIFICATIONS_CONSTANTS;
    import net.wg.gui.notification.vo.NotificationInfoVO;
    import net.wg.gui.notification.vo.NotificationViewInitVO;
    import net.wg.gui.notification.vo.NotificationMessagesListVO;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.display.DisplayObject;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popovers.PopOver;
    import scaleform.gfx.TextFieldEx;

    public class NotificationListView extends NotificationsListMeta implements INotificationsListMeta
    {

        private static const TIME_UPDATE_INTERVAL:uint = 5 * 60 * 1000;

        private static const COUNTER_PROPS:ICounterProps = new CounterProps(-28,7);

        private static const DEFAULT_SCROLL_STEP:int = 7;

        private static const LIST_Y_OFFSET:int = 210;

        private static const LIST_HEIGHT_OFFSET:int = -210;

        private static const SCROLL_Y_OFFSET:int = 220;

        private static const SCROLL_HEIGHT_OFFSET:int = -220;

        private static const EMPTY_TF_Y_OFFSET:int = 110;

        private static const TOP_SHADOW_Y_OFFSET:int = 220;

        private static const INV_WIDGET_VISIBILITY:String = "invWidgetVisibility";

        public var list:NotificationsList;

        public var background:MovieClip;

        public var bottomLip:MovieClip;

        public var scrollBar:ScrollBar;

        public var buttonBar:ContentTabBar = null;

        public var emptyListTF:TextField = null;

        public var progressiveRewardWidget:ProgressiveRewardWidget = null;

        public var widgetSeparator:MovieClip = null;

        public var topShadow:Sprite = null;

        public var bottomShadow:Sprite = null;

        private var _currentBarIdx:int = 0;

        private var _counterManager:ICounterManager = null;

        private var _ignoreScrollBarHandler:Boolean = false;

        private var _scrollStepSize:int = 7;

        private var _listBaseY:int = -1;

        private var _listBaseHeight:int = -1;

        private var _scrollBaseY:int = -1;

        private var _scrollBaseHeight:int = -1;

        private var _emptyListTFbaseY:int = -1;

        private var _listReplacedY:int = -1;

        private var _listReplacedHeight:int = -1;

        private var _scrollReplacedY:int = -1;

        private var _scrollReplacedHeight:int = -1;

        private var _emptyListTFreplacedY:int = -1;

        private var _topShadowBaseY:int = -1;

        private var _topShadowReplacedY:int = -1;

        private var _isProgressRewardEnabled:Boolean = false;

        public function NotificationListView()
        {
            super();
            TextFieldEx.setVerticalAlign(this.emptyListTF,TextFieldEx.VALIGN_CENTER);
            this.emptyListTF.visible = false;
            this._counterManager = App.utils.counterManager;
        }

        override protected function configUI() : void
        {
            super.configUI();
            hitArea = this.background;
            this.bottomLip.mouseChildren = false;
            this.bottomLip.mouseEnabled = false;
            this._listBaseY = this.list.y;
            this._listBaseHeight = this.list.height;
            this._scrollBaseY = this.scrollBar.y;
            this._scrollBaseHeight = this.scrollBar.height;
            this._emptyListTFbaseY = this.emptyListTF.y;
            this._topShadowBaseY = this.topShadow.y;
            this._topShadowReplacedY = this._topShadowBaseY + TOP_SHADOW_Y_OFFSET;
            this._listReplacedY = this._listBaseY + LIST_Y_OFFSET;
            this._listReplacedHeight = this._listBaseHeight + LIST_HEIGHT_OFFSET;
            this._scrollReplacedY = this._scrollBaseY + SCROLL_Y_OFFSET;
            this._scrollReplacedHeight = this._scrollBaseHeight + SCROLL_HEIGHT_OFFSET;
            this._emptyListTFreplacedY = this._emptyListTFbaseY + EMPTY_TF_Y_OFFSET;
            this.updateScrollBarProperties();
            this.list.itemRendererClassName = Linkages.SERVICE_MESSAGE_IR_UI;
            this.list.verticalScrollStep = this._scrollStepSize;
            this.list.addEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.onListMessageButtonClickedHandler,false,0,true);
            this.list.addEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.onListMessageLinkClickedHandler,false,0,true);
            this.list.addEventListener(Event.SCROLL,this.onListScrollHandler);
            this.list.addEventListener(ScrollEvent.UPDATE_SIZE,this.onListUpdateSizeHandler);
            this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
            App.utils.scheduler.scheduleTask(this.updateTimestamps,TIME_UPDATE_INTERVAL);
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.updateTimestamps);
            this.progressiveRewardWidget.removeEventListener(ProgressiveRewardEvent.SWITCH_WIDGET_ENABLED,this.onProgressiveRewardWidgetSwitchWidgetEnabledHandler);
            this.list.removeEventListener(Event.SCROLL,this.onListScrollHandler);
            this.list.removeEventListener(ScrollEvent.UPDATE_SIZE,this.onListUpdateSizeHandler);
            this.list.removeEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this.onListMessageButtonClickedHandler);
            this.list.removeEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this.onListMessageLinkClickedHandler);
            this.list.dispose();
            this.list = null;
            this.background = null;
            this.bottomLip = null;
            this.topShadow = null;
            this.bottomShadow = null;
            this.widgetSeparator = null;
            this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
            this.scrollBar.dispose();
            this.scrollBar = null;
            var _loc1_:int = this.buttonBar.dataProvider.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                this._counterManager.removeCounter(this.buttonBar.getButtonAt(_loc2_));
                _loc2_++;
            }
            this.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
            this.buttonBar.dispose();
            this.progressiveRewardWidget = null;
            this.buttonBar = null;
            this.emptyListTF = null;
            this._counterManager = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:TabDataVO = null;
            var _loc2_:* = false;
            super.draw();
            if(isInvalid(INV_WIDGET_VISIBILITY))
            {
                _loc1_ = TabDataVO(this.buttonBar.data);
                if(!isFlashComponentRegisteredS(HANGAR_ALIASES.PROGRESSIVE_REWARD_WIDGET) && _loc1_.id == NOTIFICATIONS_CONSTANTS.TAB_OFFERS)
                {
                    this.progressiveRewardWidget.addEventListener(ProgressiveRewardEvent.SWITCH_WIDGET_ENABLED,this.onProgressiveRewardWidgetSwitchWidgetEnabledHandler);
                    registerFlashComponentS(this.progressiveRewardWidget,HANGAR_ALIASES.PROGRESSIVE_REWARD_WIDGET);
                }
                _loc2_ = this._isProgressRewardEnabled && _loc1_.id == NOTIFICATIONS_CONSTANTS.TAB_OFFERS && isFlashComponentRegisteredS(HANGAR_ALIASES.PROGRESSIVE_REWARD_WIDGET);
                this.progressiveRewardWidget.visible = _loc2_;
                this.scrollBar.y = _loc2_?this._scrollReplacedY:this._scrollBaseY;
                this.scrollBar.height = _loc2_?this._scrollReplacedHeight:this._scrollBaseHeight;
                this.list.y = _loc2_?this._listReplacedY:this._listBaseY;
                this.list.height = _loc2_?this._listReplacedHeight:this._listBaseHeight;
                this.emptyListTF.y = _loc2_?this._emptyListTFreplacedY:this._emptyListTFbaseY;
                this.topShadow.y = _loc2_?this._topShadowReplacedY:this._topShadowBaseY;
            }
        }

        override protected function appendMessage(param1:NotificationInfoVO) : void
        {
            this.updateTimestamp(param1);
            this.list.appendData(param1);
            if(this.emptyListTF.visible)
            {
                this.emptyListTF.visible = false;
            }
        }

        override protected function setInitData(param1:NotificationViewInitVO) : void
        {
            this._scrollStepSize = param1.scrollStepFactor;
            this.list.verticalScrollStep = this._scrollStepSize;
            this.updateScrollBarProperties();
            this.buttonBar.dataProvider = param1.tabsData.tabs;
            this.setTabIndex(param1.btnBarSelectedIdx);
            this.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
        }

        override protected function setMessagesList(param1:NotificationMessagesListVO) : void
        {
            var _loc2_:NotificationInfoVO = null;
            this.setTabIndex(param1.btnBarSelectedIdx);
            this.emptyListTF.visible = StringUtils.isNotEmpty(param1.emptyListText);
            if(this.emptyListTF.visible)
            {
                this.emptyListTF.text = param1.emptyListText;
            }
            for each(_loc2_ in param1.messages)
            {
                this.updateTimestamp(_loc2_);
            }
            this.list.setData(param1);
        }

        override protected function updateMessage(param1:NotificationInfoVO) : void
        {
            this.updateTimestamp(param1);
            this.list.updateData(param1);
        }

        override protected function updateCounters(param1:Array) : void
        {
            var _loc4_:DisplayObject = null;
            if(this.buttonBar.getButtonAt(0) == null)
            {
                this.buttonBar.validateNow();
            }
            var _loc2_:int = param1.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = this.buttonBar.getButtonAt(_loc3_);
                if(StringUtils.isNotEmpty(param1[_loc3_]))
                {
                    this._counterManager.setCounter(_loc4_,param1[_loc3_],null,COUNTER_PROPS);
                }
                else
                {
                    this._counterManager.removeCounter(_loc4_);
                }
                _loc3_++;
            }
        }

        private function setTabIndex(param1:int) : void
        {
            this.setCurrentBarIdx(param1);
            this.buttonBar.selectedIndex = this._currentBarIdx;
        }

        private function updateScrollBarProperties() : void
        {
            this.scrollBar.setScrollProperties(this.list.height,0,this.list.maxVerticalScrollPosition,this._scrollStepSize);
        }

        private function updateTimestamps() : void
        {
            var _loc2_:NotificationInfoVO = null;
            App.utils.scheduler.cancelTask(this.updateTimestamps);
            var _loc1_:IDataProvider = this.list.dataProvider;
            if(_loc1_ != null)
            {
                for each(_loc2_ in _loc1_)
                {
                    this.updateTimestamp(_loc2_);
                }
                this.list.invalidateRenderers();
            }
            App.utils.scheduler.scheduleTask(this.updateTimestamps,TIME_UPDATE_INTERVAL);
        }

        private function updateTimestamp(param1:NotificationInfoVO) : void
        {
            var _loc2_:Number = param1.messageVO.timestamp;
            if(_loc2_ != Values.DEFAULT_INT)
            {
                param1.messageVO.timestampStr = getMessageActualTimeS(_loc2_);
            }
        }

        private function setCurrentBarIdx(param1:int) : void
        {
            if(param1 != this._currentBarIdx)
            {
                this._currentBarIdx = param1;
                invalidate(INV_WIDGET_VISIBILITY);
            }
        }

        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            var _loc2_:PopOver = PopOver(wrapper);
            _loc2_.title = App.utils.locale.makeString(MESSENGER.LISTVIEW_TITLE);
            _loc2_.isCloseBtnVisible = true;
        }

        override public function get width() : Number
        {
            return this.background.width;
        }

        override public function get height() : Number
        {
            return this.background.height;
        }

        private function onProgressiveRewardWidgetSwitchWidgetEnabledHandler(param1:ProgressiveRewardEvent) : void
        {
            this._isProgressRewardEnabled = param1.getFlag();
            invalidate(INV_WIDGET_VISIBILITY);
        }

        private function onListScrollHandler(param1:Event) : void
        {
            this._ignoreScrollBarHandler = true;
            this.updateScrollBarProperties();
            this.scrollBar.position = this.list.verticalScrollPosition;
            this._ignoreScrollBarHandler = false;
        }

        private function onScrollBarScrollHandler(param1:Event) : void
        {
            if(!this._ignoreScrollBarHandler)
            {
                this.list.scrollTo(this.scrollBar.position);
            }
        }

        private function onListUpdateSizeHandler(param1:ScrollEvent) : void
        {
            this._ignoreScrollBarHandler = true;
            this.updateScrollBarProperties();
            this._ignoreScrollBarHandler = false;
        }

        private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
        {
            if(this._currentBarIdx != param1.index)
            {
                this.setCurrentBarIdx(param1.index);
                onGroupChangeS(this._currentBarIdx);
            }
        }

        private function onListMessageButtonClickedHandler(param1:ServiceMessageEvent) : void
        {
            param1.stopImmediatePropagation();
            onClickActionS(param1.typeID,param1.entityID,param1.action);
            App.popoverMgr.hide();
        }

        private function onListMessageLinkClickedHandler(param1:ServiceMessageEvent) : void
        {
            param1.stopImmediatePropagation();
            onClickActionS(param1.typeID,param1.entityID,param1.action);
        }
    }
}
