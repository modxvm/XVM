package xvm.comments.UI
{
    public dynamic class UI_ContactsMutedRoster extends ContactsMutedRosterUI
    {
        public function UI_ContactsMutedRoster()
        {
            super();
            rosterList.itemRenderer = UI_UserRosterItemRenderer;
        }
    }
}
