/**
 * @author ilitvinov
 */

import wot.TeamBasesPanel.CapConfig;
import com.xvm.Utils;

/**
* Creates and manages CaptureBar instances.
*/

class wot.TeamBasesPanel.TeamBasesPanel
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.ingame.TeamBasesPanel;
    private var base:net.wargaming.ingame.TeamBasesPanel;

    public function TeamBasesPanel(wrapper:net.wargaming.ingame.TeamBasesPanel, base:net.wargaming.ingame.TeamBasesPanel)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("TeamBasesPanel");
    }

    function add()
    {
        return this.addImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    function addImpl(id, sortWeight, capColor, title, points)
    {
        if (CapConfig.enabled)
        {
            /**
            * null, null args somehow allow to set XVM-specific vals
            * at the very first moment capture bar appears.
            *
            * Passing original values make text properties original
            * at that first moment.
            */
            base.add(id, sortWeight, capColor, null, null);
            /**
            * This array is defined at parent original WG class.
            * start() is XVMs method at worker CaptureBar class.
            */
            wrapper.captureBars[wrapper.indexByID[id]]["_xvm_worker"].start(points, capColor);
        }
        else
        {
            base.add(id, sortWeight, capColor, title, points);
        }
    }
}
