package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.IScheduler;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPointsVO;
    import flash.utils.getTimer;
    import org.idmedia.as3commons.util.StringUtils;

    public class ResultPointsAnim extends ResultAppearMovieClip implements IDisposable
    {

        private static const ANIM_TIME:int = 1000;

        private static const ANIM_STEP_TIME:int = 20;

        private static const MAX_PROGRESS:Number = 1;

        private static const APPEAR_BONUS:String = "appearBonus";

        private static const PLUS:String = "+";

        public var points:AnimatedTextContainer = null;

        public var ribbon:MovieClip = null;

        protected var _total:int = 0;

        protected var _disposed:Boolean = false;

        private var _current:int = 0;

        private var _bonusTooltip:ToolTipVO = null;

        private var _startTime:Number = 0;

        private var _tooltipMgr:ITooltipMgr;

        private var _scheduler:IScheduler;

        private var _animationStarted:Boolean = false;

        private var _animationCompleted:Boolean = false;

        public function ResultPointsAnim()
        {
            this._tooltipMgr = App.toolTipMgr;
            this._scheduler = App.utils.scheduler;
            super();
            this.configUI();
        }

        public function setSizeFrame(param1:int) : void
        {
            this.ribbon.gotoAndStop(param1);
            if(this._disposed)
            {
                return;
            }
            this.points.gotoAndStop(param1);
            if(this._disposed)
            {
                return;
            }
            if(this._animationCompleted)
            {
                this.points.text = this.getPlusText(this._total);
            }
            else if(!this._animationStarted)
            {
                this.points.text = this.getPlusText(this._current);
            }
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function appearBonus() : void
        {
            gotoAndPlay(APPEAR_BONUS);
        }

        override public function immediateAppear() : void
        {
            super.immediateAppear();
            this._scheduler.cancelTask(this.increaseValue);
            this._animationCompleted = true;
            this.points.text = this.getPlusText(this._total);
        }

        public function setData(param1:ResultPointsVO) : void
        {
            this.points.text = this.getPlusText(this._current);
            this._bonusTooltip = param1.bonusTooltip;
            this._total = param1.points;
        }

        protected function playIncrease(param1:int, param2:int) : void
        {
            this._current = param1;
            this._total = param2;
            this._startTime = getTimer();
            this._scheduler.cancelTask(this.increaseValue);
            this._scheduler.scheduleRepeatableTask(this.increaseValue,ANIM_STEP_TIME,int.MAX_VALUE);
            this._animationStarted = true;
        }

        private function increaseValue() : void
        {
            var _loc1_:Number = Math.min((getTimer() - this._startTime) / ANIM_TIME,MAX_PROGRESS);
            this.points.text = this.getPlusText(this._current + int((this._total - this._current) * _loc1_));
            if(_loc1_ == MAX_PROGRESS)
            {
                this._scheduler.cancelTask(this.increaseValue);
                this._animationCompleted = true;
            }
        }

        protected function configUI() : void
        {
            this.points.mouseEnabled = this.points.mouseChildren = false;
        }

        protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.increaseValue);
            this.points.dispose();
            this.points = null;
            this.ribbon = null;
            this._bonusTooltip = null;
            this._tooltipMgr = null;
            this._scheduler = null;
            this._disposed = true;
        }

        protected function showTooltip() : void
        {
            if(this._bonusTooltip == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._bonusTooltip.tooltip))
            {
                this._tooltipMgr.showComplex(this._bonusTooltip.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._bonusTooltip.specialAlias,null].concat(this._bonusTooltip.specialArgs));
            }
        }

        protected function hideTooltip() : void
        {
            this._tooltipMgr.hide();
        }

        protected function getPlusText(param1:int) : String
        {
            if(param1 > 0)
            {
                return PLUS + param1.toString();
            }
            return param1.toString();
        }
    }
}
