package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;

    public class VehicleStateMsg extends UIComponentEx
    {

        private static const BACKGROUND_OFFSET:int = 15;

        public var vehicleMsg:TextField = null;

        public var msgBackground:Sprite = null;

        private var _offset:int = 0;

        private var _basePosition:int = 0;

        private var _textPosition:Number = 0;

        private var _data:VehicleMessageVO = null;

        public function VehicleStateMsg()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = mouseEnabled = false;
            this.msgBackground.visible = false;
            this._basePosition = this.vehicleMsg.y;
        }

        override protected function onDispose() : void
        {
            this.vehicleMsg = null;
            this.msgBackground = null;
            this._data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.msgBackground.visible = this._data.isBackground;
                this.vehicleMsg.htmlText = this._data.message;
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                if(this.msgBackground.visible)
                {
                    this.vehicleMsg.y = this._offset;
                    this.msgBackground.y = this.vehicleMsg.y + BACKGROUND_OFFSET;
                }
                else
                {
                    this.vehicleMsg.y = this._basePosition;
                }
                this.vehicleMsg.width = this.vehicleMsg.textWidth;
                this.vehicleMsg.x = width - this.vehicleMsg.width >> 1;
                this._textPosition = this.vehicleMsg.x + this.vehicleMsg.width;
                dispatchEvent(new AmmunitionPanelEvents(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE));
            }
        }

        public function setVehicleStatus(param1:VehicleMessageVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function updateStage(param1:int, param2:int) : void
        {
            this._offset = (param2 >> 2) * -1;
            invalidateSize();
        }

        public function get textX() : Number
        {
            return this._textPosition;
        }

        public function get textY() : Number
        {
            return this.y + this.vehicleMsg.y;
        }
    }
}
