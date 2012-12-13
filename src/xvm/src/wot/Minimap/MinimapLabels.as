import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.Minimap.model.VehiclePositionTracking;
import wot.utils.Logger;
import wot.Minimap.model.MapConfig;

/**
 * TODO: separate ally\enemy alive\dead
 */
class wot.Minimap.MinimapLabels
{
    /** Sends event when lost player take place */
    private var tracking:VehiclePositionTracking;
    
    /** TextFiels are attached to this. Returns Minimap.icons MovieClip */
    private var labelsContainer:MovieClip;
    
    /**
     * Accounting is essential for invalid labels remove and
     * avoiding redundant new labels attach.
     */
    private var labelTracking:Array;
    
    private var lost:Array;
        
    public function MinimapLabels(cont:MovieClip) 
    {
        labelsContainer = cont;
        labelTracking = [];
        tracking = new VehiclePositionTracking();
        
        GlobalEventDispatcher.addEventListener(MinimapEvent.LOST_PLAYERS_UPDATE, this, onLostPlayersUpdate);
    }
        
    private function onLostPlayersUpdate(event:MinimapEvent):Void
    {
        //Logger.addObject(event, "mm.mlabels.onLostPlayersUpdate.event", 3);
        lost = Array(event.payload);
        
        //Logger.add("");
        //Logger.add("ml.upd");
        
        removeAllLabels();
        createAllLabels();
    }
    
    private function removeAllLabels():Void
    {
        for (var i in labelTracking)
        {
            var tf:TextField = labelTracking[i];
            tf.removeTextField();
        }
    }
    
    private function createAllLabels():Void
    {
        /** Find UIDs that present in lost but are absent in labels */
        for (var i in lost)
        {
            /*
             * New TextField is attached to Minimap at this moment.
             */
            var tf:TextField = createLabel(lost[i]);
            
            /**
             * Pointer to its address is tracked to handle proper remove
             * and to avoid unnecessary new identical TextField creation.
             */
            labelTracking.push(tf);
        }
    }
    
    private function createLabel(player:Object):TextField
    {
        /** New TextField is attached to Minimap at this moment */
        var textField:TextField = labelsContainer.createTextField(player.uid, labelsContainer.getNextHighestDepth(), player.x, player.y, 70, 20);
        textField.html = true;
        textField.antiAliasType = "advanced";
        
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(".xvm_mm{" + MapConfig.cssLostenemy + "}");
        textField.styleSheet = style;
        
        //var text:String = MapConfig.formatLostenemy + " " + player.uid;
        //MinimapMacro.process(text, player)
        textField.htmlText = "<span class='xvm_mm'>" + player.uid + "</span>";
        
        return textField;
    }
}
