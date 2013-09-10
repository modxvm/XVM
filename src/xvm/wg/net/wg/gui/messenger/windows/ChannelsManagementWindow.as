package net.wg.gui.messenger.windows 
{
    import flash.display.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.evnts.*;
    import net.wg.gui.messenger.forms.*;
    import net.wg.gui.messenger.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ChannelsManagementWindow extends net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta
    {
        public function ChannelsManagementWindow()
        {
            super();
            isModal = false;
            isCentered = false;
            canClose = true;
            canDrag = true;
            canResize = true;
            showWindowBg = false;
            this._searchResDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            this.onViewChangeHandler();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            if (this.tabs.selectedIndex == -1) 
                this.tabs.selectedIndex = this.__currentTab;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                this.updateViewSize();
            super.draw();
            return;
        }

        internal function updateViewSize():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.view) 
            {
                var loc3:*=0;
                var loc4:*=this.view.cachedViews;
                for (loc1 in loc4) 
                {
                    loc2 = scaleform.clik.core.UIComponent(this.view.cachedViews[loc1]);
                    loc2.setSize(width, height - this.view.y);
                    loc2.validateNow();
                }
            }
            return;
        }

        protected override function onPopulate():void
        {
            window.useBottomBtns = false;
            window.title = MESSENGER.LOBBY_BUTTONS_CHANNELS;
            window.contentPadding = new scaleform.clik.utils.Padding(40, 12, 17, 9);
            window.setMaxWidth(650);
            window.setMaxHeight(400);
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement(this.tabLine.name, this.tabLine, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement(this.tabs.name, this.tabs, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            updateStage(App.appWidth, App.appHeight);
            super.onPopulate();
            this.initTabs();
            this.searchLimitLabel = getSearchLimitLabelS();
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CHANNELS_WINDOW);
            return;
        }

        public function as_getDataProvider():Object
        {
            return this._searchResDataProvider;
        }

        internal function initTabs():void
        {
            if (this.tabs != null) 
            {
                this.tabs.dataProvider = new scaleform.clik.data.DataProvider(this.tabsDataProvider);
                this.tabs.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
            }
            if (this.view != null) 
            {
                this.view.addEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onViewChangeHandler);
                this.view.addEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewChange);
                this.view.addEventListener(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK, this.onSearchCkick);
                this.view.addEventListener(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_JOIN, this.onJoinHandler);
                this.view.addEventListener(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_CREATE_CHANNEL, this.onCreateChannel);
            }
            return;
        }

        internal function onViewChange(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            var loc1:*=arg1.view;
            var loc2:*=arg1.linkage;
            switch (loc2) 
            {
                case this.SEARCH_CHANNEL_FORM_ID:
                    net.wg.gui.messenger.forms.ChannelsSearchForm(loc1).searchResultText = this.searchLimitLabel;
                    net.wg.gui.messenger.forms.ChannelsSearchForm(loc1).searchResultList.dataProvider = this._searchResDataProvider;
                    net.wg.gui.messenger.forms.ChannelsSearchForm(loc1).searchResultList.labelField = "name";
                    break;
                case this.CREATE_CHANNEL_FORM_ID:
                    break;
            }
            loc1.update({});
            this.updateViewSize();
            return;
        }

        internal function onViewChangeHandler(arg1:net.wg.gui.events.ViewStackEvent=null):void
        {
            var loc1:*=null;
            if (this.view && this.view.currentView && arg1 == null) 
            {
                loc1 = this.view.currentView as net.wg.infrastructure.interfaces.IViewStackContent;
                loc1.update({});
            }
            else if (arg1 != null) 
            {
                loc1 = arg1.view;
                loc1.update({});
            }
            return;
        }

        internal function onTabChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.__currentTab = arg1.index;
            this.updateViewSize();
            return;
        }

        protected override function onDispose():void
        {
            if (this.view) 
            {
                this.view.dispose();
                this.view.removeEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onViewChangeHandler);
                this.view.removeEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewChange);
                this.view.removeEventListener(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK, this.onSearchCkick);
                this.view.removeEventListener(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_JOIN, this.onJoinHandler);
                this.view.removeEventListener(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_CREATE_CHANNEL, this.onCreateChannel);
            }
            if (this.tabs) 
            {
                this.tabs.dispose();
                this.tabs.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
            }
            super.onDispose();
            return;
        }

        internal function onSearchCkick(arg1:net.wg.gui.messenger.evnts.ChannelsFormEvent):void
        {
            searchTokenS(arg1.channelName);
            return;
        }

        internal function onJoinHandler(arg1:net.wg.gui.messenger.evnts.ChannelsFormEvent):void
        {
            joinToChannelS(arg1.index);
            return;
        }

        internal function onCreateChannel(arg1:net.wg.gui.messenger.evnts.ChannelsFormEvent):void
        {
            var loc1:*=!(arg1.channelPass == null && arg1.channelRetypePass == null);
            createChannelS(arg1.channelName, loc1, arg1.channelPass, arg1.channelRetypePass);
            return;
        }

        public function as_freezSearchButton(arg1:Boolean):void
        {
            var loc1:*=net.wg.gui.messenger.forms.ChannelsSearchForm(this.tryGetView(this.SEARCH_CHANNEL_FORM_ID));
            if (loc1) 
                loc1.lockSearchButton(!arg1);
            return;
        }

        internal function tryGetView(arg1:String):flash.display.MovieClip
        {
            var loc1:*=null;
            if (!this.view) 
                return null;
            if (this.view.cachedViews[arg1] != null) 
                loc1 = this.view.cachedViews[arg1];
            return loc1;
        }

        internal const SEARCH_CHANNEL_FORM_ID:String="searchChannelFormUI";

        internal const CREATE_CHANNEL_FORM_ID:String="createChannelFormUI";

        internal const tabsDataProvider:Array=[{"label":MESSENGER.DIALOGS_CHANNELS_BUTTONS_SEARCHANDJOIN, "linkage":this.SEARCH_CHANNEL_FORM_ID}, {"label":MESSENGER.DIALOGS_CHANNELS_BUTTONS_CREATE, "linkage":this.CREATE_CHANNEL_FORM_ID}];

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx=null;

        public var tabLine:flash.display.Sprite=null;

        public var view:net.wg.gui.components.advanced.ViewStack=null;

        internal var searchLimitLabel:String=null;

        internal var __currentTab:Number=0;

        protected var _searchResDataProvider:net.wg.data.daapi.base.DAAPIDataProvider;
    }
}
