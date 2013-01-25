/**
 * Simplified minimap interface for communication with other Python or Flash mods.
 * 
 * TODO:
 * ) make forum topic
 */
class wot.Minimap.ExternalDeveloperInterface
{
    /**
     * Creates custom HTML text field at minimap.
     * Respects minimap scaling.
     * 
     * @param x - field coordinates.
     * @param y
     * Map center is (0, 0). Map side seems to always be 211. Floating point is acceptable.
     * 
     * @param format - custom text and\or HTML image
     * 
     * @param instanceName - internal flash identificator.
     * Maybe this can help to modify or delete marker.
     * 
     * @param styleConfig - CSS
     * @param alpha - transparency 0 - 100
     * 
     * @param width - text field size
     * @param height
     * Increase in case field content does not fit its frame and gets partially cut off
     * Decrease in case whole background map image shrinks.
     * 
     * Flash example:
     * 
     * Place code anywhere inside battle interface flash files. PlayersPanel.swf, DamagePanel.swf etc.
     * VehicleMarkersManager.swf is not allowed because of sandbox restrictions.
     * Minimap.swf, PlayersPanel.swf, DamagePanel.swf etc
     * is placed at different sandbox relative to and VehicleMarkersManager.swf
     * 
     * _root.minimap.externalDeveloperInterface.createCustomMarker(-40, 30.5, "foo");
     * _root.minimap.externalDeveloperInterface.createCustomMarker(-10, 10.5, "bar", null, 50);
     * _root.minimap.externalDeveloperInterface.createCustomMarker(-10, 10.5, "bar", null, 50, 60, 30);
     * 
     * _root.minimap.externalDeveloperInterface.createCustomMarker
     * (-40, 30.5, "foo<img src='img://../icons/bzz.png' width='8' height='8'>");
     * WoT\res_mods\icons\bzz.png
     * 
     * Python example:
     * 
     * Place code at minimap context.
     * self.__parentUI.call('minimap.externalDeveloperInterface.createCustomMarker', [-40, 30.5, "foo"])
     */
    public function createCustomMarker
    (
        x:Number,
        y:Number,
        format:String,
        instanceName:String,
        styleConfig:String,
        alpha:Number,
        width:Number,
        height:Number
    )
    {
        /**
         * There is no default argument values capability for AS2.
         * Workaround.
         * ---------------
         */
        if (!instanceName)
        {
            instanceName = "customInstance";
        }
        
        if (!styleConfig)
        {
            styleConfig = "font-family:$FieldFont; font-size:8px; color:#BBEEBB;";
        }
        
        if (!alpha)
        {
            alpha = 100;
        }
        
        if (!width)
        {
            width = 80;
        }
        
        if (!height)
        {
            height = 30;
        }
        
        /** ------------- */
        
        /**
         * MovieClip.createTextField method manual
         * http://help.adobe.com/en_US/AS2LCR/Flash_10.0/help.html?content=00001286.html
         */
        var tf:TextField = icons.createTextField(instanceName, icons.getNextHighestDepth(), x, y, width, height);
        tf.antiAliasType = "advanced";
        tf.html = true;
        tf.multiline = true;
        tf.selectable = false;
        
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(".custom{" + styleConfig + "}");
        tf.styleSheet = style;
        
        tf.htmlText = "<span class='custom'>" + format + "</span>";
        
        tf._alpha = alpha;
    }
    
    // -- Private
    
    /**
     * icons:MovieClip is Minimap.as field.
     * Contains MinimapEntry objects representing tanks\bases\cap points\cameras.
     */
    private function get icons():MovieClip
    {
        return _root.minimap.icons;
    }
}
