package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.rally.views.room.BaseTeamSection;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
    import net.wg.gui.rally.controls.SlotDropIndicator;
    
    public class SortieTeamSection extends BaseTeamSection
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
        
        public var dropTargerIndicator0:SlotDropIndicator;
        
        public var dropTargerIndicator1:SlotDropIndicator;
        
        public var dropTargerIndicator2:SlotDropIndicator;
        
        public var dropTargerIndicator3:SlotDropIndicator;
        
        public var dropTargerIndicator4:SlotDropIndicator;
        
        public var dropTargerIndicator5:SlotDropIndicator;
        
        public var dropTargerIndicator6:SlotDropIndicator;
        
        public var dropTargerIndicator7:SlotDropIndicator;
        
        public var dropTargerIndicator8:SlotDropIndicator;
        
        public var dropTargerIndicator9:SlotDropIndicator;
        
        public var dropTargerIndicator10:SlotDropIndicator;
        
        public var dropTargerIndicator11:SlotDropIndicator;
        
        public var dropTargerIndicator12:SlotDropIndicator;
        
        public var dropTargerIndicator13:SlotDropIndicator;
        
        public var dropTargerIndicator14:SlotDropIndicator;
        
        override protected function configUI() : void
        {
            super.configUI();
            lblTeamVehicles.htmlText = this.getVehiclesStaticStr();
            lblTeamHeader.text = FORTIFICATIONS.SORTIE_ROOM_ROSTERLISTTITLE;
        }
        
        override protected function getMembersStr() : String
        {
            return FORTIFICATIONS.SORTIE_ROOM_MEMBERS;
        }
        
        override protected function getVehiclesStr() : String
        {
            return App.utils.locale.makeString(FORTIFICATIONS.SORTIE_ROOM_VEHICLES);
        }
        
        override protected function getVehiclesStaticStr() : String
        {
            return App.utils.locale.makeString(FORTIFICATIONS.SORTIE_ROOM_VEHICLES);
        }
        
        override protected function getSlotsUI() : Array
        {
            var _loc2_:SortieSlot = null;
            var _loc1_:Array = [this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6,this.slot7,this.slot8,this.slot9,this.slot10,this.slot11,this.slot12,this.slot13,this.slot14];
            var _loc3_:* = 0;
            var _loc4_:SortieSlotHelper = new SortieSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.index = _loc3_++;
                _loc2_.helper = _loc4_;
                _loc2_.vehicleBtn.UIID = 53 + _loc2_.index;
            }
            return _loc1_;
        }
        
        override protected function getIndicatorsUI() : Array
        {
            return [this.dropTargerIndicator0,this.dropTargerIndicator1,this.dropTargerIndicator2,this.dropTargerIndicator3,this.dropTargerIndicator4,this.dropTargerIndicator5,this.dropTargerIndicator6,this.dropTargerIndicator7,this.dropTargerIndicator8,this.dropTargerIndicator9,this.dropTargerIndicator10,this.dropTargerIndicator11,this.dropTargerIndicator12,this.dropTargerIndicator13,this.dropTargerIndicator14];
        }
    }
}
