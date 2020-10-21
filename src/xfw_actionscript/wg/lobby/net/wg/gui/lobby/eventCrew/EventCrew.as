package net.wg.gui.lobby.eventCrew
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.gui.lobby.eventCrew.data.EventCrewVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ICommons;
    import net.wg.gui.components.containers.HorizontalGroupLayout;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import net.wg.gui.lobby.eventCrew.data.EventBonusItemVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventCrew extends UIComponentEx
    {

        private static const SMALL_HEIGHT:int = 1080;

        private static const SMALL_WIDTH:int = 1920;

        private static const STATE_SMALL:String = "small";

        private static const STATE_BIG:String = "big";

        private static const GROUP_RENDERER_GAP:int = 15;

        private static const PROGRESS_SPACE:int = 6;

        private static const GROUP_RENDERER:String = "EventSkillItemRendererUI";

        private static const SLASH:String = "/ ";

        public var icon:UILoaderAlt = null;

        public var textName:TextField = null;

        public var textNamePrem:TextField = null;

        public var textDescription:TextField = null;

        public var textCurrent:TextField = null;

        public var textCurrentPrem:TextField = null;

        public var textTotal:TextField = null;

        public var textTimer:TextField = null;

        public var progress:MovieClip = null;

        public var progressPrem:MovieClip = null;

        public var tooltipMc:MovieClip = null;

        public var group:GroupEx = null;

        private var _data:EventCrewVO = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _commons:ICommons = null;

        private var _isSick:Boolean = false;

        public function EventCrew()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.group.layout = new HorizontalGroupLayout(GROUP_RENDERER_GAP);
            this.group.itemRendererLinkage = GROUP_RENDERER;
            this.tooltipMc.addEventListener(MouseEvent.ROLL_OVER,this.onTooltipMcRollOverHandler);
            this.tooltipMc.addEventListener(MouseEvent.ROLL_OUT,this.onTooltipMcRollOutHandler);
            this._toolTipMgr = App.toolTipMgr;
            this._commons = App.utils.commons;
            this._commons.setShadowFilterWithParams(this.textTimer,0,0,16711680,1,16,16,2,2);
            this._commons.setShadowFilterWithParams(this.textNamePrem,0,0,4610559,1,10,10,2,2);
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            if(isInvalid(InvalidationType.SIZE))
            {
                if(App.appWidth < SMALL_WIDTH || App.appHeight < SMALL_HEIGHT)
                {
                    _loc1_ = STATE_SMALL;
                }
                else
                {
                    _loc1_ = STATE_BIG;
                }
                if(currentFrameLabel != _loc1_)
                {
                    gotoAndStop(_loc1_);
                    if(_baseDisposed)
                    {
                        return;
                    }
                    invalidate(InvalidationType.DATA);
                }
                dispatchEvent(new Event(Event.RESIZE));
            }
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.icon.source = this._data.icon;
                this.textName.text = this._data.label;
                this.textNamePrem.text = this._data.label;
                this.textCurrent.text = this._data.progressCurrent.toString();
                this.textCurrentPrem.text = this._data.progressCurrent.toString();
                this.textTotal.text = SLASH + this._data.progressTotal.toString();
                this.textTotal.x = this.textCurrent.x + this.textCurrent.textWidth + PROGRESS_SPACE | 0;
                this.textTimer.text = this._data.healingTimeLeft;
                this.textDescription.text = EVENT.EVENT_BONUSES_DESCRIPTION;
                this.textName.visible = this.textCurrent.visible = this.progress.visible = !this._data.isPremium;
                this.textNamePrem.visible = this.textCurrentPrem.visible = this.progressPrem.visible = this._data.isPremium;
                if(this._isSick != this._data.isSick)
                {
                    this._isSick = this._data.isSick;
                    if(this._isSick)
                    {
                        this._commons.setSaturation(this.icon,0);
                    }
                    else
                    {
                        this.icon.filters = [];
                    }
                }
                this.updateProgress();
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onTooltipMcRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onTooltipMcRollOutHandler);
            this.icon.dispose();
            this.icon.filters = [];
            this.icon = null;
            this.textCurrent = null;
            this.textCurrentPrem = null;
            this.textTotal = null;
            this.progress = null;
            this.progressPrem = null;
            this.textName = null;
            this.textNamePrem = null;
            this.textDescription = null;
            this.textTimer = null;
            this.tooltipMc = null;
            this._data = null;
            this._toolTipMgr = null;
            this._commons = null;
            this.group.dispose();
            this.group = null;
            super.onDispose();
        }

        public function setData(param1:EventCrewVO) : void
        {
            if(this._data != param1)
            {
                this._data = param1;
                this.group.dataProvider = this._data.bonuses;
                invalidateData();
            }
        }

        public function updateStage(param1:int, param2:int) : void
        {
            invalidateSize();
        }

        private function updateProgress() : void
        {
            var _loc1_:* = 0;
            var _loc4_:EventBonusItemVO = null;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc5_:int = this._data.bonuses.length;
            var _loc6_:* = 1;
            while(_loc6_ < _loc5_)
            {
                _loc4_ = this._data.bonuses[_loc6_];
                if(_loc4_.completed)
                {
                    _loc2_ = _loc2_ + _loc4_.maxProgress;
                }
                else
                {
                    _loc2_ = _loc2_ + _loc4_.currentProgress;
                }
                _loc3_ = _loc3_ + _loc4_.maxProgress;
                _loc6_++;
            }
            _loc1_ = _loc2_ * 100 / _loc3_;
            this.progress.gotoAndStop(_loc1_);
            this.progressPrem.gotoAndStop(_loc1_);
        }

        private function onTooltipMcRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onTooltipMcRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
            else if(this._data.isSpecial)
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
            }
        }
    }
}
