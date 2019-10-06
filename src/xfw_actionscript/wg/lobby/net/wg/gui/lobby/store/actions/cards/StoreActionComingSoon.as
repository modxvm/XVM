package net.wg.gui.lobby.store.actions.cards
{
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import flash.text.TextFormatAlign;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;

    public class StoreActionComingSoon extends StoreActionCardAbstract
    {

        private static const TIME_LEFT_WITHOUT_ICO_X_CORRECT:Number = -20;

        private static const TITLE_AVAILABLE_WIDTH:Number = 230;

        private var _tooltip:String = "";

        public function StoreActionComingSoon()
        {
            super();
        }

        override protected function updateData(param1:StoreActionCardVo) : void
        {
            super.updateData(param1);
            title.setTextAlign(TextFormatAlign.RIGHT);
            title.setAvailableWidth(TITLE_AVAILABLE_WIDTH);
            title.setText(param1.title);
            header.setText(param1.header);
            if(header.headerText != param1.header)
            {
                this._tooltip = App.toolTipMgr.getNewFormatter().addBody(param1.header).make();
                this.addListeners();
            }
        }

        override protected function onDispose() : void
        {
            this.removeListeners();
            super.onDispose();
        }

        override protected function setTime(param1:StoreActionTimeVo) : void
        {
            super.setTime(param1);
            if(!param1.isShowTimeIco)
            {
                timeLeft.x = header.x + TIME_LEFT_WITHOUT_ICO_X_CORRECT;
            }
        }

        private function addListeners() : void
        {
            this.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
        }

        private function removeListeners() : void
        {
            this.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
        }

        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            if(this._tooltip != Values.EMPTY_STR)
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }
    }
}
