package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Directions;

    public class VehicleStateMsg extends UIComponentEx
    {

        private static const ELITE_TYPE_GAP:int = -2;

        private static const COMMON_TYPE_GAP:int = -12;

        private static const TEXT_PADDING:int = 6;

        private static const BG_OFFSET:int = 3;

        private static const HELP_LAYOUT_ID_DELIMITER:String = "_";

        private static const HELP_LAYOUT_WIDTH:int = 280;

        private static const HELP_LAYOUT_HEIGHT:int = 65;

        private static const HELP_LAYOUT_HEIGHT_NO_BG:int = 47;

        private static const HELP_LAYOUT_NO_BG_OFFSET_Y:int = -63;

        private static const HELP_LAYOUT_OFFSET_Y:int = -5;

        public var tankTypeIcon:TankTypeIco;

        public var vehicleLevel:TextField = null;

        public var vehicleName:TextField = null;

        public var vehicleMsg:TextField = null;

        public var statusBg:Sprite = null;

        private var _data:VehicleMessageVO = null;

        private var _hitArea:Sprite = null;

        private var _vehicleStateHelpLayoutId:String = "";

        public function VehicleStateMsg()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.tankTypeIcon.mouseEnabled = this.tankTypeIcon.mouseChildren = false;
            this._hitArea = new Sprite();
            addChild(this._hitArea);
            this.statusBg.hitArea = this._hitArea;
            this.vehicleMsg.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleMsgRollOverHandler);
            this.vehicleMsg.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleMsgRollOutHandler);
        }

        override protected function onDispose() : void
        {
            this.vehicleMsg.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleMsgRollOverHandler);
            this.vehicleMsg.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleMsgRollOutHandler);
            this.vehicleMsg = null;
            this.tankTypeIcon.dispose();
            this.tankTypeIcon = null;
            this.vehicleName = null;
            this._hitArea = null;
            this.statusBg.hitArea = null;
            this.statusBg = null;
            this.vehicleLevel = null;
            this._data = null;
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

        public function get textX() : int
        {
            return this.x + this.vehicleMsg.x + this.vehicleMsg.textWidth;
        }

        public function get textY() : int
        {
            return this.y + this.vehicleMsg.y;
        }

        private function onVehicleMsgRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data.actionGroupId > 0)
            {
                App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.RANKED_BATTLES_ROLES,this._data.actionGroupId);
            }
        }

        private function onVehicleMsgRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        public function createHelpLayoutData() : HelpLayoutVO
        {
            if(StringUtils.isEmpty(this._vehicleStateHelpLayoutId))
            {
                this._vehicleStateHelpLayoutId = name + HELP_LAYOUT_ID_DELIMITER + Math.random();
            }
            var _loc1_:Boolean = this.statusBg.visible;
            var _loc2_:HelpLayoutVO = new HelpLayoutVO();
            _loc2_.x = -HELP_LAYOUT_WIDTH >> 1;
            _loc2_.y = y + _loc1_?HELP_LAYOUT_OFFSET_Y:HELP_LAYOUT_NO_BG_OFFSET_Y;
            _loc2_.width = HELP_LAYOUT_WIDTH;
            _loc2_.height = _loc1_?HELP_LAYOUT_HEIGHT:HELP_LAYOUT_HEIGHT_NO_BG;
            _loc2_.extensibilityDirection = Directions.RIGHT;
            _loc2_.message = LOBBY_HELP.HANGAR_HEADER_VEHICLE;
            _loc2_.id = this._vehicleStateHelpLayoutId;
            _loc2_.scope = this;
            return _loc2_;
        }
    }
}
