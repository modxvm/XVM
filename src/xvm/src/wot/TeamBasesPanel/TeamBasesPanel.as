/**
 * @author ilitvinov
 */
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
        //Utils.TraceXvmModule("TeamBasesPanel");
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
        super.add(id, sortWeight, colorFeature, title, points);
    }
    
    function remove(id)
    {
        /**
         * Real purpose unknown.
         * Independently ticks every 0.5 seconds
         * for vstre4nii battle type while capturing.
         * TODO: check tick rate at standart battle type.
         *
         * Ticks when someone touches circle. 
         * Capture can be still abcent at that moment.
         */
        Logger.add("* tick");
        super.remove(id);
    }
    
    function stopCapture(id, points)
    {
        /**
         * Enemy tank blocks capture.
         * Bar blinks white.
         */
        Logger.add("stopCapture(id = " + id + ", points = " + points + ")");
        super.stopCapture(id, points);
    }
    
    function updatePoints(id, points)
    {
        Logger.add("updatePoints(id = " + id + ", points = " + points + ")");
        super.updatePoints(id, points);
    }
    
    function getPoints(id)
    {
        Logger.add("getPoints(id = " + id + ")");
        super.getPoints(id);
    }
    
    function setCaptured(id, title)
    {
        Logger.add("setCaptured(id = " + id + ", title = " + title + ")");
        super.setCaptured(id, title);
    }
    
    function createCaptureBar(index, initProps)
    {
        Logger.add("createCaptureBar######");
        return (gfx.core.UIComponent.createInstance(this, "CaptureBar", "bar" + index, index, initProps));
    }
    
    // Called when bar should be reset to empty
    function draw()
    {
        Logger.add("draw()");
        super.draw();
    }
}