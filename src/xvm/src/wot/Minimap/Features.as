import wot.Minimap.Minimap;
import wot.Minimap.model.externalProxy.MapConfig;
import wot.Minimap.LostMarkers;
import wot.Minimap.model.mapSize.MapSizeModel;
import wot.Minimap.MapSizeLabel;
import com.xvm.Utils;
import com.xvm.GlobalEventDispatcher;
import wot.Minimap.Zoom;
import wot.Minimap.shapes.Square;
import wot.Minimap.ExternalDeveloperInterface;
import wot.Minimap.MinimapEntry;
import wot.Minimap.MinimapEvent;
import wot.Minimap.shapes.Lines;
import wot.Minimap.shapes.Circles;
import wot.Minimap.model.iconTracker.SyncModel;
import wot.Minimap.model.iconTracker.AutoUpdate;
import wot.Minimap.model.externalProxy.IconsProxy;

class wot.Minimap.Features
{
    private var minimap:Minimap;
    
    public function Features(minimap:Minimap) 
    {
        this.minimap = minimap;
    }
    
    public function apply():Void
    {
        
    }
}
