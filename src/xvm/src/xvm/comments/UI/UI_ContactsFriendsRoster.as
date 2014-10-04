package xvm.comments.UI
{
    public dynamic class UI_ContactsFriendsRoster extends ContactsFriendsRosterUI
    {
        public function UI_ContactsFriendsRoster()
        {
            super();
            rosterList.itemRenderer = UI_UserRosterItemRenderer;
        }
    }
}
