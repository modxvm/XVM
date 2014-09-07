package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
    import net.wg.gui.lobby.fortifications.battleRoom.SortieTeamSection;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.vo.RallySlotVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    
    public class FortClanBattleTeamSection extends SortieTeamSection
    {
        
        public function FortClanBattleTeamSection()
        {
            super();
        }
        
        override protected function getSlotVO(param1:Object) : IRallySlotVO
        {
            return new RallySlotVO(param1);
        }
        
        public function updateTeamHeaderText(param1:String) : void
        {
            lblTeamHeader.htmlText = param1;
        }
        
        override protected function updateTeamHeader() : void
        {
            lblTeamHeader.x = Math.round((this.width - lblTeamHeader.width) / 2);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            btnFight.mouseChildren = btnFight.mouseEnabled = true;
            btnNotReady.mouseChildren = btnNotReady.mouseEnabled = true;
            tooltipSubscribe([btnFight,btnNotReady]);
        }
        
        override protected function onDispose() : void
        {
            tooltipSubscribe([btnFight,btnNotReady],false);
            super.onDispose();
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            if(!actionButtonData || (actionButtonData) && (actionButtonData.toolTipData == Values.EMPTY_STR))
            {
                return;
            }
            switch(param1.currentTarget)
            {
                case btnFight:
                    App.toolTipMgr.show(actionButtonData.toolTipData);
                    break;
                case btnNotReady:
                    App.toolTipMgr.show(actionButtonData.toolTipData);
                    break;
            }
        }
    }
}
