package net.wg.gui.lobby.questsWindow.components
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.CheckBox;
    import scaleform.clik.data.DataProvider;
    
    public class SortingPanel extends UIComponent
    {
        
        public function SortingPanel()
        {
            super();
        }
        
        private static var DD_PADDING:int = 3;
        
        private static var CB_PADDING:int = 13;
        
        public var sortTF:TextField;
        
        public var sortingDD:DropdownMenu;
        
        public var doneCB:CheckBox;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.sortTF.mouseEnabled = false;
            this.sortTF.text = QUESTS.QUESTS_CURRENTTAB_HEADER_SORT;
            this.doneCB.label = QUESTS.QUESTS_CURRENTTAB_HEADER_CHECKBOX_TEXT;
            this.sortingDD.dataProvider = new DataProvider([{"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_ALL},{"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_ACTION},{"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_QUESTS}]);
            this.sortingDD.selectedIndex = 0;
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.sortingDD.x = this.sortTF.x + this.sortTF.textWidth + DD_PADDING;
            this.doneCB.x = this.sortingDD.x + this.sortingDD.width + CB_PADDING;
        }
        
        override protected function onDispose() : void
        {
            this.sortingDD.dispose();
            this.sortingDD = null;
            this.doneCB.dispose();
            this.doneCB = null;
            this.sortTF = null;
            super.onDispose();
        }
    }
}
