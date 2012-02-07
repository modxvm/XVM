class net.wargaming.ingame.PlayersPanelTypeButton extends gfx.controls.Button
{
    var addEventListener, _type, type_mc, __get__type, _tooltip, __get__tooltip, __set__tooltip, __set__type;
    function PlayersPanelTypeButton()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        this.addEventListener("rollOver", this, "showTooltip");
        this.addEventListener("rollOut", this, "hideTooltip");
        this.addEventListener("click", this, "hideTooltip");
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function set type(value)
    {
        _type = value;
        type_mc.gotoAndPlay(_type);
        //return (this.type());
        null;
    } // End of the function
    function get tooltip()
    {
        return (_tooltip);
    } // End of the function
    function set tooltip(value)
    {
        _tooltip = value;
        //return (this.tooltip());
        null;
    } // End of the function
    function showTooltip()
    {
        if (_root.g_cursorVisible)
        {
            net.wargaming.managers.ToolTipManager.showComplex(_tooltip);
        } // end if
    } // End of the function
    function hideTooltip()
    {
        net.wargaming.managers.ToolTipManager.hide();
    } // End of the function
} // End of Class
