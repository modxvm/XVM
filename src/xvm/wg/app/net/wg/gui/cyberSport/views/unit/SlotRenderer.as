package net.wg.gui.cyberSport.views.unit
{
    import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
    import flash.text.TextField;
    import net.wg.gui.rally.vo.RallySlotVO;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    
    public class SlotRenderer extends RallyLockableSlotRenderer
    {
        
        public function SlotRenderer()
        {
            super();
        }
        
        public var ratingTF:TextField;
        
        public var levelLbl:TextField;
        
        public function get unitSlotData() : RallySlotVO
        {
            return slotData as RallySlotVO;
        }
        
        override protected function onRemoveClick(param1:ButtonEvent) : void
        {
            if(this.unitSlotData)
            {
                if(this.unitSlotData.player)
                {
                    super.onRemoveClick(param1);
                }
                else if(index > 4)
                {
                    dispatchEvent(new CSComponentEvent(CSComponentEvent.LOCK_SLOT_REQUEST,index));
                }
                
            }
        }
        
        override protected function onDispose() : void
        {
            this.ratingTF = null;
            this.levelLbl = null;
            super.onDispose();
        }
    }
}
