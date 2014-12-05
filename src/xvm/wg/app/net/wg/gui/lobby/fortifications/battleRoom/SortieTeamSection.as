package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
    import net.wg.gui.rally.controls.SlotDropIndicator;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    
    public class SortieTeamSection extends TeamSectionWithDropIndicators
    {
        
        public function SortieTeamSection()
        {
            super();
            btnFight.UIID = 72;
            btnNotReady.UIID = 72;
        }
        
        public var slot0:SortieSlot;
        
        public var slot1:SortieSlot;
        
        public var slot2:SortieSlot;
        
        public var slot3:SortieSlot;
        
        public var slot4:SortieSlot;
        
        public var slot5:SortieSlot;
        
        public var slot6:SortieSlot;
        
        public var slot7:SortieSlot;
        
        public var slot8:SortieSlot;
        
        public var slot9:SortieSlot;
        
        public var slot10:SortieSlot;
        
        public var slot11:SortieSlot;
        
        public var slot12:SortieSlot;
        
        public var slot13:SortieSlot;
        
        public var slot14:SortieSlot;
        
        public var dropTargetIndicator0:SlotDropIndicator;
        
        public var dropTargetIndicator1:SlotDropIndicator;
        
        public var dropTargetIndicator2:SlotDropIndicator;
        
        public var dropTargetIndicator3:SlotDropIndicator;
        
        public var dropTargetIndicator4:SlotDropIndicator;
        
        public var dropTargetIndicator5:SlotDropIndicator;
        
        public var dropTargetIndicator6:SlotDropIndicator;
        
        public var dropTargetIndicator7:SlotDropIndicator;
        
        public var dropTargetIndicator8:SlotDropIndicator;
        
        public var dropTargetIndicator9:SlotDropIndicator;
        
        public var dropTargetIndicator10:SlotDropIndicator;
        
        public var dropTargetIndicator11:SlotDropIndicator;
        
        public var dropTargetIndicator12:SlotDropIndicator;
        
        public var dropTargetIndicator13:SlotDropIndicator;
        
        public var dropTargetIndicator14:SlotDropIndicator;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.updateTeamHeader();
        }
        
        protected function updateTeamHeader() : void
        {
            if(!lblTeamHeader)
            {
                return;
            }
            lblTeamHeader.text = FORTIFICATIONS.SORTIE_ROOM_ROSTERLISTTITLE;
        }
        
        override protected function getMembersStr() : String
        {
            return FORTIFICATIONS.SORTIE_ROOM_MEMBERS;
        }
        
        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6,this.slot7,this.slot8,this.slot9,this.slot10,this.slot11,this.slot12,this.slot13,this.slot14];
            var _loc3_:* = 0;
            var _loc4_:ISlotRendererHelper = new SortieSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.index = _loc3_++;
                _loc2_.helper = _loc4_;
                SortieSlot(_loc2_).vehicleBtn.UIID = 53 + _loc2_.index;
            }
            return _loc1_;
        }
        
        override public function getIndicatorsUI() : Vector.<ISlotDropIndicator>
        {
            return new <ISlotDropIndicator>[this.dropTargetIndicator0,this.dropTargetIndicator1,this.dropTargetIndicator2,this.dropTargetIndicator3,this.dropTargetIndicator4,this.dropTargetIndicator5,this.dropTargetIndicator6,this.dropTargetIndicator7,this.dropTargetIndicator8,this.dropTargetIndicator9,this.dropTargetIndicator10,this.dropTargetIndicator11,this.dropTargetIndicator12,this.dropTargetIndicator13,this.dropTargetIndicator14];
        }
    }
}
