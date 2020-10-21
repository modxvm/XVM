package net.wg.gui.lobby.eventItemsTrade.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.NumericStepper;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventItemsTrade.events.PaymentPanelEvent;

    public class EventPaymentPanel extends MovieClip implements IDisposable
    {

        private static const EVENT_COLOR:int = 13282557;

        private static const EVENT_COLOR_ERROR:int = 16721687;

        public var valueTF:TextField = null;

        public var count:NumericStepper;

        public var buyBtn:ISoundButtonEx = null;

        public var descriptionTF:TextField = null;

        public var countTF:TextField = null;

        private var _count:int = 0;

        private var _value:int = 0;

        private var _valueMax:int = 0;

        private var _valueCurrent:int = 0;

        public function EventPaymentPanel()
        {
            super();
        }

        public function configUI() : void
        {
            this.count.addEventListener(IndexEvent.INDEX_CHANGE,this.onCountIndexChangeHandler,false,0,true);
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
        }

        public final function dispose() : void
        {
            this.count.removeEventListener(IndexEvent.INDEX_CHANGE,this.onCountIndexChangeHandler);
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.valueTF = null;
            this.count.dispose();
            this.count = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
            this.descriptionTF = null;
            this.countTF = null;
        }

        public function setData(param1:int, param2:int, param3:String, param4:int) : void
        {
            this._value = this._valueCurrent = param1;
            this._valueMax = param2;
            this.valueTF.text = param1.toString();
            this.descriptionTF.text = param3;
            this.countTF.text = param4.toString();
            if(param4 > 0)
            {
                this.countTF.visible = true;
                this.count.minimum = 1;
                this.count.maximum = param4;
            }
            else
            {
                this.countTF.visible = false;
                this.count.minimum = 0;
                this.count.maximum = 0;
            }
            this.checkValue();
        }

        public function set btnLabel(param1:String) : void
        {
            this.buyBtn.label = param1;
        }

        public function set btnTooltip(param1:String) : void
        {
            this.buyBtn.tooltip = param1;
        }

        private function checkValue() : void
        {
            if(this._valueCurrent <= this._valueMax)
            {
                this.buyBtn.enabled = true;
                this.valueTF.textColor = EVENT_COLOR;
            }
            else
            {
                this.buyBtn.enabled = false;
                this.valueTF.textColor = EVENT_COLOR_ERROR;
            }
            if(this.count.maximum == 0)
            {
                this.buyBtn.enabled = false;
                this.buyBtn.mouseEnabledOnDisabled = true;
            }
            this.valueTF.text = this._valueCurrent.toString();
            var _loc1_:int = this._valueMax / this._value;
            if(this.count.maximum > _loc1_)
            {
                this.count.maximum = _loc1_;
            }
        }

        public function updateTokens(param1:int) : void
        {
            this._valueMax = param1;
            this.checkValue();
        }

        private function onCountIndexChangeHandler(param1:IndexEvent) : void
        {
            this._valueCurrent = this.count.value * this._value;
            this.checkValue();
            this._count = this.count.value;
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new PaymentPanelEvent(PaymentPanelEvent.PAYMENT_PANEL_BUTTON_CLICK,this._count));
        }
    }
}
