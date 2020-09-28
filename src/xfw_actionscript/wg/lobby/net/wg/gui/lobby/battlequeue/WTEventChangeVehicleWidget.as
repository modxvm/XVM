package net.wg.gui.lobby.battlequeue
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.text.TextField;
    import flash.display.Sprite;

    public class WTEventChangeVehicleWidget extends MovieClip implements IDisposable
    {

        private static const TICKET_X_OFFSET:int = 5;

        private static const TIMER_ICON_OFFSET:int = -10;

        private static const BONUS_GLOW_BORDER:int = 16;

        public var changeBtn:ISoundButtonEx;

        public var changeDescription:TextField;

        public var changeText:TextField;

        public var timeValue:TextField;

        public var timeText:TextField;

        public var timeIcon:Sprite;

        public var ticketIcon:Sprite;

        public var widgetHitArea:Sprite;

        public var mcCorner:Sprite;

        private var _vehicleName:String = "";

        public function WTEventChangeVehicleWidget()
        {
            super();
            this.hitArea = this.widgetHitArea;
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setData(param1:WTEventChangeVehicleWidgetVO) : void
        {
            if(this._vehicleName != param1.vehicleName)
            {
                this._vehicleName = param1.vehicleName;
                this.changeText.htmlText = param1.changeTitle;
                this.changeBtn.label = param1.btnLabel;
                this.timeText.htmlText = param1.calculatedText;
                App.utils.commons.updateTextFieldSize(this.timeText,true,true);
                this.changeDescription.htmlText = param1.ticketText;
                App.utils.commons.updateTextFieldSize(this.changeDescription,true,true);
            }
            this.changeDescription.visible = this.ticketIcon.visible = param1.needTicket && !param1.isBoss;
            this.mcCorner.visible = !param1.isBoss && !param1.needTicket;
            this.timeValue.htmlText = param1.waitingTime;
            App.utils.commons.updateTextFieldSize(this.timeValue,true,true);
            this.updateLayout();
        }

        protected function onDispose() : void
        {
            this.changeDescription = null;
            this.changeText = null;
            this.timeValue = null;
            this.timeText = null;
            this.changeBtn.dispose();
            this.changeBtn = null;
            this.timeIcon = null;
            this.ticketIcon = null;
            this.mcCorner = null;
        }

        private function updateLayout() : void
        {
            this.timeText.x = width - BONUS_GLOW_BORDER - this.timeText.width - this.timeIcon.width - this.timeValue.width - 2 * TIMER_ICON_OFFSET >> 1;
            this.timeIcon.x = this.timeText.x + this.timeText.width + TIMER_ICON_OFFSET >> 0;
            this.timeValue.x = this.timeIcon.x + this.timeIcon.width + TIMER_ICON_OFFSET >> 0;
            this.changeDescription.x = width - BONUS_GLOW_BORDER - this.changeDescription.width - this.ticketIcon.width - TICKET_X_OFFSET >> 1;
            this.ticketIcon.x = this.changeDescription.x + this.changeDescription.width + TICKET_X_OFFSET >> 0;
        }

        override public function get height() : Number
        {
            return this.widgetHitArea.height;
        }
    }
}
