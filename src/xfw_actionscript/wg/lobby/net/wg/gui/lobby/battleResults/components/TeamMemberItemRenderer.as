package net.wg.gui.lobby.battleResults.components
{
    import flash.filters.ColorMatrixFilter;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UserNameField;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.icons.SquadIcon;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.ILocale;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import net.wg.data.constants.ColorSchemeNames;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;

    public class TeamMemberItemRenderer extends TeamMemberRendererBase
    {

        private static const DAMAGE_DEATH_COLOR:int = 6381391;

        private static const DAMAGE_DEFAULT_COLOR:int = 13413751;

        private static const DIMMED_COLOR_VALUE:Number = 0.4;

        private static const PLAYER_NAME_WIDTH:int = 121;

        private static const PLAYER_NAME_POS_X:int = 2;

        private static const VEHICLE_ICON_POS_X:int = 105;

        private static const VEHICLE_NAME_POS_X:int = 157;

        private static const DAMAGE_LBL_POS_X:int = 230;

        private static const FRAGS_LBL_POS_X:int = 286;

        private static const XP_LBL_POS_X:int = 325;

        private static const XP_ICON_POS_X:int = 368;

        private static const RESOURCE_LBL_POS_X:int = 384;

        private static const RESOURCE_ICON_POS_X:int = 429;

        private static const STATE_OUT:String = "out";

        private static const STATE_OVER:String = "over";

        private static const PLAYER_NAME_OFFSET:int = 6;

        private static const BADGE_OFFSET:int = 23;

        private static const SQUAD_WIDTH:int = 28;

        private static const CHAR_MINUS:String = "-";

        private static const ZERO:String = "0";

        private static const SLASH_N:String = "\n";

        private static const BADGE_GAP:int = 2;

        public var clickArea:MovieClip = null;

        public var selfBg:MovieClip = null;

        public var deadBg:MovieClip = null;

        public var playerName:UserNameField = null;

        public var vehicleName:TextField = null;

        public var damageLbl:TextField = null;

        public var fragsLbl:TextField = null;

        public var xpLbl:TextField = null;

        public var xpIcon:Sprite = null;

        public var resourceLbl:TextField = null;

        public var resourceIcon:Sprite = null;

        public var medalIcon:EfficiencyIconRenderer = null;

        public var fakeFocusIndicator:MovieClip = null;

        public var squadIcon:SquadIcon = null;

        public var vehicleIcon:UILoaderAlt = null;

        public var badgeIcon:UILoaderAlt = null;

        public var testerIcon:UILoaderAlt = null;

        public var testerBG:MovieClip = null;

        protected var xOffset:int = 0;

        protected var playerNameWidth:int = 0;

        private var _isOwnSquad:Boolean = false;

        private var _squadID:int = -1;

        private var _locale:ILocale;

        private var _tooltipMgr:ITooltipMgr;

        private var _badgeVisibleLayout:Boolean = false;

        private var _suffixBadgeIcon:String = "";

        public function TeamMemberItemRenderer()
        {
            this._locale = App.utils.locale;
            this._tooltipMgr = App.toolTipMgr;
            super();
            this.playerNameWidth = PLAYER_NAME_WIDTH;
        }

        private static function getDimmFilter() : ColorMatrixFilter
        {
            var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
            var _loc2_:Array = [DIMMED_COLOR_VALUE,0,0,0,0];
            var _loc3_:Array = [0,DIMMED_COLOR_VALUE,0,0,0];
            var _loc4_:Array = [0,0,DIMMED_COLOR_VALUE,0,0];
            var _loc5_:Array = [0,0,0,1,0];
            var _loc6_:Array = [];
            _loc6_ = _loc6_.concat(_loc2_);
            _loc6_ = _loc6_.concat(_loc3_);
            _loc6_ = _loc6_.concat(_loc4_);
            _loc6_ = _loc6_.concat(_loc5_);
            _loc1_.matrix = _loc6_;
            return _loc1_;
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = true;
            hitArea = this.clickArea;
            this.playerName.addEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
            this.medalIcon.addEventListener(MouseEvent.ROLL_OVER,this.onMedalIconRollOverHandler);
            this.medalIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
            this.medalIcon.addEventListener(MouseEvent.CLICK,this.onMedalIconClickHandler);
        }

        override protected function onDispose() : void
        {
            this.subscribeResField(false);
            this.playerName.removeEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
            this.medalIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onMedalIconRollOverHandler);
            this.medalIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
            this.medalIcon.removeEventListener(MouseEvent.CLICK,this.onMedalIconClickHandler);
            this.medalIcon.dispose();
            this.medalIcon = null;
            this.testerIcon.dispose();
            this.testerIcon = null;
            this.testerBG = null;
            this.clickArea = null;
            this.selfBg = null;
            this.deadBg = null;
            this.playerName.dispose();
            this.playerName = null;
            this.vehicleName = null;
            this.damageLbl = null;
            this.fragsLbl = null;
            this.xpLbl = null;
            this.xpIcon = null;
            this.resourceLbl = null;
            this.resourceIcon = null;
            this.fakeFocusIndicator = null;
            this.squadIcon.dispose();
            this.squadIcon = null;
            this.badgeIcon.dispose();
            this.badgeIcon = null;
            this.vehicleIcon.dispose();
            this.vehicleIcon = null;
            this._locale = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        override protected function showData(param1:TeamMemberItemVO) : void
        {
            this.playerName.width = this.playerNameWidth;
            this._suffixBadgeIcon = param1.suffixBadgeIcon;
            this.selfBg.visible = param1.isSelf;
            this.deadBg.visible = false;
            this.medalIcon.visible = false;
            this.resourceLbl.visible = false;
            this.resourceIcon.visible = false;
            this._isOwnSquad = param1.isOwnSquad;
            this._squadID = param1.squadID;
            var _loc2_:IColorScheme = null;
            if(param1.isTeamKiller)
            {
                _loc2_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1?ColorSchemeNames.TEAMKILLER_DEAD:ColorSchemeNames.TEAMKILLER);
            }
            else if(param1.isOwnSquad)
            {
                _loc2_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1?ColorSchemeNames.SELECTED_DEAD:ColorSchemeNames.SELECTED);
            }
            else
            {
                _loc2_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1?ColorSchemeNames.NORMAL_DEAD:ColorSchemeNames.NORMAL);
            }
            if(param1.resourceCount != Values.DEFAULT_INT)
            {
                this.resourceLbl.text = param1.resourceCount.toString();
                this.subscribeResField(false);
            }
            else
            {
                this.resourceLbl.text = CHAR_MINUS;
                this.subscribeResField(true);
            }
            if(StringUtils.isNotEmpty(this._suffixBadgeIcon))
            {
                this.playerName.width = this.playerName.width - BADGE_OFFSET;
            }
            this.playerName.userVO = param1.userVO;
            this.playerName.textColor = _loc2_.rgb;
            this.vehicleIcon.source = param1.tankIcon?param1.tankIcon:this.vehicleIcon.sourceAlt;
            this.vehicleName.htmlText = param1.vehicleName;
            this.xpLbl.text = this._locale.integer(param1.xp - param1.achievementXP);
            var _loc3_:String = param1.badgeIcon;
            var _loc4_:Boolean = StringUtils.isNotEmpty(_loc3_);
            this.badgeIcon.visible = _loc4_;
            if(_loc4_)
            {
                this.badgeIcon.source = _loc3_;
                if(!this._badgeVisibleLayout)
                {
                    this.playerName.x = this.playerName.x + BADGE_OFFSET;
                }
                this.playerName.width = this.playerName.width - BADGE_OFFSET;
            }
            else if(this._badgeVisibleLayout)
            {
                this.playerName.x = this.playerName.x - BADGE_OFFSET;
            }
            this._badgeVisibleLayout = _loc4_;
            this.damageLbl.text = ZERO;
            this.vehicleName.textColor = _loc2_.rgb;
            this.fragsLbl.textColor = this.damageLbl.textColor = DAMAGE_DEFAULT_COLOR;
            if(param1.deathReason > -1)
            {
                this.damageLbl.textColor = DAMAGE_DEATH_COLOR;
                this.deadBg.visible = true;
                this.vehicleIcon.filters = [getDimmFilter()];
            }
            else
            {
                this.vehicleIcon.filters = [];
            }
            if(param1.damageDealt > 0)
            {
                this.damageLbl.text = this._locale.integer(param1.damageDealt);
            }
            this.fragsLbl.visible = param1.kills > 0;
            if(this.fragsLbl.visible)
            {
                this.fragsLbl.text = param1.kills.toString();
            }
            if(param1.tkills > 0)
            {
                this.fragsLbl.textColor = getColorForAlias(ColorSchemeNames.TEAMKILLER,DEFAULT_TEAM_KILLER_COLOR);
            }
            if(param1.medalsCount > 0)
            {
                this.medalIcon.value = param1.medalsCount;
                this.medalIcon.validateNow();
                this.medalIcon.visible = true;
            }
        }

        override protected function updateCommonData(param1:CommonStatsVO) : void
        {
            this.squadIcon.hide();
            if(param1.isShowSquad)
            {
                if(this._squadID > 0)
                {
                    this.squadIcon.show(this._isOwnSquad,this._squadID);
                }
            }
            else
            {
                this.playerName.x = this.selfBg.x + PLAYER_NAME_OFFSET;
                this.playerName.width = this.playerNameWidth + SQUAD_WIDTH - this.playerName.x;
                if(this._badgeVisibleLayout)
                {
                    this.badgeIcon.x = this.playerName.x - BADGE_GAP;
                    this.playerName.x = this.badgeIcon.x + BADGE_OFFSET;
                    this.playerName.width = this.playerName.width - BADGE_OFFSET;
                }
                if(StringUtils.isNotEmpty(this._suffixBadgeIcon))
                {
                    this.playerName.width = this.playerName.width - BADGE_OFFSET;
                }
            }
            var _loc2_:Boolean = param1.isShowResources;
            if(_loc2_)
            {
                this.playerName.width = this.playerNameWidth + this.xOffset;
                this.playerName.x = PLAYER_NAME_POS_X;
                if(this._badgeVisibleLayout)
                {
                    this.badgeIcon.x = this.playerName.x - BADGE_GAP;
                    this.playerName.x = this.badgeIcon.x + BADGE_OFFSET;
                    this.playerName.width = this.playerName.width - BADGE_OFFSET;
                }
                if(StringUtils.isNotEmpty(this._suffixBadgeIcon))
                {
                    this.playerName.width = this.playerName.width - BADGE_OFFSET;
                }
                this.vehicleIcon.x = VEHICLE_ICON_POS_X + this.xOffset;
                this.vehicleName.x = VEHICLE_NAME_POS_X + this.xOffset;
                this.damageLbl.x = DAMAGE_LBL_POS_X + this.xOffset;
                this.fragsLbl.x = FRAGS_LBL_POS_X + this.xOffset;
                this.xpLbl.x = XP_LBL_POS_X + this.xOffset;
                this.xpIcon.x = XP_ICON_POS_X + this.xOffset;
                this.resourceLbl.x = RESOURCE_LBL_POS_X + this.xOffset;
                this.resourceIcon.x = RESOURCE_ICON_POS_X + this.xOffset;
            }
            this.resourceLbl.visible = _loc2_;
            this.resourceIcon.visible = _loc2_;
        }

        private function setSuffixBadge() : void
        {
            var _loc1_:Boolean = StringUtils.isNotEmpty(this._suffixBadgeIcon);
            this.testerIcon.visible = this.testerBG.visible = _loc1_;
            if(_loc1_)
            {
                this.testerIcon.source = this._suffixBadgeIcon;
                this.testerIcon.x = this.playerName.x + this.playerName.textWidth + BADGE_GAP >> 0;
                this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
            }
        }

        private function subscribeResField(param1:Boolean) : void
        {
            if(param1)
            {
                if(!this.resourceLbl.hasEventListener(MouseEvent.ROLL_OVER))
                {
                    this.resourceLbl.addEventListener(MouseEvent.ROLL_OVER,this.onResourceRollOverHandler);
                    this.resourceLbl.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
                    this.resourceIcon.addEventListener(MouseEvent.ROLL_OVER,this.onResourceRollOverHandler);
                    this.resourceIcon.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
                }
            }
            else if(this.resourceLbl.hasEventListener(MouseEvent.ROLL_OVER))
            {
                this.resourceLbl.removeEventListener(MouseEvent.ROLL_OVER,this.onResourceRollOverHandler);
                this.resourceLbl.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
                this.resourceIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onResourceRollOverHandler);
                this.resourceIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
            }
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = param1;
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            this.fakeFocusIndicator.gotoAndPlay(STATE_OVER);
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            this.fakeFocusIndicator.gotoAndPlay(STATE_OUT);
        }

        private function onPlayerNameChangeHandler(param1:Event) : void
        {
            this.setSuffixBadge();
        }

        private function onMedalIconRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:Vector.<String> = null;
            var _loc3_:* = 0;
            var _loc4_:uint = 0;
            if(data.achievements.length > 0)
            {
                _loc2_ = new Vector.<String>();
                _loc3_ = data.achievements.length;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    _loc2_.push(this._locale.makeString(ACHIEVEMENTS.all(data.achievements[_loc4_].type)));
                    _loc4_++;
                }
                this._tooltipMgr.show(_loc2_.join(SLASH_N));
            }
        }

        private function onComponentRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onMedalIconClickHandler(param1:MouseEvent) : void
        {
            handleMouseRelease(param1);
        }

        private function onResourceRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = this._tooltipMgr.getNewFormatter().addBody(TOOLTIPS.BATTLERESULTS_FORTRESOURCE_LEGIONER_BODY,true).make();
            this._tooltipMgr.showComplex(_loc2_);
        }
    }
}
