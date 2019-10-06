package net.wg.gui.lobby.components.maintenance.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Errors;

    public class MaintenanceVO extends DAAPIDataClass
    {

        private static const SHELLS_FIELD:String = "shells";

        public var gold:Number;

        public var credits:Number;

        public var vehicleId:String = "";

        public var repairCost:Number;

        public var maxRepairCost:Number;

        public var autoRepair:Boolean;

        public var autoShells:Boolean;

        public var autoEqip:Boolean;

        public var autoEquipVisible:Boolean = true;

        public var maxAmmo:int;

        public var gunIntCD:int;

        public var casseteFieldText:String = "";

        public var shells:Array = null;

        public var infoAfterShellBlock:String = "";

        public function MaintenanceVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            this.disposeShells();
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:MaintenanceShellVO = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            if(param1 == SHELLS_FIELD)
            {
                this.shells = [];
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,SHELLS_FIELD + Errors.CANT_NULL);
                _loc6_ = 0;
                _loc7_ = 0;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new MaintenanceShellVO(_loc4_);
                    this.shells.push(_loc5_);
                    _loc7_ = _loc7_ + _loc5_.userCount;
                    if(!_loc6_)
                    {
                        _loc6_ = _loc5_.maxAmmo;
                    }
                }
                for each(_loc5_ in this.shells)
                {
                    _loc5_.possibleMax = _loc6_ - _loc7_;
                    _loc5_.totalLoaded = _loc7_;
                    _loc5_.list = this.shells.slice();
                    _loc5_.list.splice(this.shells.indexOf(_loc5_),1);
                }
                for each(_loc5_ in this.shells)
                {
                    _loc5_.updateUserCount();
                }
                return false;
            }
            return true;
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:MaintenanceShellVO = null;
            if(param1 == SHELLS_FIELD)
            {
                _loc3_ = [];
                for each(_loc4_ in this.shells)
                {
                    _loc3_.push(_loc4_.toHash());
                }
                param2[param1] = _loc3_;
                return false;
            }
            return true;
        }

        public function disposeShells() : void
        {
            var _loc1_:MaintenanceShellVO = null;
            for each(_loc1_ in this.shells)
            {
                if(_loc1_)
                {
                    _loc1_.dispose();
                }
            }
            this.shells.splice(0);
            this.shells = null;
        }
    }
}
