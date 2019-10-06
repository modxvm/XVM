package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.components.maintenance.data.MaintenanceVO;
    import net.wg.gui.lobby.components.maintenance.data.ModuleVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class TechnicalMaintenanceMeta extends AbstractWindowView
    {

        public var getEquipment:Function;

        public var repair:Function;

        public var setRefillSettings:Function;

        public var showModuleInfo:Function;

        public var fillVehicle:Function;

        public var updateEquipmentCurrency:Function;

        private var _maintenanceVO:MaintenanceVO;

        private var _array2:Array;

        private var _array3:Array;

        private var _arrayModuleVO:Array;

        public function TechnicalMaintenanceMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:ModuleVO = null;
            if(this._maintenanceVO)
            {
                this._maintenanceVO.dispose();
                this._maintenanceVO = null;
            }
            if(this._array2)
            {
                this._array2.splice(0,this._array2.length);
                this._array2 = null;
            }
            if(this._array3)
            {
                this._array3.splice(0,this._array3.length);
                this._array3 = null;
            }
            if(this._arrayModuleVO)
            {
                for each(_loc1_ in this._arrayModuleVO)
                {
                    _loc1_.dispose();
                }
                this._arrayModuleVO.splice(0,this._arrayModuleVO.length);
                this._arrayModuleVO = null;
            }
            super.onDispose();
        }

        public function getEquipmentS(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
        {
            App.utils.asserter.assertNotNull(this.getEquipment,"getEquipment" + Errors.CANT_NULL);
            this.getEquipment(param1,param2,param3,param4,param5,param6);
        }

        public function repairS() : void
        {
            App.utils.asserter.assertNotNull(this.repair,"repair" + Errors.CANT_NULL);
            this.repair();
        }

        public function setRefillSettingsS(param1:String, param2:Boolean, param3:Boolean, param4:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setRefillSettings,"setRefillSettings" + Errors.CANT_NULL);
            this.setRefillSettings(param1,param2,param3,param4);
        }

        public function showModuleInfoS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.showModuleInfo,"showModuleInfo" + Errors.CANT_NULL);
            this.showModuleInfo(param1);
        }

        public function fillVehicleS(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Array, param8:Array) : void
        {
            App.utils.asserter.assertNotNull(this.fillVehicle,"fillVehicle" + Errors.CANT_NULL);
            this.fillVehicle(param1,param2,param3,param4,param5,param6,param7,param8);
        }

        public function updateEquipmentCurrencyS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.updateEquipmentCurrency,"updateEquipmentCurrency" + Errors.CANT_NULL);
            this.updateEquipmentCurrency(param1,param2);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:MaintenanceVO = this._maintenanceVO;
            this._maintenanceVO = new MaintenanceVO(param1);
            this.setData(this._maintenanceVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setEquipment(param1:Array, param2:Array, param3:Array) : void
        {
            var _loc9_:ModuleVO = null;
            var _loc4_:Array = this._array2;
            this._array2 = param1;
            var _loc5_:Array = this._array3;
            this._array3 = param2;
            var _loc6_:Array = this._arrayModuleVO;
            this._arrayModuleVO = [];
            var _loc7_:uint = param3.length;
            var _loc8_:* = 0;
            while(_loc8_ < _loc7_)
            {
                this._arrayModuleVO[_loc8_] = new ModuleVO(param3[_loc8_]);
                _loc8_++;
            }
            this.setEquipment(this._array2,this._array3,this._arrayModuleVO);
            if(_loc4_)
            {
                _loc4_.splice(0,_loc4_.length);
            }
            if(_loc5_)
            {
                _loc5_.splice(0,_loc5_.length);
            }
            if(_loc6_)
            {
                for each(_loc9_ in _loc6_)
                {
                    _loc9_.dispose();
                }
                _loc6_.splice(0,_loc6_.length);
            }
        }

        protected function setData(param1:MaintenanceVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setEquipment(param1:Array, param2:Array, param3:Array) : void
        {
            var _loc4_:String = "as_setEquipment" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc4_);
            throw new AbstractException(_loc4_);
        }
    }
}
