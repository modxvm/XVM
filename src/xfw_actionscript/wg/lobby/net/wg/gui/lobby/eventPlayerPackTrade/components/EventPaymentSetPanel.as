package net.wg.gui.lobby.eventPlayerPackTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventItemsTrade.events.PaymentPanelEvent;

    public class EventPaymentSetPanel extends Sprite implements IDisposable
    {

        private static const TEXT_OFFSET:int = 5;

        private static const LINE_OFFSET:int = 2;

        public var line:Sprite = null;

        public var oldPriceTF:TextField = null;

        public var newPriceTF:TextField = null;

        public var percentTF:TextField = null;

        public var buyBtn:UniversalBtn = null;

        public function EventPaymentSetPanel()
        {
            super();
        }

        public function configUI() : void
        {
            App.utils.universalBtnStyles.setStyle(this.buyBtn,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.buyBtn.mouseEnabledOnDisabled = true;
        }

        public final function dispose() : void
        {
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.line = null;
            this.oldPriceTF = null;
            this.newPriceTF = null;
            this.percentTF = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
        }

        public function layoutElements() : void
        {
            this.oldPriceTF.x = this.newPriceTF.x - this.oldPriceTF.textWidth - TEXT_OFFSET;
            this.line.x = this.oldPriceTF.x + this.oldPriceTF.width - this.oldPriceTF.textWidth - LINE_OFFSET;
            this.line.width = this.oldPriceTF.textWidth;
        }

        public function setData(param1:int, param2:int, param3:int) : void
        {
            this.oldPriceTF.text = App.utils.locale.integer(param1);
            this.newPriceTF.text = App.utils.locale.integer(param2);
            this.percentTF.text = param3.toString();
        }

        public function set btnLabel(param1:String) : void
        {
            this.buyBtn.label = param1;
        }

        public function set btnEnabled(param1:Boolean) : void
        {
            this.buyBtn.enabled = param1;
        }

        public function set btnTooltip(param1:String) : void
        {
            this.buyBtn.tooltip = param1;
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new PaymentPanelEvent(PaymentPanelEvent.PAYMENT_PANEL_BUTTON_CLICK));
        }
    }
}
