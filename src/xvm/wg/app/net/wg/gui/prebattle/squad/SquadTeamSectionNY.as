package net.wg.gui.prebattle.squad
{
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    
    public class SquadTeamSectionNY extends SquadTeamSection
    {
        
        public function SquadTeamSectionNY()
        {
            super();
        }
        
        public var slot3:IRallySimpleSlotRenderer;
        
        public var slot4:IRallySimpleSlotRenderer;
        
        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[slot0,slot1,slot2,this.slot3,this.slot4];
            var _loc3_:ISlotRendererHelper = new SquadSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }
    }
}
