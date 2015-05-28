/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile_ui
{
    import com.xfw.*;
    import fl.transitions.easing.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import net.wg.gui.utils.*;
    import scaleform.clik.motion.*;
    import xvm.profile_ui.components.*;

    public dynamic class UI_TechniqueStatisticTab extends TechniqueStatisticTab_UI
    {
        private var worker:TechniqueStatisticTab;

        public function UI_TechniqueStatisticTab()
        {
            super();
            worker = new TechniqueStatisticTab(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override protected function onDispose():void
        {
            super.onDispose();
            worker.onDispose();
        }

        override public function update(arg1:Object):void
        {
            if (_baseDisposed)
                return;

            worker.update(arg1 as ProfileVehicleDossierVO);
            super.update(arg1);

            if (xfw_group.unitRendererClass != UI_TechnicsDashLineTextItemIRenderer)
                xfw_group.unitRendererClass = UI_TechnicsDashLineTextItemIRenderer;
        }

        // PUBLIC

        public function get baseDisposed():Boolean
        {
            return _baseDisposed;
        }
    }
}
