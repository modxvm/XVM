package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.prebattle.squads.event.vo.EventSlotVO;

    public class EventSquadTeamSection extends SimpleSquadTeamSection
    {

        public var slot3:IRallySimpleSlotRenderer;

        public var slot4:IRallySimpleSlotRenderer;

        public var headerInfoIcon:Sprite = null;

        public function EventSquadTeamSection()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.headerInfoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onHeaderInfoIconRollOverHandler);
            this.headerInfoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onHeaderInfoIconRollOutHandler);
            this.headerInfoIcon.useHandCursor = true;
        }

        override protected function showBonuses() : Boolean
        {
            return false;
        }

        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[slot0,slot1,slot2,this.slot3,this.slot4];
            var _loc3_:ISlotRendererHelper = new EventSquadSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }

        override protected function onBeforeDispose() : void
        {
            this.headerInfoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onHeaderInfoIconRollOverHandler);
            this.headerInfoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onHeaderInfoIconRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.slot3 = null;
            this.slot4 = null;
            this.headerInfoIcon = null;
            super.onDispose();
        }

        private function onHeaderInfoIconRollOverHandler(param1:MouseEvent) : void
        {
            _tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.EVENT_SQUAD_INFO,null);
        }

        private function onHeaderInfoIconRollOutHandler(param1:MouseEvent) : void
        {
            _tooltipMgr.hide();
        }

        override protected function getSlotVO(param1:Object) : IRallySlotVO
        {
            return new EventSlotVO(param1);
        }
    }
}
