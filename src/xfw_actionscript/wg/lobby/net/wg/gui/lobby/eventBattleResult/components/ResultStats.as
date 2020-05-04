package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.utils.FrameHelper;
    import flash.events.Event;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;

    public class ResultStats extends UIComponentEx
    {

        private static const APPEAR_LABEL:String = "appear";

        private static const COMPLETE_LABEL:String = "completeStat";

        public var stat1:ResultStatItem = null;

        public var stat2:ResultStatItem = null;

        public var stat3:ResultStatItem = null;

        public var stat4:ResultStatItem = null;

        public var objectives:ResultObjectives = null;

        private var _animateArr:Vector.<ResultStatItem> = null;

        private var _nextItem:int = 0;

        private var _frameHelper:FrameHelper = null;

        public function ResultStats()
        {
            super();
            this._animateArr = new <ResultStatItem>[this.objectives,this.stat1,this.stat2,this.stat3,this.stat4];
            this._frameHelper = new FrameHelper(this);
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:int = this._animateArr.length;
            var _loc2_:* = 1;
            while(_loc2_ <= _loc1_)
            {
                addFrameScript(this._frameHelper.getFrameByLabel(COMPLETE_LABEL + _loc2_),this.onCompleteFrame);
                _loc2_++;
            }
            this._animateArr[_loc1_ - 1].addEventListener(Event.COMPLETE,this.onLastItemCompleteHandler);
            mouseEnabled = false;
        }

        public function setSizeFrame(param1:int) : void
        {
            var _loc2_:int = this._animateArr.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._animateArr[_loc3_].gotoAndStop(param1);
                if(_baseDisposed)
                {
                    return;
                }
                _loc3_++;
            }
        }

        public function appear() : void
        {
            this._nextItem = 1;
            gotoAndPlay(APPEAR_LABEL);
        }

        public function immediateAppear() : void
        {
            this.clearFrameLabels();
            gotoAndStop(COMPLETE_LABEL + String(this._animateArr.length + 1));
            var _loc1_:int = this._animateArr.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                this._animateArr[_loc2_].immediateAppear();
                _loc2_++;
            }
        }

        public function setData(param1:ResultDataVO) : void
        {
            this.objectives.setData(param1.objectives.completed,EVENT.RESULTSCREEN_OBJECTIVES_HEADER,param1.objectives);
            this.objectives.setTotal(param1.objectives.total);
            this.stat1.setData(param1.kills,EVENT.RESULTSCREEN_STATS_KILL,param1.killsTooltip);
            this.stat2.setData(param1.damage,EVENT.RESULTSCREEN_STATS_DAMAGE,param1.damageTooltip);
            this.stat3.setData(param1.assist,EVENT.RESULTSCREEN_STATS_ASSIST,param1.assistTooltip);
            this.stat4.setData(param1.armor,EVENT.RESULTSCREEN_STATS_ARMOR,param1.armorTooltip);
            var _loc2_:int = this._animateArr.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._animateArr[_loc3_].setIcon(_loc3_);
                _loc3_++;
            }
        }

        override protected function onDispose() : void
        {
            this.clearFrameLabels();
            var _loc1_:int = this._animateArr.length;
            this._animateArr[_loc1_ - 1].removeEventListener(Event.COMPLETE,this.onLastItemCompleteHandler);
            this._animateArr.splice(0,_loc1_);
            this._animateArr = null;
            this.objectives.dispose();
            this.objectives = null;
            this.stat1.dispose();
            this.stat1 = null;
            this.stat2.dispose();
            this.stat2 = null;
            this.stat3.dispose();
            this.stat3 = null;
            this.stat4.dispose();
            this.stat4 = null;
            this._frameHelper.dispose();
            this._frameHelper = null;
            super.onDispose();
        }

        private function clearFrameLabels() : void
        {
            var _loc1_:int = this._animateArr.length;
            var _loc2_:* = 1;
            while(_loc2_ <= _loc1_)
            {
                addFrameScript(this._frameHelper.getFrameByLabel(COMPLETE_LABEL + _loc2_),null);
                _loc2_++;
            }
        }

        private function onCompleteFrame() : void
        {
            this._animateArr[this._nextItem - 1].playIncrease();
            dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.STAT_APPEAR));
            if(this._nextItem == this._animateArr.length)
            {
                stop();
            }
            else
            {
                this._nextItem++;
            }
        }

        private function onLastItemCompleteHandler(param1:Event) : void
        {
            dispatchEvent(param1);
        }
    }
}
