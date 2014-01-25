package net.wg.gui.messenger.windows
{
   import net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import flash.display.InteractiveObject;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.messenger.evnts.ChannelsFormEvent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.messenger.forms.ChannelsSearchForm;
   import flash.display.MovieClip;


   public class ChannelsManagementWindow extends ChannelsManagementWindowMeta
   {
          
      public function ChannelsManagementWindow() {
         this.tabsDataProvider = [
            {
               "label":MESSENGER.DIALOGS_CHANNELS_BUTTONS_SEARCHANDJOIN,
               "linkage":this.SEARCH_CHANNEL_FORM_ID
            }
         ,
            {
               "label":MESSENGER.DIALOGS_CHANNELS_BUTTONS_CREATE,
               "linkage":this.CREATE_CHANNEL_FORM_ID
            }
         ];
         super();
         isModal = false;
         isCentered = false;
         canClose = true;
         canDrag = true;
         canResize = true;
         showWindowBg = false;
         this._searchResDataProvider = new DAAPIDataProvider();
      }

      public var tabs:ButtonBarEx = null;

      public var tabLine:Sprite = null;

      public var view:ViewStack = null;

      private const SEARCH_CHANNEL_FORM_ID:String = "searchChannelFormUI";

      private const CREATE_CHANNEL_FORM_ID:String = "createChannelFormUI";

      private var searchLimitLabel:String = null;

      private const tabsDataProvider:Array;

      private var __currentTab:Number = 0;

      protected var _searchResDataProvider:DAAPIDataProvider;

      override protected function onSetModalFocus(param1:InteractiveObject) : void {
         super.onSetModalFocus(param1);
         this.onViewChangeHandler();
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         if(this.tabs.selectedIndex == -1)
         {
            this.tabs.selectedIndex = this.__currentTab;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateViewSize();
         }
         super.draw();
      }

      private function updateViewSize() : void {
         var _loc1_:String = null;
         var _loc2_:UIComponent = null;
         if(this.view)
         {
            for (_loc1_ in this.view.cachedViews)
            {
               _loc2_ = UIComponent(this.view.cachedViews[_loc1_]);
               _loc2_.setSize(width,height - this.view.y);
               _loc2_.validateNow();
            }
         }
      }

      override protected function onPopulate() : void {
         window.useBottomBtns = false;
         window.title = MESSENGER.LOBBY_BUTTONS_CHANNELS;
         window.contentPadding = new Padding(40,10,17,9);
         window.setMaxWidth(650);
         window.setMaxHeight(400);
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.tabLine.name,this.tabLine,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement(this.tabs.name,this.tabs,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         updateStage(App.appWidth,App.appHeight);
         super.onPopulate();
         this.initTabs();
         this.searchLimitLabel = getSearchLimitLabelS();
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CHANNELS_WINDOW);
      }

      public function as_getDataProvider() : Object {
         return this._searchResDataProvider;
      }

      private function initTabs() : void {
         if(this.tabs != null)
         {
            this.tabs.dataProvider = new DataProvider(this.tabsDataProvider);
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         }
         if(this.view != null)
         {
            this.view.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
            this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewChange);
            this.view.addEventListener(ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK,this.onSearchCkick);
            this.view.addEventListener(ChannelsFormEvent.ON_JOIN,this.onJoinHandler);
            this.view.addEventListener(ChannelsFormEvent.ON_CREATE_CHANNEL,this.onCreateChannel);
         }
      }

      private function onViewChange(param1:ViewStackEvent) : void {
         var _loc2_:IViewStackContent = param1.view;
         switch(param1.linkage)
         {
            case this.SEARCH_CHANNEL_FORM_ID:
               ChannelsSearchForm(_loc2_).searchResultText = this.searchLimitLabel;
               ChannelsSearchForm(_loc2_).searchResultList.dataProvider = this._searchResDataProvider;
               ChannelsSearchForm(_loc2_).searchResultList.labelField = "name";
               break;
            case this.CREATE_CHANNEL_FORM_ID:
               break;
         }
         _loc2_.update({});
         this.updateViewSize();
      }

      private function onViewChangeHandler(param1:ViewStackEvent=null) : void {
         var _loc2_:IViewStackContent = null;
         if((this.view) && (this.view.currentView) && param1 == null)
         {
            _loc2_ = this.view.currentView as IViewStackContent;
            _loc2_.update({});
         }
         else
         {
            if(param1 != null)
            {
               _loc2_ = param1.view;
               _loc2_.update({});
            }
         }
      }

      private function onTabChange(param1:IndexEvent) : void {
         this.__currentTab = param1.index;
         this.updateViewSize();
      }

      override protected function onDispose() : void {
         if(this.view)
         {
            this.view.dispose();
            this.view.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
            this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewChange);
            this.view.removeEventListener(ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK,this.onSearchCkick);
            this.view.removeEventListener(ChannelsFormEvent.ON_JOIN,this.onJoinHandler);
            this.view.removeEventListener(ChannelsFormEvent.ON_CREATE_CHANNEL,this.onCreateChannel);
         }
         if(this.tabs)
         {
            this.tabs.dispose();
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         }
         super.onDispose();
      }

      private function onSearchCkick(param1:ChannelsFormEvent) : void {
         searchTokenS(param1.channelName);
      }

      private function onJoinHandler(param1:ChannelsFormEvent) : void {
         joinToChannelS(param1.index);
      }

      private function onCreateChannel(param1:ChannelsFormEvent) : void {
         var _loc2_:* = !(param1.channelPass == null && param1.channelRetypePass == null);
         createChannelS(param1.channelName,_loc2_,param1.channelPass,param1.channelRetypePass);
      }

      public function as_freezSearchButton(param1:Boolean) : void {
         var _loc2_:ChannelsSearchForm = ChannelsSearchForm(this.tryGetView(this.SEARCH_CHANNEL_FORM_ID));
         if(_loc2_)
         {
            _loc2_.lockSearchButton(!param1);
         }
      }

      private function tryGetView(param1:String) : MovieClip {
         var _loc2_:MovieClip = null;
         if(!this.view)
         {
            return null;
         }
         if(this.view.cachedViews[param1] != null)
         {
            _loc2_ = this.view.cachedViews[param1];
         }
         return _loc2_;
      }
   }

}