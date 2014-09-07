package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
    import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    
    public class SortieSlot extends RallyLockableSlotRenderer
    {
        
        public function SortieSlot()
        {
            super();
        }
        
        public var showTakePlaceBtn:Boolean = true;
        
        override public function setStatus(param1:int) : String
        {
            var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
            if(param1 < STATUSES.length && (param1))
            {
                _loc2_ = STATUSES[param1];
            }
            statusIndicator.status = _loc2_;
            return _loc2_;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            takePlaceFirstTimeBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
            if(takePlaceBtn)
            {
                takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
            }
        }
    }
}
