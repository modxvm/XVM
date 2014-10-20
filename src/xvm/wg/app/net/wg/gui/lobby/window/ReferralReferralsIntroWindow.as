package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.ReferralReferralsIntroWindowMeta;
    import net.wg.infrastructure.base.meta.IReferralReferralsIntroWindowMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.InteractiveObject;
    import net.wg.data.VO.RefSysReferralsIntroVO;
    
    public class ReferralReferralsIntroWindow extends ReferralReferralsIntroWindowMeta implements IReferralReferralsIntroWindowMeta
    {
        
        public function ReferralReferralsIntroWindow()
        {
            super();
            isModal = false;
            isCentered = true;
            this.squadIcon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
            this.bgImage.source = RES_ICONS.MAPS_ICONS_REFERRAL_BG_IMAGE;
        }
        
        public var bgImage:UILoaderAlt = null;
        
        public var applyButton:SoundButtonEx = null;
        
        public var titleTF:TextField = null;
        
        public var bodyTF:TextField = null;
        
        public var squadIcon:UILoaderAlt = null;
        
        public var squadTF:TextField = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.applyButton.label = MENU.REFERRALREFERRERINTROWINDOW_APPLYBUTTON_LABEL;
            this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.applyButton);
        }
        
        override protected function setData(param1:RefSysReferralsIntroVO) : void
        {
            this.titleTF.htmlText = param1.titleTF;
            this.bodyTF.htmlText = param1.bodyTF;
            this.squadTF.htmlText = param1.squadTF;
            param1.dispose();
            var param1:RefSysReferralsIntroVO = null;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.applyButton.label = MENU.REFERRALREFERRERINTROWINDOW_APPLYBUTTON_LABEL;
            window.title = MENU.REFERRALREFERRERINTROWINDOW_WINDOWTITLE;
            window.useBottomBtns = true;
            this.updateElements();
        }
        
        override protected function onDispose() : void
        {
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            this.squadTF = null;
            this.bodyTF = null;
            this.titleTF = null;
            this.squadIcon.dispose();
            this.squadIcon = null;
            this.bgImage.dispose();
            this.bgImage = null;
            super.onDispose();
        }
        
        private function updateElements() : void
        {
            this.applyButton.x = this._width - this.applyButton.width >> 1;
        }
        
        private function onClickApplyBtnHandler(param1:ButtonEvent) : void
        {
            onClickApplyBtnS();
        }
    }
}
