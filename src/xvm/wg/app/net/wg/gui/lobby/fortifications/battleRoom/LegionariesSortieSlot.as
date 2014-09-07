package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;
    
    public class LegionariesSortieSlot extends SortieSlot
    {
        
        public function LegionariesSortieSlot()
        {
            super();
            if(this.legionariesIcon)
            {
                this.legionariesIcon.visible = false;
            }
        }
        
        private static var ICON_PADDING:uint = 10;
        
        public var legionariesIcon:UILoaderAlt = null;
        
        override protected function configUI() : void
        {
            tooltipSubscribeListOfControls.push(this.legionariesIcon);
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.legionariesIcon.dispose();
            this.legionariesIcon = null;
            super.onDispose();
        }
        
        override public function updateComponents() : void
        {
            super.updateComponents();
            if(!this.legionariesIcon)
            {
                return;
            }
            if((slotData) && (slotData.player) && (LegionariesCandidateVO(slotData.player).isLegionaries))
            {
                this.legionariesIcon.visible = true;
                this.legionariesIcon.mouseEnabled = true;
                this.legionariesIcon.x = slotLabel.x + slotLabel.textWidth + ICON_PADDING;
            }
            else
            {
                this.legionariesIcon.mouseEnabled = false;
                this.legionariesIcon.visible = false;
            }
        }
    }
}
