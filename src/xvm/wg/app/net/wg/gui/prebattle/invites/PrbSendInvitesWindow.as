package net.wg.gui.prebattle.invites
{
   import net.wg.infrastructure.base.meta.impl.PrbSendInvitesWindowMeta;
   import net.wg.infrastructure.base.meta.IPrbSendInvitesWindowMeta;
   import net.wg.data.constants.Linkages;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.components.advanced.Accordion;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.TextInput;
   import scaleform.clik.data.DataProvider;
   import flash.utils.setTimeout;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.events.ViewStackEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.FocusHandlerEvent;
   import net.wg.gui.events.ListEventEx;
   import flash.events.Event;
   import net.wg.gui.prebattle.squad.MessengerUtils;
   import flash.display.InteractiveObject;
   import net.wg.gui.components.windows.Window;
   import flash.utils.clearTimeout;
   import scaleform.clik.events.ListEvent;
   import scaleform.gfx.MouseEventEx;
   import org.idmedia.as3commons.util.StringUtils;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.utils.getQualifiedClassName;


   public class PrbSendInvitesWindow extends PrbSendInvitesWindowMeta implements IPrbSendInvitesWindowMeta
   {
          
      public function PrbSendInvitesWindow() {
         this.friendMemberDataProvider = new DAAPIDataProvider();
         this.clanMemberDataProvider = new DAAPIDataProvider();
         this.searchMemberDataProvider = new DAAPIDataProvider();
         this.receiverData = new DataProvider();
         super();
         this.emptyRenderer.visible = false;
      }

      private static const inviteTextColor:uint = 9803143;

      private static const UPDATE_DEFAULT_POSITION:String = "updateWindowPosition";

      private static const userViewsDataProvider:Array;

      private static function makeRoster(param1:Object) : Object {
         var _loc2_:Object =
            {
               "uid":param1.uid,
               "userName":param1.userName,
               "chatRoster":param1.chatRoster,
               "online":param1.online,
               "displayName":param1.displayName,
               "colors":param1.colors,
               "himself":param1.himself
            }
         ;
         return _loc2_;
      }

      public var friendMemberDataProvider:DAAPIDataProvider;

      public var clanMemberDataProvider:DAAPIDataProvider;

      public var searchMemberDataProvider:DAAPIDataProvider;

      public var usersAccordion:Accordion;

      public var addUserButton:SoundButtonEx;

      public var addAllUsersButton:SoundButtonEx;

      public var removeUserButton:SoundButtonEx;

      public var removeAllUsersButton:SoundButtonEx;

      public var receiverList:ScrollingListEx;

      public var onlineCheckBox:CheckBox;

      public var messageTextInput:TextInput;

      public var sendButton:SoundButtonEx;

      public var emptyRenderer:UserRosterItemRenderer;

      private var coolDownTimerID:uint = 0;

      private var wait:Boolean = false;

      private var lastToken:String = null;

      private var onSearchResultReceived:Boolean = false;

      private var lastIsOnlineFlag:Boolean = false;

      private var receiverData:DataProvider;

      private var inviteDefaultTextColor:uint = 4144953;

      public function as_setWindowTitle(param1:String) : void {
         window.title = param1;
      }

      public function as_getFriendsDP() : Object {
         return this.friendMemberDataProvider;
      }

      public function as_getClanDP() : Object {
         return this.clanMemberDataProvider;
      }

      public function as_getSearchDP() : Object {
         return this.searchMemberDataProvider;
      }

      public function as_getReceiverDP() : Object {
         return this.receiverData;
      }

      public function as_onSearchResultReceived(param1:Boolean) : void {
         this.onSearchResultReceived = param1;
      }

      public function as_setDefaultOnlineFlag(param1:Boolean) : void {
         if(this.onlineCheckBox != null)
         {
            this.onlineCheckBox.selected = param1;
         }
      }

      public function as_onReceiveSendInvitesCooldown(param1:uint) : void {
         this.enableManagmentButtons(false);
         this.sendButton.enabled = false;
         this.coolDownTimerID = setTimeout(this.onEndSendInvitesCooldown,param1 * 1000);
      }

      override protected function onPopulate() : void {
         this.updateWindowProperties(false);
         super.onPopulate();
         showWindowBg = false;
         window.title = "";
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.bottom = 16;
         _loc1_.left = 13;
         _loc1_.right = 12;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(UPDATE_DEFAULT_POSITION))
         {
            window.x = 0;
            window.y = 0;
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.usersAccordion.view.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChange);
         this.usersAccordion.view.cache = true;
         this.usersAccordion.addEventListener(SendInvitesEvent.SHOW_CONTEXT_MENU,this.showContextMenu);
         this.usersAccordion.addEventListener(SendInvitesEvent.INIT_COMPONENT,this.usersAccordion_initComponentHandler);
         this.usersAccordion.addEventListener(SendInvitesEvent.LIST_DOUBLE_CLICK,this.usersAccordion_listItemDoubleClickHandler);
         this.usersAccordion.addEventListener(SendInvitesEvent.SEARCH_TOKEN,this.usersAccordion_searchTokenHandler);
         this.usersAccordion.dataProvider = new DataProvider(userViewsDataProvider);
         this.usersAccordion.selectedIndex = 0;
         this.addAllUsersButton.addEventListener(ButtonEvent.CLICK,this.handleClickAddAllUsersButton);
         this.addUserButton.addEventListener(ButtonEvent.CLICK,this.handleClickAddUserButton);
         this.removeUserButton.addEventListener(ButtonEvent.CLICK,this.handleClickRemoveUserButton);
         this.removeAllUsersButton.addEventListener(ButtonEvent.CLICK,this.handleClickRemoveAllUsersButton);
         this.onlineCheckBox.addEventListener(ButtonEvent.CLICK,this.handleSelectOnlineCheckBox);
         this.messageTextInput.defaultTextFormat.color = this.inviteDefaultTextColor;
         this.messageTextInput.textField.textColor = this.inviteDefaultTextColor;
         this.messageTextInput.defaultTextFormat.italic = false;
         this.messageTextInput.addEventListener(FocusHandlerEvent.FOCUS_IN,this.messageTextInput_CLIK_focusInHandler);
         this.messageTextInput.defaultText = MENU.PREBATTLE_INVITATIONS_LABELS_DEFAULTINVITETEXT;
         this.sendButton.addEventListener(ButtonEvent.CLICK,this.handleSendInvitations);
         this.sendButton.enabled = false;
         this.receiverList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.receiverList_itemDoubleClickHandler);
         this.receiverList.addEventListener(ListEventEx.ITEM_CLICK,this.receiverList_ClickHandler);
         this.receiverList.dataProvider = this.receiverData;
         this.friendMemberDataProvider.addEventListener(Event.CHANGE,this.onUsersListChange);
         this.clanMemberDataProvider.addEventListener(Event.CHANGE,this.onUsersListChange);
         this.searchMemberDataProvider.addEventListener(Event.CHANGE,this.onUsersListChange);
         this.enableManagmentButtons(true);
         this.sendButton.enabled = false;
         App.utils.scheduler.envokeInNextFrame(this.updateFocus);
         invalidate(UPDATE_DEFAULT_POSITION);
      }

      private function onUsersListChange(param1:Event) : void {
         var _loc2_:DAAPIDataProvider = param1.target as DAAPIDataProvider;
         _loc2_.requestItemRange(0,_loc2_.length,this.updateReceiverList);
      }

      private function updateReceiverList(param1:Array) : void {
         var _loc5_:* = NaN;
         var _loc2_:int = param1.length;
         var _loc3_:* = false;
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = this.hasUserInReceiverList(param1[_loc4_]);
            if(_loc5_ >= 0)
            {
               _loc3_ = true;
               if(MessengerUtils.isIgnored(param1[_loc4_]))
               {
                  this.receiverData.splice(_loc5_,1);
               }
               else
               {
                  this.receiverData[_loc5_] = param1[_loc4_];
               }
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            this.receiverData.invalidate();
         }
      }

      private function onViewChange(param1:ViewStackEvent) : void {
         var _loc2_:InteractiveObject = param1.view.getComponentForFocus();
         if(_loc2_)
         {
            setFocus(_loc2_);
         }
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         this.updateFocus();
      }

      override protected function onDispose() : void {
         App.utils.scheduler.cancelTask(this.updateFocus);
         this.friendMemberDataProvider.removeEventListener(Event.CHANGE,this.onUsersListChange);
         this.clanMemberDataProvider.removeEventListener(Event.CHANGE,this.onUsersListChange);
         this.searchMemberDataProvider.removeEventListener(Event.CHANGE,this.onUsersListChange);
         this.sendButton.removeEventListener(ButtonEvent.CLICK,this.handleSendInvitations);
         this.receiverList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.receiverList_itemDoubleClickHandler);
         this.receiverList.removeEventListener(ListEventEx.ITEM_CLICK,this.receiverList_ClickHandler);
         this.messageTextInput.removeEventListener(FocusHandlerEvent.FOCUS_IN,this.messageTextInput_CLIK_focusInHandler);
         this.addAllUsersButton.removeEventListener(ButtonEvent.CLICK,this.handleClickAddAllUsersButton);
         this.addUserButton.removeEventListener(ButtonEvent.CLICK,this.handleClickAddUserButton);
         this.removeUserButton.removeEventListener(ButtonEvent.CLICK,this.handleClickRemoveUserButton);
         this.removeAllUsersButton.removeEventListener(ButtonEvent.CLICK,this.handleClickRemoveAllUsersButton);
         this.onlineCheckBox.removeEventListener(ButtonEvent.CLICK,this.handleSelectOnlineCheckBox);
         this.usersAccordion.view.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChange);
         this.usersAccordion.removeEventListener(SendInvitesEvent.SEARCH_TOKEN,this.usersAccordion_searchTokenHandler);
         this.usersAccordion.removeEventListener(SendInvitesEvent.SHOW_CONTEXT_MENU,this.showContextMenu);
         this.usersAccordion.removeEventListener(SendInvitesEvent.INIT_COMPONENT,this.usersAccordion_initComponentHandler);
         this.usersAccordion.removeEventListener(SendInvitesEvent.LIST_DOUBLE_CLICK,this.usersAccordion_listItemDoubleClickHandler);
         this.receiverList.disposeRenderers();
         this.receiverList = null;
         this.receiverData.cleanUp();
         this.receiverData = null;
         super.onDispose();
      }

      private function updateWindowProperties(param1:Boolean) : void {
         if(window)
         {
            Window(window).visible = param1;
         }
      }

      private function updateFocus() : void {
         this.updateWindowProperties(true);
         setFocus(this);
      }

      private function enableManagmentButtons(param1:Boolean) : void {
         this.addUserButton.enabled = param1;
         this.addAllUsersButton.enabled = param1;
         this.removeAllUsersButton.enabled = param1;
         this.removeUserButton.enabled = param1;
      }

      private function onEndSendInvitesCooldown() : void {
         this.receiverData.cleanUp();
         this.receiverData.invalidate();
         clearTimeout(this.coolDownTimerID);
         this.enableManagmentButtons(true);
         this.sendButton.enabled = false;
         this.wait = false;
      }

      private function hasUserInReceiverList(param1:Object) : Number {
         var _loc2_:Number = -1;
         var _loc3_:Number = 0;
         while(_loc3_ < this.receiverData.length)
         {
            if(this.receiverData[_loc3_].uid == param1.uid)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }

      private function onReceiveUserInfo(param1:Object) : void {
         var _loc2_:Object = makeRoster(param1);
         if(MessengerUtils.isIgnored(_loc2_))
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_ADDIGNOREDUSER);
            return;
         }
         if(!_loc2_.online)
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USEROFFLINE);
            return;
         }
         if(this.hasUserInReceiverList(_loc2_) < 0)
         {
            this.receiverData.push(_loc2_);
            this.receiverData.invalidate();
            this.sendButton.enabled = true;
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_EXISTSINRECEIVELIST);
         }
      }

      private function onReceiveUsersInfo(param1:Array) : void {
         var _loc5_:Object = null;
         var _loc2_:Number = param1.length;
         if(_loc2_ == 0)
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_NOTFOUNDUSERS);
            return;
         }
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = makeRoster(param1[_loc3_]);
            if(!((MessengerUtils.isIgnored(_loc5_)) || !_loc5_.online))
            {
               if(this.hasUserInReceiverList(_loc5_) < 0)
               {
                  this.receiverData.push(_loc5_);
               }
            }
            _loc3_++;
         }
         this.receiverData.invalidate();
         var _loc4_:* = this.receiverData.length > 0;
         if(!_loc4_)
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_NOTFOUNDUSERS);
         }
         this.sendButton.enabled = _loc4_;
      }

      private function removeReceiveItem() : void {
         if(this.receiverData.length > 0)
         {
            if(this.receiverList.selectedIndex > -1)
            {
               this.receiverData.splice(this.receiverList.selectedIndex,1);
               this.receiverData.invalidate();
               this.sendButton.enabled = !(this.receiverData.length == 0);
            }
            else
            {
               showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOREMOVE);
            }
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY);
         }
      }

      private function setToken(param1:String) : void {
         if(param1 == null)
         {
            return;
         }
         searchTokenS(param1);
      }

      private function messageTextInput_CLIK_focusInHandler(param1:FocusHandlerEvent) : void {
         var _loc2_:uint = this.messageTextInput.textField.getTextFormat()["color"];
         if(_loc2_ == this.inviteDefaultTextColor)
         {
            this.messageTextInput.textField.textColor = inviteTextColor;
            this.messageTextInput.text = "";
         }
      }

      private function usersAccordion_listItemDoubleClickHandler(param1:SendInvitesEvent) : void {
         this.onReceiveUserInfo(param1.initItem);
      }

      private function receiverList_ClickHandler(param1:ListEvent) : void {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            App.contextMenuMgr.showUserContextMenu(this,param1.itemData,new PrbSendInviteCIGenerator());
         }
      }

      private function receiverList_itemDoubleClickHandler(param1:ListEvent) : void {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            return;
         }
         this.removeReceiveItem();
      }

      private function handleClickAddUserButton(param1:ButtonEvent=null) : void {
         var _loc2_:ScrollingListEx = ScrollingListEx(this.usersAccordion.view.currentView.rosterList);
         if(_loc2_.dataProvider.length > 0)
         {
            if(_loc2_.selectedIndex > -1)
            {
               _loc2_.dataProvider.requestItemAt(_loc2_.selectedIndex,this.onReceiveUserInfo);
            }
            else
            {
               showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_SELECTUSERTOADD);
            }
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USERLISTEMPTY);
         }
      }

      private function handleClickAddAllUsersButton(param1:ButtonEvent) : void {
         var _loc2_:DAAPIDataProvider = DAAPIDataProvider(this.usersAccordion.view.currentView.rosterList.dataProvider);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:uint = _loc2_.length;
         if(_loc3_ > 0)
         {
            _loc2_.requestItemRange(0,_loc2_.length-1,this.onReceiveUsersInfo);
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_USERLISTEMPTY);
         }
      }

      private function handleClickRemoveUserButton(param1:ButtonEvent=null) : void {
         this.removeReceiveItem();
      }

      private function handleClickRemoveAllUsersButton(param1:ButtonEvent) : void {
         if(this.receiverData.length > 0)
         {
            this.receiverData.cleanUp();
            this.receiverData.invalidate();
            this.sendButton.enabled = false;
         }
         else
         {
            showErrorS(MENU.PREBATTLE_INVITATIONS_ERRORS_RECEIVERLISTEMPTY);
         }
      }

      private function handleSelectOnlineCheckBox(param1:ButtonEvent) : void {
         var _loc2_:Boolean = param1.currentTarget.selected;
         var _loc3_:* = false;
         if(!(this.lastToken == null) && !(this.lastToken == "") && (this.onSearchResultReceived) && !(this.lastIsOnlineFlag == _loc2_))
         {
            _loc3_ = true;
         }
         setOnlineFlagS(_loc2_);
         if(_loc3_)
         {
            this.setToken(this.lastToken);
         }
         this.lastIsOnlineFlag = _loc2_;
      }

      private function handleSendInvitations(param1:ButtonEvent) : void {
         var _loc2_:Array = [];
         var _loc3_:* = "";
         if(this.messageTextInput.textField.getTextFormat()["color"] != this.inviteDefaultTextColor)
         {
            _loc3_ = StringUtils.trim(this.messageTextInput.text);
         }
         var _loc4_:Number = 0;
         while(_loc4_ < this.receiverData.length)
         {
            _loc2_.push(this.receiverData[_loc4_].uid);
            _loc4_++;
         }
         this.enableManagmentButtons(true);
         this.sendButton.enabled = false;
         this.wait = true;
         sendInvitesS(_loc2_,_loc3_);
      }

      private function showContextMenu(param1:SendInvitesEvent) : void {
         if(param1.initItem)
         {
            App.contextMenuMgr.showUserContextMenu(this,param1.initItem,new PrbSendInviteCIGenerator());
         }
      }

      private function usersAccordion_searchTokenHandler(param1:SendInvitesEvent) : void {
         this.lastToken = param1.searchString;
         this.setToken(this.lastToken);
      }

      private function usersAccordion_initComponentHandler(param1:SendInvitesEvent) : void {
         var _loc3_:String = null;
         var _loc2_:IViewStackContent = param1.initItem as IViewStackContent;
         if(_loc2_ != null)
         {
            _loc3_ = getQualifiedClassName(_loc2_);
            if(_loc3_ == Linkages.INVITES_FRIENDS)
            {
               _loc2_.update(this.friendMemberDataProvider);
            }
            else
            {
               if(_loc3_ == Linkages.INVITES_CLAN)
               {
                  _loc2_.update(this.clanMemberDataProvider);
               }
               else
               {
                  if(_loc3_ == Linkages.INVITES_SEARCH)
                  {
                     _loc2_.update(this.searchMemberDataProvider);
                  }
               }
            }
         }
      }
   }

}