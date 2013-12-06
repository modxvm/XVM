package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.base.meta.impl.QuestsCurrentTabMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta;


   public class QuestsCurrentTab extends QuestsCurrentTabMeta implements IViewStackContent, IQuestsCurrentTabMeta
   {
          
      public function QuestsCurrentTab() {
         super();
      }

      public var questContent:QuestContent;

      public function as_setQuestsData(param1:Array, param2:Number) : void {
         this.questContent.setQuestsData(param1,param2);
      }

      public function as_setSelectedQuest(param1:String) : void {
         this.questContent.setSelectedQuest(param1);
      }

      public function update(param1:Object) : void {
          
      }

      override protected function configUI() : void {
         super.configUI();
         this.questContent.setNodataLabel(QUESTS.QUESTS_CURRENT_NODATA);
      }

      override protected function onDispose() : void {
         this.questContent.dispose();
         super.onDispose();
      }
   }

}