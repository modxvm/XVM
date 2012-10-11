import flash.filters.DropShadowFilter;
import wot.utils.Utils;

class wot.VehicleMarkersManager.ErrorHandler
{
    private static var errorCounter: Number = 0;
    private static var errorText: String = "";
    
    public static function setText(str)
    {
        if (!_root.hasOwnProperty("xvmErrorText"))
            createErrorField();

        errorText += "[" + Utils.padLeft((errorCounter++).toString(), 3, '0') + "] " + str + "\n";
        while ((errorText.split("\n")).length > 15)
            errorText = errorText.slice(errorText.indexOf("\n") + 1, errorText.length - 1);
        _root.xvmErrorText.htmlText += 
            "<p align='left'><font face='$FieldFont' size='13' color='#FF6666'>" + errorText + "</font></p>";
    }
    
    private static function createErrorField()
    {
        var et: TextField = _root.createTextField("xvmErrorText", _root.getNextHighestDepth(), 200, 40, 1000, 300);
        et.antiAliasType = "advanced";
        et.wordWrap = true;
        et.multiline = true;
        et.setNewTextFormat(new TextFormat("$FieldFont", 12, 0xFF6666, false, false, false, null, null, "left"));
        et.html = true;
        et.filters = [new DropShadowFilter(0, 0, 0, 100, 3, 3, 2, 3)];
    }
}