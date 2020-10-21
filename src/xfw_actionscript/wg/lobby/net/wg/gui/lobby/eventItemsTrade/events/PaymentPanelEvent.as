package net.wg.gui.lobby.eventItemsTrade.events
{
    import flash.events.Event;

    public class PaymentPanelEvent extends Event
    {

        public static const PAYMENT_PANEL_BUTTON_CLICK:String = "paymentPanelButtonClick";

        private var _count:int = 0;

        public function PaymentPanelEvent(param1:String, param2:int = 0)
        {
            super(param1,true,false);
            this._count = param2;
        }

        override public function clone() : Event
        {
            return new PaymentPanelEvent(type,this._count);
        }

        public function get count() : int
        {
            return this._count;
        }
    }
}
