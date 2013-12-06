package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.questsWindow.components.ProgressQuestIndicator;
   import net.wg.gui.lobby.questsWindow.data.HeaderDataVO;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
   import net.wg.gui.lobby.questsWindow.data.InfoDataVO;
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   import net.wg.gui.lobby.questsWindow.data.ConditionsVO;
   import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
   import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
   import net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO;
   import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([QuestsWindow,QuestsCurrentTab,QuestsFutureTab,QuestRenderer,ProgressQuestIndicator,QuestsList,HeaderDataVO,QuestRendererVO,QuestBlock,QuestsCounter,QuestContent,QuestStatusComponent,HeaderBlock,DescriptionBlock,InfoDataVO,SubtaskVO,MiddleInfoBlock,SubtaskComponent,VehicleBlock,ConditionsBlock,ConditionsVO,QuestAwardsBlock,QuestDataVO,ConditionElement,ConditionElementVO,ConditionsComponent,QuestScrollPane,ComplexTooltipVO,QuestsDashlineItem]));
      }
   }

}