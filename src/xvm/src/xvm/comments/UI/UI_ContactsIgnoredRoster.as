package xvm.comments.UI
{
    public dynamic class UI_ContactsIgnoredRoster extends ContactsIgnoredRosterUI
    {
        public function UI_ContactsIgnoredRoster()
        {
            super();
            rosterList.itemRenderer = UI_UserRosterItemRenderer;
        }
    }
}
