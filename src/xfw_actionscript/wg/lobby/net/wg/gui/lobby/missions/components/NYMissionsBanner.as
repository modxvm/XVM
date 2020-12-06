package net.wg.gui.lobby.missions.components
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.data.constants.Fonts;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import net.wg.utils.IUtils;
    import flash.text.TextFormat;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import net.wg.gui.lobby.missions.event.MissionViewEvent;

    public class NYMissionsBanner extends BaseDAAPIComponent
    {

        private static const BTN_HALF_GAP:int = 12;

        private static const BTN_HALF_GAP_SMALL:int = 8;

        private static const MESSAGE_BTN_GAP:int = 11;

        private static const MESSAGE_Y:int = 86;

        private static const MESSAGE_Y_SMALL:int = 60;

        private static const SIZE_CHANGE_POINT:int = 900;

        private static const BG_SIZE_BIG:String = "big";

        private static const BG_SIZE_SMALL:String = "small";

        private static const BOTTOM_GAP:int = -21;

        private static const BOTTOM_GAP_SMALL:int = -31;

        private static const CHALLENGE_BTN_ICON_TEXT_OFFSET:int = -163;

        private static const CHALLENGE_BTN_ICON_TEXT_OFFSET_SMALL:int = -142;

        private static const DAILY_BTN_ICON_TEXT_OFFSET:int = -163;

        private static const DAILY_BTN_ICON_TEXT_OFFSET_SMALL:int = -140;

        private static const NY_TF_FONTSIZE_BIG:uint = 16;

        private static const NY_TF_FONTSIZE_SMALL:uint = 14;

        private static const NY_TF_FONTSIZE_LINEHEIGHT_OFFSET:uint = 1;

        private static const INV_BUTTON_SIZE:String = "invButtonSize";

        public var toChallengeBtn:UniversalBtn = null;

        public var toDailyQuestsBtn:UniversalBtn = null;

        public var messageTF:TextField = null;

        public var bg:MovieClip = null;

        private var _isBigSize:Boolean = false;

        private var _currentHeight:int = -1;

        private var _currentWidth:int = -1;

        public function NYMissionsBanner()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.toChallengeBtn.currentFont = this.toDailyQuestsBtn.currentFont = Fonts.FIELD_FONT;
            this.toChallengeBtn.addEventListener(ButtonEvent.CLICK,this.onToChallengeBtnClickHanlder);
            this.toDailyQuestsBtn.addEventListener(ButtonEvent.CLICK,this.onToDailyQuestsBtnClickHandler);
            this.toChallengeBtn.addEventListener(Event.RESIZE,this.onBtnResizeHandler);
            this.toDailyQuestsBtn.addEventListener(Event.RESIZE,this.onBtnResizeHandler);
            this.toChallengeBtn.dynamicSizeByText = this.toDailyQuestsBtn.dynamicSizeByText = true;
            this.toChallengeBtn.placeIconFromBorder = this.toDailyQuestsBtn.placeIconFromBorder = true;
            this.toChallengeBtn.iconOffsetX = this.toDailyQuestsBtn.iconOffsetX = 1;
            this.toChallengeBtn.label = NY.NYMISSIONSBANNER_BUTTONS_TOCHALLENGEBTN;
            this.toDailyQuestsBtn.label = NY.NYMISSIONSBANNER_BUTTONS_TODAILYQUESTSBTN;
            this.isSizeChanged();
            this.rebuildHorizontal();
            this.rebuildVerticalAndTexts();
        }

        override protected function onDispose() : void
        {
            this.toChallengeBtn.removeEventListener(Event.RESIZE,this.onBtnResizeHandler);
            this.toChallengeBtn.removeEventListener(ButtonEvent.CLICK,this.onToChallengeBtnClickHanlder);
            this.toChallengeBtn.dispose();
            this.toChallengeBtn = null;
            this.toDailyQuestsBtn.removeEventListener(Event.RESIZE,this.onBtnResizeHandler);
            this.toDailyQuestsBtn.removeEventListener(ButtonEvent.CLICK,this.onToDailyQuestsBtnClickHandler);
            this.toDailyQuestsBtn.dispose();
            this.toDailyQuestsBtn = null;
            this.messageTF = null;
            this.bg = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INV_BUTTON_SIZE))
            {
                this.rebuildHorizontal();
            }
        }

        public function getMaxHeight(param1:int, param2:int) : int
        {
            this._currentWidth = param1;
            var _loc3_:Boolean = this.isSizeChanged();
            this.rebuildHorizontal();
            if(!_loc3_)
            {
                return this._currentHeight;
            }
            this.rebuildVerticalAndTexts();
            return this._currentHeight;
        }

        private function rebuildVerticalAndTexts() : void
        {
            var _loc1_:IUtils = App.utils;
            var _loc2_:TextFormat = this.messageTF.getTextFormat();
            _loc2_.size = this._isBigSize?NY_TF_FONTSIZE_BIG:NY_TF_FONTSIZE_SMALL;
            _loc2_.leading = NY_TF_FONTSIZE_LINEHEIGHT_OFFSET;
            this.messageTF.setTextFormat(_loc2_);
            this.messageTF.text = _loc1_.locale.makeString(NY.NYMISSIONSBANNER_MESSAGE,{"messageInsertion":_loc1_.locale.makeString(NY.NYMISSIONSBANNER_MESSAGEINSERTION)});
            _loc1_.commons.updateTextFieldSize(this.messageTF,false,true);
            this.bg.gotoAndStop(this._isBigSize?BG_SIZE_BIG:BG_SIZE_SMALL);
            this.messageTF.y = this._isBigSize?MESSAGE_Y:MESSAGE_Y_SMALL;
            var _loc3_:* = this.messageTF.y + this.messageTF.height + MESSAGE_BTN_GAP | 0;
            this.toChallengeBtn.y = this.toDailyQuestsBtn.y = _loc3_;
            var _loc4_:String = this._isBigSize?UniversalBtnStylesConst.STYLE_HEAVY_NY_TRANSPARENT:UniversalBtnStylesConst.STYLE_SLIM_NY_TRANSPARENT;
            _loc1_.universalBtnStyles.setStyle(this.toChallengeBtn,_loc4_);
            _loc1_.universalBtnStyles.setStyle(this.toDailyQuestsBtn,_loc4_);
            this.toChallengeBtn.iconSource = this._isBigSize?RES_ICONS.MAPS_ICONS_NEW_YEAR_ICONS_BTN_CHALLENGE:RES_ICONS.MAPS_ICONS_NEW_YEAR_ICONS_BTN_CHALLENGE_SMALL;
            this.toDailyQuestsBtn.iconSource = this._isBigSize?RES_ICONS.MAPS_ICONS_NEW_YEAR_ICONS_BTN_DAILY:RES_ICONS.MAPS_ICONS_NEW_YEAR_ICONS_BTN_DAILY_SMALL;
            this.toChallengeBtn.iconOffsetText = this._isBigSize?CHALLENGE_BTN_ICON_TEXT_OFFSET:CHALLENGE_BTN_ICON_TEXT_OFFSET_SMALL;
            this.toDailyQuestsBtn.iconOffsetText = this._isBigSize?DAILY_BTN_ICON_TEXT_OFFSET:DAILY_BTN_ICON_TEXT_OFFSET_SMALL;
            this._currentHeight = _loc3_ + this.toChallengeBtn.height + (this._isBigSize?BOTTOM_GAP:BOTTOM_GAP_SMALL);
        }

        private function rebuildHorizontal() : void
        {
            var _loc1_:* = 0;
            this.bg.x = this._currentWidth - this.bg.width >> 1;
            this.messageTF.x = this._currentWidth - this.messageTF.width >> 1;
            _loc1_ = this._isBigSize?BTN_HALF_GAP:BTN_HALF_GAP_SMALL;
            this.toChallengeBtn.paddingHorizontal = this.toDailyQuestsBtn.paddingHorizontal = this._isBigSize?10:5;
            this.toChallengeBtn.x = (this._currentWidth >> 1) - this.toChallengeBtn.width - _loc1_ | 0;
            this.toDailyQuestsBtn.x = (this._currentWidth >> 1) + _loc1_ | 0;
        }

        private function isSizeChanged() : Boolean
        {
            var _loc1_:* = App.appHeight >= SIZE_CHANGE_POINT;
            var _loc2_:* = _loc1_ == this._isBigSize;
            this._isBigSize = _loc1_;
            return _loc2_;
        }

        override public function get height() : Number
        {
            return this._currentHeight;
        }

        private function onBtnResizeHandler(param1:Event) : void
        {
            param1.stopImmediatePropagation();
            this.toChallengeBtn.width = this.toDailyQuestsBtn.width = Math.max(this.toChallengeBtn.width,this.toDailyQuestsBtn.width);
            invalidate(INV_BUTTON_SIZE);
        }

        private function onToDailyQuestsBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new MissionViewEvent(MissionViewEvent.NY_BANNER_GOTO_DAILY,true));
        }

        private function onToChallengeBtnClickHanlder(param1:ButtonEvent) : void
        {
            dispatchEvent(new MissionViewEvent(MissionViewEvent.NY_BANNER_GOTO_CHALLENGE,true));
        }
    }
}
