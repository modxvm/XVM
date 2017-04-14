/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import com.xvm.lobby.ui.profile.components.*;

    public dynamic class UI_ProfileTechniquePage extends ProfileTechniquePage_UI
    {
        private var technique:Technique;

        public function UI_ProfileTechniquePage()
        {
            super();
        }

        override protected function onPopulate():void
        {
            //Logger.add("UI_ProfileTechniquePage.onPopulate");
            super.onPopulate();
            try
            {
                technique = new TechniquePage(this, Xfw.cmd(XvmCommands.GET_PLAYER_NAME));
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

        override public function as_setSelectedVehicleIntCD(itemCD:Number):void
        {
            super.as_setSelectedVehicleIntCD(itemCD);
            if (technique)
            {
                technique.setSelectedVehicleIntCD(itemCD);
            }
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

        public function as_responseVehicleDossierXvm(data:Object):void
        {
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
