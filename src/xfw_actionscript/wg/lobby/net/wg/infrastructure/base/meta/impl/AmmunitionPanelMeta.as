package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.modulesPanel.ModulesPanel;
    import net.wg.gui.components.controls.VO.ShellButtonVO;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class AmmunitionPanelMeta extends ModulesPanel
    {

        public var showTechnicalMaintenance:Function;

        public var showCustomization:Function;

        public var toRentContinue:Function;

        public var showChangeNation:Function;

        public var toggleNYCustomization:Function;

        public var onNYBonusPanelClicked:Function;

        private var _vectorShellButtonVO:Vector.<ShellButtonVO>;

        private var _vehicleMessageVO:VehicleMessageVO;

        public function AmmunitionPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:ShellButtonVO = null;
            if(this._vectorShellButtonVO)
            {
                for each(_loc1_ in this._vectorShellButtonVO)
                {
                    _loc1_.dispose();
                }
                this._vectorShellButtonVO.splice(0,this._vectorShellButtonVO.length);
                this._vectorShellButtonVO = null;
            }
            if(this._vehicleMessageVO)
            {
                this._vehicleMessageVO.dispose();
                this._vehicleMessageVO = null;
            }
            super.onDispose();
        }

        public function showTechnicalMaintenanceS() : void
        {
            App.utils.asserter.assertNotNull(this.showTechnicalMaintenance,"showTechnicalMaintenance" + Errors.CANT_NULL);
            this.showTechnicalMaintenance();
        }

        public function showCustomizationS() : void
        {
            App.utils.asserter.assertNotNull(this.showCustomization,"showCustomization" + Errors.CANT_NULL);
            this.showCustomization();
        }

        public function toRentContinueS() : void
        {
            App.utils.asserter.assertNotNull(this.toRentContinue,"toRentContinue" + Errors.CANT_NULL);
            this.toRentContinue();
        }

        public function showChangeNationS() : void
        {
            App.utils.asserter.assertNotNull(this.showChangeNation,"showChangeNation" + Errors.CANT_NULL);
            this.showChangeNation();
        }

        public function toggleNYCustomizationS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.toggleNYCustomization,"toggleNYCustomization" + Errors.CANT_NULL);
            this.toggleNYCustomization(param1);
        }

        public function onNYBonusPanelClickedS() : void
        {
            App.utils.asserter.assertNotNull(this.onNYBonusPanelClicked,"onNYBonusPanelClicked" + Errors.CANT_NULL);
            this.onNYBonusPanelClicked();
        }

        public final function as_setAmmo(param1:Array, param2:Boolean) : void
        {
            var _loc6_:ShellButtonVO = null;
            var _loc3_:Vector.<ShellButtonVO> = this._vectorShellButtonVO;
            this._vectorShellButtonVO = new Vector.<ShellButtonVO>(0);
            var _loc4_:uint = param1.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                this._vectorShellButtonVO[_loc5_] = new ShellButtonVO(param1[_loc5_]);
                _loc5_++;
            }
            this.setAmmo(this._vectorShellButtonVO,param2);
            if(_loc3_)
            {
                for each(_loc6_ in _loc3_)
                {
                    _loc6_.dispose();
                }
                _loc3_.splice(0,_loc3_.length);
            }
        }

        public final function as_updateVehicleStatus(param1:Object) : void
        {
            var _loc2_:VehicleMessageVO = this._vehicleMessageVO;
            this._vehicleMessageVO = new VehicleMessageVO(param1);
            this.updateVehicleStatus(this._vehicleMessageVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setAmmo(param1:Vector.<ShellButtonVO>, param2:Boolean) : void
        {
            var _loc3_:String = "as_setAmmo" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }

        protected function updateVehicleStatus(param1:VehicleMessageVO) : void
        {
            var _loc2_:String = "as_updateVehicleStatus" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
