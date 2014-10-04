package xvm.comments.UI
{
    public dynamic class UI_ContactsClanRoster extends ContactsClanRosterUI
    {
        public function UI_ContactsClanRoster()
        {
            super();
            rosterList.itemRenderer = UI_UserRosterItemRenderer;
        }
    }
}
