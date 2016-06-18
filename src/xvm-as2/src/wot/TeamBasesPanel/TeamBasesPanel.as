// AS3:DONE import com.xvm.*;
// AS3:DONE import com.xvm.events.*;
// AS3:DONE 
// AS3:DONE class wot.TeamBasesPanel.TeamBasesPanel
// AS3:DONE {
// AS3:DONE     /////////////////////////////////////////////////////////////////
// AS3:DONE     // wrapped methods
// AS3:DONE 
// AS3:DONE     private var wrapper:net.wargaming.ingame.TeamBasesPanel;
// AS3:DONE     private var base:net.wargaming.ingame.TeamBasesPanel;
// AS3:DONE 
// AS3:DONE     public function TeamBasesPanel(wrapper:net.wargaming.ingame.TeamBasesPanel, base:net.wargaming.ingame.TeamBasesPanel)
// AS3:DONE     {
// AS3:DONE         this.wrapper = wrapper;
// AS3:DONE         this.base = base;
// AS3:DONE         TeamBasesPanelCtor();
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // wrapped methods
// AS3:DONE     /////////////////////////////////////////////////////////////////
// AS3:DONE 
// AS3:DONE     public function TeamBasesPanelCtor()
// AS3:DONE     {
// AS3:DONE         Utils.TraceXvmModule("TeamBasesPanel");
// AS3:DONE         GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, this, onConfigLoaded);
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // PRIVATE
// AS3:DONE 
// AS3:DONE     private function onConfigLoaded()
// AS3:DONE     {
// AS3:DONE         wrapper._rendererHeight += Macros.FormatGlobalNumberValue(Config.config.captureBar.distanceOffset, 0);
// AS3:DONE     }
// AS3:DONE }
