package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;

    public class VehicleStateMsg extends UIComponentEx
    {

        private static const ELITE_TYPE_GAP:int = -2;

        private static const COMMON_TYPE_GAP:int = -12;

        private static const TEXT_PADDING:int = 6;

        private static const BG_OFFSET:int = 3;

        public var tankTypeIcon:TankTypeIco;

        public var vehicleLevel:TextField = null;

        public var vehicleName:TextField = null;

        public var vehicleMsg:TextField = null;

        public var statusBg:Sprite = null;

        private var _data:VehicleMessageVO = null;

        public function VehicleStateMsg()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = mouseEnabled = false;
            this.tankTypeIcon.mouseEnabled = this.tankTypeIcon.mouseChildren = false;
        }

        override protected function onDispose() : void
        {
            this.vehicleName = null;
            this.vehicleMsg = null;
            this._data = null;
            this.tankTypeIcon.dispose();
            this.tankTypeIcon = null;
            this.statusBg = null;
            this.vehicleLevel = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(this._data)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.vehicleMsg.htmlText = this._data.message;
                    this.vehicleLevel.text = this._data.vehicleLevel;
                    this.vehicleName.text = this._data.vehicleName;
                    this.tankTypeIcon.type = this._data.tankType;
                    this.tankTypeIcon.validateNow();
                    this.statusBg.visible = this.vehicleMsg.visible = this._data.message.length > 0;
                    invalidateSize();
                }
                if(isInvalid(InvalidationType.SIZE))
                {
                    this.vehicleLevel.x = 0;
                    this.vehicleName.width = this.vehicleName.textWidth + TEXT_PADDING;
                    this.vehicleLevel.width = this.vehicleLevel.textWidth + TEXT_PADDING;
                    this.vehicleMsg.width = this.vehicleMsg.textWidth + TEXT_PADDING;
                    this.vehicleMsg.height = this.vehicleMsg.textHeight + TEXT_PADDING;
                    _loc1_ = this._data.isElite?ELITE_TYPE_GAP:COMMON_TYPE_GAP;
                    this.tankTypeIcon.x = this.vehicleLevel.x + this.vehicleLevel.width + this.tankTypeIcon.width + _loc1_ ^ 0;
                    this.vehicleName.x = this.tankTypeIcon.x + this.tankTypeIcon.width + _loc1_ ^ 0;
                    _loc2_ = this.vehicleName.x + this.vehicleName.width >> 1;
                    this.vehicleLevel.x = this.vehicleLevel.x - _loc2_;
                    this.tankTypeIcon.x = this.tankTypeIcon.x - _loc2_;
                    this.vehicleName.x = this.vehicleName.x - _loc2_;
                    this.vehicleMsg.x = -this.vehicleMsg.width >> 1;
                    this.statusBg.x = this.vehicleMsg.x + (this.vehicleMsg.width >> 1);
                    this.statusBg.y = this.vehicleMsg.y + (this.vehicleMsg.height >> 1) + BG_OFFSET;
                    dispatchEvent(new AmmunitionPanelEvents(AmmunitionPanelEvents.VEHICLE_STATE_MSG_RESIZE));
                }
            }
        }

        public function setVehicleStatus(param1:VehicleMessageVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function updateStage(param1:int, param2:int) : void
        {
            invalidateSize();
        }

        override public function get height() : Number
        {
            return this.vehicleMsg.visible?this.vehicleMsg.y + this.vehicleMsg.height:this.vehicleName.height;
        }

        public function get textX() : Number
        {
            return this.x + this.vehicleMsg.x + this.vehicleMsg.textWidth;
        }

        public function get textY() : Number
        {
            return this.y + this.vehicleMsg.y;
        }
    }
}
