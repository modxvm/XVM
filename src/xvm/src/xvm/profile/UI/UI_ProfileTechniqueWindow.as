/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.lobby.window.*;
    import xvm.profile.components.*;

    public dynamic class UI_ProfileTechniqueWindow extends ProfileTechniqueWindow_UI
    {
        private var technique:Technique;

        public function UI_ProfileTechniqueWindow()
        {
            //Logger.add("UI_ProfileTechniqueWindow");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
        }

        override protected function onPopulate():void
        {
            //Logger.add("onPopulate");
            super.onPopulate();

            var profileWindow:ProfileWindow = this.parent.parent.parent.parent as ProfileWindow;
            if (profileWindow == null)
            {
                Logger.add("WARNING: [UI_ProfileTechniqueWindow] Cannot find ProfileWindow");
                return;
            }

            // get player name from window title
            var playerName:String = WGUtils.GetPlayerName((profileWindow.window as Window).title);

            // get player id from the view name.
            var playerId:int = parseInt(profileWindow.as_name.replace("profileWindow_", ""));

            technique = new TechniqueWindow(this, playerName, playerId)
            addChild(technique);
        }

        override protected function onDispose():void
        {
            if (technique != null)
            {
                removeChild(technique);
                technique.dispose();
                technique = null;
            }
            super.onDispose();
        }

        // PUBLIC

        public function get currentDataXvm():Object
        {
            return currentData;
        }

        public function get battlesTypeXvm():String
        {
            return battlesType;
        }

        public function get baseDisposed():Boolean
        {
            return _baseDisposed;
        }

        public function as_responseDossierXvm(battlesType:String, vehicles:Object):void
        {
            if (_baseDisposed)
                return;

            try
            {
                if (technique)
                    technique.as_responseDossierXvm(battlesType, vehicles);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function as_responseVehicleDossierXvm(data:Object):void
        {
            //Logger.add("as_responseVehicleDossierXvm");
            if (_baseDisposed)
                return;

            try
            {
                var vdossier:VehicleDossier = new VehicleDossier(data);
                if (vdossier != null)
                {
                    Dossier.setVehicleDossier(vdossier);
                    if (technique)
                        technique.as_responseVehicleDossierXvm(vdossier);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
