package net.wg.gui.lobby.eventTankRent
{
    import net.wg.infrastructure.base.meta.impl.EventTankRentMeta;
    import net.wg.infrastructure.base.meta.IEventTankRentMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventTankRent.data.EventTankRentVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.IUtils;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventTankRent extends EventTankRentMeta implements IEventTankRentMeta
    {

        private static const INFO_SPACE:uint = 4;

        private static const BUTTON_SPACE:uint = 20;

        private static const SECTION_SPACE:uint = 15;

        private static const TEXT_DESCR_SPACE:uint = 25;

        private static const DESCRIPTION_SPACE:uint = 12;

        public var textField:TextField = null;

        public var textReward:TextField = null;

        public var textDescription:TextField = null;

        public var btnRent:UniversalBtn = null;

        public var orSprite:Sprite = null;

        public var infoIcon:Sprite = null;

        public var btnGet:UniversalBtn = null;

        private var _data:EventTankRentVO = null;

        private var _toolTipMgr:ITooltipMgr;

        private var _utils:IUtils;

        public function EventTankRent()
        {
            this._toolTipMgr = App.toolTipMgr;
            this._utils = App.utils;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.btnRent.label = EVENT.HANGAR_EVENTTANKRENT_TOPACK;
            this.btnRent.addEventListener(ButtonEvent.CLICK,this.onBtnRentClickHandler);
            this._utils.universalBtnStyles.setStyle(this.btnRent,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
            this.textDescription.text = EVENT.TANKPANEL_OR;
            this.btnGet.label = EVENT.TANKPANEL_TOQUESTS;
            this.btnGet.addEventListener(ButtonEvent.CLICK,this.onBtnGetClickHandler);
            this._utils.universalBtnStyles.setStyle(this.btnGet,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.textField.text = this._data.description;
                this.textReward.text = this._data.rewardText;
                this._utils.commons.updateTextFieldSize(this.textField,true,false);
                this._utils.commons.updateTextFieldSize(this.textReward,true,false);
                _loc1_ = this.infoIcon.width + INFO_SPACE + this.textField.width + BUTTON_SPACE + this.btnGet.width + SECTION_SPACE + this.orSprite.width + DESCRIPTION_SPACE + this.btnRent.width + BUTTON_SPACE + this.textReward.width + BUTTON_SPACE;
                this.infoIcon.x = -_loc1_ >> 1;
                this.textField.x = this.infoIcon.x + this.infoIcon.width + INFO_SPACE;
                this.btnGet.x = this.textField.x + this.textField.width + BUTTON_SPACE | 0;
                this.orSprite.x = this.btnGet.x + this.btnGet.width + SECTION_SPACE;
                this.textDescription.x = this.orSprite.x - TEXT_DESCR_SPACE;
                this.textReward.x = this.orSprite.x + this.orSprite.width + DESCRIPTION_SPACE;
                this.btnRent.x = this.textReward.x + this.textReward.width + BUTTON_SPACE | 0;
            }
        }

        override protected function onDispose() : void
        {
            this._toolTipMgr = null;
            this._utils = null;
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.btnGet.removeEventListener(ButtonEvent.CLICK,this.onBtnGetClickHandler);
            this.btnGet.dispose();
            this.btnGet = null;
            this.infoIcon = null;
            this.btnRent.removeEventListener(ButtonEvent.CLICK,this.onBtnRentClickHandler);
            this.btnRent.dispose();
            this.btnRent = null;
            this.textDescription = null;
            this.textField = null;
            this.orSprite = null;
            this.textReward = null;
            this._data = null;
            super.onDispose();
        }

        override protected function setRentData(param1:EventTankRentVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function as_setVisible(param1:Boolean) : void
        {
            visible = param1;
        }

        private function onBtnGetClickHandler(param1:ButtonEvent) : void
        {
            onToQuestsClickS();
        }

        private function onBtnRentClickHandler(param1:ButtonEvent) : void
        {
            onEventRentClickS();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
