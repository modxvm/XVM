class net.wargaming.managers.XMLKeyConverter
{
    var textField, string;
    function XMLKeyConverter()
    {
    } // End of the function
    function convert(key)
    {
        textField = _root.createTextField("convertingTextField", _root.getNextHighestDepth(), -1000, -1000, 1, 1);
        textField.text = key;
        string = _root.convertingTextField.text;
        textField.removeTextField();
        return (string);
    } // End of the function
} // End of Class
