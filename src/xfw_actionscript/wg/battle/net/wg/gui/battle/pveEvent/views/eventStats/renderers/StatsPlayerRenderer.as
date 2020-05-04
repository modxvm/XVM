package net.wg.gui.battle.pveEvent.views.eventStats.renderers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.data.constants.InvalidationType;
    import flash.text.TextField;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.components.controls.BadgeComponent;
    import flash.display.MovieClip;
    import net.wg.gui.battle.pveEvent.views.eventStats.VO.EventStatsPlayerVO;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.BATTLEATLAS;

    public class StatsPlayerRenderer extends UIComponentEx implements IUpdatable
    {

        private static const PLAYER_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private static const ICON_MARGIN:uint = 23;

        private static const PLAYER_XPOS:uint = 42;

        private static const SELF_SQUAD_COLOR:uint = 16757350;

        private static const DEFAULT_COLOR:uint = 15461355;

        private static const BADGE_GAP:int = 2;

        public var playerTF:TextField = null;

        public var vehicleTF:TextField = null;

        public var damageTF:TextField = null;

        public var killsTF:TextField = null;

        public var squadIcon:BattleAtlasSprite = null;

        public var badge:BadgeComponent = null;

        public var testerIcon:BattleAtlasSprite = null;

        public var vehicleTypeIcon:BattleAtlasSprite = null;

        public var selectedMC:MovieClip = null;

        public var deadMC:MovieClip = null;

        public var testerBG:MovieClip = null;

        private var _data:EventStatsPlayerVO = null;

        private var _isHimself:Boolean = false;

        private var _isAlive:Boolean = false;

        private var _isPlayerInSquad:Boolean = false;

        private var _playerTFWidth:int = -1;

        private var _badgeData:BadgeVisualVO = null;

        public function StatsPlayerRenderer()
        {
            super();
            this._playerTFWidth = this.playerTF.width;
        }

        public function update(param1:Object) : void
        {
            this._data = EventStatsPlayerVO(param1);
            this._badgeData = this._data.badgeVisualVO;
            this._isHimself = this._data.isPlayerHimself;
            this._isAlive = this._data.isAlive;
            this._isPlayerInSquad = this._data.isSquad;
            invalidate(PLAYER_VALIDATION);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.visible = false;
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            if(this._data && isInvalid(PLAYER_VALIDATION))
            {
                this.visible = true;
                if(this._isHimself || this._isPlayerInSquad)
                {
                    this.playerTF.textColor = this.vehicleTF.textColor = this.damageTF.textColor = this.killsTF.textColor = SELF_SQUAD_COLOR;
                }
                else
                {
                    this.playerTF.textColor = this.vehicleTF.textColor = this.damageTF.textColor = this.killsTF.textColor = DEFAULT_COLOR;
                }
                this.selectedMC.visible = this._isHimself;
                this.deadMC.visible = !this._isAlive;
                this.vehicleTF.text = this._data.vehicleName;
                this.damageTF.text = this._data.damage;
                this.killsTF.text = this._data.kills;
                this.playerTF.width = this._playerTFWidth;
                if(this._badgeData)
                {
                    this.badge.visible = true;
                    this.badge.setData(this._badgeData);
                    this.playerTF.x = this.badge.x + ICON_MARGIN;
                    this.playerTF.width = this.playerTF.width - ICON_MARGIN;
                }
                else
                {
                    this.badge.visible = false;
                    this.playerTF.x = PLAYER_XPOS;
                }
                if(StringUtils.isNotEmpty(this._data.squadIndex))
                {
                    this.squadIcon.visible = true;
                    if(this._isPlayerInSquad)
                    {
                        this.squadIcon.imageName = BATTLEATLAS.squad_gold(this._data.squadIndex);
                    }
                    else
                    {
                        this.squadIcon.imageName = BATTLEATLAS.squad_silver(this._data.squadIndex);
                    }
                }
                else
                {
                    this.squadIcon.visible = false;
                }
                _loc1_ = StringUtils.isNotEmpty(this._data.suffixBadgeIcon);
                this.testerIcon.visible = this.testerBG.visible = _loc1_;
                if(_loc1_)
                {
                    this.testerIcon.imageName = this._data.suffixBadgeIcon;
                    this.playerTF.width = this.playerTF.width - ICON_MARGIN;
                }
                App.utils.commons.truncateTextFieldText(this.playerTF,this._data.playerName);
                if(_loc1_)
                {
                    this.testerIcon.x = this.playerTF.x + this.playerTF.textWidth + BADGE_GAP >> 0;
                    this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
                }
                this.vehicleTypeIcon.imageName = this._data.vehicleTypeIcon;
            }
            super.draw();
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this._badgeData = null;
            this.playerTF = null;
            this.vehicleTF = null;
            this.damageTF = null;
            this.killsTF = null;
            this.squadIcon = null;
            this.badge.dispose();
            this.badge = null;
            this.testerIcon = null;
            this.vehicleTypeIcon = null;
            this.selectedMC = null;
            this.deadMC = null;
            this.testerBG = null;
            super.onDispose();
        }
    }
}
