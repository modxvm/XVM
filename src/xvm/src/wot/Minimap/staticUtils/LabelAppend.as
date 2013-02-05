import wot.Minimap.staticUtils.MinimapMacro;
import wot.Minimap.model.externalProxy.MapConfig;
import flash.geom.Point;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.model.externalProxy.PlayersPanelProxy;

class wot.Minimap.staticUtils.LabelAppend
{
    public static function append(container:MovieClip, uid:Number, entryName:String, vehicleClass:String):TextField
    {
        /**
         * Skip creation of textFields with "undefined" string.
         * Happens for oneSelf icon at replay rewind.
         */
            
        var offset:Point = MapConfig.unitLabelOffset(entryName);
        
        var player:Player = PlayersPanelProxy.getPlayerInfo(uid);
        
        var textField:TextField = container.createTextField("textField-" + player.uid + entryName, container.getNextHighestDepth(), offset.x, offset.y, 100, 40);
        textField.antiAliasType = "advanced";
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;
        
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(MapConfig.unitLabelCss(entryName));
        textField.styleSheet = style;
        
        var text:String = getText(entryName, player, vehicleClass);
        if (text == "undefined" || !text)
        {
            text = "";
        }
        textField.htmlText = text;
        
        if (MapConfig.unitShadowEnabled(entryName))
        {
            textField.filters = [MapConfig.unitShadow(entryName)];
        }
        
        textField._alpha = MapConfig.unitLabelAlpha(entryName);
        
        return textField;
    }
    
    // -- Private
    
    private static function getText(entryName:String, player:Player, vehicleClass:String):String
    {
        var format:String = MapConfig.unitLabelFormat(entryName);
        
        return MinimapMacro.process(format, player, vehicleClass);
    }
}