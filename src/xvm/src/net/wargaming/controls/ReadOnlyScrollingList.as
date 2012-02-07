class net.wargaming.controls.ReadOnlyScrollingList extends gfx.controls.ScrollingList
{
    var dispatchItemEvent;
    function ReadOnlyScrollingList()
    {
        super();
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        return (false);
    } // End of the function
    function handleItemClick(event)
    {
        var _loc2 = event.target.index;
        if (isNaN(_loc2))
        {
            return;
        } // end if
        this.dispatchItemEvent(event);
    } // End of the function
} // End of Class
