package net.wg.gui.lobby.questsWindow
{
    import net.wg.infrastructure.base.meta.impl.QuestsCurrentTabMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.data.constants.QuestsStates;
    import flash.display.InteractiveObject;
    
    public class QuestsCurrentTab extends QuestsCurrentTabMeta implements IQuestsTab, IDAAPIModule
    {
        
        public function QuestsCurrentTab()
        {
            super();
        }
        
        private var _questContent:QuestContent;
        
        public function as_setQuestsData(param1:Array, param2:Number) : void
        {
            this._questContent.setQuestsData(param1,param2);
        }
        
        public function as_setSelectedQuest(param1:String) : void
        {
            this._questContent.setSelectedQuest(param1);
        }
        
        public function update(param1:Object) : void
        {
        }
        
        override protected function configUI() : void
        {
            this.questContent.setNodataLabel(QUESTS.QUESTS_CURRENT_NODATA);
            this.questContent.questsList.questsState = QuestsStates.CURRENT_STATE;
            this.questContent.validateNow();
        }
        
        override protected function onDispose() : void
        {
            this._questContent.dispose();
            super.onDispose();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.questContent.sortingFunction = getSortedTableDataS;
        }
        
        public function get questContent() : QuestContent
        {
            return this._questContent;
        }
        
        public function set questContent(param1:QuestContent) : void
        {
            this._questContent = param1;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
    }
}
