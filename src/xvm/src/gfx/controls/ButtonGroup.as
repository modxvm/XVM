class gfx.controls.ButtonGroup extends gfx.events.EventDispatcher
{
    var scope, children, selectedButton, dispatchEvent;
    function ButtonGroup(name, scope)
    {
        super();
        this.name = name;
        this.scope = scope;
        children = [];
    } // End of the function
    function get length()
    {
        return (children.length);
    } // End of the function
    function addButton(button)
    {
        this.removeButton(button);
        children.push(button);
        if (button.__get__selected())
        {
            this.setSelectedButton(button);
        } // end if
        button.addEventListener("select", this, "handleSelect");
        button.addEventListener("click", this, "handleClick");
    } // End of the function
    function removeButton(button)
    {
        var _loc2 = this.indexOf(button);
        if (_loc2 > -1)
        {
            children.splice(_loc2, 1);
            button.removeEventListener("select", this, "handleSelect");
            button.removeEventListener("click", this, "handleClick");
        } // end if
        if (selectedButton == button)
        {
            selectedButton = null;
        } // end if
    } // End of the function
    function indexOf(button)
    {
        var _loc4 = this.__get__length();
        if (_loc4 == 0)
        {
            return (-1);
        } // end if
        for (var _loc2 = 0; _loc2 < this.__get__length(); ++_loc2)
        {
            if (children[_loc2] == button)
            {
                return (_loc2);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    function getButtonAt(index)
    {
        return (children[index]);
    } // End of the function
    function get data()
    {
        return (selectedButton.data);
    } // End of the function
    function setSelectedButton(button)
    {
        if (selectedButton == button || this.indexOf(button) == -1 && button != null)
        {
            return;
        } // end if
        if (selectedButton != null && selectedButton._name != null)
        {
            selectedButton.__set__selected(false);
        } // end if
        selectedButton = button;
        if (selectedButton == null)
        {
            return;
        } // end if
        selectedButton.__set__selected(true);
        this.dispatchEvent({type: "change", item: selectedButton, data: selectedButton.data});
    } // End of the function
    function toString()
    {
        return ("[Scaleform RadioButtonGroup " + name + "]");
    } // End of the function
    function handleSelect(event)
    {
        if (event.target.selected)
        {
            this.setSelectedButton(event.target);
        }
        else
        {
            this.setSelectedButton(null);
        } // end else if
    } // End of the function
    function handleClick(event)
    {
        this.dispatchEvent({type: "itemClick", item: event.target});
        this.setSelectedButton(event.target);
    } // End of the function
    var name = "buttonGroup";
} // End of Class
