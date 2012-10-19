/**
 * @author ilitvinov
 */
import wot.utils.Logger;

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    public function CaptureBar()
    {
        Logger.add("CaptureBar #################");
        super();
    }
    
    function updateProgress(points)
    {
        Logger.add("updateProgress(points = " + points + ")");
        super.updateProgress(points);
    }
}