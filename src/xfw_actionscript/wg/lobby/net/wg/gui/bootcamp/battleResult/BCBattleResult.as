package net.wg.gui.bootcamp.battleResult
{
    import net.wg.infrastructure.base.meta.impl.BCBattleResultMeta;
    import net.wg.infrastructure.base.meta.IBCBattleResultMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.battleResult.containers.BottomContainer;
    import net.wg.gui.bootcamp.battleResult.containers.TankLabel;
    import net.wg.gui.bootcamp.battleResult.views.BattleStatsView;
    import flash.geom.Point;
    import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.events.UILoaderEvent;
    import flash.display.DisplayObject;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import flash.ui.Keyboard;

    public class BCBattleResult extends BCBattleResultMeta implements IBCBattleResultMeta
    {

        private static const INTRO_INFO_CHANGED:String = "infoChanged";

        private static const LAYOUT_INVALID:String = "layoutInvalid";

        private static const BATTLE_STATS_LINKAGE:String = "BattleStatsVictoryUI";

        private static const DESCRIPTION_OFFSET_Y:int = 168;

        private static const TANK_LABEL_DESCRIPTION_OFFSET_X:int = -40;

        private static const STATUS_POSITION_SCREEN_PERCENT:Number = 0.1;

        private static const DESCRIPTION_SMALL_OFFSET_Y:int = 131;

        private static const STAGE_SMALL_SIZE:int = 1000;

        private static const SMALL_STATUS_SCALE:Number = 0.78;

        public var bg:UILoaderAlt = null;

        public var textStatus:TextField = null;

        public var textDescription:TextField = null;

        public var black:MovieClip = null;

        public var bottom:BottomContainer = null;

        public var tankLabel:TankLabel = null;

        private var _bgProportion:Number;

        private var _finals:BattleStatsView = null;

        private var _stageDimensions:Point;

        private var _data:BCBattleViewVO = null;

        public function BCBattleResult()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            if(!this._stageDimensions)
            {
                this._stageDimensions = new Point();
            }
            this._stageDimensions.x = param1;
            this._stageDimensions.y = param2;
            invalidate(LAYOUT_INVALID);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._bgProportion = Math.round(this.bg.originalWidth) / Math.round(this.bg.originalHeight);
            this.bottom.btnHangar.label = BOOTCAMP.BTN_CONTINUE;
            this.bottom.btnHangar.addEventListener(ButtonEvent.CLICK,this.onBtnHangarClickHandler);
            this.bottom.addEventListener(BattleViewEvent.ANIMATION_COMPLETE,this.onBottomAnimationCompleteHandler);
            addEventListener(BattleViewEvent.ANIMATIONS_QUEUE_START,this.onViewAnimationsQueueStartHandler);
            this.textDescription.autoSize = TextFieldAutoSize.LEFT;
            this.textStatus.autoSize = TextFieldAutoSize.LEFT;
            this.bg.addEventListener(UILoaderEvent.COMPLETE,this.onBgCompleteHandler);
            focusable = true;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(isInvalid(INTRO_INFO_CHANGED))
            {
                if(this._finals == null)
                {
                    this._finals = App.utils.classFactory.getComponent(BATTLE_STATS_LINKAGE,BattleStatsView);
                    addChild(DisplayObject(this._finals));
                }
                if(this._data)
                {
                    this._finals.setData(this._data);
                    this.textStatus.htmlText = this._data.resultTypeStr;
                    this.bg.source = this._data.background;
                    this.textDescription.text = this._data.finishReasonStr;
                    if(this.tankLabel)
                    {
                        this.tankLabel.setData(this._data.playerVehicle);
                    }
                }
            }
            if(this._stageDimensions && isInvalid(LAYOUT_INVALID))
            {
                _loc1_ = this._stageDimensions.x;
                _loc2_ = this._stageDimensions.y;
                if(_loc1_ / _loc2_ >= this._bgProportion)
                {
                    this.bg.width = _loc1_;
                    this.bg.height = Math.round(_loc1_ / this._bgProportion);
                }
                else
                {
                    this.bg.height = _loc2_;
                    this.bg.width = Math.round(_loc2_ * this._bgProportion);
                }
                this.bg.x = _loc1_ - this.bg.width >> 1;
                this.textStatus.y = STATUS_POSITION_SCREEN_PERCENT * _loc2_ | 0;
                if(_loc2_ <= STAGE_SMALL_SIZE)
                {
                    this.textStatus.scaleX = this.textStatus.scaleY = SMALL_STATUS_SCALE;
                    this.textDescription.y = this.tankLabel.y = this.textStatus.y + DESCRIPTION_SMALL_OFFSET_Y;
                }
                else
                {
                    this.textStatus.scaleX = this.textStatus.scaleY = 1;
                    this.textDescription.y = this.tankLabel.y = this.textStatus.y + DESCRIPTION_OFFSET_Y;
                }
                this.textStatus.x = _loc1_ - this.textStatus.width >> 1;
                this.tankLabel.x = _loc1_ - (this.tankLabel.width + TANK_LABEL_DESCRIPTION_OFFSET_X + this.textDescription.width) >> 1;
                this.textDescription.x = this.tankLabel.x + this.tankLabel.width + TANK_LABEL_DESCRIPTION_OFFSET_X;
                this.black.width = _loc1_;
                this.black.height = _loc2_;
                this._finals.x = this.bottom.x = _loc1_ >> 1;
                this._finals.y = this.bottom.y = _loc2_;
                this.bottom.bottomBg.width = _loc1_;
                this.bottom.bottomBg.x = -_loc1_ >> 1;
            }
        }

        override protected function onDispose() : void
        {
            this.bottom.btnHangar.removeEventListener(ButtonEvent.CLICK,this.onBtnHangarClickHandler);
            this.bg.removeEventListener(UILoaderEvent.COMPLETE,this.onBgCompleteHandler);
            removeEventListener(BattleViewEvent.ANIMATIONS_QUEUE_START,this.onViewAnimationsQueueStartHandler);
            this.bottom.removeEventListener(BattleViewEvent.ANIMATION_COMPLETE,this.onBottomAnimationCompleteHandler);
            this.bottom.dispose();
            this.bottom = null;
            this.bg.dispose();
            this.bg = null;
            this.textStatus = null;
            this.textDescription = null;
            this.black = null;
            this._finals.dispose();
            this._finals = null;
            this._stageDimensions = null;
            this._data = null;
            this.tankLabel.dispose();
            this.tankLabel = null;
            super.onDispose();
        }

        override protected function setData(param1:BCBattleViewVO) : void
        {
            this._data = param1;
            invalidate(INTRO_INFO_CHANGED);
        }

        override public function handleInput(param1:InputEvent) : void
        {
            var _loc3_:* = NaN;
            super.handleInput(param1);
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.value != InputValue.KEY_UP)
            {
                _loc3_ = _loc2_.code;
                if(_loc3_ == Keyboard.ESCAPE || _loc3_ == Keyboard.ENTER || _loc3_ == Keyboard.SPACE)
                {
                    param1.handled = true;
                    clickS();
                }
            }
        }

        private function onBgCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidate(LAYOUT_INVALID);
        }

        private function onBtnHangarClickHandler(param1:ButtonEvent) : void
        {
            clickS();
        }

        private function onBottomAnimationCompleteHandler(param1:BattleViewEvent) : void
        {
            if(this._finals)
            {
                this._finals.startAppearAnimation();
            }
        }

        private function onViewAnimationsQueueStartHandler(param1:BattleViewEvent) : void
        {
            onAnimationAwardStartS(param1.elementId);
        }
    }
}
