package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattleResultsVO;
    import net.wg.utils.IScheduler;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import fl.motion.easing.Cubic;

    public class ResultsContainer extends UIComponentEx
    {

        private static const READY_BUTTON_Y_COMPACT:int = 520;

        private static const READY_BUTTON_Y:int = 585;

        private static const SHOW_TWEEN_DELAY:int = 1000;

        private static const SHOW_TWEEN_DURATION:int = 1000;

        private static const BTN_ANIM_DELTA_Y:int = 8;

        private static const BLOCKS_ANIM_DELTA_X:int = 25;

        private static const RIGHT_BLOCK_POS:int = 391;

        private static const LEFT_BLOCK_POS:int = -25;

        public var leftBlock:RankedListsContainer = null;

        public var rightBlock:RankedListsContainer = null;

        public var readyBtn:UniversalBtn = null;

        private var _tweens:Vector.<Tween> = null;

        private var _btnTween:Tween = null;

        private var _isCompactSize:Boolean = true;

        private var _data:RankedBattleResultsVO = null;

        private var _animInProgress:Boolean = false;

        private var _scheduler:IScheduler;

        private var _animReadyFrame:int = -1;

        public function ResultsContainer()
        {
            this._scheduler = App.utils.scheduler;
            super();
            stop();
            this._animReadyFrame = totalFrames - 1;
            addFrameScript(this._animReadyFrame,this.onAnimationReady);
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.utils.universalBtnStyles.setStyle(this.readyBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.leftBlock.setData(this._data.leftData,true);
                this.rightBlock.setData(this._data.rightData);
                this.readyBtn.visible = this._data.readyBtnVisible;
                this.readyBtn.label = this._data.readyBtn;
            }
        }

        override protected function onDispose() : void
        {
            stop();
            addFrameScript(this._animReadyFrame,null);
            this.clearSchedule();
            this._scheduler = null;
            this.clearTweens();
            this.clearBtnTween();
            this.leftBlock.dispose();
            this.leftBlock = null;
            this.rightBlock.dispose();
            this.rightBlock = null;
            this.readyBtn.dispose();
            this.readyBtn = null;
            this._data = null;
            super.onDispose();
        }

        public function init() : void
        {
            this.clearSchedule();
            this.clearTweens();
            this.clearBtnTween();
            var _loc1_:int = this._isCompactSize?READY_BUTTON_Y_COMPACT:READY_BUTTON_Y;
            this.readyBtn.y = _loc1_ + BTN_ANIM_DELTA_Y;
            this.readyBtn.alpha = Values.ZERO;
            this.rightBlock.x = RIGHT_BLOCK_POS + BLOCKS_ANIM_DELTA_X;
            this.rightBlock.alpha = Values.ZERO;
            this.leftBlock.x = LEFT_BLOCK_POS - BLOCKS_ANIM_DELTA_X;
            this.leftBlock.alpha = Values.ZERO;
            this._animInProgress = false;
        }

        public function setCompact(param1:Boolean) : void
        {
            this._isCompactSize = param1;
            this.leftBlock.setCompact(param1);
            this.rightBlock.setCompact(param1);
            this.updateBtnPosition();
        }

        public function setData(param1:RankedBattleResultsVO) : void
        {
            if(param1 != null && this._data != param1)
            {
                this._data = param1;
                invalidateData();
            }
        }

        public function show() : void
        {
            this.init();
            gotoAndPlay(1);
        }

        public function switchLists(param1:Boolean) : void
        {
            this.leftBlock.visible = this.rightBlock.visible = param1;
        }

        private function onAnimationReady() : void
        {
            stop();
            this._scheduler.scheduleTask(this.animStart,SHOW_TWEEN_DELAY);
        }

        private function clearSchedule() : void
        {
            this._scheduler.cancelTask(this.animStart);
        }

        private function animStart() : void
        {
            this._animInProgress = true;
            this.animBtn();
            this._tweens = new Vector.<Tween>();
            this._tweens.push(new Tween(SHOW_TWEEN_DURATION,this.rightBlock,{
                "x":RIGHT_BLOCK_POS,
                "alpha":Values.DEFAULT_ALPHA
            },{
                "paused":false,
                "ease":Cubic.easeOut,
                "fastTransform":false
            }));
            this._tweens.push(new Tween(SHOW_TWEEN_DURATION,this.leftBlock,{
                "x":LEFT_BLOCK_POS,
                "alpha":Values.DEFAULT_ALPHA
            },{
                "paused":false,
                "ease":Cubic.easeOut,
                "fastTransform":false
            }));
        }

        private function updateBtnPosition() : void
        {
            var _loc1_:* = 0;
            if(this._animInProgress)
            {
                this.clearBtnTween();
                this.animBtn();
            }
            else
            {
                _loc1_ = this._isCompactSize?READY_BUTTON_Y_COMPACT:READY_BUTTON_Y;
                this.readyBtn.y = _loc1_;
            }
        }

        private function animBtn() : void
        {
            var _loc1_:int = this._isCompactSize?READY_BUTTON_Y_COMPACT:READY_BUTTON_Y;
            this._btnTween = new Tween(SHOW_TWEEN_DURATION,this.readyBtn,{
                "y":_loc1_,
                "alpha":Values.DEFAULT_ALPHA
            },{
                "paused":false,
                "ease":Cubic.easeOut,
                "fastTransform":false,
                "onComplete":this.onAnimationComplete
            });
        }

        private function clearBtnTween() : void
        {
            if(this._btnTween)
            {
                this._btnTween.paused = true;
                this._btnTween.dispose();
                this._btnTween = null;
            }
        }

        private function clearTweens() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            if(this._tweens)
            {
                _loc1_ = this._tweens.length;
                _loc2_ = 0;
                while(_loc2_ < _loc1_)
                {
                    this._tweens[_loc2_].paused = true;
                    this._tweens[_loc2_].dispose();
                    _loc2_++;
                }
                this._tweens.splice(0,_loc1_);
                this._tweens = null;
            }
        }

        private function onAnimationComplete(param1:Tween) : void
        {
            this._animInProgress = false;
            this.updateBtnPosition();
        }
    }
}
