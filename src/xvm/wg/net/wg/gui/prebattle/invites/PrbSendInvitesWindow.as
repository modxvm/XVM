package net.wg.gui.prebattle.invites 
{
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class PrbSendInvitesWindow extends net.wg.infrastructure.base.meta.impl.PrbSendInvitesWindowMeta implements net.wg.infrastructure.base.meta.IPrbSendInvitesWindowMeta
    {
        public function PrbSendInvitesWindow()
        {
            this.friendMemberDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.clanMemberDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.searchMemberDataProvider = new net.wg.data.daapi.base.DAAPIDataProvider();
            this.receiverData = new scaleform.clik.data.DataProvider();
            super();
            this.emptyRenderer.visible = false;
            return;
        }

        internal function enableManagmentButtons(arg1:Boolean):void
        {
            this.addUserButton.enabled = arg1;
            this.addAllUsersButton.enabled = arg1;
            this.removeAllUsersButton.enabled = arg1;
            this.removeUserButton.enabled = arg1;
            return;
        }

        public function as_onReceiveSendInvitesCooldown(arg1:uint):void
        {
            this.enableManagmentButtons(false);
            this.sendButton.enabled = false;
            this.coolDownTimerID = flash.utils.setTimeout(this.onEndSendInvitesCooldown, arg1 * 1000);
            return;
        }

        internal function onEndSendInvitesCooldown():void
        {
            this.receiverData.cleanUp();
            this.receiverData.invalidate();
            flash.utils.clearTimeout(this.coolDownTimerID);
            this.enableManagmentButtons(true);
            this.sendButton.enabled = false;
            this.wait = false;
            return;
        }

        internal function hasUserInReceiverList(arg1:Object):Boolean
        {
            var loc1:*=false;
            var loc2:*=0;
            while (loc2 < this.receiverData.length) 
            {
                if (this.receiverData[loc2].uid == arg1.uid) 
                {
                    loc1 = true;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function usersAccordion_listItemDoubleClickHandler(arg1:net.wg.gui.prebattle.invites.SendInvitesEvent):void
        {
            this.onReceiveUserInfo(arg1.initItem);
            return;
        }

        internal function receiverList_itemDoubleClickHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                return;
            this.removeReceiveItem();
            return;
        }

        public function as_setDefaultOnlineFlag(arg1:Boolean):void
        {
            if (this.onlineCheckBox != null) 
                this.onlineCheckBox.selected = arg1;
            return;
        }

        internal function onReceiveUserInfo(arg1:Object):void
        {
            var loc1:*=makeRoster(arg1);
            if (net.wg.gui.prebattle.squad.MessengerUtils.isIgnored(loc1)) 
            {
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_ADDIGNOREDUSER);
                return;
            }
            if (!loc1.online) 
            {
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USEROFFLINE);
                return;
            }
            if (this.hasUserInReceiverList(loc1)) 
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_EXISTSINRECEIVELIST);
            else 
            {
                this.receiverData.push(loc1);
                this.receiverData.invalidate();
                this.sendButton.enabled = true;
            }
            return;
        }

        internal function handleClickAddUserButton(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            var loc1:*=net.wg.gui.components.controls.ScrollingListEx(this.usersAccordion.view.currentView.rosterList);
            if (loc1.dataProvider.length > 0) 
                if (loc1.selectedIndex > -1) 
                    loc1.dataProvider.requestItemAt(loc1.selectedIndex, this.onReceiveUserInfo);
                else 
                    showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOADD);
            else 
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USERLISTEMPTY);
            return;
        }

        internal function handleClickAddAllUsersButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=net.wg.data.daapi.base.DAAPIDataProvider(this.usersAccordion.view.currentView.rosterList.dataProvider);
            if (loc1 == null) 
                return;
            var loc2:*=loc1.length;
            if (loc2 > 0) 
                loc1.requestItemRange(0, (loc1.length - 1), this.onReceiveUsersInfo);
            else 
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USERLISTEMPTY);
            return;
        }

        internal function onReceiveUsersInfo(arg1:Array):void
        {
            var loc4:*=null;
            var loc1:*=arg1.length;
            if (loc1 == 0) 
            {
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_NOTFOUNDUSERS);
                return;
            }
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc4 = makeRoster(arg1[loc2]);
                if (!(net.wg.gui.prebattle.squad.MessengerUtils.isIgnored(loc4) || !loc4.online)) 
                    if (!this.hasUserInReceiverList(loc4)) 
                        this.receiverData.push(loc4);
                ++loc2;
            }
            this.receiverData.invalidate();
            var loc3:*;
            if (!(loc3 = this.receiverData.length > 0)) 
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_NOTFOUNDUSERS);
            this.sendButton.enabled = loc3;
            return;
        }

        internal function handleClickRemoveUserButton(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            this.removeReceiveItem();
            return;
        }

        internal function removeReceiveItem():void
        {
            if (this.receiverData.length > 0) 
                if (this.receiverList.selectedIndex > -1) 
                {
                    this.receiverData.splice(this.receiverList.selectedIndex, 1);
                    this.receiverData.invalidate();
                    this.sendButton.enabled = !(this.receiverData.length == 0);
                }
                else 
                    showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOREMOVE);
            else 
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY);
            return;
        }

        internal function handleClickRemoveAllUsersButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (this.receiverData.length > 0) 
            {
                this.receiverData.cleanUp();
                this.receiverData.invalidate();
                this.sendButton.enabled = false;
            }
            else 
                showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY);
            return;
        }

        internal function handleSelectOnlineCheckBox(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=arg1.currentTarget.selected;
            var loc2:*=false;
            if (!(this.lastToken == null) && !(this.lastToken == "") && this.onSearchResultReceived && !(this.lastIsOnlineFlag == loc1)) 
                loc2 = true;
            setOnlineFlagS(loc1);
            if (loc2) 
                this.setToken(this.lastToken);
            this.lastIsOnlineFlag = loc1;
            return;
        }

        internal function handleSendInvitations(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=[];
            var loc2:*="";
            if (this.messageTextInput.textField.getTextFormat()["color"] != this.inviteDefaultTextColor) 
                loc2 = org.idmedia.as3commons.util.StringUtils.trim(this.messageTextInput.text);
            var loc3:*=0;
            while (loc3 < this.receiverData.length) 
            {
                loc1.push(this.receiverData[loc3].uid);
                ++loc3;
            }
            this.enableManagmentButtons(true);
            this.sendButton.enabled = false;
            this.wait = true;
            sendInvitesS(loc1, loc2);
            return;
        }

        internal function usersAccordion_searchTokenHandler(arg1:net.wg.gui.prebattle.invites.SendInvitesEvent):void
        {
            this.lastToken = arg1.searchString;
            this.setToken(this.lastToken);
            return;
        }

        internal function setToken(arg1:String):void
        {
            if (arg1 == null) 
                return;
            searchTokenS(arg1);
            return;
        }

        internal function usersAccordion_initComponentHandler(arg1:net.wg.gui.prebattle.invites.SendInvitesEvent):void
        {
            var loc2:*=null;
            var loc1:*=arg1.initItem as net.wg.infrastructure.interfaces.IViewStackContent;
            if (loc1 != null) 
            {
                loc2 = flash.utils.getQualifiedClassName(loc1);
                if (loc2 != net.wg.data.constants.Linkages.INVITES_FRIENDS) 
                    if (loc2 != net.wg.data.constants.Linkages.INVITES_CLAN) 
                        if (loc2 == net.wg.data.constants.Linkages.INVITES_SEARCH) 
                            loc1.update(this.searchMemberDataProvider);
                    else 
                        loc1.update(this.clanMemberDataProvider);
                else 
                    loc1.update(this.friendMemberDataProvider);
            }
            return;
        }

        internal static function makeRoster(arg1:Object):Object
        {
            var loc1:*={"uid":arg1.uid, "userName":arg1.userName, "chatRoster":arg1.chatRoster, "online":arg1.online, "displayName":arg1.displayName, "colors":arg1.colors, "himself":arg1.himself};
            return loc1;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            showWindowBg = false;
            window.title = "";
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.bottom = 16;
            loc1.left = 13;
            loc1.right = 12;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_DEFAULT_POSITION)) 
            {
                window.x = 0;
                window.y = 0;
            }
            return;
        }

        public function as_setWindowTitle(arg1:String):void
        {
            window.title = arg1;
            return;
        }

        public function as_getFriendsDP():Object
        {
            return this.friendMemberDataProvider;
        }

        public function as_getClanDP():Object
        {
            return this.clanMemberDataProvider;
        }

        public function as_getSearchDP():Object
        {
            return this.searchMemberDataProvider;
        }

        public function as_getReceiverDP():Object
        {
            return this.receiverData;
        }

        public function as_onSearchResultReceived(arg1:Boolean):void
        {
            this.onSearchResultReceived = arg1;
            return;
        }

        internal function showContextMenu(arg1:net.wg.gui.prebattle.invites.SendInvitesEvent):void
        {
            if (arg1.initItem) 
                App.contextMenuMgr.showUserContextMenu(this, arg1.initItem, new net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator());
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.usersAccordion.view.cache = true;
            this.usersAccordion.addEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.SHOW_CONTEXT_MENU, this.showContextMenu);
            this.usersAccordion.addEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.INIT_COMPONENT, this.usersAccordion_initComponentHandler);
            this.usersAccordion.addEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.LIST_DOUBLE_CLICK, this.usersAccordion_listItemDoubleClickHandler);
            this.usersAccordion.addEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.SEARCH_TOKEN, this.usersAccordion_searchTokenHandler);
            this.usersAccordion.dataProvider = new scaleform.clik.data.DataProvider(userViewsDataProvider);
            this.usersAccordion.selectedIndex = 0;
            this.addAllUsersButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickAddAllUsersButton);
            this.addUserButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickAddUserButton);
            this.removeUserButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickRemoveUserButton);
            this.removeAllUsersButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickRemoveAllUsersButton);
            this.onlineCheckBox.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSelectOnlineCheckBox);
            this.messageTextInput.defaultTextFormat.color = this.inviteDefaultTextColor;
            this.messageTextInput.textField.textColor = this.inviteDefaultTextColor;
            this.messageTextInput.defaultTextFormat.italic = false;
            this.messageTextInput.addEventListener(scaleform.clik.events.FocusHandlerEvent.FOCUS_IN, this.messageTextInput_CLIK_focusInHandler);
            this.messageTextInput.defaultText = MENU.PREBATTLE_INVITATIONS_LABELS_DEFAULTINVITETEXT;
            this.sendButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSendInvitations);
            this.sendButton.enabled = false;
            this.receiverList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.receiverList_itemDoubleClickHandler);
            this.receiverList.dataProvider = this.receiverData;
            this.enableManagmentButtons(true);
            this.sendButton.enabled = false;
            App.utils.scheduler.envokeInNextFrame(this.updateFocus);
            invalidate(UPDATE_DEFAULT_POSITION);
            return;
        }

        internal function updateFocus():void
        {
            App.utils.focusHandler.setFocus(this);
            return;
        }

        public override function setFocus():void
        {
            App.utils.scheduler.envokeInNextFrame(this.updateFocus);
            return;
        }

        protected override function onDispose():void
        {
            this.sendButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSendInvitations);
            this.receiverList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.receiverList_itemDoubleClickHandler);
            this.messageTextInput.removeEventListener(scaleform.clik.events.FocusHandlerEvent.FOCUS_IN, this.messageTextInput_CLIK_focusInHandler);
            this.addAllUsersButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickAddAllUsersButton);
            this.addUserButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickAddUserButton);
            this.removeUserButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickRemoveUserButton);
            this.removeAllUsersButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickRemoveAllUsersButton);
            this.usersAccordion.removeEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.SEARCH_TOKEN, this.usersAccordion_searchTokenHandler);
            this.onlineCheckBox.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSelectOnlineCheckBox);
            this.usersAccordion.removeEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.SHOW_CONTEXT_MENU, this.showContextMenu);
            this.usersAccordion.removeEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.INIT_COMPONENT, this.usersAccordion_initComponentHandler);
            this.usersAccordion.removeEventListener(net.wg.gui.prebattle.invites.SendInvitesEvent.LIST_DOUBLE_CLICK, this.usersAccordion_listItemDoubleClickHandler);
            this.receiverList.disposeRenderers();
            this.receiverList = null;
            this.receiverData.cleanUp();
            this.receiverData = null;
            super.onDispose();
            return;
        }

        internal function messageTextInput_CLIK_focusInHandler(arg1:scaleform.clik.events.FocusHandlerEvent):void
        {
            var loc1:*=this.messageTextInput.textField.getTextFormat()["color"];
            if (loc1 == this.inviteDefaultTextColor) 
            {
                this.messageTextInput.textField.textColor = inviteTextColor;
                this.messageTextInput.text = "";
            }
            return;
        }

        internal static const inviteTextColor:uint=9803143;

        internal static const UPDATE_DEFAULT_POSITION:String="updateWindowPosition";

        internal static const userViewsDataProvider:Array=[{"label":MESSENGER.DIALOGS_CONTACTS_TREE_FRIENDS, "linkage":net.wg.data.constants.Linkages.INVITES_FRIENDS}, {"label":MESSENGER.DIALOGS_CONTACTS_TREE_CLAN, "linkage":net.wg.data.constants.Linkages.INVITES_CLAN}, {"label":MESSENGER.DIALOGS_SEARCHCONTACT_TITLE, "linkage":net.wg.data.constants.Linkages.INVITES_SEARCH}];

        public var friendMemberDataProvider:net.wg.data.daapi.base.DAAPIDataProvider;

        public var clanMemberDataProvider:net.wg.data.daapi.base.DAAPIDataProvider;

        public var searchMemberDataProvider:net.wg.data.daapi.base.DAAPIDataProvider;

        public var usersAccordion:net.wg.gui.components.advanced.Accordion;

        public var addUserButton:net.wg.gui.components.controls.SoundButtonEx;

        public var addAllUsersButton:net.wg.gui.components.controls.SoundButtonEx;

        public var removeAllUsersButton:net.wg.gui.components.controls.SoundButtonEx;

        public var receiverList:net.wg.gui.components.controls.ScrollingListEx;

        public var onlineCheckBox:net.wg.gui.components.controls.CheckBox;

        public var messageTextInput:net.wg.gui.components.controls.TextInput;

        public var sendButton:net.wg.gui.components.controls.SoundButtonEx;

        public var emptyRenderer:net.wg.gui.prebattle.invites.UserRosterItemRenderer;

        internal var coolDownTimerID:uint=0;

        internal var wait:Boolean=false;

        internal var lastToken:String=null;

        internal var onSearchResultReceived:Boolean=false;

        internal var lastIsOnlineFlag:Boolean=false;

        internal var receiverData:scaleform.clik.data.DataProvider;

        internal var inviteDefaultTextColor:uint=4144953;

        public var removeUserButton:net.wg.gui.components.controls.SoundButtonEx;
    }
}
