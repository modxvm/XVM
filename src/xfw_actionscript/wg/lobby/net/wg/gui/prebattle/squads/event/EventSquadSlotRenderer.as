package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotRenderer;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;

    public class EventSquadSlotRenderer extends SimpleSquadSlotRenderer
    {

        private var _toolTipMgr:ITooltipMgr;

        public function EventSquadSlotRenderer()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            contextMenuArea.addEventListener(MouseEvent.ROLL_OVER,this.onRendererRollOverHandler);
            contextMenuArea.addEventListener(MouseEvent.ROLL_OUT,this.onRendererRollOutHandler);
        }

        override protected function onDispose() : void
        {
            contextMenuArea.removeEventListener(MouseEvent.ROLL_OVER,this.onRendererRollOverHandler);
            contextMenuArea.removeEventListener(MouseEvent.ROLL_OUT,this.onRendererRollOutHandler);
            this._toolTipMgr = null;
            super.onDispose();
        }

        private function onRendererRollOverHandler(param1:MouseEvent) : void
        {
            if(slotData && slotData.player)
            {
                this._toolTipMgr.showComplex(slotData.player.eventTooltip);
            }
        }

        private function onRendererRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
