package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
    import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
    
    public class SortieSlot extends RallyLockableSlotRenderer
    {
        
        public function SortieSlot() {
            super();
        }
        
        public var showTakePlaceBtn:Boolean = true;
        
        override public function setStatus(param1:int) : String {
            var _loc2_:String = STATUS_NORMAL;
            if(param1 < STATUSES.length && (param1))
            {
                _loc2_ = STATUSES[param1];
            }
            if(_loc2_ == STATUS_COMMANDER)
            {
                _loc2_ = STATUS_READY;
            }
            statusIndicator.gotoAndStop(_loc2_);
            return _loc2_;
        }
        
        override protected function configUI() : void {
            super.configUI();
            takePlaceFirstTimeBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
            if(takePlaceBtn)
            {
                takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
            }
        }
    }
}
