class net.wargaming.controls.DropListItemRenderer extends net.wargaming.controls.TextFieldShort
{
    var data;
    function DropListItemRenderer()
    {
        super();
    } // End of the function
    function setData(data)
    {
        this.data = data;
        this.update();
    } // End of the function
    function update()
    {
    } // End of the function
    function updateAfterStateChange()
    {
        this.update();
        super.updateAfterStateChange();
    } // End of the function
} // End of Class
