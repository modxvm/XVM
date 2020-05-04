package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ILocale;
    import net.wg.utils.IScheduler;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.gfx.TextFieldEx;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import flash.utils.getTimer;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.events.Event;

    public class ResultStatItem extends UIComponentEx
    {

        private static const ANIM_TIME:int = 1000;

        private static const ANIM_MIN_ITEMS:int = 10;

        private static const ANIM_STEP_TIME:int = 20;

        private static const MAX_PROGRESS:Number = 1;

        public var icon:MovieClip = null;

        public var textCurrent:TextField = null;

        public var description:AnimatedTextContainer = null;

        public var hitMc:MovieClip = null;

        private var _tooltipMgr:ITooltipMgr;

        private var _locale:ILocale;

        private var _scheduler:IScheduler;

        private var _tooltipData:ToolTipVO = null;

        private var _total:int = 0;

        private var _startTime:Number = 0;

        private var _totalTime:Number = 0;

        public function ResultStatItem()
        {
            this._tooltipMgr = App.toolTipMgr;
            this._locale = App.utils.locale;
            this._scheduler = App.utils.scheduler;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            TextFieldEx.setNoTranslate(this.textCurrent,true);
            this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.textCurrent.text = Values.ZERO.toString();
        }

        override protected function onBeforeDispose() : void
        {
            this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.increaseValue);
            this.textCurrent = null;
            this.icon = null;
            this.description.dispose();
            this.description = null;
            this.hitMc = null;
            this._tooltipMgr = null;
            this._tooltipData = null;
            this._locale = null;
            this._scheduler = null;
            super.onDispose();
        }

        public function setData(param1:int, param2:String, param3:ToolTipVO = null) : void
        {
            this._total = param1;
            this.description.text = param2;
            this._tooltipData = param3;
        }

        public function setIcon(param1:int) : void
        {
            this.icon.gotoAndStop(param1);
        }

        public function playIncrease() : void
        {
            this._startTime = getTimer();
            this._totalTime = this._total > ANIM_MIN_ITEMS?ANIM_TIME:this._total * ANIM_TIME / ANIM_MIN_ITEMS;
            this._scheduler.cancelTask(this.increaseValue);
            this._scheduler.scheduleRepeatableTask(this.increaseValue,ANIM_STEP_TIME,int.MAX_VALUE);
        }

        public function immediateAppear() : void
        {
            this._scheduler.cancelTask(this.increaseValue);
            this.textCurrent.text = this._locale.integer(this._total);
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._tooltipData == null || alpha != Values.DEFAULT_ALPHA)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._tooltipData.tooltip))
            {
                this._tooltipMgr.showComplex(this._tooltipData.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._tooltipData.specialAlias,null].concat(this._tooltipData.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function increaseValue() : void
        {
            var _loc1_:Number = Math.min((getTimer() - this._startTime) / this._totalTime,MAX_PROGRESS);
            this.textCurrent.text = this._locale.integer(int(this._total * _loc1_));
            if(_loc1_ == MAX_PROGRESS)
            {
                this._scheduler.cancelTask(this.increaseValue);
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
