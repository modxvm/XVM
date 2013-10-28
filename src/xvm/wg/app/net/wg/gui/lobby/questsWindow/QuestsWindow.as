package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.base.meta.impl.QuestsWindowMeta;
   import net.wg.infrastructure.base.meta.IQuestsWindowMeta;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import flash.display.Sprite;
   import net.wg.gui.events.ViewStackEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.data.Aliases;


   public class QuestsWindow extends QuestsWindowMeta implements IQuestsWindowMeta
   {
          
      public function QuestsWindow() {
         super();
         showWindowBg = false;
         isCentered = true;
      }

      public var tabs_mc:ButtonBarEx;

      public var view_mc:ViewStack;

      public var line:Sprite;

      private var _currentTabRegistered:Boolean = false;

      private var _futureTabRegistered:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED,this.handleView);
         this.tabs_mc.dataProvider = new DataProvider([
            {
               "label":QUESTS.QUESTS_TABS_CURRENT,
               "linkage":"CurrentTab_UI"
            }
         ,
            {
               "label":QUESTS.QUESTS_TABS_FUTURE,
               "linkage":"FutureTab_UI"
            }
         ]);
         this.tabs_mc.selectedIndex = 0;
         this.tabs_mc.validateNow();
         App.utils.focusHandler.setFocus(this.tabs_mc);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = QUESTS.QUESTS_TITLE;
      }

      override protected function onDispose() : void {
         this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.handleView);
         super.onDispose();
         App.toolTipMgr.hide();
      }

      private function handleView(param1:ViewStackEvent) : void {
         if(param1.linkage == "CurrentTab_UI" && !this._currentTabRegistered)
         {
            registerFlashComponentS(IDAAPIModule(param1.view),Aliases.QUESTS_CURRENT_TAB);
            this._currentTabRegistered = true;
         }
         if(param1.linkage == "FutureTab_UI" && !this._futureTabRegistered)
         {
            registerFlashComponentS(IDAAPIModule(param1.view),Aliases.QUESTS_FUTURE_TAB);
            this._futureTabRegistered = true;
         }
      }

      override protected function draw() : void {
         super.draw();
      }

      override public function setFocus() : void {
         super.setFocus();
         App.utils.scheduler.envokeInNextFrame(App.utils.focusHandler.setFocus,this);
      }
   }

}