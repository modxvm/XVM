package net.wg.gui.messenger.windows
{
   import net.wg.gui.messenger.meta.impl.ContactsWindowMeta;
   import net.wg.gui.messenger.meta.IContactsWindowMeta;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import flash.display.InteractiveObject;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.messenger.evnts.ContactsFormEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.utils.getQualifiedClassName;


   public class ContactsWindow extends ContactsWindowMeta implements IContactsWindowMeta
   {
          
      public function ContactsWindow() {
         this.friendsDP = new DAAPIDataProvider();
         this.clanDP = new DAAPIDataProvider();
         this.ignoredDP = new DAAPIDataProvider();
         this.mutedDP = new DAAPIDataProvider();
         this.searchDP = new DAAPIDataProvider();
         super();
         isCentered = false;
         showWindowBg = false;
         canResize = true;
         canDrag = true;
      }

      private static const VIEW_LIST:String = "ContactsListFormUI";

      private static const VIEW_SEARCH:String = "ContactsSearchFormUI";

      private static const INVALIDATE_VIEW:String = "invalidateView";

      public var tabs:ButtonBarEx;

      public var tabLine:Sprite;

      public var viewStack:ViewStack;

      protected var friendsDP:DAAPIDataProvider;

      protected var clanDP:DAAPIDataProvider;

      protected var ignoredDP:DAAPIDataProvider;

      protected var mutedDP:DAAPIDataProvider;

      protected var searchDP:DAAPIDataProvider;

      protected var searchResultText:String;

      protected var freezeSearch:Boolean;

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         this.updateFocusInViewContainer();
      }

      public function as_getFriendsDP() : Object {
         return this.friendsDP;
      }

      public function as_getClanDP() : Object {
         return this.clanDP;
      }

      public function as_getIgnoredDP() : Object {
         return this.ignoredDP;
      }

      public function as_getMutedDP() : Object {
         return this.mutedDP;
      }

      public function as_getSearchDP() : Object {
         return this.searchDP;
      }

      public function as_setSearchResultText(param1:String) : void {
         this.searchResultText = param1;
      }

      public function as_frozenSearchAction(param1:Boolean) : void {
         this.freezeSearch = param1;
         this.updateViewData();
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabSelected);
         this.viewStack.removeEventListener(ContactsFormEvent.SEARCH,this.onSearchFormEvent);
         this.viewStack.removeEventListener(ContactsFormEvent.ADD_TO_FRIENDS,this.onSearchFormEvent);
         this.viewStack.removeEventListener(ContactsFormEvent.ADD_TO_IGNORED,this.onSearchFormEvent);
         if(this.friendsDP)
         {
            this.friendsDP.cleanUp();
            this.friendsDP = null;
         }
         if(this.clanDP)
         {
            this.clanDP.cleanUp();
            this.clanDP = null;
         }
         if(this.ignoredDP)
         {
            this.ignoredDP.cleanUp();
            this.ignoredDP = null;
         }
         if(this.mutedDP)
         {
            this.mutedDP.cleanUp();
            this.mutedDP = null;
         }
         if(this.searchDP)
         {
            this.searchDP.cleanUp();
            this.searchDP = null;
         }
      }

      override protected function configUI() : void {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("tabs",this.tabs,Constraints.TOP | Constraints.RIGHT | Constraints.LEFT);
         constraints.addElement("tabLine",this.tabLine,Constraints.TOP | Constraints.RIGHT | Constraints.LEFT);
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabSelected);
         this.viewStack.addEventListener(ContactsFormEvent.SEARCH,this.onSearchFormEvent);
         this.viewStack.addEventListener(ContactsFormEvent.ADD_TO_FRIENDS,this.onSearchFormEvent);
         this.viewStack.addEventListener(ContactsFormEvent.ADD_TO_IGNORED,this.onSearchFormEvent);
         this.initTabs();
         this.updateViewData();
      }

      override protected function draw() : void {
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateViewSize();
         }
         if(isInvalid(INVALIDATE_VIEW))
         {
            this.updateViewData();
            this.updateViewSize();
         }
         super.draw();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = MESSENGER.LOBBY_BUTTONS_CONTACTS;
         window.contentPadding = new Padding(36,15,20,14);
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CONTACTS_WINDOW);
      }

      private function initTabs() : void {
         this.tabs.dataProvider = new DataProvider([
            {
               "label":MESSENGER.DIALOGS_CONTACTS_TITLE,
               "linkage":VIEW_LIST
            }
         ,
            {
               "label":MESSENGER.DIALOGS_SEARCHCONTACT_TITLE,
               "linkage":VIEW_SEARCH
            }
         ]);
         this.tabs.selectedIndex = 0;
      }

      private function updateViewSize() : void {
         var _loc4_:String = null;
         var _loc5_:UIComponent = null;
         var _loc1_:Padding = window.contentPadding as Padding;
         var _loc2_:Number = window.getBackground().width - _loc1_.left - _loc1_.right;
         var _loc3_:Number = window.getBackground().height - _loc1_.top - _loc1_.bottom - this.viewStack.y;
         for (_loc4_ in this.viewStack.cachedViews)
         {
            _loc5_ = this.viewStack.cachedViews[_loc4_] as UIComponent;
            _loc5_.setSize(_loc2_,_loc3_);
            if(_loc5_ == this.viewStack.currentView)
            {
               _loc5_.validateNow();
            }
         }
      }

      private function updateFocusInViewContainer() : void {
         if(this.viewStack == null || this.viewStack.currentView == null)
         {
            return;
         }
         var _loc1_:IViewStackContent = this.viewStack.currentView as IViewStackContent;
         this.updateView(_loc1_);
      }

      private function updateView(param1:IViewStackContent, param2:Object=null) : void {
         param1.update(param2);
         if(param1.getComponentForFocus())
         {
            this.setFocus(param1.getComponentForFocus());
         }
      }

      private function updateViewData() : void {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc1_:IViewStackContent = this.viewStack.currentView as IViewStackContent;
         if(_loc1_ != null)
         {
            _loc2_ = getQualifiedClassName(_loc1_);
            _loc3_ = null;
            if(_loc2_ == VIEW_LIST)
            {
               _loc3_ =
                  {
                     "friendsDP":this.friendsDP,
                     "clanDP":this.clanDP,
                     "ignoredDP":this.ignoredDP,
                     "mutedDP":this.mutedDP
                  }
               ;
            }
            else
            {
               if(_loc2_ == VIEW_SEARCH)
               {
                  _loc3_ =
                     {
                        "searchDP":this.searchDP,
                        "resultText":this.searchResultText,
                        "freezeSearch":this.freezeSearch
                     }
                  ;
               }
            }
            this.updateView(_loc1_,_loc3_);
         }
      }

      private function onSearchFormEvent(param1:ContactsFormEvent) : void {
         switch(param1.type)
         {
            case ContactsFormEvent.SEARCH:
               searchContactS(param1.searchValue);
               break;
            case ContactsFormEvent.ADD_TO_FRIENDS:
               addToFriendsS(param1.uid,param1.name);
               break;
            case ContactsFormEvent.ADD_TO_IGNORED:
               addToIgnoredS(param1.uid,param1.name);
               break;
         }
      }

      private function onTabSelected(param1:IndexEvent) : void {
         invalidate(INVALIDATE_VIEW);
      }
   }

}