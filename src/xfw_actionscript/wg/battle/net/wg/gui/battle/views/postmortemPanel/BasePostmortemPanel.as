package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import flash.text.TextField;

    public class BasePostmortemPanel extends BattleDisplayable
    {

        private static const EMPTY_STR:String = "";

        private static const INVALID_PLAYER_INFO:uint = 1 << 7;

        private static const INVALID_VEHICLE_PANEL:uint = 1 << 8;

        private static const INVALID_PLAYER_INFO_POSITION:uint = 1 << 9;

        private static const INVALID_DEAD_REASON_VISIBILITY:uint = 1 << 10;

        public static const VEHICLE_PANEL_OFFSET_Y:int = 120;

        protected static const PLAYER_INFO_DELTA_Y:int = 250;

        protected static const GAP_VEHICLE_PANEL_DEAD_REASON:int = 20;

        public var playerInfoTF:TextField = null;

        public var deadReasonTF:TextField = null;

        public var vehiclePanel:VehiclePanel = null;

        private var _deadReason:String = "";

        private var _playerInfo:String = "";

        private var _showVehiclePanel:Boolean = true;

        private var _vehicleLevel:String = "";

        private var _vehicleImg:String = "";

        private var _vehicleType:String = "";

        private var _vehicleName:String = "";

        public function BasePostmortemPanel()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_DEAD_REASON_VISIBILITY))
            {
                this.playerInfoTF.visible = false;
                this.deadReasonTF.visible = true;
                this.vehiclePanel.visible = this._showVehiclePanel;
            }
            if(isInvalid(INVALID_PLAYER_INFO))
            {
                this.playerInfoTF.visible = true;
                this.deadReasonTF.visible = false;
                this.vehiclePanel.visible = false;
                if(this._playerInfo != this.playerInfoTF.htmlText)
                {
                    this.playerInfoTF.htmlText = this._playerInfo;
                }
            }
            if(isInvalid(INVALID_VEHICLE_PANEL))
            {
                this.playerInfoTF.visible = false;
                this.deadReasonTF.visible = true;
                if(this._deadReason != this.deadReasonTF.htmlText)
                {
                    this.deadReasonTF.htmlText = this._deadReason;
                }
                this.vehiclePanel.visible = this._showVehiclePanel;
                if(this._showVehiclePanel)
                {
                    this.vehiclePanel.setVehicleData(this._vehicleLevel,this._vehicleImg,this._vehicleType,this._vehicleName);
                }
            }
            if(isInvalid(INVALID_PLAYER_INFO_POSITION))
            {
                this.updatePlayerInfoPosition();
            }
        }

        override protected function onDispose() : void
        {
            this.playerInfoTF = null;
            this.deadReasonTF = null;
            this.vehiclePanel.dispose();
            this.vehiclePanel = null;
            super.onDispose();
        }

        public function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String) : void
        {
            this._deadReason = param1;
            this._showVehiclePanel = param2;
            this._vehicleLevel = param3;
            this._vehicleImg = param4;
            this._vehicleName = param6;
            this._vehicleType = param5;
            invalidate(INVALID_VEHICLE_PANEL);
        }

        public function setPlayerInfo(param1:String) : void
        {
            this._playerInfo = param1;
            invalidate(INVALID_PLAYER_INFO);
        }

        public function showDeadReason() : void
        {
            invalidate(INVALID_DEAD_REASON_VISIBILITY);
        }

        public function updateElementsPosition() : void
        {
            invalidate(INVALID_PLAYER_INFO_POSITION);
        }

        protected function updatePlayerInfoPosition() : void
        {
            this.playerInfoTF.y = -PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
            this.vehiclePanel.y = -(App.appHeight >> 1) + VEHICLE_PANEL_OFFSET_Y;
            this.deadReasonTF.y = this.vehiclePanel.y - GAP_VEHICLE_PANEL_DEAD_REASON - this.deadReasonTF.height;
        }

        protected function setComponentsVisibility(param1:Boolean) : void
        {
            this.playerInfoTF.visible = param1;
            this.vehiclePanel.visible = param1;
            this.deadReasonTF.visible = param1;
        }
    }
}
