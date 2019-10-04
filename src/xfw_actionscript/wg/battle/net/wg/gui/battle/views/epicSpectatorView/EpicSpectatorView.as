package net.wg.gui.battle.views.epicSpectatorView
{
    import net.wg.infrastructure.base.meta.impl.EpicSpectatorViewMeta;
    import net.wg.infrastructure.base.meta.IEpicSpectatorViewMeta;
    import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.InvalidationType;
    import net.wg.data.constants.generated.EPIC_CONSTS;

    public class EpicSpectatorView extends EpicSpectatorViewMeta implements IEpicSpectatorViewMeta, IPostmortemPanelMeta
    {

        private static const LEFT_POSTMORTEM_PANE_OVERLAY_OFFSET:int = 24;

        private static const FOLLOW_LABEL_MOUSE_HINT_OFFSET:int = -20;

        private static const FOLLOW_LABEL_HEIGHT_POSITION_RATIO:Number = 0.7;

        private static const DAMAGE_PANEL_OVERLAY_START_FRAME:int = 2;

        public var damagePanelOverlay:MovieClip = null;

        public var postmortemPanelOverlay:MovieClip = null;

        public var followLabel:MovieClip = null;

        private var _stageHeight:int = 0;

        private var _stageWidth:int = 0;

        private var _mode:int = -1;

        public function EpicSpectatorView()
        {
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.damagePanelOverlay.cameraControlsTitleTF.text = EPIC_BATTLE.SPECTATOR_MODE_CAMERA_CONTROLS_TITLE;
            this.damagePanelOverlay.cameraWasdTF.text = EPIC_BATTLE.SPECTATOR_MODE_CAMERA_WASD;
            this.damagePanelOverlay.cameraMouseTF.text = EPIC_BATTLE.SPECTATOR_MODE_CAMERA_MOUSE_ROTATE;
            this.postmortemPanelOverlay.msgTitleTF.text = EPIC_BATTLE.SPECTATOR_MODE_MSG_TEXT;
            this.followLabel.visible = false;
            var _loc1_:TextField = this.followLabel.mouseFollowHint.textField;
            _loc1_.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function onDispose() : void
        {
            this.damagePanelOverlay.stop();
            this.damagePanelOverlay = null;
            this.postmortemPanelOverlay = null;
            this.followLabel = null;
            super.onDispose();
        }

        override protected function updatePlayerInfoPosition() : void
        {
            playerInfoTF.x = this._stageWidth - playerInfoTF.width >> 1;
            playerInfoTF.y = (this._stageHeight >> 1) - PLAYER_INFO_DELTA_Y;
            vehiclePanel.x = this._stageWidth - vehiclePanel.width >> 1;
            vehiclePanel.y = (this._stageHeight >> 1) + VEHICLE_PANEL_OFFSET_Y;
            deadReasonTF.x = this._stageWidth - deadReasonTF.width >> 1;
            deadReasonTF.y = (this._stageHeight >> 1) + VEHICLE_PANEL_OFFSET_Y - GAP_VEHICLE_PANEL_DEAD_REASON - deadReasonTF.height;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.followLabel.visible = false;
                this.damagePanelOverlay.visible = this._mode == EPIC_CONSTS.SPECTATOR_MODE_FREECAM;
                this.postmortemPanelOverlay.visible = this._mode != EPIC_CONSTS.SPECTATOR_MODE_DEATHCAM;
                if(this._mode == EPIC_CONSTS.SPECTATOR_MODE_FREECAM)
                {
                    setComponentsVisibility(false);
                    this.damagePanelOverlay.gotoAndPlay(DAMAGE_PANEL_OVERLAY_START_FRAME);
                }
            }
        }

        public function as_changeMode(param1:int) : void
        {
            if(EPIC_CONSTS.SPECTATOR_VIEW_STATES.indexOf(param1) != -1)
            {
                this._mode = param1;
                invalidateData();
            }
        }

        public function as_focusOnVehicle(param1:Boolean) : void
        {
            if(this._mode == EPIC_CONSTS.SPECTATOR_MODE_FREECAM)
            {
                this.followLabel.visible = param1;
            }
        }

        public function as_setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String) : void
        {
            setDeadReasonInfo(param1,param2,param3,param4,param5,param6);
        }

        public function as_setFollowInfoText(param1:String) : void
        {
            this.followLabel.mouseFollowHint.textField.text = param1;
            this.followLabel.mouseFollowHint.x = FOLLOW_LABEL_MOUSE_HINT_OFFSET - this.followLabel.mouseFollowHint.width >> 1;
        }

        public function as_setPlayerInfo(param1:String) : void
        {
            setPlayerInfo(param1);
        }

        public function as_setTimer(param1:String) : void
        {
            this.postmortemPanelOverlay.TimerTF.text = param1;
        }

        public function as_showDeadReason() : void
        {
            showDeadReason();
        }

        public function updateStage(param1:int, param2:int) : void
        {
            this.damagePanelOverlay.x = 0;
            this.damagePanelOverlay.y = param2;
            this.postmortemPanelOverlay.x = (param1 >> 1) - LEFT_POSTMORTEM_PANE_OVERLAY_OFFSET;
            this.postmortemPanelOverlay.y = param2;
            this.followLabel.x = param1 >> 1;
            this.followLabel.y = param2 * FOLLOW_LABEL_HEIGHT_POSITION_RATIO >> 0;
            this._stageHeight = param2;
            this._stageWidth = param1;
            this.updatePlayerInfoPosition();
        }
    }
}
