package net.wg.gui.lobby.store.views.data
{
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.controls.VO.SimpleRendererVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class VehiclesFiltersVO extends FiltersVO
    {

        private static const VEHICLE_TYPES:String = "vehicleTypes";

        private static const LEVELS_TYPES:String = "levels";

        private static const SELECTED_TYPES_NAMES:String = "selectedTypes";

        private static const SELECTED_LEVELS_NAMES:String = "selectedLevels";

        public var vehicleTypes:DataProvider = null;

        public var levels:DataProvider = null;

        public var selectedTypes:Array;

        public var selectedLevels:Array;

        public function VehiclesFiltersVO(param1:Object)
        {
            this.selectedTypes = [];
            this.selectedLevels = [];
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:Object = null;
            if(param1 == VEHICLE_TYPES)
            {
                this.vehicleTypes = new DataProvider();
                for each(_loc3_ in param2)
                {
                    this.vehicleTypes.push(new SimpleRendererVO(_loc3_));
                }
                return false;
            }
            if(param1 == LEVELS_TYPES)
            {
                this.levels = new DataProvider();
                for each(_loc4_ in param2)
                {
                    this.levels.push(new SimpleRendererVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            if(param1 == SELECTED_TYPES_NAMES)
            {
                param2[param1] = this.selectedTypes;
                return false;
            }
            if(param1 == SELECTED_LEVELS_NAMES)
            {
                param2[param1] = this.selectedLevels;
                return false;
            }
            if(param1 == VEHICLE_TYPES && this.vehicleTypes != null)
            {
                return false;
            }
            if(param1 == LEVELS_TYPES && this.levels != null)
            {
                return false;
            }
            return super.onDataRead(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this.vehicleTypes)
            {
                _loc1_.dispose();
            }
            for each(_loc1_ in this.levels)
            {
                _loc1_.dispose();
            }
            if(this.vehicleTypes != null)
            {
                this.vehicleTypes.cleanUp();
                this.vehicleTypes = null;
            }
            if(this.levels != null)
            {
                this.levels.cleanUp();
                this.levels = null;
            }
            this.selectedTypes.splice(0,this.selectedTypes.length);
            this.selectedTypes = null;
            this.selectedLevels.splice(0,this.selectedLevels.length);
            this.selectedLevels = null;
            super.onDispose();
        }
    }
}
