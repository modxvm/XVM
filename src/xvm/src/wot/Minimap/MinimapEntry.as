import flash.geom.Point;
import wot.Minimap.model.MinimapMacro;
import wot.Minimap.model.PlayersPanelProxy;
import wot.Minimap.model.MapConfig;

/**
 * MinimapEntry represent individual object on map.
 * One tank icon, base capture point, starting point or player himself.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.MinimapEntry extends net.wargaming.ingame.MinimapEntry
{
    /**
     * Subject of PlayersPanel <-> Minimap syncronization.
     * Syncronized during light delegate event.
     */
    public var uid:Number;
    
    private var macro:MinimapMacro;
    private var player:Object;
    
    function setDead(isPermanent)
    {
        // If MinimapConfig.enabled
        /** Does not work. No idea why */
        //Logger.add("- MinimapEntry.setDead(" + MapConfig.isDeadPermanent + ")");
        //MapConfig.isDeadPermanent
        //Logger.addObject(_root, "_root", 2);
        //super.setDead(MapConfig.isDeadPermanent);
    }
    
    function lightPlayer(visibility)
    {
        uid = _root.minimap.sync.getTestUid();
        player = PlayersPanelProxy.getPlayerInfo(uid);
        
        appendText();
    }
    
    // -- Private
    
    private function appendText(htmlText:String):Void
    {
        // TODO: {{vehicle-short}}
        var offset:Point = MapConfig.textOffset;
        
        var textField:TextField = markMC.createTextField("textField", 1, offset.x, offset.y, 100, 20);
        textField.antiAliasType = "advanced";
        textField.html = true;
       
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(getCSS());
        textField.styleSheet = style;
        
        textField.htmlText = "<span class='xvm_mm'>" + getText() + "</span>";
    }
    
    private function getCSS():String
    {
        var style:String;

        switch (this.entryName)
        {
            case "ally":
                style = MapConfig.cssAlly;
                break;
            case "enemy":
                style = MapConfig.cssEnemy;
                break;
            case "squadman":
                style = MapConfig.cssSquad;
                break;
            default:
                style = MapConfig.cssOneself;
        }
        
        style = ".xvm_mm{" + style + "}"

        return style;
    }
    
    private function getText():String
    {
        var text:String;
        
        switch (this.entryName)
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
            default:
                text = MapConfig.formatOneself;
        }
        
        return MinimapMacro.process(text, player);
    }
}
