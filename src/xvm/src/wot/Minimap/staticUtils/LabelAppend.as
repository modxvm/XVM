import wot.Minimap.MinimapEntry;
import wot.Minimap.model.MinimapMacro;
import wot.Minimap.model.MapConfig;
import flash.geom.Point;

class wot.Minimap.staticUtils.LabelAppend
{
    public static function append(mc:MovieClip, player:Object, entryName:String, offset:Point):TextField
    {
        var textField:TextField = mc.createTextField("textField-" + player.uid + entryName, mc.getNextHighestDepth(), offset.x, offset.y, 100, 20);
        textField.antiAliasType = "advanced";
        textField.html = true;
        
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(getCSS(entryName));
        textField.styleSheet = style;
        
        textField.htmlText = "<span class='xvm_mm'>" + getText(entryName, player) + "</span>"; //getText()
        
        return textField;
    }
    
    // -- Private
    
    private static function getCSS(entryName:String):String
    {
        var style:String;

        switch (entryName)
        {
            case MinimapEntry.MINIMAP_ENTRY_TYPE_ALLY:
                style = MapConfig.cssAlly;
                break;
            case MinimapEntry.MINIMAP_ENTRY_TYPE_ENEMY:
                style = MapConfig.cssEnemy;
                break;
            case MinimapEntry.MINIMAP_ENTRY_TYPE_SQUAD:
                style = MapConfig.cssSquad;
                break;
            case MinimapEntry.MINIMAP_ENTRY_TYPE_LOST:
                style = MapConfig.cssLostenemy;
                break;
            default:
                style = MapConfig.cssOneself;
        }
        
        style = ".xvm_mm{" + style + "}";

        return style;
    }
    
    private static function getText(entryName:String, player:Object):String
    {
        var text:String;
        
        switch (entryName)
        {
            case "ally":
                text = MapConfig.formatAlly;
                break;
            case "enemy":
                text = MapConfig.formatEnemy;
                break;
            case "squadman":
                text = MapConfig.formatSquad;
                break;
            case "lostenemy":
                text = MapConfig.formatLostenemy;
                break;
            default:
                text = MapConfig.formatOneself;
        }
        
        return MinimapMacro.process(text, player);
    }
}