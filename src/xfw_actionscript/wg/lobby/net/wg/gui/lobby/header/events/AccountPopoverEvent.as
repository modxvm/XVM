package net.wg.gui.lobby.header.events
{
    import flash.events.Event;

    public class AccountPopoverEvent extends Event
    {

        public static const CLICK_ON_MAIN_BUTTON:String = "clickOnMainButton";

        public static const OPEN_CLAN_RESEARCH:String = "openClanResearch";

        public static const OPEN_REQUEST_INVITE:String = "openRequestInvite";

        public static const OPEN_REFERRAL_MANAGEMENT:String = "openReferralManagement";

        public static const OPEN_INVITE:String = "openInvite";

        public function AccountPopoverEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
    }
}
