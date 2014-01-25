package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.base.meta.impl.QuestsCurrentTabMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import flash.display.InteractiveObject;


   public class QuestsCurrentTab extends QuestsCurrentTabMeta implements IQuestsTab, IDAAPIModule
   {
          
      public function QuestsCurrentTab() {
         super();
      }

      private var _questContent:QuestContent;

      public function as_setQuestsData(param1:Array, param2:Number) : void {
         this._questContent.setQuestsData(param1,param2);
      }

      public function as_setSelectedQuest(param1:String) : void {
         this._questContent.setSelectedQuest(param1);
      }

      public function update(param1:Object) : void {
          
      }

      override protected function configUI() : void {
         super.configUI();
         this._questContent.setNodataLabel(QUESTS.QUESTS_CURRENT_NODATA);
      }

      override protected function onDispose() : void {
         this._questContent.dispose();
         super.onDispose();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         this._questContent.sortingFunction = getSortedTableDataS;
      }

      public function get questContent() : QuestContent {
         return this._questContent;
      }

      public function set questContent(param1:QuestContent) : void {
         this._questContent = param1;
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}