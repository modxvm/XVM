/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import xvm.profile_ui.components.*;

    public dynamic class UI_ProfileTechniquePage extends ProfileTechniquePage_UI
    {
        private var technique:Technique;

        public function UI_ProfileTechniquePage()
        {
            super();
        }

        override protected function onPopulate():void
        {
            super.onPopulate();
            technique = new TechniquePage(this, Xfw.cmd(XvmCommands.GET_PLAYER_NAME));
            addChild(technique);
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

        public function as_xvm_sendAccountData():void
        {
            if (_baseDisposed)
                return;

            try
            {
                if (technique)
                    technique.as_xvm_sendAccountData();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function as_responseVehicleDossierXvm(data:Object):void
        {
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
