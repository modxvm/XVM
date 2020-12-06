package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class AmmunitionPanelMeta extends BaseDAAPIComponent
    {

        public var showRepairDialog:Function;

        public var showCustomization:Function;

        public var toRentContinue:Function;

        public var showChangeNation:Function;

        public var onNYBonusPanelClicked:Function;

        private var _vehicleMessageVO:VehicleMessageVO;

        public function AmmunitionPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vehicleMessageVO)
            {
                this._vehicleMessageVO.dispose();
                this._vehicleMessageVO = null;
            }
            super.onDispose();
        }

        public function showRepairDialogS() : void
        {
            App.utils.asserter.assertNotNull(this.showRepairDialog,"showRepairDialog" + Errors.CANT_NULL);
            this.showRepairDialog();
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

        public function onNYBonusPanelClickedS() : void
        {
            App.utils.asserter.assertNotNull(this.onNYBonusPanelClicked,"onNYBonusPanelClicked" + Errors.CANT_NULL);
            this.onNYBonusPanelClicked();
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

        protected function updateVehicleStatus(param1:VehicleMessageVO) : void
        {
            var _loc2_:String = "as_updateVehicleStatus" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
