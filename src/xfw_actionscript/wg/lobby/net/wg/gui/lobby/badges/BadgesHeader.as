package net.wg.gui.lobby.badges
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.IUpdatableComponent;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.advanced.BackButton;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.components.assets.SpottedBackground;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.lobby.badges.data.BadgesHeaderVO;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import flash.text.TextFieldAutoSize;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.gui.lobby.badges.events.BadgesEvent;

    public class BadgesHeader extends UIComponentEx implements IUpdatableComponent
    {

        private static const INV_BADGE_VISUAL:String = "inv_badge_img";

        private static const INV_SUF_BADGE_IMG:String = "inv_suf_badge_img";

        private static const BADGE_IMG_GAP:int = 91;

        private static const SLOT_CLOSE_BTN_GAP:int = -11;

        private static const MAX_PLAYER_NAME_WIDTH:int = 433;

        private static const BADGE_IMG_WIDTH:int = 80;

        private static const SUFFIX_SELECTED_ALPHA:Number = Values.DEFAULT_ALPHA;

        private static const SUFFIX_DESELECTED_ALPHA:Number = 0.3;

        private static const PLAYER_TF_DEFAULT_Y:int = 55;

        private static const SUFFIX_TF_BADGE_OFFSET_X:int = -5;

        public var backButton:BackButton = null;

        public var badgeComponent:BadgeComponent = null;

        public var suffixBadgeImg:UILoaderAlt = null;

        public var suffixBageBg:MovieClip = null;

        public var separator:MovieClip = null;

        public var bottomShadow:SpottedBackground = null;

        public var bg:Sprite = null;

        public var backlight:Sprite = null;

        public var descrTf:TextField = null;

        public var playerTf:TextField = null;

        public var slotCloseBtn:ISoundButtonEx = null;

        public var suffixSetting:CheckBox = null;

        private var _data:BadgesHeaderVO = null;

        private var _badgeVisualVO:BadgeVisualVO = null;

        private var _suffixBadgeImg:String = "";

        private var _hasSelectedBadge:Boolean = false;

        public function BadgesHeader()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = this.separator.mouseEnabled = this.playerTf.mouseEnabled = this.separator.mouseChildren = this.bottomShadow.mouseEnabled = this.bottomShadow.mouseChildren = false;
            this.playerTf.autoSize = TextFieldAutoSize.LEFT;
            this.suffixSetting.addEventListener(Event.SELECT,this.onSuffixSettingSelectHandler);
            this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
            this.slotCloseBtn.addEventListener(ButtonEvent.CLICK,this.onSlotCloseBtnClickHandler);
            this.suffixBadgeImg.visible = this.suffixBageBg.visible = this.suffixSetting.visible = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.backButton.label = this._data.backBtnLabel;
                this.backButton.descrLabel = this._data.backBtnDescrLabel;
                this.descrTf.htmlText = this._data.descrTf;
                this.playerTf.htmlText = this._data.playerText;
                this.updateBadgeRelatedLayout();
            }
            if(this._badgeVisualVO != null && isInvalid(INV_BADGE_VISUAL))
            {
                this.badgeComponent.setData(this._badgeVisualVO);
                this.slotCloseBtn.visible = this._hasSelectedBadge;
                this.updateBadgeRelatedLayout();
            }
            if(isInvalid(INV_SUF_BADGE_IMG))
            {
                if(StringUtils.isNotEmpty(this._suffixBadgeImg))
                {
                    this.suffixBageBg.visible = this.suffixSetting.selected;
                    this.suffixBadgeImg.alpha = this.suffixBageBg.visible?SUFFIX_SELECTED_ALPHA:SUFFIX_DESELECTED_ALPHA;
                    this.suffixBadgeImg.visible = true;
                    this.descrTf.visible = false;
                    this.suffixSetting.visible = true;
                    this.suffixSetting.toolTip = App.toolTipMgr.getNewFormatter().addHeader(TOOLTIPS.BADGEINFO_TITLE,true).addBody(TOOLTIPS.BADGEINFO_TEXT,true).make();
                    this.suffixSetting.infoIcoType = InfoIcon.TYPE_INFO;
                    this.updateBadgeRelatedLayout();
                }
                else
                {
                    this.suffixBageBg.visible = false;
                    this.suffixBadgeImg.visible = false;
                    this.descrTf.visible = true;
                    this.suffixSetting.visible = false;
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.separator.width = this.bg.width = _width;
                this.bottomShadow.setWidth(_width);
                this.backlight.x = _width - this.backlight.width >> 1;
                this.descrTf.x = _width - this.descrTf.width >> 1;
                this.updateBadgeRelatedLayout();
            }
        }

        override protected function onDispose() : void
        {
            this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
            this.backButton.dispose();
            this.backButton = null;
            this.suffixSetting.removeEventListener(Event.SELECT,this.onSuffixSettingSelectHandler);
            this.suffixSetting.dispose();
            this.suffixSetting = null;
            this.suffixBadgeImg.dispose();
            this.suffixBadgeImg = null;
            this.badgeComponent.dispose();
            this.badgeComponent = null;
            this.slotCloseBtn.removeEventListener(ButtonEvent.CLICK,this.onSlotCloseBtnClickHandler);
            this.slotCloseBtn.dispose();
            this.slotCloseBtn = null;
            this._badgeVisualVO = null;
            this.descrTf = null;
            this.playerTf = null;
            this.separator = null;
            this.bg = null;
            this.backlight = null;
            this.bottomShadow.dispose();
            this.bottomShadow = null;
            this._data = null;
            this.suffixBageBg = null;
            super.onDispose();
        }

        public function setBadgeData(param1:BadgeVisualVO, param2:Boolean) : void
        {
            this._badgeVisualVO = param1;
            this._hasSelectedBadge = param2;
            invalidate(INV_BADGE_VISUAL);
        }

        public function setSuffixBadgeImg(param1:String, param2:String, param3:Boolean) : void
        {
            if(StringUtils.isEmpty(param1))
            {
                this.suffixBageBg.visible = false;
                this.suffixBadgeImg.visible = false;
                this.descrTf.visible = true;
                this.suffixSetting.visible = false;
            }
            else
            {
                this.suffixSetting.selected = param3;
                this._suffixBadgeImg = param1;
                this.suffixBadgeImg.source = this._suffixBadgeImg;
                this.suffixSetting.label = param2;
                this.suffixSetting.autoSize = TextFieldAutoSize.LEFT;
                this.suffixSetting.validateNow();
                invalidate(INV_SUF_BADGE_IMG);
            }
        }

        public function update(param1:Object) : void
        {
            this._data = BadgesHeaderVO(param1);
            invalidateData();
        }

        private function updateBadgeRelatedLayout() : void
        {
            if(this.playerTf.textWidth > MAX_PLAYER_NAME_WIDTH)
            {
                this.playerTf.autoSize = TextFieldAutoSize.NONE;
                this.playerTf.width = MAX_PLAYER_NAME_WIDTH;
                App.utils.commons.truncateTextFieldText(this.playerTf,this.playerTf.htmlText,true,true);
            }
            else
            {
                this.playerTf.autoSize = TextFieldAutoSize.LEFT;
            }
            this.playerTf.x = _width - (this.playerTf.width - BADGE_IMG_GAP) >> 1;
            if(StringUtils.isNotEmpty(this._suffixBadgeImg))
            {
                this.playerTf.x = this.playerTf.x - (SUFFIX_TF_BADGE_OFFSET_X + (this.suffixBadgeImg.width >> 1));
            }
            this.badgeComponent.x = this.playerTf.x - BADGE_IMG_GAP | 0;
            this.playerTf.y = PLAYER_TF_DEFAULT_Y;
            if(this._hasSelectedBadge)
            {
                this.slotCloseBtn.x = this.badgeComponent.x + BADGE_IMG_WIDTH + SLOT_CLOSE_BTN_GAP | 0;
            }
            if(StringUtils.isNotEmpty(this._suffixBadgeImg))
            {
                this.suffixBadgeImg.x = this.playerTf.width + this.playerTf.x | 0;
                this.suffixBageBg.x = this.suffixBadgeImg.x - this.suffixBadgeImg.width | 0;
                this.suffixSetting.x = this.playerTf.x;
                this.suffixSetting.invalidateData();
                this.suffixSetting.dispatchEvent(new Event(Event.RESIZE,true));
            }
        }

        private function onSuffixSettingSelectHandler(param1:Event) : void
        {
            if(this.suffixSetting.selected)
            {
                dispatchEvent(new BadgesEvent(BadgesEvent.SUFFIX_BADGE_SELECT,true));
            }
            else
            {
                dispatchEvent(new BadgesEvent(BadgesEvent.SUFFIX_BADGE_DESELECT,true));
            }
        }

        private function onBackButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new BadgesEvent(BadgesEvent.BACK_BUTTON_CLICK,true));
        }

        private function onSlotCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new BadgesEvent(BadgesEvent.BADGE_DESELECT,true));
        }
    }
}
