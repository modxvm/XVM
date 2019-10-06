package net.wg.gui.lobby.rankedBattles19.view
{
    import net.wg.infrastructure.base.meta.impl.RankedBattlesUnreachableViewMeta;
    import net.wg.infrastructure.base.meta.IRankedBattlesUnreachableViewMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
    import net.wg.gui.lobby.rankedBattles19.view.unreachableView.RankedUnreachableBottomBlock;
    import flash.text.TextField;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesUnreachableViewVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.UILoaderEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.utils.StageSizeBoundaries;

    public class RankedBattlesUnreachableView extends RankedBattlesUnreachableViewMeta implements IRankedBattlesUnreachableViewMeta, IStageSizeDependComponent
    {

        private static const BIG_HEIGHT:int = 1131;

        private static const CLOSE_BTN_TOP_OFFSET:int = 63;

        private static const CLOSE_BTN_RIGHT_OFFSET:int = -33;

        private static const CENTER_BIG_TO_BUTTONS_OFFSET_Y:int = 189;

        private static const HEADER_OFFSET_Y:int = 40;

        private static const CENTER_TO_BUTTONS_OFFSET_Y:int = 121;

        private static const FOOTER_HEIGHT:int = 262;

        private static const CENTER_IMG_OFFSET_Y:int = -30;

        private static const CENTER_IMG_BIG_OFFSET_Y:int = -50;

        public var centerImg:UILoaderAlt = null;

        public var centerImgBig:UILoaderAlt = null;

        public var closeBtn:ISoundButtonEx = null;

        public var header:RankedBattlesPageHeader = null;

        public var bottomBlockMc:RankedUnreachableBottomBlock = null;

        public var centerTF:TextField = null;

        private var _data:RankedBattlesUnreachableViewVO = null;

        private var _imgHalfHeight:int = -1;

        private var _imgBigHalfHeight:int = -1;

        public function RankedBattlesUnreachableView()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            invalidate(InvalidationType.LAYOUT);
        }

        override protected function onDispose() : void
        {
            this.centerImg.removeEventListener(UILoaderEvent.COMPLETE,this.onCenterImgCompleteHandler);
            this.centerImgBig.removeEventListener(UILoaderEvent.COMPLETE,this.onCenterImgBigCompleteHandler);
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.header.dispose();
            this.header = null;
            this.bottomBlockMc.dispose();
            this.bottomBlockMc = null;
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.centerImg.dispose();
            this.centerImg = null;
            this.centerImgBig.dispose();
            this.centerImgBig = null;
            this.centerTF = null;
            this._data = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.centerImg.addEventListener(UILoaderEvent.COMPLETE,this.onCenterImgCompleteHandler);
            this.centerImgBig.addEventListener(UILoaderEvent.COMPLETE,this.onCenterImgBigCompleteHandler);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
            this.centerImg.mouseEnabled = this.centerImg.mouseChildren = false;
            this.centerImgBig.mouseEnabled = this.centerImgBig.mouseChildren = false;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            App.stageSizeMgr.register(this);
        }

        override protected function setData(param1:RankedBattlesUnreachableViewVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = false;
            var _loc3_:* = 0;
            super.draw();
            if(this._data)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.centerImg.source = this._data.centerImg;
                    this.centerImgBig.source = this._data.centerImgBig;
                    this.closeBtn.label = this._data.closeBtnLabel;
                    this.closeBtn.tooltip = this._data.closeBtnTooltip;
                    this.header.setData(this._data.header);
                    this.centerTF.htmlText = this._data.centerText;
                    this.bottomBlockMc.bottomTF.htmlText = this._data.bottomText;
                    setBackground(this._data.bgImage);
                    this.bottomBlockMc.setRules(this._data.bottomRules);
                }
                if(isInvalid(InvalidationType.LAYOUT))
                {
                    this.closeBtn.x = bgActualWidth - this.closeBtn.width + CLOSE_BTN_RIGHT_OFFSET;
                    this.closeBtn.y = CLOSE_BTN_TOP_OFFSET;
                    _loc1_ = App.appHeight;
                    _loc2_ = _loc1_ < BIG_HEIGHT;
                    this.centerImg.visible = _loc2_;
                    this.centerImgBig.visible = !_loc2_;
                    this.header.x = bgActualWidth - this.header.width >> 1;
                    this.centerTF.x = bgActualWidth - this.centerTF.width >> 1;
                    this.centerImg.x = bgActualWidth - this.centerImg.width >> 1;
                    this.centerImgBig.x = bgActualWidth - this.centerImgBig.width >> 1;
                    this.bottomBlockMc.x = bgActualWidth >> 1;
                    this.bottomBlockMc.y = bgActualHeight - FOOTER_HEIGHT;
                    this.header.y = HEADER_OFFSET_Y;
                    _loc3_ = HEADER_OFFSET_Y + this.header.height + this.bottomBlockMc.y >> 1;
                    if(_loc2_)
                    {
                        this.centerImg.y = _loc3_ - this._imgHalfHeight + CENTER_IMG_OFFSET_Y;
                        this.centerTF.y = this.centerImg.y + this._imgHalfHeight + CENTER_TO_BUTTONS_OFFSET_Y;
                    }
                    else
                    {
                        this.centerImgBig.y = _loc3_ - this._imgBigHalfHeight + CENTER_IMG_BIG_OFFSET_Y;
                        this.centerTF.y = this.centerImgBig.y + this._imgBigHalfHeight + CENTER_BIG_TO_BUTTONS_OFFSET_Y;
                    }
                }
            }
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            var _loc3_:Boolean = param1 < StageSizeBoundaries.WIDTH_1366 || param2 < StageSizeBoundaries.HEIGHT_900;
            this.header.setScreenSize(_loc3_);
            invalidateLayout();
        }

        private function handleEscape() : void
        {
            onEscapePressS();
        }

        private function onCenterImgBigCompleteHandler(param1:UILoaderEvent) : void
        {
            this._imgBigHalfHeight = this.centerImgBig.height >> 1;
            invalidateLayout();
        }

        private function onCenterImgCompleteHandler(param1:UILoaderEvent) : void
        {
            this._imgHalfHeight = this.centerImg.height >> 1;
            invalidateLayout();
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            onCloseBtnClickS();
        }
    }
}
