import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.Minimap.model.UnitPositionTracking;
import wot.Minimap.model.MapConfig;

class wot.Minimap.MinimapLabels
{
    /** Sends event when some unit is lost */
    private var tracking:UnitPositionTracking;
    
    /** TextFiels are attached to this. Actually this is Minimap.icons:MovieClip */
    private var labelsContainer:MovieClip;
    
    /** Keeps pointers to all created minimap extra labels */
    private var labelTracking:Array;
        
    public function MinimapLabels(cont:MovieClip) 
    {
        labelsContainer = cont;
        labelTracking = [];
        
        /** Just keep link alive. Sends position update events. */
        tracking = new UnitPositionTracking();
        
        /** Position update event */
        GlobalEventDispatcher.addEventListener(MinimapEvent.LOST_PLAYERS_UPDATE, this, onLostPlayersUpdate);
    }
        
    private function onLostPlayersUpdate(event:MinimapEvent):Void
    {
        /** No optimization needed. Performance is acceptable. */
        removeAllLabels();
        createAllLabels(Array(event.payload)); /** Array of lost players by UnitPositionTracking */
    }
    
    private function removeAllLabels():Void
    {
        for (var i in labelTracking)
        {
            var tf:TextField = labelTracking[i];
            tf.removeTextField();
        }
    }
    
    private function createAllLabels(lost:Array):Void
    {
        /** Find UIDs that present in lost but are absent in labels */
        for (var i in lost)
        {
            /* New TextField is attached to Minimap at this moment */
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
