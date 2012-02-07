class net.wargaming.FixedScrollingList extends net.wargaming.ScrollingList
{
    var dispatchItemEvent;
    function FixedScrollingList()
    {
        super();
    } // End of the function
    function handleItemClick(event)
    {
        this.dispatchItemEvent(event);
    } // End of the function
} // End of Class
