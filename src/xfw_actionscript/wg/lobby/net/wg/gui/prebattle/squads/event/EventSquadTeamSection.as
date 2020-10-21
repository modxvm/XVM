package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotHelper;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;

    public class EventSquadTeamSection extends SimpleSquadTeamSection
    {

        public var slot3:IRallySimpleSlotRenderer;

        public var slot4:IRallySimpleSlotRenderer;

        public function EventSquadTeamSection()
        {
            super();
        }

        override protected function showBonuses() : Boolean
        {
            return false;
        }

        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[slot0,slot1,slot2,this.slot3,this.slot4];
            var _loc3_:ISlotRendererHelper = new SimpleSquadSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }

        override protected function onDispose() : void
        {
            this.slot3 = null;
            this.slot4 = null;
            super.onDispose();
        }
    }
}
