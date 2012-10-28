/**
 * @author ilitvinov
 */

import wot.TeamBasesPanel.CapConfig;
import wot.utils.Utils;

/**
 * Creates and manages CaptureBar instances.
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
           /**
            * null, null args somehow allow to set XVM-specific vals
            * at the very first moment capture bar appears.
            * 
            * Passing original values make text properties original
            * at that first moment.
            */
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
