package net.wg.gui.bootcamp.messageWindow.controls
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class MessageItemRendererReward extends MessageItemRendererBase
    {

        public var iconLoader:UILoaderAlt;

        public function MessageItemRendererReward()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }

        override protected function updateData() : void
        {
            super.updateData();
            this.iconLoader.source = data.icon;
        }

        override protected function onDispose() : void
        {
            this.iconLoader.dispose();
            this.iconLoader = null;
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            super.onDispose();
        }

        private function onMouseOverHandler(param1:Event) : void
        {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BOOTCAMP_AWARD_MEDAL,null,data.labelTooltip,data.description,data.iconTooltip);
        }

        private function onMouseOutHandler(param1:Event) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
