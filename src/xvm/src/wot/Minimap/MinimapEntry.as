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
    private var playerInfo:Object;
    
    private var _isDeadPermanent:Boolean;
    private var _isPostmortem:Boolean;
    
    function lightPlayer(visibility)
    {
        /** Behavior is altered temporarily so original icon highlighting works */
        if (syncProcedureInProgress)
        {
            uid = _root.minimap.sync.getTestUid();
            playerInfo = PlayersPanelProxy.getPlayerInfo(uid);
            
            appendText();
        }
        else
        {
            super.lightPlayer(visibility);
        }
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
        
        return MinimapMacro.process(text, playerInfo);
    }
    
    private function get syncProcedureInProgress():Boolean
    {
        return _root.minimap.sync.syncProcedureInProgress
    }
}
