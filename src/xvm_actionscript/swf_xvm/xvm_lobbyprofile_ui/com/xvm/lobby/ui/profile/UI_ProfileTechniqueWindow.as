/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.ui.profile.components.*;
    import com.xvm.types.dossier.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.lobby.window.*;

    public dynamic class UI_ProfileTechniqueWindow extends ProfileTechniqueWindow_UI
    {
        private var technique:Technique;

        public function UI_ProfileTechniqueWindow()
        {
            //Logger.add("UI_ProfileTechniqueWindow");
            super();
        }

        override protected function onPopulate():void
        {
            //Logger.add("UI_ProfileTechniqueWindow.onPopulate");
            super.onPopulate();
            try
            {
                var profileWindow:ProfileWindow = this.parent.parent.parent.parent as ProfileWindow;
                if (profileWindow == null)
                {
                    Logger.add("WARNING: [UI_ProfileTechniqueWindow] Cannot find ProfileWindow");
                    return;
                }

                // get player name from window title
                var playerName:String = XfwUtils.GetPlayerName((profileWindow.window as Window).title);

                // get player id from the view name.
                var accountDBID:int = parseInt(profileWindow.as_config.name.replace("profileWindow_", ""));

                technique = new Technique(this, playerName, accountDBID)
                addChild(technique);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function onDispose():void
        {
            if (technique)
            {
                removeChild(technique);
                technique.dispose();
                technique = null;
            }
            super.onDispose();
        }

        override public function as_setInitData(param1:Object):void
        {
            try
            {
                if (technique)
                {
                    technique.fixInitData(param1);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            super.as_setInitData(param1);
        }

        override protected function applyData(param1:Object):void
        {
            super.applyData(param1);
            try
            {
                if (technique)
                {
                    technique.applyData(param1);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function as_responseDossier(param1:String, param2:Object, param3:String, param4:String):void
        {
            //Logger.add("as_responseDossier");
            super.as_responseDossier(param1, param2, param3, param4);
            try
            {
                if (technique)
                {
                    technique.fixStatData();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PUBLIC

        public function get currentDataXvm():Object
        {
            return currentData;
        }

        public function as_responseVehicleDossierXvm(data:Object):void
        {
            //Logger.add("as_responseVehicleDossierXvm");
            if (_baseDisposed)
                return;

            try
            {
                var vdossier:VehicleDossier = new VehicleDossier(data);
                if (vdossier)
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
