package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSlotsVO;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;
    
    public class FortBattleRoomSections extends SortieTeamSection
    {
        
        public function FortBattleRoomSections()
        {
            this.icons = [];
            super();
        }
        
        private var icons:Array;
        
        override public function updateMembers(param1:Boolean, param2:Array) : void
        {
            super.updateMembers(param1,param2);
        }
        
        override protected function configUI() : void
        {
            var _loc2_:LegionariesSortieSlot = null;
            super.configUI();
            var _loc1_:Array = [slot0,slot1,slot2,slot3,slot4,slot5,slot6,slot7,slot8,slot9,slot10,slot11,slot12,slot13,slot14];
            for each(_loc2_ in _loc1_)
            {
                this.icons.push(_loc2_.legionariesIcon);
            }
        }
        
        override protected function getSlotVO(param1:Object) : IRallySlotVO
        {
            return new LegionariesSlotsVO(param1);
        }
        
        override protected function updateRenderIcon(param1:ISlotDropIndicator) : void
        {
            var _loc2_:int = param1.index;
            var _loc3_:IRallySlotVO = getSlotModel(_loc2_);
            if((_loc3_) && (_loc3_.player) && (LegionariesCandidateVO(_loc3_.player).isLegionaries))
            {
                param1.setAdditionalToolTipTarget(this.icons[_loc2_]);
            }
            else
            {
                param1.removeAdditionalTooltipTarget();
            }
        }
        
        override protected function onDispose() : void
        {
            this.icons.splice(0,this.icons.length);
            this.icons = null;
            super.onDispose();
        }
    }
}
