import com.xvm.*;
import com.xvm.events.*;

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

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    public function TeamBasesPanelCtor()
    {
        Utils.TraceXvmModule("TeamBasesPanel");
        GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, this, onConfigLoaded);
    }

    // PRIVATE

    private function onConfigLoaded()
    {
        wrapper._rendererHeight += Macros.FormatGlobalNumberValue(Config.config.captureBar.distanceOffset, 0);
    }
}
