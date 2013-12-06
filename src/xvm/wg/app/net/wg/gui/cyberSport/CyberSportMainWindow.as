package net.wg.gui.cyberSport
{
   import net.wg.infrastructure.base.meta.impl.CyberSportMainWindowMeta;
   import net.wg.infrastructure.base.meta.ICyberSportMainWindowMeta;
   import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.infrastructure.base.meta.ICyberSportBaseViewMeta;
   import scaleform.clik.controls.Button;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.gui.components.windows.WindowEvent;
   import flash.display.MovieClip;
   import net.wg.gui.cyberSport.views.events.CyberSportEvent;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import net.wg.gui.cyberSport.views.UnitView;
   import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
   import flash.display.InteractiveObject;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.data.Aliases;
   import net.wg.infrastructure.interfaces.IDAAPIModule;


   public class CyberSportMainWindow extends CyberSportMainWindowMeta implements ICyberSportMainWindowMeta
   {
          
      public function CyberSportMainWindow() {
         super();
         this.autoSearch.visible = false;
         showWindowBg = false;
         canMinimize = true;
         visible = true;
      }

      private static const UPDATE_AUTO_SEARCH_MODEL:String = "autoSearchModel";

      public var autoSearch:ICSAutoSearchMainView;

      public var backBtn:SoundButton;

      public var stack:ViewStack;

      private var autoSearchModel:AutoSearchVO;

      private var currentView:ICyberSportBaseViewMeta;

      private var chatFocusNeeded:Boolean = true;

      public function as_enableWndCloseBtn(param1:Boolean) : void {
         Button(window.getCloseBtn()).enabled = param1;
      }

      override public function set window(param1:IWindow) : void {
         if(window)
         {
            window.removeEventListener(WindowEvent.SCALE_X_CHANGED,this.onScaleChanged);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onScaleChanged);
         }
         super.window = param1;
         if(window)
         {
            window.addEventListener(WindowEvent.SCALE_X_CHANGED,this.onScaleChanged);
            window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onScaleChanged);
         }
      }

      private function onScaleChanged(param1:WindowEvent) : void {
         if(param1.type == WindowEvent.SCALE_X_CHANGED)
         {
            window.width = param1.prevValue;
         }
         else
         {
            window.height = param1.prevValue;
         }
      }

      public function as_loadView(param1:String, param2:String) : void {
         var _loc3_:MovieClip = this.stack.show(param1);
         if(this.currentView)
         {
            this.currentView.removeEventListener(CyberSportEvent.LOAD_VIEW_REQUEST,this.onViewLoadRequest);
            if(!this.stack.cache)
            {
               this.unregisterCurrentView();
            }
         }
         this.registerCurrentView(_loc3_,param2);
         this.checkBackBtnState();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = CYBERSPORT.WINDOW_TITLE;
         window.contentPadding = new Padding(35,13,-5,12);
      }

      override public function as_getGeometry() : Array {
         if(window)
         {
            return [window.x,window.y,-1,-1];
         }
         return null;
      }

      override protected function onDispose() : void {
         this.autoSearch.stopTimer();
         this.autoSearch.dispose();
         super.onDispose();
      }

      override protected function configUI() : void {
         if(_baseDisposed)
         {
            DebugUtils.LOG_DEBUG("!!! CyberSportMainWindow disposed before initializing !!!");
            return;
         }
         super.configUI();
         this.backBtn.buttonMode = true;
         this.backBtn.useHandCursor = true;
         this.backBtn.addEventListener(ButtonEvent.CLICK,this.backBtnClick);
         addEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,this.showAutoSearchView);
         addEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.autoSearchApplyHandler);
         addEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.autoSearchCancelHandler);
         invalidate(UPDATE_AUTO_SEARCH_MODEL);
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            if(this.autoSearch.visible)
            {
               this.autoSearch.handleInput(param1);
            }
            else
            {
               if(isBackBtnVisibleS())
               {
                  param1.handled = true;
                  if(this.currentView  is  UnitView && (UnitView(this.currentView).rosterTeamContext))
                  {
                     UnitView(this.currentView).preInitFadeAnimationCancel();
                  }
                  else
                  {
                     onBackClickS();
                  }
               }
               else
               {
                  if(window.getCloseBtn().enabled)
                  {
                     param1.handled = true;
                     onWindowCloseS();
                  }
               }
            }
         }
      }

      override public function setFocus() : void {
         super.setFocus();
         var _loc1_:IChannelComponentHolder = this.currentView as IChannelComponentHolder;
         if((_loc1_) && (this.chatFocusNeeded))
         {
            _loc1_.getChannelComponent().setFocusToInput();
            this.chatFocusNeeded = false;
         }
         else
         {
            if(this.autoSearch.visible)
            {
               this.autoSearchUpdateFocus();
            }
            else
            {
               App.utils.focusHandler.setFocus(this.currentView as InteractiveObject);
            }
         }
      }

      public function as_autoSearchEnableBtn(param1:Boolean) : void {
         this.autoSearch.enableButton(param1);
      }

      public function as_hideAutoSearch() : void {
         this.autoSearch.stopTimer();
         this.autoSearch.visible = false;
         this.autoSearchModel = null;
      }

      public function as_changeAutoSearchState(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         this.autoSearchModel = new AutoSearchVO(param1);
         invalidate(UPDATE_AUTO_SEARCH_MODEL);
      }

      private function autoSearchUpdateFocus() : void {
         this.autoSearch.updateFocus();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(UPDATE_AUTO_SEARCH_MODEL)) && (this.autoSearchModel))
         {
            this.autoSearch.changeState = this.autoSearchModel;
            this.autoSearch.visible = true;
            App.utils.scheduler.envokeInNextFrame(this.autoSearchUpdateFocus);
         }
      }

      private function onViewLoadRequest(param1:CyberSportEvent) : void {
         switch(param1.alias)
         {
            case CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI:
               onBrowseUnitsS();
               break;
            case CYBER_SPORT_ALIASES.UNIT_VIEW_UI:
               if(param1.itemId)
               {
                  onJoinUnitS(param1.itemId,param1.peripheryID,param1.slotIndex);
               }
               else
               {
                  onCreateUnitS();
               }
               break;
         }
      }

      private function backBtnClick(param1:ButtonEvent) : void {
         onBackClickS();
      }

      private function checkBackBtnState() : void {
         this.backBtn.visible = isBackBtnVisibleS();
      }

      private function registerCurrentView(param1:MovieClip, param2:String) : void {
         this.currentView = param1 as ICyberSportBaseViewMeta;
         this.currentView.as_setPyAlias(param2);
         this.currentView.addEventListener(CyberSportEvent.LOAD_VIEW_REQUEST,this.onViewLoadRequest);
         var _loc3_:IChannelComponentHolder = param1 as IChannelComponentHolder;
         if(_loc3_ != null)
         {
            registerComponent(_loc3_.getChannelComponent(),Aliases.CHANNEL_COMPONENT);
         }
         registerComponent(this.currentView as IDAAPIModule,this.currentView.as_getPyAlias());
         this.chatFocusNeeded = true;
         this.setFocus();
      }

      private function unregisterCurrentView() : void {
         if(this.currentView  is  IChannelComponentHolder)
         {
            unregisterComponent(Aliases.CHANNEL_COMPONENT);
         }
         unregisterComponent(this.currentView.as_getPyAlias());
      }

      private function autoSearchCancelHandler(param1:CSComponentEvent) : void {
         autoSearchCancelS(param1.data.toString());
      }

      private function autoSearchApplyHandler(param1:CSComponentEvent) : void {
         autoSearchApplyS(param1.data.toString());
      }

      private function showAutoSearchView(param1:CSComponentEvent) : void {
         onAutoMatchS(param1.data.state.toString(),param1.data.cmpDescr);
      }
   }

}