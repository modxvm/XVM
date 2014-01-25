package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.base.meta.impl.QuestsWindowMeta;
   import net.wg.infrastructure.base.meta.IQuestsWindowMeta;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.advanced.ViewStack;
   import flash.display.Sprite;
   import net.wg.gui.events.ViewStackEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Linkages;
   import flash.display.InteractiveObject;
   import scaleform.clik.events.ListEvent;
   import net.wg.infrastructure.events.LifeCycleEvent;
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

      private var _currentQuestsTab:IQuestsTab = null;

      private var _futureQuestsTab:IQuestsTab = null;

      override protected function configUI() : void {
         super.configUI();
         this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
         this.tabs_mc.dataProvider = new DataProvider([
            {
               "label":QUESTS.QUESTS_TABS_CURRENT,
               "linkage":Linkages.CURRENT_TAB_UI
            }
         ,
            {
               "label":QUESTS.QUESTS_TABS_FUTURE,
               "linkage":Linkages.FUTURE_TAB_UI
            }
         ]);
         this.tabs_mc.selectedIndex = 0;
         this.tabs_mc.validateNow();
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.tabs_mc);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = QUESTS.QUESTS_TITLE;
      }

      override protected function onDispose() : void {
         this._currentQuestsTab = null;
         this._futureQuestsTab = null;
         this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
         this.tabs_mc.dispose();
         this.tabs_mc = null;
         this.view_mc.dispose();
         this.view_mc = null;
         this.line = null;
         App.toolTipMgr.hide();
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function onSetModalFocus(param1:InteractiveObject) : void {
         super.onSetModalFocus(param1);
         setFocus(this);
      }

      private function getQuestListFromTab(param1:IQuestsTab) : QuestsList {
         return param1.questContent.questsList;
      }

      private function tryToRegisterTab(param1:IQuestsTab, param2:String, param3:String, param4:String, param5:IQuestsTab) : IQuestsTab {
         if(param5 == null && param2 == param3)
         {
            param5 = param1;
            this.getQuestListFromTab(param5).addEventListener(ListEvent.INDEX_CHANGE,this.onQuestListIndexChangeHandler);
            param5.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeTabDisposeHandler);
            registerFlashComponentS(param5,param4);
         }
         return param5;
      }

      private function onViewChangedHandler(param1:ViewStackEvent) : void {
         var _loc2_:IQuestsTab = IQuestsTab(param1.view);
         this._currentQuestsTab = this.tryToRegisterTab(_loc2_,param1.linkage,Linkages.CURRENT_TAB_UI,Aliases.QUESTS_CURRENT_TAB,this._currentQuestsTab);
         this._futureQuestsTab = this.tryToRegisterTab(_loc2_,param1.linkage,Linkages.FUTURE_TAB_UI,Aliases.QUESTS_FUTURE_TAB,this._futureQuestsTab);
      }

      private function onQuestListIndexChangeHandler(param1:ListEvent) : void {
         setFocus(InteractiveObject(param1.target));
      }

      private function onBeforeTabDisposeHandler(param1:LifeCycleEvent) : void {
         var _loc2_:IQuestsTab = IQuestsTab(param1.target);
         this.getQuestListFromTab(_loc2_).removeEventListener(ListEvent.INDEX_CHANGE,this.onQuestListIndexChangeHandler);
         _loc2_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeTabDisposeHandler);
      }
   }

}