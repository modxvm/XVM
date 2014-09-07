package net.wg.gui.rally.controls
{
    import net.wg.gui.cyberSport.controls.GrayTransparentButton;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class RallySlotRenderer extends VoiceRallySlotRenderer
    {
        
        public function RallySlotRenderer()
        {
            super();
        }
        
        public var removeBtn:GrayTransparentButton;
        
        override public function cooldown(param1:Boolean) : void
        {
            super.cooldown(param1);
            this.removeBtn.enabled = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            slotLabel.doubleClickEnabled = true;
            if(this.removeBtn)
            {
                this.removeBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveClick);
                this.removeBtn.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                this.removeBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            statusIndicator.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            statusIndicator.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            if(commander)
            {
                commander.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            vehicleBtn.addEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
        }
        
        override protected function onDispose() : void
        {
            if(this.removeBtn)
            {
                this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveClick);
                this.removeBtn.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                this.removeBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
                this.removeBtn.dispose();
                this.removeBtn = null;
            }
            vehicleBtn.removeEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
            statusIndicator.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            statusIndicator.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            if(commander)
            {
                commander.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            super.onDispose();
        }
        
        protected function onRemoveClick(param1:ButtonEvent) : void
        {
            if((slotData) && (slotData.player))
            {
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LEAVE_SLOT_REQUEST,slotData.player.dbID));
            }
        }
        
        protected function onChooseVehicleClick(param1:RallyViewsEvent) : void
        {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            if((slotData) && (slotData.player) && (slotData.player.himself))
            {
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.CHOOSE_VEHICLE,slotData.player.dbID));
            }
        }
    }
}
