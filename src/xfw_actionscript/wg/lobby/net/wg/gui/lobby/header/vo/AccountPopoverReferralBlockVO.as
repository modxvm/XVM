package net.wg.gui.lobby.header.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class AccountPopoverReferralBlockVO extends DAAPIDataClass
    {

        public var invitedText:String = "";

        public var moreInfoText:String = "";

        public var isLinkBtnEnabled:Boolean = false;

        public function AccountPopoverReferralBlockVO(param1:Object)
        {
            super(param1);
        }
    }
}
