package net.wg.gui.lobby.rankedBattles19.view.divisions
{
    import net.wg.infrastructure.base.meta.impl.RankedBattlesDivisionQualificationMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesDivisionQualificationMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
    import net.wg.gui.lobby.rankedBattles19.constants.StatsConsts;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class RankedBattlesDivisionQualification extends RankedBattlesDivisionQualificationMeta implements IRankedBattlesDivisionQualificationMeta, IStageSizeDependComponent
    {

        private static const STATS_H_OFFSET_BIG:int = 280;

        private static const STATS_H_OFFSET_SMALL:int = 220;

        private static const MAX_BG_WIDTH:int = 1600;

        private static const ICON_V_OFFSET_SMALL:int = -40;

        private static const ICON_V_OFFSET_BIG:int = -60;

        private static const BG_V_OFFSET_SMALL:int = -3;

        private static const BG_V_OFFSET_BIG:int = -5;

        private static const BG_HEIGHT_SMALL:int = 120;

        private static const BG_HEIGHT_BIG:int = 160;

        private static const STATS_V_OFFSET_BIG:int = 55;

        private static const STATS_V_OFFSET_SMALL:int = 20;

        private static const TITLE_V_OFFSET_BIG:int = -20;

        private static const TITLE_V_OFFSET_SMALL:int = -5;

        private static const TITLE_FADE_DURATION:int = 400;

        private static const TITLE_FADE_DELAY:int = 0;

        private static const ICON_FADE_DURATION:int = 400;

        private static const ICON_FADE_DELAY:int = 200;

        private static const STATS_FADE_DURATION:int = 400;

        private static const STATS_FADE_DELAY:int = 400;

        public var titleTf:TextField = null;

        public var rankIcon:Image = null;

        public var efficiencyStats:RankedBattleStats = null;

        public var stepsStats:RankedBattleStats = null;

        public var bg:Sprite = null;

        private var _titleContainer:Sprite = null;

        private var _iconContainer:Sprite = null;

        private var _statsContainer:Sprite = null;

        private var _tweens:Vector.<Tween> = null;

        private var _smallImageSrc:String = "";

        private var _bigImageSrc:String = "";

        private var _progressTextSmall:String = "";

        private var _progressTextBig:String = "";

        private var _isSmall:Boolean = false;

        private var _tooltipMgr:ITooltipMgr = null;

        private var _isCompleted:Boolean = false;

        private var _isFirstEnter:Boolean = false;

        public function RankedBattlesDivisionQualification()
        {
            super();
            this._titleContainer = new Sprite();
            this._iconContainer = new Sprite();
            this._statsContainer = new Sprite();
            addChild(this._titleContainer);
            addChild(this._iconContainer);
            addChild(this._statsContainer);
            this._titleContainer.addChild(this.titleTf);
            this._iconContainer.addChild(this.rankIcon);
            this._statsContainer.addChild(this.efficiencyStats);
            this._statsContainer.addChild(this.stepsStats);
            this._titleContainer.alpha = 0;
            this._iconContainer.alpha = 0;
            this._statsContainer.alpha = 0;
            this._tweens = new Vector.<Tween>(0);
        }

        override protected function setQualificationEfficiencyData(param1:RankedBattlesStatsVO) : void
        {
            this.efficiencyStats.setData(param1);
        }

        override protected function setQualificationStepsData(param1:RankedBattlesStatsVO) : void
        {
            this.stepsStats.setData(param1);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.efficiencyStats.addEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
            this.efficiencyStats.addEventListener(MouseEvent.ROLL_OUT,this.onStatsDeltaRollOutHandler);
            this.efficiencyStats.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
            this.efficiencyStats.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
            this.efficiencyStats.iconSizeBig = StatsConsts.ICON_SIZE_84;
            this.efficiencyStats.iconSizeSmall = StatsConsts.ICON_SIZE_64;
            this.stepsStats.addEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
            this.stepsStats.addEventListener(MouseEvent.ROLL_OUT,this.onStatsInfoRollOutHandler);
            this.stepsStats.valueStyleBig = TEXT_MANAGER_STYLES.GRAND_TITLE;
            this.stepsStats.valueStyleSmall = TEXT_MANAGER_STYLES.SUPER_PROMO_TITLE;
            this.stepsStats.iconSizeBig = StatsConsts.ICON_SIZE_84;
            this.stepsStats.iconSizeSmall = StatsConsts.ICON_SIZE_64;
            this.rankIcon.addEventListener(Event.CHANGE,this.onRankIconChangeHandler);
            this._tooltipMgr = App.toolTipMgr;
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            this.efficiencyStats.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsDeltaRollOverHandler);
            this.efficiencyStats.removeEventListener(MouseEvent.ROLL_OUT,this.onStatsDeltaRollOutHandler);
            this.efficiencyStats.dispose();
            this.efficiencyStats = null;
            this.stepsStats.removeEventListener(MouseEvent.ROLL_OVER,this.onStatsInfoRollOverHandler);
            this.stepsStats.removeEventListener(MouseEvent.ROLL_OUT,this.onStatsInfoRollOutHandler);
            this.stepsStats.dispose();
            this.stepsStats = null;
            this.rankIcon.removeEventListener(Event.CHANGE,this.onRankIconChangeHandler);
            this.rankIcon.dispose();
            this.rankIcon.filters = null;
            this.rankIcon = null;
            this.titleTf = null;
            this.bg = null;
            removeChild(this._titleContainer);
            removeChild(this._iconContainer);
            removeChild(this._statsContainer);
            this._titleContainer = null;
            this._iconContainer = null;
            this._statsContainer = null;
            this._tooltipMgr = null;
            this.clearTweens();
            this._tweens = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._isFirstEnter)
                {
                    this._isFirstEnter = false;
                    this._titleContainer.alpha = 0;
                    this._iconContainer.alpha = 0;
                    this._statsContainer.alpha = 0;
                    this.clearTweens();
                    this._tweens.push(new Tween(TITLE_FADE_DURATION,this._titleContainer,{"alpha":1},{
                        "paused":false,
                        "delay":TITLE_FADE_DELAY
                    }));
                    this._tweens.push(new Tween(ICON_FADE_DURATION,this._iconContainer,{"alpha":1},{
                        "paused":false,
                        "delay":ICON_FADE_DELAY
                    }));
                    this._tweens.push(new Tween(STATS_FADE_DURATION,this._statsContainer,{"alpha":1},{
                        "paused":false,
                        "delay":STATS_FADE_DELAY
                    }));
                }
                else
                {
                    this._titleContainer.alpha = 1;
                    this._iconContainer.alpha = 1;
                    this._statsContainer.alpha = 1;
                }
                if(this._isCompleted)
                {
                    App.utils.commons.setSaturation(this.rankIcon,0);
                }
                else
                {
                    this.rankIcon.filters = null;
                }
                invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT) || isInvalid(InvalidationType.SIZE))
            {
                this.rankIcon.source = this._isSmall?this._smallImageSrc:this._bigImageSrc;
                this.titleTf.htmlText = this._isSmall?this._progressTextSmall:this._progressTextBig;
                this.updateLayoutHorizontal();
                this.updateLayoutVertical();
            }
        }

        public function as_setQualificationData(param1:String, param2:String, param3:Boolean) : void
        {
            this._smallImageSrc = param1;
            this._bigImageSrc = param2;
            this._isFirstEnter = param3;
            invalidateData();
        }

        public function as_setQualificationProgress(param1:String, param2:String, param3:Boolean) : void
        {
            this._progressTextSmall = param1;
            this._progressTextBig = param2;
            this._isCompleted = param3;
            invalidateData();
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            this._isSmall = param1 < StageSizeBoundaries.WIDTH_1920 || param2 < StageSizeBoundaries.HEIGHT_900;
            if(this._isSmall)
            {
                this.efficiencyStats.minimize();
                this.stepsStats.minimize();
            }
            else
            {
                this.efficiencyStats.maximize();
                this.stepsStats.maximize();
            }
            invalidateLayout();
        }

        private function clearTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }

        private function updateLayoutHorizontal() : void
        {
            this.rankIcon.x = width - this.rankIcon.width >> 1;
            var _loc1_:int = width - 2 * viewPadding.left;
            this.bg.width = Math.min(_loc1_,MAX_BG_WIDTH);
            this.bg.x = width - this.bg.width >> 1;
            this.titleTf.x = this.rankIcon.x + (this.rankIcon.width - this.titleTf.width >> 1);
            var _loc2_:* = width >> 1;
            if(this._isSmall)
            {
                this.efficiencyStats.x = _loc2_ - STATS_H_OFFSET_SMALL;
                this.stepsStats.x = _loc2_ + STATS_H_OFFSET_SMALL;
            }
            else
            {
                this.efficiencyStats.x = _loc2_ - STATS_H_OFFSET_BIG;
                this.stepsStats.x = _loc2_ + STATS_H_OFFSET_BIG;
            }
        }

        private function updateLayoutVertical() : void
        {
            this.rankIcon.y = (_height - this.rankIcon.height >> 1) + (this._isSmall?ICON_V_OFFSET_SMALL:ICON_V_OFFSET_BIG);
            this.bg.height = this._isSmall?BG_HEIGHT_SMALL:BG_HEIGHT_BIG;
            this.bg.y = this.rankIcon.y + (this.rankIcon.height - this.bg.height >> 1);
            this.titleTf.y = this.rankIcon.y - this.titleTf.height;
            if(this._isSmall)
            {
                this.bg.y = this.bg.y + BG_V_OFFSET_SMALL;
                this.efficiencyStats.y = this.stepsStats.y = this.rankIcon.y + STATS_V_OFFSET_SMALL;
                this.titleTf.y = this.titleTf.y + TITLE_V_OFFSET_SMALL;
            }
            else
            {
                this.bg.y = this.bg.y + BG_V_OFFSET_BIG;
                this.efficiencyStats.y = this.stepsStats.y = this.rankIcon.y + STATS_V_OFFSET_BIG;
                this.titleTf.y = this.titleTf.y + TITLE_V_OFFSET_BIG;
            }
        }

        private function onRankIconChangeHandler(param1:Event) : void
        {
            invalidateLayout();
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
