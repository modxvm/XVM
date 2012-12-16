import flash.geom.Point;
import wot.Minimap.MinimapEvent;
import wot.Minimap.model.MinimapMacro;
import wot.Minimap.model.PlayersPanelProxy;
import wot.Minimap.model.MapConfig;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;

/**
 * MinimapEntry represent individual object on map.
 * One tank icon, base capture point, starting point or player himself.
 * 
 * MinimapEntry object at Minimap is called icon.
 * 
 * Extended behaviour:
 * ) Appending extra information about unit like level, type, nick etc.
 *   This aspect is handled by Minimap class also.
 * ) Remain disappeared icons to indicate last enemy position.
 *   Only this class handles this aspect.
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
    
    /** Link to macro parser */
    private var macro:MinimapMacro;
    private var playerInfo:Object;
    
    function lightPlayer(visibility)
    {
        /** Behavior is altered temporarily so original icon highlighting works */
        if (syncProcedureInProgress)
        {
            initExtendedBehaviour();
        }
        else
        {
            super.lightPlayer(visibility);
        }
    }
    
    function setDead(isPermanent)
    {
        Logger.add("setDead " + uid);
        isDead = true;
        isDeadPermanent = isPermanent;
        this.invalidate();
    }
    
    function setPostmortem(isPostmortem)
    {
        Logger.add("setPostmortem(" + isPostmortem + ")");
        this.isPostmortem = isPostmortem;
        this.invalidate();
    } // End of the function
    
    /**
     * Unit remove invoked by Python.
     * Possibly enemy disappear\loose from view event
     * or very far out of sight position change.
     * XVM extension dont want icons to disappear.
     * Let them be to indicate last enemy position.
     */
    function removeMovieClip()
    {
        if (uid && entryName == "enemy")
        {
            /**
             * This icon should remain until subject appears in new place or dies.
             * Shows last enemy position with info attached.
             */
            fadeOut();
        }
        else
        {
            super.removeMovieClip();
        }
    }
    
    // -- Private
    
    private function fadeOut():Void
    {
        this._alpha = 30;
        Logger.add("removeMovieClip " + uid % 100 + " at " + _x + "/" + _y);
    }
    
    private function initExtendedBehaviour():Void
    {
        uid = _root.minimap.sync.getTestUid();
        playerInfo = PlayersPanelProxy.getPlayerInfo(uid);
        appendExtraInfoToUI();
        
        if (entryName == "enemy")
        {
            /**
             * Remove obsolete icon:MinimapEntry showing last enemy unit position with the same uid,
             * because this icon is its actual position and represents moving unit curretnly revealed.
             * Nothing is removed by event in case no icon at last position present.
             */
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.REMOVE_OBSOLETE_ICON, uid));
            
            /** Get ready to be removed when icon with the same uid appears at new position or dies */
            GlobalEventDispatcher.addEventListener(MinimapEvent.REMOVE_OBSOLETE_ICON, this, onRemoveObsoleteIcon);
        }
    }
    
    private function onRemoveObsoleteIcon(event:MinimapEvent):Void
    {
        if (uid == event.payload.uid)// && isLost == true)
        {
            Logger.add("onRemoveObsoleteIcon(e) " + uid);
            /**
             * This icon in lost state is obsolete.
             * Subject appeared with new icon or dead.
             */
            super.removeMovieClip();
        }
    }
    
    private function appendExtraInfoToUI():Void
    {
        // TODO: {{vehicle-short}}
        var offset:Point = MapConfig.textOffset;
        
        var textField:TextField = markMC.createTextField("textField", 1, offset.x, offset.y, 100, 20);
        textField.antiAliasType = "advanced";
        textField.html = true;
       
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(getCSS());
        textField.styleSheet = style;
        
        textField.htmlText = "<span class='xvm_mm'>" + uid % 100 + "</span>"; //getText()
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
