package net.wg.gui.battle.eventBattle.views.bossWidget
{
    import net.wg.infrastructure.base.meta.impl.EventBossProgressWidgetMeta;
    import net.wg.infrastructure.base.meta.IEventBossProgressWidgetMeta;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.battle.eventBattle.views.bossWidget.VO.DAAPIEventBossProgressWidgetVO;
    import net.wg.gui.battle.views.stats.StatsUserProps;
    import net.wg.utils.ICommons;
    import flash.utils.Dictionary;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import flash.display.BlendMode;
    import flash.events.Event;

    public class EventBossProgressWidget extends EventBossProgressWidgetMeta implements IEventBossProgressWidgetMeta
    {

        private static const HP_WIDTH:int = 479;

        private static const SCHEME_COLOR_WHITE:String = "white";

        private static const SCHEME_COLOR_RED:String = "red";

        private static const SCHEME_COLOR_YELLOW:String = "yellow";

        private static const TF_COLOR_WHITE:uint = 16777215;

        private static const TF_COLOR_YELLOW:uint = 16768409;

        private static const TF_COLOR_RED:uint = 16752541;

        private static const ALPHA_FULL_HP:Number = 0.4;

        private static const ALPHA_WHITE:Number = 0.8;

        private static const ALPHA_NONWHITE:Number = 1;

        private static const VEHICLE_ICON_OFFSET:int = 2;

        private static const VEHICLE_SPECIAL_FRAME_OFFSET:int = -10;

        private static const BASE_BAR_OFFSET:int = 84;

        private static const SKULL_OFFSET:int = 74;

        private static const PLAYER_NAME_OFFSET:int = 104;

        private static const KILLS_ICON_OFFSET:int = 25;

        private static const KILLS_TF_OFFSET:int = -4;

        private static const HEALTH_BAR_PROGRESS_MULTIPLIER:Number = 0.01;

        private static const TF_Y_OFFSET:int = 22;

        private static const ICONS_Y_OFFSET:int = 15;

        private static const HP_X_OFFSET:int = 3;

        private static const INVALIDATE_BOSS_HEALTH:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        private static const INVALIDATE_BOSS_KILLS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        public var healthBar:EventHealthBar = null;

        public var vehicleIcon:BattleAtlasSprite = null;

        public var vehicleFrame:BattleAtlasSprite = null;

        public var skullIcon:BattleAtlasSprite = null;

        public var fragsTF:TextField = null;

        public var fragsIcon:BattleAtlasSprite = null;

        public var playerNameFullTF:TextField = null;

        public var playerNameCutTF:TextField = null;

        public var hpMaxTF:TextField = null;

        public var hpCurrentTF:TextField = null;

        public var hit:Sprite = null;

        private var _data:DAAPIEventBossProgressWidgetVO = null;

        private var _currentColorScheme:String = "red";

        private var _userProps:StatsUserProps = null;

        private var _commons:ICommons = null;

        private var _colorDict:Dictionary;

        private var _currentHpPercent:Number = 1;

        public function EventBossProgressWidget()
        {
            this._colorDict = new Dictionary();
            super();
            this._colorDict[SCHEME_COLOR_WHITE] = TF_COLOR_WHITE;
            this._colorDict[SCHEME_COLOR_RED] = TF_COLOR_RED;
            this._colorDict[SCHEME_COLOR_YELLOW] = TF_COLOR_YELLOW;
            this._commons = App.utils.commons;
            this.healthBar.width = HP_WIDTH;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.fragsTF.mouseEnabled = false;
            this.playerNameFullTF.mouseEnabled = false;
            this.playerNameCutTF.mouseEnabled = false;
            this.hpMaxTF.mouseEnabled = this.hpCurrentTF.mouseEnabled = false;
            this.playerNameCutTF.visible = false;
            this.hpCurrentTF.alpha = ALPHA_WHITE;
            this.hpMaxTF.alpha = ALPHA_FULL_HP;
            TextFieldEx.setNoTranslate(this.fragsTF,true);
            TextFieldEx.setNoTranslate(this.playerNameFullTF,true);
            TextFieldEx.setNoTranslate(this.playerNameCutTF,true);
            TextFieldEx.setNoTranslate(this.hpMaxTF,true);
            TextFieldEx.setNoTranslate(this.hpCurrentTF,true);
            this.fragsIcon.imageName = BATTLEATLAS.BOSS_KILLS;
            this.updateColorScheme(this._currentColorScheme);
            this.updateLayout();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this._data != null)
            {
                this.updateUserProps(this._data);
                this.updateHpData();
                this.updateKills();
                this.updateColorScheme(this._currentColorScheme);
                this.vehicleIcon.imageName = this._data.isSpecial?BATTLEATLAS.BOSS_ICON_SPECIAL:BATTLEATLAS.BOSS_ICON;
                invalidateSize();
            }
            if(isInvalid(INVALIDATE_BOSS_HEALTH))
            {
                this.updateHpData();
            }
            if(isInvalid(INVALIDATE_BOSS_KILLS))
            {
                this.updateKills();
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateLayout();
            }
        }

        override protected function onDispose() : void
        {
            App.utils.data.cleanupDynamicObject(this._colorDict);
            this._colorDict = null;
            this.fragsTF = null;
            this.playerNameFullTF = null;
            this.playerNameCutTF = null;
            this.vehicleIcon = null;
            this.skullIcon = null;
            this.vehicleFrame = null;
            this.fragsIcon = null;
            this.hit = null;
            this.healthBar.dispose();
            this.healthBar = null;
            this._data = null;
            this.hpMaxTF = null;
            this.hpCurrentTF = null;
            this._commons = null;
            if(this._userProps)
            {
                this._userProps.dispose();
                this._userProps = null;
            }
            super.onDispose();
        }

        override protected function setWidgetData(param1:DAAPIEventBossProgressWidgetVO) : void
        {
            this._data = param1;
            this._currentColorScheme = this._data.isSpecial?SCHEME_COLOR_YELLOW:this._data.isPlayer?SCHEME_COLOR_WHITE:SCHEME_COLOR_RED;
            invalidate(InvalidationType.DATA);
        }

        public function as_setHpRatio(param1:Number) : void
        {
            this.healthBar.hpRatio = param1;
        }

        public function as_updateHp(param1:Number) : void
        {
            this._data.hpCurrent = param1;
            invalidate(INVALIDATE_BOSS_HEALTH);
        }

        public function as_updateKills(param1:Number) : void
        {
            this._data.kills = param1;
            invalidate(INVALIDATE_BOSS_KILLS);
        }

        public function setPlayerNameProps() : void
        {
            this._commons.truncateTextFieldText(this.playerNameCutTF,this._userProps.userName);
            this._commons.formatPlayerName(this.playerNameFullTF,this._userProps,!this._data.isPlayer,this._data.isPlayer);
        }

        private function updateColorScheme(param1:String) : void
        {
            this.skullIcon.imageName = BATTLEATLAS.getBossSkull(param1);
            this.vehicleFrame.imageName = BATTLEATLAS.getBossFrame(param1);
            this.vehicleFrame.blendMode = param1 == SCHEME_COLOR_YELLOW?BlendMode.ADD:BlendMode.NORMAL;
            this.playerNameFullTF.alpha = this.playerNameCutTF.alpha = this.fragsTF.alpha = this.skullIcon.alpha = param1 == SCHEME_COLOR_WHITE?ALPHA_WHITE:ALPHA_NONWHITE;
            this.playerNameFullTF.textColor = this._colorDict[param1];
            this.playerNameCutTF.textColor = this._colorDict[param1];
            this.fragsTF.textColor = this._colorDict[param1];
        }

        private function updateHpData() : void
        {
            if(this._data == null)
            {
                return;
            }
            this.hpCurrentTF.text = this._data.hpCurrent.toString();
            this.hpMaxTF.text = "/ " + this._data.hpMax.toString();
            var _loc1_:Number = this._data.hpMax > 0?this._data.hpCurrent / this._data.hpMax:1;
            var _loc2_:uint = TF_COLOR_WHITE;
            if(_loc1_ != this._currentHpPercent)
            {
                this._currentHpPercent = _loc1_;
                if(this._currentHpPercent < this.healthBar.hpRatio)
                {
                    _loc2_ = TF_COLOR_RED;
                }
                if(this.hpCurrentTF.textColor != _loc2_)
                {
                    this.hpCurrentTF.textColor = _loc2_;
                }
            }
            App.utils.commons.updateTextFieldSize(this.hpMaxTF,true,false);
            App.utils.commons.updateTextFieldSize(this.hpCurrentTF,true,false);
            this.updateHpLayout();
            this.healthBar.setHp(100 * this._currentHpPercent * HEALTH_BAR_PROGRESS_MULTIPLIER);
        }

        private function updateKills() : void
        {
            if(this._data == null)
            {
                return;
            }
            this.fragsTF.text = this._data.kills.toString();
        }

        private function updateLayout() : void
        {
            this.vehicleFrame.x = this.vehicleFrame.y = this._data != null && this._data.isSpecial?VEHICLE_SPECIAL_FRAME_OFFSET:0;
            this.vehicleIcon.x = this.vehicleIcon.y = VEHICLE_ICON_OFFSET;
            this.healthBar.x = BASE_BAR_OFFSET;
            this.skullIcon.x = SKULL_OFFSET;
            this.skullIcon.y = this.fragsIcon.y = ICONS_Y_OFFSET;
            this.playerNameFullTF.x = this.playerNameCutTF.x = PLAYER_NAME_OFFSET;
            this.playerNameFullTF.y = this.playerNameCutTF.y = this.fragsTF.y = this.hpMaxTF.y = this.hpCurrentTF.y = TF_Y_OFFSET;
            this.fragsIcon.x = this.playerNameFullTF.x + this.playerNameFullTF.width + KILLS_ICON_OFFSET;
            this.fragsTF.x = this.fragsIcon.x + this.fragsIcon.width + KILLS_TF_OFFSET;
            this.updateHpLayout();
            dispatchEvent(new Event(Event.RESIZE));
        }

        private function updateHpLayout() : void
        {
            this.hpMaxTF.x = this.healthBar.x + HP_WIDTH - this.hpMaxTF.width + HP_X_OFFSET;
            this.hpCurrentTF.x = this.hpMaxTF.x - this.hpCurrentTF.width;
        }

        private function updateUserProps(param1:DAAPIEventBossProgressWidgetVO) : void
        {
            if(!this._userProps)
            {
                this._userProps = new StatsUserProps(param1.playerName,param1.playerFakeName,param1.clanAbbrev,param1.region,0);
            }
            else
            {
                this._userProps.userName = param1.playerName;
                this._userProps.fakeName = param1.playerFakeName;
                this._userProps.clanAbbrev = param1.clanAbbrev;
                this._userProps.region = param1.region;
            }
            if(this._userProps.isChanged)
            {
                this._userProps.applyChanges();
                this.setPlayerNameProps();
            }
        }
    }
}
