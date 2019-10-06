package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
    import net.wg.gui.components.advanced.ClanEmblem;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.utils.ICommons;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.lobby.header.vo.AccountPopoverBlockVO;
    import flash.events.Event;
    import net.wg.gui.lobby.header.events.AccountPopoverEvent;

    public class AccountPopoverBlockBase extends UIComponentEx implements IAccountClanPopOverBlock
    {

        private static const UPDATE_EMBLEM:String = "updateEmblem";

        private static const ADDITIONAL_TF_PADDING:int = 5;

        private static const ADDITIONAL_BTN_PADDING:int = 9;

        public var separator:ISeparatorAsset = null;

        public var emblem:ClanEmblem = null;

        public var textFieldHeader:TextField = null;

        public var textFieldName:TextField = null;

        public var textFieldPosition:TextField = null;

        public var doActionBtn:SoundButtonEx = null;

        protected var data:IDAAPIDataClass = null;

        protected var commons:ICommons;

        private var _emblemID:String = "";

        public function AccountPopoverBlockBase()
        {
            this.commons = App.utils.commons;
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.separator.setCenterAsset(Linkages.TOOLTIP_SEPARATOR_UI);
            this.doActionBtn.mouseEnabledOnDisabled = true;
            this.doActionBtn.addEventListener(ButtonEvent.CLICK,this.onDoActionBtnClickHandler);
            this.emblem.visible = false;
        }

        override protected function onDispose() : void
        {
            this.separator.dispose();
            this.separator = null;
            this.commons = null;
            this.emblem.dispose();
            this.emblem = null;
            this.textFieldHeader = null;
            this.textFieldName = null;
            this.textFieldPosition = null;
            this.doActionBtn.removeEventListener(ButtonEvent.CLICK,this.onDoActionBtnClickHandler);
            this.doActionBtn.dispose();
            this.doActionBtn = null;
            this.data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this.data != null && isInvalid(InvalidationType.DATA))
            {
                this.applyData();
                invalidateSize();
            }
            if(StringUtils.isNotEmpty(this._emblemID) && isInvalid(UPDATE_EMBLEM))
            {
                this.emblem.setImage(this._emblemID);
                this.emblem.visible = true;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.applySize();
            }
        }

        public function setData(param1:IDAAPIDataClass) : void
        {
            this.data = param1;
            invalidateData();
        }

        public function setEmblem(param1:String) : void
        {
            if(StringUtils.isNotEmpty(param1) && param1 != this._emblemID)
            {
                this._emblemID = param1;
                invalidate(UPDATE_EMBLEM);
            }
        }

        protected function applyData() : void
        {
            var _loc2_:* = false;
            var _loc1_:AccountPopoverBlockVO = AccountPopoverBlockVO(this.data);
            _loc2_ = _loc1_.isDoActionBtnVisible;
            this.doActionBtn.visible = _loc2_;
            if(_loc2_)
            {
                this.doActionBtn.label = _loc1_.btnLabel;
                this.doActionBtn.enabled = _loc1_.btnEnabled;
                this.doActionBtn.tooltip = _loc1_.btnEnabled?_loc1_.btnTooltip:_loc1_.disabledTooltip;
            }
            var _loc3_:Boolean = _loc1_.isTextFieldNameVisible;
            this.textFieldName.visible = _loc3_;
            if(_loc3_)
            {
                this.setTextFieldNameText(_loc1_.formationName);
            }
            this.textFieldHeader.text = _loc1_.formation;
            this.textFieldPosition.text = _loc1_.position;
        }

        protected function setTextFieldNameText(param1:String) : void
        {
            this.textFieldName.text = param1;
        }

        protected function applySize() : void
        {
            this.commons.updateTextFieldSize(this.textFieldName,false);
            this.commons.updateTextFieldSize(this.textFieldPosition,false);
            this.textFieldPosition.y = this.textFieldName.y + this.textFieldName.height - ADDITIONAL_TF_PADDING ^ 0;
            if(this.doActionBtn.visible)
            {
                this.doActionBtn.y = this.textFieldPosition.y + this.textFieldPosition.height + ADDITIONAL_BTN_PADDING ^ 0;
            }
            else
            {
                this.doActionBtn.y = 0;
            }
            this.updateSize();
            dispatchEvent(new Event(Event.RESIZE));
        }

        protected function updateSize() : void
        {
            var _loc1_:* = this.textFieldPosition.y + this.textFieldPosition.textHeight ^ 0;
            if(this.doActionBtn.visible)
            {
                _loc1_ = this.doActionBtn.y + this.doActionBtn.height ^ 0;
            }
            this.height = _loc1_;
        }

        protected function dispatchAccountPopoverEvent(param1:String) : void
        {
            dispatchEvent(new AccountPopoverEvent(param1));
        }

        private function onDoActionBtnClickHandler(param1:ButtonEvent) : void
        {
            this.dispatchAccountPopoverEvent(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON);
        }
    }
}
