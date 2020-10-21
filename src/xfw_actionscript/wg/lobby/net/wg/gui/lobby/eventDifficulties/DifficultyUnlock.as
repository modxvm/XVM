package net.wg.gui.lobby.eventDifficulties
{
    import net.wg.infrastructure.base.meta.impl.DifficultyUnlockMeta;
    import net.wg.infrastructure.base.meta.IDifficultyUnlockMeta;
    import flash.display.MovieClip;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import flash.text.TextField;
    import net.wg.utils.IUtils;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
    import net.wg.gui.components.windows.Window;
    import flash.filters.BlurFilter;
    import flash.filters.BitmapFilterQuality;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import scaleform.clik.events.ButtonEvent;

    public class DifficultyUnlock extends DifficultyUnlockMeta implements IDifficultyUnlockMeta
    {

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const BTNS_GAP:int = 7;

        private static const DIFFICULTY_LABEL:String = "difficulty";

        private static const BLUR_XY:int = 20;

        private static const HEIGHT_MIN:int = 768;

        private static const BG_IMAGE_Y:int = 60;

        private static const DIFFICULTY_STATS_Y:int = 445;

        private static const TITLE_Y:int = 378;

        private static const DESCRIPTION1_Y:int = 488;

        private static const DIVIDER_Y:int = 533;

        private static const DESCRIPTION2_Y:int = 556;

        private static const CONFIRM_BTN_Y:int = 589;

        private static const CHANGE_DIFFICULTY_BTN_Y:int = 589;

        public var bg:MovieClip = null;

        public var bgImage:FrameStateCmpnt = null;

        public var divider:MovieClip = null;

        public var difficultyStars:FrameStateCmpnt = null;

        public var confirmBtn:UniversalBtn = null;

        public var changeDifficultyBtn:UniversalBtn = null;

        public var titleTF:TextField = null;

        public var description1TF:TextField = null;

        public var description2TF:TextField = null;

        private var _utils:IUtils;

        private var _blurWindows:Vector.<DisplayObject>;

        public function DifficultyUnlock()
        {
            this._utils = App.utils;
            super();
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            var _loc2_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.confirmBtn),InteractiveObject(this.changeDifficultyBtn)];
            App.utils.commons.initTabIndex(_loc2_);
            setFocus(_loc2_[0]);
            _loc2_.splice(0,_loc2_.length);
        }

        public function as_setDifficulty(param1:int, param2:Boolean) : void
        {
            this.difficultyStars.frameLabel = DIFFICULTY_LABEL + param1.toString();
            this.bgImage.frameLabel = DIFFICULTY_LABEL + param1.toString();
            this.changeDifficultyBtn.enabled = param2;
        }

        public function as_blurOtherWindows(param1:int) : void
        {
            var _loc3_:uint = 0;
            var _loc4_:uint = 0;
            var _loc5_:DisplayObject = null;
            this.clearBlurWindows();
            this._blurWindows = new Vector.<DisplayObject>(0);
            var _loc2_:ISimpleManagedContainer = App.containerMgr.getContainer(param1);
            if(_loc2_)
            {
                _loc3_ = _loc2_.numChildren;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    _loc5_ = _loc2_.getChildAt(_loc4_);
                    if(!(_loc5_ is Window && (_loc5_ as Window).sourceView == this))
                    {
                        this._blurWindows.push(_loc5_);
                        _loc5_.filters = [new BlurFilter(BLUR_XY,BLUR_XY,BitmapFilterQuality.MEDIUM)];
                    }
                    _loc4_++;
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleTF.text = EVENT.EVENT_DIFFICULTY_UNLOCK_TITLE;
            this.description1TF.text = EVENT.EVENT_DIFFICULTY_UNLOCK_DESCRIPTION1;
            this.description2TF.text = EVENT.EVENT_DIFFICULTY_UNLOCK_DESCRIPTION2;
            closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
            this.confirmBtn.label = EVENT.EVENT_DIFFICULTY_CONFIRM;
            this.changeDifficultyBtn.label = EVENT.EVENT_DIFFICULTY_CHANGE;
            this._utils.universalBtnStyles.setStyle(this.confirmBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            this._utils.universalBtnStyles.setStyle(this.changeDifficultyBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
            this.confirmBtn.addEventListener(ButtonEvent.CLICK,this.onConfirmBtnClick);
            this.changeDifficultyBtn.addEventListener(ButtonEvent.CLICK,this.onChangeDifficultyBtnClick);
        }

        override protected function onDispose() : void
        {
            this.clearBlurWindows();
            this.difficultyStars.dispose();
            this.difficultyStars = null;
            this.bgImage.dispose();
            this.bgImage = null;
            this.confirmBtn.removeEventListener(ButtonEvent.CLICK,this.onConfirmBtnClick);
            this.confirmBtn.dispose();
            this.confirmBtn = null;
            this.changeDifficultyBtn.removeEventListener(ButtonEvent.CLICK,this.onChangeDifficultyBtnClick);
            this.changeDifficultyBtn.dispose();
            this.changeDifficultyBtn = null;
            this.titleTF = null;
            this.description1TF = null;
            this.description2TF = null;
            this.divider = null;
            this.bg = null;
            this._utils = null;
            super.onDispose();
        }

        override protected function layoutElements() : void
        {
            this.bg.width = width;
            this.bg.height = height;
            this.bgImage.x = width - this.bgImage.width >> 1;
            this.difficultyStars.x = width - this.difficultyStars.width >> 1;
            this.titleTF.x = width - this.titleTF.width >> 1;
            this.description1TF.x = width - this.description1TF.width >> 1;
            this.description2TF.x = width - this.description2TF.width >> 1;
            var _loc1_:* = width >> 1;
            this.divider.x = _loc1_;
            this.confirmBtn.x = _loc1_ - this.confirmBtn.width - BTNS_GAP;
            this.changeDifficultyBtn.x = _loc1_ + BTNS_GAP;
            if(closeBtn != null)
            {
                closeBtn.validateNow();
                closeBtn.x = width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
            }
            var _loc2_:* = height - HEIGHT_MIN >> 1;
            this.bgImage.y = BG_IMAGE_Y + _loc2_;
            this.difficultyStars.y = DIFFICULTY_STATS_Y + _loc2_;
            this.titleTF.y = TITLE_Y + _loc2_;
            this.description1TF.y = DESCRIPTION1_Y + _loc2_;
            this.divider.y = DIVIDER_Y + _loc2_;
            this.description2TF.y = DESCRIPTION2_Y + _loc2_;
            this.confirmBtn.y = CONFIRM_BTN_Y + _loc2_;
            this.changeDifficultyBtn.y = CHANGE_DIFFICULTY_BTN_Y + _loc2_;
        }

        override protected function onEscapeKeyDown() : void
        {
            onCloseClickS();
        }

        override protected function onCloseBtn() : void
        {
            onCloseClickS();
        }

        private function onConfirmBtnClick(param1:ButtonEvent) : void
        {
            onCloseClickS();
        }

        private function onChangeDifficultyBtnClick(param1:ButtonEvent) : void
        {
            onDifficultyChangeClickS();
        }

        private function clearBlurWindows() : void
        {
            var _loc1_:DisplayObject = null;
            if(this._blurWindows)
            {
                while(this._blurWindows.length)
                {
                    _loc1_ = this._blurWindows.pop();
                    _loc1_.filters = [];
                }
                this._blurWindows = null;
            }
        }
    }
}
