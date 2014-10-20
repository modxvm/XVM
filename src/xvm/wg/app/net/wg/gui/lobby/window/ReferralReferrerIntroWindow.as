package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.ReferralReferrerIntroWindowMeta;
    import net.wg.infrastructure.base.meta.IReferralReferrerIntroWindowMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.interfaces.IReferralTextBlockCmp;
    import net.wg.data.VO.ReferralReferrerIntroVO;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import scaleform.gfx.TextFieldEx;
    
    public class ReferralReferrerIntroWindow extends ReferralReferrerIntroWindowMeta implements IReferralReferrerIntroWindowMeta
    {
        
        public function ReferralReferrerIntroWindow()
        {
            super();
            isModal = false;
            isCentered = true;
            TextFieldEx.setVerticalAlign(this.titleMessageTF,TextFieldEx.VALIGN_CENTER);
            this.textBlocks = new <IReferralTextBlockCmp>[this.inviteBlock,this.squadGameBlock,this.referralsBlock];
            this.bgImage.source = RES_ICONS.MAPS_ICONS_REFERRAL_BG_IMAGE;
        }
        
        public var bgImage:UILoaderAlt = null;
        
        public var applyButton:SoundButtonEx = null;
        
        public var titleMessageTF:TextField = null;
        
        public var inviteBlock:IReferralTextBlockCmp = null;
        
        public var squadGameBlock:IReferralTextBlockCmp = null;
        
        public var referralsBlock:IReferralTextBlockCmp = null;
        
        public var textBlocks:Vector.<IReferralTextBlockCmp> = null;
        
        private var model:ReferralReferrerIntroVO = null;
        
        override protected function setData(param1:ReferralReferrerIntroVO) : void
        {
            this.model = param1;
            this.titleMessageTF.htmlText = param1.titleMsg;
            var _loc2_:int = this.textBlocks.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                IUpdatable(this.textBlocks[_loc3_]).update(param1.blocksVOs[_loc3_]);
                _loc3_++;
            }
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.applyButton.label = MENU.REFERRALREFERRERINTROWINDOW_APPLYBUTTON_LABEL;
            window.title = MENU.REFERRALREFERRERINTROWINDOW_WINDOWTITLE;
            window.useBottomBtns = true;
            this.updateElements();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.addEventListener(ReferralTextBlockCmp.LINK_BTN_CLICK,this.onClickLinkBtnHandler);
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            this.removeEventListener(ReferralTextBlockCmp.LINK_BTN_CLICK,this.onClickLinkBtnHandler);
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            this.bgImage.dispose();
            this.bgImage = null;
            for each(_loc1_ in this.textBlocks)
            {
                _loc1_.dispose();
                _loc1_ = null;
            }
            this.textBlocks.splice(0,this.textBlocks.length);
            this.textBlocks = null;
            this.titleMessageTF = null;
            this.model.dispose();
            this.model = null;
            super.onDispose();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.applyButton);
        }
        
        private function updateElements() : void
        {
            var _loc3_:DisplayObject = null;
            var _loc4_:DisplayObject = null;
            var _loc1_:int = this.textBlocks.length;
            var _loc2_:* = 1;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = DisplayObject(this.textBlocks[_loc2_]);
                _loc4_ = DisplayObject(this.textBlocks[_loc2_ - 1]);
                _loc4_.x = this._width - _loc4_.width >> 1;
                _loc3_.x = _loc4_.x;
                _loc3_.y = _loc4_.y + _loc4_.height ^ 0;
                _loc2_++;
            }
            this.applyButton.x = this._width - this.applyButton.width >> 1;
        }
        
        private function onClickApplyBtnHandler(param1:ButtonEvent) : void
        {
            onClickApplyButtonS();
        }
        
        private function onClickLinkBtnHandler(param1:Event) : void
        {
            onClickHrefLinkS();
        }
    }
}
