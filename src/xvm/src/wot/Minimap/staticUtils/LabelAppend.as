import wot.Minimap.staticUtils.MinimapMacro;
import wot.Minimap.model.externalProxy.MapConfig;
import flash.geom.Point;
import wot.Minimap.dataTypes.Player;
import wot.Minimap.model.externalProxy.PlayersPanelProxy;

class wot.Minimap.staticUtils.LabelAppend
{
    public static function append(mc:MovieClip, uid:Number, entryName:String, vehicleClass:String, scale:Number, extraOffset:Point):TextField
    {
        var offset:Point = MapConfig.unitLabelOffset(entryName);
        if (extraOffset)
        {
            /**
             * Used for lost markers.
             * Large values transferred in comparison to config offset.
             * (-4; -4) - config offset for lost. (-50; 30) - major offset for lost to present lost position.
             */
            offset = offset.add(extraOffset);
        }
        
        var player:Player = PlayersPanelProxy.getPlayerInfo(uid);
        
        var textField:TextField = mc.createTextField("textField-" + player.uid + entryName, mc.getNextHighestDepth(), offset.x, offset.y, 100, 40);
        textField.antiAliasType = "advanced";
        textField.html = true;
        textField.multiline = true;
        textField.selectable = false;
        
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(getCSS(entryName));
        textField.styleSheet = style;
        
        /**
         * LostMarkers does not have scaling applied by parent.
         * Applying manually.
         */
        if (scale)
        {
            textField._xscale = scale;
            textField._yscale = scale;
        }
        
        textField.htmlText = "<span class='xvm_mm'>" + getText(entryName, player, vehicleClass) + "</span>"; //getText()
        
        if (MapConfig.unitShadowEnabled(entryName))
        {
            textField.filters = [MapConfig.unitShadow(entryName)];
        }
        
        return textField;
    }
    
    // -- Private
    
    private static function getCSS(entryName:String):String
    {
        var style:String = MapConfig.unitLabelCss(entryName);

        style = ".xvm_mm{" + style + "}";

        return style;
    }
    
    private static function getText(entryName:String, player:Player, vehicleClass:String):String
    {
        var format:String = MapConfig.unitLabelFormat(entryName);
        
        return MinimapMacro.process(format, player, vehicleClass);
    }
}