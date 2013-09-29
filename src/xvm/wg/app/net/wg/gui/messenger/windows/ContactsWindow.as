package net.wg.gui.messenger.windows 
{
    import flash.display.*;
    import flash.utils.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.evnts.*;
    import net.wg.gui.messenger.meta.*;
    import net.wg.gui.messenger.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ContactsWindow extends net.wg.gui.messenger.meta.impl.ContactsWindowMeta implements net.wg.gui.messenger.meta.IContactsWindowMeta
    {
        public function ContactsWindow()
        {
            this.friendsDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.clanDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.ignoredDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.mutedDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.searchDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            super();
            isCentered = false;
            showWindowBg = false;
            canResize = true;
            canDrag = true;
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            this.updateFocusInViewContainer();
            return;
        }

        public function as_getFriendsDP():Object
        {
            return this.friendsDP;
        }

        public function as_getClanDP():Object
        {
            return this.clanDP;
        }

        public function as_getIgnoredDP():Object
        {
            return this.ignoredDP;
        }

        public function as_getMutedDP():Object
        {
            return this.mutedDP;
        }

        public function as_getSearchDP():Object
        {
            return this.searchDP;
        }

        public function as_setSearchResultText(arg1:String):void
        {
            this.searchResultText = arg1;
            return;
        }

        public function as_frozenSearchAction(arg1:Boolean):void
        {
            this.freezeSearch = arg1;
            this.updateViewData();
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.tabs.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabSelected);
            this.viewStack.removeEventListener(net.wg.gui.messenger.evnts.ContactsFormEvent.SEARCH, this.onSearchFormEvent);
            this.viewStack.removeEventListener(net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_FRIENDS, this.onSearchFormEvent);
            this.viewStack.removeEventListener(net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_IGNORED, this.onSearchFormEvent);
            if (this.friendsDP) 
            {
                this.friendsDP.cleanUp();
                this.friendsDP = null;
            }
            if (this.clanDP) 
            {
                this.clanDP.cleanUp();
                this.clanDP = null;
            }
            if (this.ignoredDP) 
            {
                this.ignoredDP.cleanUp();
                this.ignoredDP = null;
            }
            if (this.mutedDP) 
            {
                this.mutedDP.cleanUp();
                this.mutedDP = null;
            }
            if (this.searchDP) 
            {
                this.searchDP.cleanUp();
                this.searchDP = null;
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("tabs", this.tabs, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("tabLine", this.tabLine, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.LEFT);
            this.tabs.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabSelected);
            this.viewStack.addEventListener(net.wg.gui.messenger.evnts.ContactsFormEvent.SEARCH, this.onSearchFormEvent);
            this.viewStack.addEventListener(net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_FRIENDS, this.onSearchFormEvent);
            this.viewStack.addEventListener(net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_IGNORED, this.onSearchFormEvent);
            this.initTabs();
            this.updateViewData();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.updateViewSize();
            }
            if (isInvalid(INVALIDATE_VIEW)) 
            {
                this.updateViewData();
                this.updateViewSize();
            }
            super.draw();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.title = MESSENGER.LOBBY_BUTTONS_CONTACTS;
            window.contentPadding = new scaleform.clik.utils.Padding(36, 15, 20, 14);
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CONTACTS_WINDOW);
            return;
        }

        internal function initTabs():void
        {
            this.tabs.dataProvider = new scaleform.clik.data.DataProvider([{"label":MESSENGER.DIALOGS_CONTACTS_TITLE, "linkage":VIEW_LIST}, {"label":MESSENGER.DIALOGS_SEARCHCONTACT_TITLE, "linkage":VIEW_SEARCH}]);
            this.tabs.selectedIndex = 0;
            return;
        }

        internal function updateViewSize():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            var loc2:*=window.getBackground().width - loc1.left - loc1.right;
            var loc3:*=window.getBackground().height - loc1.top - loc1.bottom - this.viewStack.y;
            var loc6:*=0;
            var loc7:*=this.viewStack.cachedViews;
            for (loc4 in loc7) 
            {
                (loc5 = this.viewStack.cachedViews[loc4] as scaleform.clik.core.UIComponent).setSize(loc2, loc3);
                if (loc5 != this.viewStack.currentView) 
                {
                    continue;
                }
                loc5.validateNow();
            }
            return;
        }

        internal function updateFocusInViewContainer():void
        {
            if (this.viewStack == null || this.viewStack.currentView == null) 
            {
                return;
            }
            var loc1:*=this.viewStack.currentView as net.wg.infrastructure.interfaces.IViewStackContent;
            loc1.update(null);
            return;
        }

        internal function updateViewData():void
        {
            var loc2:*=null;
            var loc1:*=this.viewStack.currentView as net.wg.infrastructure.interfaces.IViewStackContent;
            if (loc1 != null) 
            {
                loc2 = flash.utils.getQualifiedClassName(loc1);
                if (loc2 != VIEW_LIST) 
                {
                    if (loc2 == VIEW_SEARCH) 
                    {
                        loc1.update({"searchDP":this.searchDP, "resultText":this.searchResultText, "freezeSearch":this.freezeSearch});
                    }
                }
                else 
                {
                    loc1.update({"friendsDP":this.friendsDP, "clanDP":this.clanDP, "ignoredDP":this.ignoredDP, "mutedDP":this.mutedDP});
                }
            }
            return;
        }

        internal function onSearchFormEvent(arg1:net.wg.gui.messenger.evnts.ContactsFormEvent):void
        {
            var loc1:*=arg1.type;
            switch (loc1) 
            {
                case net.wg.gui.messenger.evnts.ContactsFormEvent.SEARCH:
                {
                    searchContactS(arg1.searchValue);
                    break;
                }
                case net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_FRIENDS:
                {
                    addToFriendsS(arg1.uid, arg1.name);
                    break;
                }
                case net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_IGNORED:
                {
                    addToIgnoredS(arg1.uid, arg1.name);
                    break;
                }
            }
            return;
        }

        internal function onTabSelected(arg1:scaleform.clik.events.IndexEvent):void
        {
            invalidate(INVALIDATE_VIEW);
            return;
        }

        internal static const VIEW_LIST:String="ContactsListFormUI";

        internal static const VIEW_SEARCH:String="ContactsSearchFormUI";

        internal static const INVALIDATE_VIEW:String="invalidateView";

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx;

        public var tabLine:flash.display.Sprite;

        public var viewStack:net.wg.gui.components.advanced.ViewStack;

        protected var friendsDP:net.wg.data.daapi.base.DAAPIDataProvider;

        protected var clanDP:net.wg.data.daapi.base.DAAPIDataProvider;

        protected var ignoredDP:net.wg.data.daapi.base.DAAPIDataProvider;

        protected var mutedDP:net.wg.data.daapi.base.DAAPIDataProvider;

        protected var searchDP:net.wg.data.daapi.base.DAAPIDataProvider;

        protected var searchResultText:String;

        protected var freezeSearch:Boolean;
    }
}
