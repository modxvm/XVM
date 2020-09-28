package net.wg.gui.battle.views.prebattleTimer
{
    import net.wg.infrastructure.base.meta.impl.EventPrebattleTimerMeta;
    import net.wg.infrastructure.base.meta.IEventPrebattleTimerMeta;
    import net.wg.data.constants.InvalidationType;
    import net.wg.data.constants.generated.PREBATTLE_TIMER;
    import net.wg.gui.components.controls.TextFieldContainer;
    import flash.display.MovieClip;
    import net.wg.utils.IScheduler;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.battle.views.prebattleTimer.data.PrebattleTimerMessageVO;
    import net.wg.data.constants.Values;
    import flash.text.TextFormat;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Fonts;
    import flash.display.Sprite;
    import fl.motion.easing.Cubic;

    public class EventPrebattleTimer extends EventPrebattleTimerMeta implements IEventPrebattleTimerMeta
    {

        private static const DEFAULT_FADE_IN_DURATION:uint = 300;

        private static const FADE_OUT_DURATION:uint = 400;

        private static const FADE_DELAY:uint = 200;

        private static const MIN_MSG_DURATION:uint = 1200;

        private static const MSG_BIG_FONT_CHANGE_LENGTH_L:int = 11;

        private static const MSG_BIG_FONT_CHANGE_LENGTH_M:int = 13;

        private static const MSG_FONT_DEFAULT:uint = 24;

        private static const MSG_FONT_BIG:uint = 73;

        private static const MSG_FONT_BIG_M:int = 66;

        private static const MSG_FONT_BIG_S:int = 52;

        private static const MSG_OFFSET_Y_BIG:int = -70;

        private static const WINOFFSET_Y_BIG:int = -80;

        private static const EXTRA_MSG_COMPACT_OFFSET_Y:uint = 20;

        private static const MESSAGE_COMPACT_OFFSET_Y:int = 15;

        private static const COMPACT_OFFSET_Y:uint = 35;

        private static const EXTRA_MSG_FADE_IN_OFFSET_Y:uint = 50;

        private static const EXTRA_MSG_FADE_OUT_DELAY:uint = 1000;

        private static const HIGHLIGHT_TEXT_COLOR:Object = {};

        private static const COMPACT_HEIGHT:uint = 899;

        private static const COMPACT_WIDTH:uint = 1599;

        private static const FRAME_POSTFIX_SMALL:String = "Small";

        private static const TIMER_Y_OFFSET:int = 30;

        private static const TEXT_SMALL_SCALE:Number = 0.7;

        private static const INVALID_EXTRA_MSG_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;

        private static const INVALID_FADE_IN_MESSAGE_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 7;

        private static const INVALID_FADE_IN_WIN_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 8;

        {
            HIGHLIGHT_TEXT_COLOR[PREBATTLE_TIMER.MSG_HIGHLIGHT_BLUE] = 12117759;
            HIGHLIGHT_TEXT_COLOR[PREBATTLE_TIMER.MSG_HIGHLIGHT_RED] = 16763594;
        }

        public var extraMessage:TextFieldContainer = null;

        public var messageIcon:MovieClip = null;

        public var messageGlow:MovieClip = null;

        private var _scheduler:IScheduler;

        private var _tweensIn:Vector.<Tween>;

        private var _tweensOut:Vector.<Tween>;

        private var _highlightedMsgs:Vector.<PrebattleTimerMessageVO> = null;

        private var _isProcessing:Boolean = false;

        private var _extraMessageText:String = "";

        private var _fadeInDuration:uint = 300;

        private var _isCompactLayout:Boolean = false;

        private var _currentMessageHighlight:String = "dark";

        private var _messageOriginY:int;

        public function EventPrebattleTimer()
        {
            this._scheduler = App.utils.scheduler;
            this._tweensIn = new Vector.<Tween>();
            this._tweensOut = new Vector.<Tween>();
            super();
            isNeedWinChangePosition = true;
            this._highlightedMsgs = new Vector.<PrebattleTimerMessageVO>(0);
            this._messageOriginY = message.y;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this._isCompactLayout = param2 < COMPACT_HEIGHT || param1 < COMPACT_WIDTH;
            var _loc3_:Number = this._isCompactLayout?TEXT_SMALL_SCALE:1;
            this.extraMessage.scaleX = this.extraMessage.scaleY = _loc3_;
            this.messageIcon.scaleX = this.messageIcon.scaleY = _loc3_;
            message.scaleX = message.scaleY = _loc3_;
            win.scaleX = win.scaleY = _loc3_;
            message.y = this._messageOriginY;
            if(this._isCompactLayout)
            {
                message.y = message.y - MESSAGE_COMPACT_OFFSET_Y;
            }
            this.updateMessageGlow(this._currentMessageHighlight);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_MESSAGE_TF))
            {
                message.visible = true;
            }
            if(isInvalid(INVALID_WIN_TF))
            {
                win.visible = true;
            }
            if(isInvalid(INVALID_EXTRA_MSG_TF))
            {
                this.extraMessage.y = win.y + win.height + win.offsetY | 0;
                if(this._isCompactLayout)
                {
                    this.extraMessage.y = this.extraMessage.y + EXTRA_MSG_COMPACT_OFFSET_Y;
                }
                this.extraMessage.label = this._extraMessageText;
                this.fadeInItem(this.extraMessage,0,EXTRA_MSG_FADE_IN_OFFSET_Y,false);
                this._scheduler.scheduleTask(this.fadeOutItem,EXTRA_MSG_FADE_OUT_DELAY,this.extraMessage);
            }
            if(isInvalid(INVALID_FADE_IN_MESSAGE_TF))
            {
                this.fadeInItem(message);
            }
            if(isInvalid(INVALID_FADE_IN_WIN_TF))
            {
                this.fadeInItem(win);
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.messageIcon.alpha = 0;
            this.messageIcon.mouseChildren = this.messageIcon.mouseEnabled = false;
            this.messageGlow.alpha = 0;
            this.messageGlow.mouseChildren = this.messageGlow.mouseEnabled = false;
        }

        override protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.processHighlightedMsgsQueue);
            this._scheduler.cancelTask(this.fadeOutAll);
            this._scheduler.cancelTask(this.fadeOutItem);
            this._scheduler = null;
            this.disposeTweens();
            this._tweensIn = null;
            this._tweensOut = null;
            this._highlightedMsgs.length = 0;
            this._highlightedMsgs = null;
            this.extraMessage.dispose();
            this.extraMessage = null;
            this.messageIcon = null;
            this.messageGlow = null;
            super.onDispose();
        }

        override protected function doComponentVisibility(param1:Boolean) : void
        {
            super.doComponentVisibility(param1);
            win.visible = true;
            message.visible = true;
            win.alpha = param1?1:0;
            message.alpha = param1?1:0;
        }

        override protected function queueHighlightedMessage(param1:PrebattleTimerMessageVO, param2:Boolean) : void
        {
            if(param2)
            {
                this.disposeTweens();
                this._highlightedMsgs.length = 0;
                this._isProcessing = false;
            }
            this._highlightedMsgs.push(param1);
            if(!this._isProcessing)
            {
                this.processHighlightedMsgsQueue();
            }
        }

        override protected function doUpdateSize(param1:Boolean) : void
        {
            timer.scaleX = timer.scaleY = param1?TIMER_SMALL_SCALE:TIMER_LARGE_SCALE;
            timer.y = TIMER_Y_OFFSET + (param1?TIMER_SMALL_Y:TIMER_LARGE_Y);
        }

        public function as_showExtraMessage(param1:String, param2:String) : void
        {
            this.extraMessage.textColor = HIGHLIGHT_TEXT_COLOR[param2];
            this._extraMessageText = param1;
            invalidate(INVALID_EXTRA_MSG_TF);
        }

        private function updateMessageGlow(param1:String) : void
        {
            if(param1 == Values.EMPTY_STR)
            {
                return;
            }
            var _loc2_:String = !this._isCompactLayout || param1 == PREBATTLE_TIMER.MSG_HIGHLIGHT_DARK?"":FRAME_POSTFIX_SMALL;
            this._currentMessageHighlight = param1;
            this.messageGlow.gotoAndStop(this._currentMessageHighlight + _loc2_);
        }

        private function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweensIn)
            {
                this.resetTween(_loc1_);
                _loc1_.dispose();
            }
            this._tweensIn.length = 0;
            for each(_loc1_ in this._tweensOut)
            {
                this.resetTween(_loc1_,false);
                _loc1_.dispose();
            }
            this._tweensOut.length = 0;
        }

        private function resetTween(param1:Tween, param2:Boolean = true) : void
        {
            var _loc3_:* = !param1.paused;
            param1.paused = true;
            if(_loc3_)
            {
                param1.target.alpha = param2?1:0;
            }
        }

        private function processHighlightedMsgsQueue() : void
        {
            var _loc2_:String = null;
            var _loc3_:String = null;
            var _loc4_:String = null;
            var _loc5_:uint = 0;
            var _loc6_:* = 0;
            var _loc7_:TextFormat = null;
            var _loc1_:PrebattleTimerMessageVO = this._highlightedMsgs.shift();
            if(_loc1_)
            {
                this._isProcessing = true;
                _loc2_ = _loc1_.msg;
                _loc3_ = _loc1_.winCondition;
                _loc4_ = _loc1_.icon;
                _loc5_ = _loc1_.duration;
                if(_loc1_.fadeInDuration > 0)
                {
                    this._fadeInDuration = _loc1_.fadeInDuration;
                }
                else
                {
                    this._fadeInDuration = DEFAULT_FADE_IN_DURATION;
                }
                if(!StringUtils.isEmpty(_loc2_))
                {
                    if(_loc1_.isBigMsg)
                    {
                        _loc6_ = MSG_FONT_BIG_S;
                        if(_loc2_.length < MSG_BIG_FONT_CHANGE_LENGTH_M)
                        {
                            _loc6_ = MSG_FONT_BIG_M;
                        }
                        if(_loc2_.length < MSG_BIG_FONT_CHANGE_LENGTH_L)
                        {
                            _loc6_ = MSG_FONT_BIG;
                        }
                        message.fontSize = _loc6_;
                        message.offsetY = MSG_OFFSET_Y_BIG;
                        win.offsetY = WINOFFSET_Y_BIG;
                    }
                    else
                    {
                        message.fontSize = MSG_FONT_DEFAULT;
                        message.offsetY = win.offsetY = 0;
                    }
                    setMessage(_loc2_);
                    highlightedMessageShownS(_loc1_.msgType);
                    invalidate(INVALID_FADE_IN_MESSAGE_TF);
                }
                if(!StringUtils.isEmpty(_loc3_))
                {
                    _loc7_ = new TextFormat();
                    _loc7_.font = Fonts.TITLE_FONT;
                    win.defaultTextFormat = _loc7_;
                    setWinConditionText(_loc3_);
                    invalidate(INVALID_FADE_IN_WIN_TF);
                }
                this.updateMessageGlow(_loc1_.hightLight);
                this.fadeInItem(this.messageGlow);
                if(!StringUtils.isEmpty(_loc4_))
                {
                    this.messageIcon.gotoAndStop(_loc4_);
                    this.fadeInItem(this.messageIcon);
                }
                this._scheduler.scheduleTask(this.fadeOutAll,Math.max(_loc5_ - FADE_DELAY,MIN_MSG_DURATION));
                this._scheduler.scheduleTask(this.processHighlightedMsgsQueue,Math.max(_loc5_ + FADE_DELAY * 2,MIN_MSG_DURATION));
            }
            else
            {
                this.disposeTweens();
                this._isProcessing = false;
            }
        }

        private function fadeOutAll() : void
        {
            this.fadeOutItem(message);
            this.fadeOutItem(win);
            this.fadeOutItem(this.messageGlow);
            this.fadeOutItem(this.messageIcon);
        }

        private function fadeInItem(param1:Sprite, param2:uint = 0, param3:int = 0, param4:Boolean = true) : void
        {
            message.visible = true;
            var _loc5_:Object = {};
            _loc5_.alpha = 1;
            if(param3 != 0)
            {
                param1.y = param1.y + param3;
                _loc5_.y = param1.y - param3;
            }
            var _loc6_:Tween = new Tween(this._fadeInDuration,param1,_loc5_,{
                "delay":param2,
                "ease":Cubic.easeIn
            });
            if(param4)
            {
                this._tweensIn.push(_loc6_);
            }
        }

        private function fadeOutItem(param1:Sprite, param2:uint = 0) : void
        {
            this._tweensOut.push(new Tween(FADE_OUT_DURATION,param1,{"alpha":0},{"delay":param2}));
        }

        override public function set y(param1:Number) : void
        {
            if(this._isCompactLayout)
            {
                super.y = param1 - COMPACT_OFFSET_Y;
            }
            else
            {
                super.y = param1;
            }
        }
    }
}
