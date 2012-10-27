/**
 * @author ilitvinov
 */

import wot.TeamBasesPanel.CapConfig;
import wot.utils.Utils;

/**
 * Creates and manages capture bar mc library instances.
 * Reads config and sends view formatting to CaptureBar instances.
 * See CaptureBar class for implemented extra feature list.
 * 
 * TODO:
 * ) Localization
 * ) Documentaion
 * ) Clean up
 * ) Deploy to test
 */

class wot.TeamBasesPanel.TeamBasesPanel extends net.wargaming.ingame.TeamBasesPanel
{
    var m_xvmCapEnabled:Boolean;
    
    public function TeamBasesPanel() 
    {
        Utils.TraceXvmModule("TeamBasesPanel");
        super();
        m_xvmCapEnabled = CapConfig.enabled;
    }
    
    function add(id, sortWeight, colorFeature, title, points)
    {
        if (m_xvmCapEnabled)
        {
            super.add(id, sortWeight, colorFeature, null, null);
            captureBars[indexByID[id]].start(points);
        }
        else
        {
            super.add(id, sortWeight, colorFeature, title, points);
        }
    }
    
   /**
    * Called when point becomes fully captured.
    * No need to define behavior. updateProgress() handles full capture.
    */
   function setCaptured(id, title){}
}
