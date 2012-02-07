class gfx.controls.ListItemRenderer extends gfx.controls.Button
{
    var index, __set__label, state, __set__selected, data, _name, owner, focusTarget;
    function ListItemRenderer()
    {
        super();
    } // End of the function
    function setListData(index, label, selected)
    {
        this.index = index;
        if (label == null)
        {
            this.__set__label("Empty");
        }
        else
        {
            this.__set__label(label);
        } // end else if
        state = "up";
        this.__set__selected(selected);
    } // End of the function
    function setData(data)
    {
        this.data = data;
    } // End of the function
    function toString()
    {
        return ("[Scaleform ListItemRenderer " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        focusTarget = owner;
    } // End of the function
    var selectable = true;
} // End of Class
