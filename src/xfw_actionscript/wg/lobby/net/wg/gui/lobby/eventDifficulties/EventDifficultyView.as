package net.wg.gui.lobby.eventDifficulties
{
    import net.wg.infrastructure.base.meta.impl.EventDifficultyViewMeta;
    import net.wg.infrastructure.base.meta.IEventDifficultyViewMeta;
    import flash.text.TextField;
    import net.wg.gui.lobby.eventDifficulties.controls.EventDifficultyButtonContainer;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventDifficulties.controls.EventDifficultyProgressContainer;
    import net.wg.gui.lobby.eventDifficulties.data.EventDifficultiesVO;
    import net.wg.gui.lobby.eventDifficulties.events.DifficultySelectionEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFormat;

    public class EventDifficultyView extends EventDifficultyViewMeta implements IEventDifficultyViewMeta
    {

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const DIFFICULTIES_BUTTON_WIDTH_BIG:int = 1242;

        private static const DIFFICULTIES_BUTTON_HEIGHT_BIG:int = 622;

        private static const DIFFICULTIES_BUTTON_WIDTH_SMALL:int = 882;

        private static const DIFFICULTIES_BUTTON_HEIGHT_SMALL:int = 447;

        private static const DIFFICULTIES_BUTTON_GAP_BIG:int = 421;

        private static const DIFFICULTIES_BUTTON_GAP_SMALL:int = 301;

        private static const TITLE_POSY_BIG:int = 160;

        private static const TITLE_POSY_SMALL:int = 110;

        private static const TITLE_GAP_SMALL:int = 44;

        private static const TITLE_GAP_BIG:int = 67;

        private static const STATE_BIG:String = "big";

        private static const STATE_SMALL:String = "small";

        private static const SMALL_HEIGHT:int = 912;

        private static const SMALL_WIDTH:int = 1500;

        private static const TITLE_TEXT_SIZE_BIG:int = 32;

        private static const TITLE_TEXT_SIZE_SMALL:int = 22;

        private static const CONTENT_BIG:int = 602;

        private static const CONTENT_SMALL:int = 448;

        public var titleTF:TextField = null;

        public var difficultyButton1:EventDifficultyButtonContainer = null;

        public var difficultyButton2:EventDifficultyButtonContainer = null;

        public var difficultyButton3:EventDifficultyButtonContainer = null;

        public var messengerBg:Sprite = null;

        public var background:Sprite = null;

        public var difficultyProgressBar:EventDifficultyProgressContainer = null;

        private var _data:EventDifficultiesVO = null;

        private var _buttons:Vector.<EventDifficultyButtonContainer>;

        public function EventDifficultyView()
        {
            this._buttons = new Vector.<EventDifficultyButtonContainer>(0);
            super();
            this._buttons.push(this.difficultyButton1,this.difficultyButton2,this.difficultyButton3);
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:* = false;
            var _loc6_:* = 0;
            var _loc10_:* = 0;
            var _loc12_:EventDifficultyButtonContainer = null;
            var _loc13_:* = false;
            super.updateStage(param1,param2);
            setSize(param1,param2 + this.messengerBg.height);
            _loc3_ = param1 < SMALL_WIDTH || param2 < SMALL_HEIGHT;
            var _loc4_:String = _loc3_?STATE_SMALL:STATE_BIG;
            var _loc5_:int = _loc3_?DIFFICULTIES_BUTTON_GAP_SMALL:DIFFICULTIES_BUTTON_GAP_BIG;
            _loc6_ = _loc3_?param2 - CONTENT_SMALL >> 1:param2 - CONTENT_BIG >> 1;
            var _loc7_:int = _loc3_?DIFFICULTIES_BUTTON_WIDTH_SMALL:DIFFICULTIES_BUTTON_WIDTH_BIG;
            this.titleTF.x = param1 - this.titleTF.width >> 1;
            this.titleTF.y = _loc6_;
            var _loc8_:int = _loc3_?this.titleTF.y + TITLE_GAP_SMALL:this.titleTF.y + TITLE_GAP_BIG;
            var _loc9_:int = this._buttons.length;
            _loc10_ = param1 - _loc7_ >> 1;
            var _loc11_:* = 0;
            while(_loc11_ < _loc9_)
            {
                _loc12_ = this._buttons[_loc11_];
                _loc13_ = lastFocusedElement != null && _loc12_.contains(lastFocusedElement);
                _loc12_.frameLabel = _loc4_;
                if(_loc13_)
                {
                    setFocus(_loc12_.difficultyButton);
                }
                _loc12_.y = _loc8_;
                _loc12_.x = _loc10_ + _loc5_ * _loc11_;
                _loc11_++;
            }
            this.difficultyProgressBar.udpateSize(param1,param2);
            this.difficultyProgressBar.x = param1 >> 1;
            this.difficultyProgressBar.y = _loc3_?this.difficultyButton1.y + DIFFICULTIES_BUTTON_HEIGHT_SMALL:this.difficultyButton1.y + DIFFICULTIES_BUTTON_HEIGHT_BIG;
            invalidateData();
        }

        override protected function setData(param1:EventDifficultiesVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
            this.titleTF.text = EVENT.EVENT_SELECT_DIFFICULTY;
            addEventListener(DifficultySelectionEvent.DIFFICULTY_BUTTON_CLICK,this.onEventDifficultyPanelClickHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.messengerBg.y = _height - this.messengerBg.height;
                this.messengerBg.width = _width;
                this.background.width = _width;
                this.background.height = _height;
                _loc1_ = _width < SMALL_WIDTH || _height < SMALL_HEIGHT;
                _loc2_ = _loc1_?TITLE_TEXT_SIZE_SMALL:TITLE_TEXT_SIZE_BIG;
                this.updateTextSize(this.titleTF,_loc2_);
            }
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                _loc3_ = this._buttons.length;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    this._buttons[_loc4_].setData(this._data.levels[_loc4_]);
                    _loc4_++;
                }
            }
        }

        override protected function layoutElements() : void
        {
            if(closeBtn != null)
            {
                closeBtn.validateNow();
                closeBtn.x = width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
            }
        }

        override protected function onEscapeKeyDown() : void
        {
            closeViewS();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onDispose() : void
        {
            removeEventListener(DifficultySelectionEvent.DIFFICULTY_BUTTON_CLICK,this.onEventDifficultyPanelClickHandler);
            this.messengerBg = null;
            this.background = null;
            this.titleTF = null;
            this.difficultyProgressBar.dispose();
            this.difficultyProgressBar = null;
            this._data = null;
            this._buttons.splice(0,this._buttons.length);
            this._buttons = null;
            this.difficultyButton1.dispose();
            this.difficultyButton1 = null;
            this.difficultyButton2.dispose();
            this.difficultyButton2 = null;
            this.difficultyButton3.dispose();
            this.difficultyButton3 = null;
            super.onDispose();
        }

        public function as_setProgress(param1:int, param2:String, param3:int) : void
        {
            this.difficultyProgressBar.setProgress(param1,param2,param3);
        }

        private function updateTextSize(param1:TextField, param2:int) : void
        {
            var _loc3_:TextFormat = param1.getTextFormat();
            _loc3_.size = param2;
            param1.setTextFormat(_loc3_);
            param1.defaultTextFormat = _loc3_;
        }

        private function onEventDifficultyPanelClickHandler(param1:DifficultySelectionEvent) : void
        {
            selectDifficultyS(param1.id);
        }
    }
}
