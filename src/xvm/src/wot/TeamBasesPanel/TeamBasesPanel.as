/**
 * @author ilitvinov
 */
import wot.TeamBasesPanel.InternalTimer;
import wot.utils.Logger

/**
  * Creates and manages capture bar mc library instances.
 */

class wot.TeamBasesPanel.TeamBasesPanel extends net.wargaming.ingame.TeamBasesPanel
{
    var _itemRenderer = "XCaptureBar";
    
    public function TeamBasesPanel() 
    {
        super();
        Logger.add("TeamBasesPanel()");
        
        // TODO:
        // Utils.TraceXvmModule("TeamBasesPanel");
    }
    
    function add(id, sortWeight, colorFeature, title, points)
    {
        Logger.add(
        "add(id = " + id +
        ", sortWeight = " + sortWeight +
        ", colorFeature = " + colorFeature +
        ", title = " + title +
        ", points = " + points +
        ")");
        Logger.add("");
        super.add(id, sortWeight, colorFeature, title, points);
        captureBars[indexByID[id]].insertTimerRef(new InternalTimer());
    }
}