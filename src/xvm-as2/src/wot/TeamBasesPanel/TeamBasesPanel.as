/**
 * @author ilitvinov
 */

import com.xvm.*;
import wot.TeamBasesPanel.*;

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
        TeamBasesPanelCtor();
    }

    function add()
    {
        return this.addImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    function TeamBasesPanelCtor()
    {
        Utils.TraceXvmModule("TeamBasesPanel");
    }

    function addImpl(id, sortWeight, capColor, title, points, rate, baseNum)
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
            base.add(id, sortWeight, capColor, null, null, null);

            // Get capture base number text
            Cmd.captureBarGetBaseNum(this, onCaptureBarGetBaseNum, id);

            /**
            * This array is defined at parent original WG class.
            * start() is XVMs method at worker CaptureBar class.
            */
            wrapper.captureBars[wrapper.indexByID[id]].xvm_worker.start(points, capColor, rate, baseNumText);
        }
        else
        {
            base.add.apply(base, arguments);
        }
    }

    // PRIVATE

    private var baseNumText:String = "";

    function onCaptureBarGetBaseNum(num:String)
    {
        baseNumText = num;
    }
}
