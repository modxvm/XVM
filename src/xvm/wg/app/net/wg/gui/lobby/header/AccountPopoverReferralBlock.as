package net.wg.gui.lobby.header
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    
    public class AccountPopoverReferralBlock extends UIComponent
    {
        
        public function AccountPopoverReferralBlock()
        {
            super();
        }
        
        private static var MORE_BTN_X_OFFSET:int = 9;
        
        public var invitedTF:TextField = null;
        
        public var moreInfoTF:TextField = null;
        
        public var moreInfoLinkBtn:SoundButtonEx = null;
        
        public function setData(param1:AccountPopoverReferralBlockVO) : void
        {
            this.invitedTF.htmlText = param1.invitedText;
            this.moreInfoTF.htmlText = param1.moreInfoText;
            App.utils.commons.moveDsiplObjToEndOfText(this.moreInfoLinkBtn,this.moreInfoTF,MORE_BTN_X_OFFSET,0);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.invitedTF = null;
            this.moreInfoTF = null;
            this.moreInfoLinkBtn.dispose();
            this.moreInfoLinkBtn = null;
            super.onDispose();
        }
    }
}
