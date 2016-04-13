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

    private var baseNumText:String = "";

    function TeamBasesPanelCtor()
    {
        Utils.TraceXvmModule("TeamBasesPanel");
    }

    function addImpl(id, sortWeight, colorFeature, title, points, rate)
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
            base.add(id, sortWeight, colorFeature, null, null, null);

            // Get capture base number text
            baseNumText = DAAPI.xvm_captureBarGetBaseNumText(id);

            /**
            * This array is defined at parent original WG class.
            * start() is XVMs method at worker CaptureBar class.
            */
            wrapper.captureBars[wrapper.indexByID[id]].xvm_worker.start(points, colorFeature, rate, baseNumText);
        }
        else
        {
            base.add.apply(base, arguments);
        }
    }

    // PRIVATE

    function onCaptureBarGetBaseNum(num:String)
    {
        baseNumText = num;
    }
}
