package net.wg.gui.lobby.rankedBattles19.view
{
    import net.wg.infrastructure.base.meta.impl.RankedBattlesLeaguesViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesLeaguesViewMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
    import net.wg.gui.lobby.rankedBattles19.components.BonusBattles;
    import net.wg.gui.lobby.rankedBattles19.view.stats.LeaguesStatsBlock;
    import flash.display.Sprite;
    import net.wg.gui.lobby.rankedBattles19.data.LeaguesViewVO;
    import net.wg.utils.ITextManager;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
    import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.rankedBattles19.data.LeaguesStatsBlockVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsDeltaVO;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsInfoVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.gui.lobby.rankedBattles19.constants.LeagueIconConsts;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class RankedBattlesLeaguesView extends RankedBattlesLeaguesViewMeta implements IRankedBattlesLeaguesViewMeta, IStageSizeDependComponent
    {

        private static const STATS_H_OFFSET_BIG:int = 300;

        private static const STATS_H_OFFSET_SMALL:int = 250;

        private static const BG_V_OFFSET_SMALL:int = -55;

        private static const BG_V_OFFSET_BIG:int = -75;

        private static const BG_HEIGHT_SMALL:int = 120;

        private static const BG_HEIGHT_BIG:int = 160;

        private static const DESCR_TF_V_OFFSET_BIG:int = 48;

        private static const LEAGUE_ICON_V_OFFSET_BIG:int = -10;

        private static const STATS_V_OFFSET_BIG:int = -56;

        private static const BONUS_BATTLES_V_OFFSET_BIG:int = 155;

        private static const TITLE_BLOCK_H_SMALL:int = 40;

        private static const TITLE_BLOCK_H_BIG:int = 80;

        private static const DESCR_TF_V_OFFSET_SMALL:int = 35;

        private static const LEAGUE_ICON_V_OFFSET_SMALL:int = -10;

        private static const STATS_V_OFFSET_SMALL:int = -45;

        private static const BONUS_BATTLES_TF_V_OFFSET_SMALL:int = 112;

        private static const TITLE_PADDING_WEIGHT:Number = 0.25;

        private static const STATS_PADDING_WEIGHT:Number = 0.25;

        private static const TITLE_PADDING_TOP_MIN:int = 20;

        private static const STATS_PADDING_BOTTOM_MIN:int = 25;

        private static const LEAGUE_BLOCK_HEIGHT_SMALL:int = 230;

        private static const LEAGUE_BLOCK_HEIGHT_BIG:int = 320;

        public var titleTf:TextField = null;

        public var descrTf:TextField = null;

        public var leagueIcon:MovieClip = null;

        public var statsDelta:RankedBattleStats = null;

        public var statsInfo:RankedBattleStats = null;

        public var bonusBattles:BonusBattles = null;

        public var statsBlock:LeaguesStatsBlock = null;

        public var bg:Sprite = null;

        private var _data:LeaguesViewVO = null;

        private var _textMgr:ITextManager = null;

        private var _prevBoundariesHeight:int = 0;

        private var _isSmall:Boolean = false;

        private var _tooltipMgr:ITooltipMgr = null;

        public function RankedBattlesLeaguesView()
        {
            super();
            this._tooltipMgr = App.toolTipMgr;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.statsDelta.addEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
            this.statsDelta.addEventListener(MouseEvent.ROLL_OUT,this.onStatsDeltaRollOutHandler);
            this.statsDelta.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
            this.statsDelta.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
            this.statsDelta.iconSizeBig = StatsConsts.ICON_SIZE_84;
            this.statsDelta.iconSizeSmall = StatsConsts.ICON_SIZE_64;
            this.statsInfo.addEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
            this.statsInfo.addEventListener(MouseEvent.ROLL_OUT,this.onStatsInfoRollOutHandler);
            this.statsInfo.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
            this.statsInfo.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
            this.statsInfo.iconSizeBig = StatsConsts.ICON_SIZE_84;
            this.statsInfo.iconSizeSmall = StatsConsts.ICON_SIZE_64;
            this._textMgr = App.textMgr;
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            this.statsBlock.dispose();
            this.statsBlock = null;
            this.statsDelta.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
            this.statsDelta.removeEventListener(MouseEvent.ROLL_OUT,this.onStatsDeltaRollOutHandler);
            this.statsDelta.dispose();
            this.statsDelta = null;
            this.statsInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
            this.statsInfo.removeEventListener(MouseEvent.ROLL_OUT,this.onStatsInfoRollOutHandler);
            this.statsInfo.dispose();
            this.statsInfo = null;
            this.bonusBattles.dispose();
            this.bonusBattles = null;
            this.titleTf = null;
            this.descrTf = null;
            this.leagueIcon.dispose();
            this.leagueIcon = null;
            this.bg = null;
            this._data = null;
            this._textMgr = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    invalidateLayout();
                }
                if(isInvalid(InvalidationType.LAYOUT) || isInvalid(INV_VIEW_PADDING))
                {
                    this.updateLeagueIcon();
                    if(_baseDisposed)
                    {
                        return;
                    }
                    this.updateLabels();
                    this.updateLayoutVertical();
                    invalidateSize();
                }
                if(isInvalid(InvalidationType.SIZE))
                {
                    this.updateLayoutHorizontal();
                }
            }
        }

        override protected function setData(param1:LeaguesViewVO) : void
        {
            if(param1 != null && this._data != param1)
            {
                this._data = LeaguesViewVO(param1);
                invalidateData();
            }
        }

        override protected function setStatsData(param1:LeaguesStatsBlockVO) : void
        {
            this.statsBlock.setData(param1);
        }

        override protected function setEfficiencyData(param1:RankedBattlesStatsDeltaVO) : void
        {
            this.statsDelta.setData(param1);
        }

        override protected function setRatingData(param1:RankedBattlesStatsInfoVO) : void
        {
            this.statsInfo.setData(param1);
        }

        public function as_setBonusBattlesLabel(param1:String) : void
        {
            this.bonusBattles.visible = StringUtils.isNotEmpty(param1);
            if(this.bonusBattles.visible)
            {
                this.bonusBattles.setText(param1);
            }
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(this._prevBoundariesHeight != param2)
            {
                this._prevBoundariesHeight = param2;
                this._isSmall = param2 < StageSizeBoundaries.HEIGHT_900;
                if(this._isSmall)
                {
                    this.statsDelta.minimize();
                    this.statsInfo.minimize();
                    this.statsBlock.minimize();
                }
                else
                {
                    this.statsDelta.maximize();
                    this.statsInfo.maximize();
                    this.statsBlock.maximize();
                }
                invalidateLayout();
            }
        }

        private function updateLeagueIcon() : void
        {
            var _loc1_:int = this._isSmall?LeagueIconConsts.SMALL_FRAME_OFFSET:LeagueIconConsts.BIG_FRAME_OFFSET;
            this.leagueIcon.gotoAndStop(this._data.league + _loc1_);
        }

        private function updateLabels() : void
        {
            if(this._isSmall)
            {
                this.titleTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE,this._data.title);
                this.descrTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_TEXT,this._data.descr);
            }
            else
            {
                this.titleTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.GRAND_TITLE,this._data.title);
                this.descrTf.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_BIG_TEXT,this._data.descr);
            }
        }

        private function updateLayoutHorizontal() : void
        {
            var _loc1_:* = width >> 1;
            this.titleTf.x = width - this.titleTf.width >> 1;
            this.descrTf.x = width - this.descrTf.width >> 1;
            this.leagueIcon.x = _loc1_;
            this.statsBlock.x = _loc1_;
            this.bg.x = width - this.bg.width >> 1;
            this.bonusBattles.x = _loc1_;
            if(this._isSmall)
            {
                this.statsDelta.x = this.leagueIcon.x - STATS_H_OFFSET_SMALL;
                this.statsInfo.x = this.leagueIcon.x + STATS_H_OFFSET_SMALL;
            }
            else
            {
                this.statsDelta.x = this.leagueIcon.x - STATS_H_OFFSET_BIG;
                this.statsInfo.x = this.leagueIcon.x + STATS_H_OFFSET_BIG;
            }
        }

        private function updateLayoutVertical() : void
        {
            var _loc1_:* = 0;
            _loc1_ = height - viewPadding.top - this.statsBlock.height;
            if(this._isSmall)
            {
                _loc1_ = _loc1_ - (LEAGUE_BLOCK_HEIGHT_SMALL + TITLE_BLOCK_H_SMALL);
                this.titleTf.y = Math.max(_loc1_ * TITLE_PADDING_WEIGHT,TITLE_PADDING_TOP_MIN) + viewPadding.top | 0;
                this.descrTf.y = this.titleTf.y + DESCR_TF_V_OFFSET_SMALL;
                this.statsBlock.y = height - this.statsBlock.height - Math.max(_loc1_ * STATS_PADDING_WEIGHT,STATS_PADDING_BOTTOM_MIN);
                this.leagueIcon.y = (this.statsBlock.y + this.titleTf.y + TITLE_BLOCK_H_SMALL >> 1) + LEAGUE_ICON_V_OFFSET_SMALL;
                this.statsDelta.y = this.statsInfo.y = this.leagueIcon.y + STATS_V_OFFSET_SMALL;
                this.bonusBattles.y = this.leagueIcon.y + BONUS_BATTLES_TF_V_OFFSET_SMALL;
                this.bg.y = this.leagueIcon.y + BG_V_OFFSET_SMALL;
                this.bg.height = BG_HEIGHT_SMALL;
            }
            else
            {
                _loc1_ = _loc1_ - (LEAGUE_BLOCK_HEIGHT_BIG + TITLE_BLOCK_H_BIG);
                this.titleTf.y = Math.max(_loc1_ * TITLE_PADDING_WEIGHT,TITLE_PADDING_TOP_MIN) + viewPadding.top | 0;
                this.descrTf.y = this.titleTf.y + DESCR_TF_V_OFFSET_BIG;
                this.statsBlock.y = height - this.statsBlock.height - Math.max(_loc1_ * STATS_PADDING_WEIGHT,STATS_PADDING_BOTTOM_MIN);
                this.leagueIcon.y = (this.statsBlock.y + this.titleTf.y + TITLE_BLOCK_H_BIG >> 1) + LEAGUE_ICON_V_OFFSET_BIG;
                this.statsDelta.y = this.statsInfo.y = this.leagueIcon.y + STATS_V_OFFSET_BIG;
                this.bonusBattles.y = this.leagueIcon.y + BONUS_BATTLES_V_OFFSET_BIG;
                this.bg.y = this.leagueIcon.y + BG_V_OFFSET_BIG;
                this.bg.height = BG_HEIGHT_BIG;
            }
        }

        private function onStatsDeltaRollOverHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_EFFICIENCY,null);
        }

        private function onStatsDeltaRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onStatsInfoRollOverHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_POSITION,null);
        }

        private function onStatsInfoRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
