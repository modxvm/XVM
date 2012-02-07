class gfx.ui.InputDetails
{
    var type, code, value, navEquivalent;
    function InputDetails(type, code, value, navEquivalent)
    {
        this.type = type;
        this.code = code;
        this.value = value;
        this.navEquivalent = navEquivalent;
    } // End of the function
    function toString()
    {
        return (["[InputDelegate", "code=" + code, "type=" + type, "value=" + value, "navEquivalent=" + navEquivalent + "]"].toString());
    } // End of the function
} // End of Class
