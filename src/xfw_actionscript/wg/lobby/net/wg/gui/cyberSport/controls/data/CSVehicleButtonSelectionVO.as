package net.wg.gui.cyberSport.controls.data
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class CSVehicleButtonSelectionVO extends Object implements IDisposable
    {

        private var _selectedVehicle:Number;

        private var _nationIDRange:Array;

        private var _vTypeRange:Array;

        private var _vLevelRange:Array;

        public function CSVehicleButtonSelectionVO(param1:Number, param2:Array = null, param3:Array = null, param4:Array = null)
        {
            super();
            this._selectedVehicle = param1;
            this._nationIDRange = param2;
            this._vTypeRange = param3;
            this._vLevelRange = param4;
        }

        public function dispose() : void
        {
        }

        public function get selectedVehicle() : Number
        {
            return this._selectedVehicle;
        }

        public function get nationIDRange() : Array
        {
            return this._nationIDRange;
        }

        public function get vTypeRange() : Array
        {
            return this._vTypeRange;
        }

        public function get vLevelRange() : Array
        {
            return this._vLevelRange;
        }
    }
}
