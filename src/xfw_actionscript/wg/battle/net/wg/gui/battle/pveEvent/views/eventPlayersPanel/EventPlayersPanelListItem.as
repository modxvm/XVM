package net.wg.gui.battle.pveEvent.views.eventPlayersPanel
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.eventcomponents.NumberProgress;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.battle.pveEvent.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventPlayersPanelListItem extends BattleUIComponent
    {

        private static const SUFFIX_SQUAD:String = "_Squad";

        private static const NAME_COLOR_GREY:int = 1;

        private static const NAME_COLOR_SQUAD:int = 2;

        private static const NAME_COLOR_BLACK:int = 3;

        private static const VEHICLE_ENABLE:int = 1;

        private static const VEHICLE_DISABLE:int = 2;

        private static const ICON_MARGIN:uint = 23;

        private static const PLAYER_XPOS:uint = 22;

        private static const NAME_SPACE:uint = 120;

        private static const BADGE_GAP:int = 2;

        public var lifeBg:NumberProgress = null;

        public var namePlayer:NumberProgress = null;

        public var typeVehicle:MovieClip = null;

        public var nameVehicleTF:TextField = null;

        public var healthBar:EventHealthBar = null;

        public var squadIcon:BattleAtlasSprite = null;

        public var testerIcon:BattleAtlasSprite = null;

        public var badge:BadgeComponent = null;

        private var _namePlayer:String = "";

        private var _countLives:uint = 0;

        private var _isSquad:Boolean = false;

        private var _vehID:uint = 0;

        private var _playerNameSpace:int = 0;

        private var _isEnabled:Boolean = true;

        public function EventPlayersPanelListItem()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.squadIcon.visible = false;
        }

        override protected function onDispose() : void
        {
            this.lifeBg.dispose();
            this.lifeBg = null;
            this.namePlayer.dispose();
            this.namePlayer = null;
            this.typeVehicle = null;
            this.nameVehicleTF = null;
            this.healthBar.dispose();
            this.healthBar = null;
            this.squadIcon = null;
            this.badge.dispose();
            this.badge = null;
            this.testerIcon = null;
            super.onDispose();
        }

        public function setCountLives(param1:uint) : void
        {
            this._countLives = param1;
            this.lifeBg.setColor(VEHICLE_ENABLE);
            this.lifeBg.setValue(param1.toString());
            this.nameVehicleTF.visible = this.typeVehicle.visible = param1 > 0;
            if(!this._isEnabled && param1 == 0)
            {
                this.setEnable(false);
            }
        }

        public function setHp(param1:int, param2:int) : void
        {
            var _loc3_:Number = this.healthBar.getHpMaskWidth();
            this.healthBar.gotoAndStop(this.healthBar.totalFrames * (1 - param2 / param1));
            if(_baseDisposed)
            {
                return;
            }
            var _loc4_:Number = this.healthBar.getHpMaskWidth();
            _loc3_ = _loc3_ == 1?_loc4_:_loc3_;
            this.healthBar.playFx(_loc3_,_loc4_);
            if(!this._isEnabled && param2 > 0)
            {
                this.setEnable(true);
            }
        }

        public function setData(param1:DAAPIPlayerPanelInfoVO) : void
        {
            this._namePlayer = param1.name;
            this._isSquad = param1.isSquad;
            this._vehID = param1.vehID;
            this._countLives = param1.countLives;
            this.namePlayer.setColor(this._isSquad?NAME_COLOR_SQUAD:NAME_COLOR_GREY);
            this.nameVehicleTF.text = param1.nameVehicle;
            var _loc2_:String = param1.typeVehicle;
            if(this._isSquad)
            {
                _loc2_ = _loc2_ + SUFFIX_SQUAD;
            }
            this.typeVehicle.gotoAndStop(_loc2_);
            if(_baseDisposed)
            {
                return;
            }
            this.nameVehicleTF.visible = this.typeVehicle.visible = this._countLives > 0;
            this.setHp(param1.hpMax,param1.hpCurrent);
            this.setCountLives(this._countLives);
            if(param1.hpCurrent == 0)
            {
                this.setEnable(false);
            }
            this.healthBar.setSquadState(this._isSquad);
            if(_baseDisposed)
            {
                return;
            }
            var _loc3_:int = param1.squadIndex;
            if(_loc3_ > 0)
            {
                this.squadIcon.visible = true;
                if(this._isSquad)
                {
                    this.squadIcon.imageName = BATTLEATLAS.squad_event_gold(_loc3_.toString());
                }
                else
                {
                    this.squadIcon.imageName = BATTLEATLAS.squad_event_silver(_loc3_.toString());
                }
            }
            this._playerNameSpace = NAME_SPACE;
            var _loc4_:BadgeVisualVO = param1.badgeVisualVO;
            if(_loc4_)
            {
                this.badge.visible = true;
                this.badge.setData(_loc4_);
                this.namePlayer.x = this.badge.x + ICON_MARGIN;
                this._playerNameSpace = this._playerNameSpace - ICON_MARGIN;
            }
            else
            {
                this.badge.visible = false;
                this.namePlayer.x = PLAYER_XPOS;
            }
            var _loc5_:Boolean = StringUtils.isNotEmpty(param1.suffixBadgeIcon);
            this.testerIcon.visible = _loc5_;
            if(_loc5_)
            {
                this.testerIcon.imageName = param1.suffixBadgeIcon;
                this._playerNameSpace = this._playerNameSpace - ICON_MARGIN;
            }
            this.namePlayer.setTextFieldWidth(this._playerNameSpace);
            this.namePlayer.setValue(this._namePlayer);
            if(_loc5_)
            {
                this.testerIcon.x = this.namePlayer.x + this.namePlayer.getTextWidth() + BADGE_GAP >> 0;
            }
        }

        public function setEnable(param1:Boolean) : void
        {
            if(param1)
            {
                this.namePlayer.setColor(this._isSquad?NAME_COLOR_SQUAD:NAME_COLOR_GREY);
            }
            else
            {
                this.namePlayer.setColor(NAME_COLOR_BLACK);
            }
            this.namePlayer.setTextFieldWidth(this._playerNameSpace);
            this.namePlayer.setValue(this._namePlayer);
            this.typeVehicle.visible = param1;
            this.nameVehicleTF.visible = param1;
            this.lifeBg.setColor(param1?VEHICLE_ENABLE:VEHICLE_DISABLE);
            this.lifeBg.setValue(this._countLives.toString());
            this._isEnabled = param1;
        }

        public function get vehID() : uint
        {
            return this._vehID;
        }
    }
}
