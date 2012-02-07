class net.wargaming.messenger.controls.BattleMessageList extends net.wargaming.notification.FadingMessageList
{
    function BattleMessageList()
    {
        super();
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        if (details.navEquivalent == gfx.ui.NavigationCode.ENTER)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
} // End of Class
