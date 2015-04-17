/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import xvm.profile.components.*;

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
            technique = new TechniquePage(this, XvmGlobals[XvmGlobals.CURRENT_USER_NAME]);
            addChild(technique);
        }

        public function as_responseVehicleDossierXvm(data:Object):void
        {
            if(_baseDisposed)
                return;
            try
            {
                technique.as_responseVehicleDossierXvm(new VehicleDossier(data));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
