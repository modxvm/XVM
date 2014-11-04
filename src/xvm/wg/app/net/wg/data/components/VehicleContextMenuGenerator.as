package net.wg.data.components
{
    import net.wg.infrastructure.interfaces.IVehicleContextMenuGenerator;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.data.daapi.ContextMenuVehicleVo;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.ContextMenuConstants;
    
    public class VehicleContextMenuGenerator extends Object implements IVehicleContextMenuGenerator
    {
        
        public function VehicleContextMenuGenerator()
        {
            super();
        }
        
        public static var VEHICLE_INFO:String = "vehicleInfo";
        
        public static var VEHICLE_SELL:String = "vehicleSell";
        
        public static var VEHICLE_RESEARCH:String = "vehicleResearch";
        
        public static var VEHICLE_CHECK:String = "vehicleCheck";
        
        public static var VEHICLE_UNCHECK:String = "vehicleUncheck";
        
        public static var VEHICLE_STATISTIC:String = "showVehicleStatistics";
        
        public static var VEHICLE_BUY:String = "vehicleBuy";
        
        public static var VEHICLE_REMOVE:String = "vehicleRemove";
        
        public static var COMPONENT_HANGAR:String = "hangar";
        
        public function generateData(param1:ContextMenuVehicleVo) : Vector.<IContextItem>
        {
            return this.getContextItems(param1);
        }
        
        private function getContextItems(param1:ContextMenuVehicleVo) : Vector.<IContextItem>
        {
            var _loc5_:Object = null;
            var _loc6_:String = null;
            var _loc7_:String = null;
            var _loc2_:Vector.<IContextItem> = new Vector.<IContextItem>();
            var _loc3_:Array = this.getVehicleMapForComponent(param1);
            App.utils.asserter.assertNotNull(_loc3_,"variable idsData:Map, method getContextItems, class VehicleContextMenuGenerator " + Errors.CANT_NULL);
            var _loc4_:Number = 0;
            while(_loc4_ < _loc3_.length)
            {
                _loc5_ = _loc3_[_loc4_];
                for(_loc6_ in _loc5_)
                {
                    if(_loc6_ != Values.EMPTY_STR)
                    {
                        _loc7_ = _loc6_ == ContextMenuConstants.SEPARATE?null:MENU.contextmenu(_loc6_);
                        _loc2_.push(new ContextItem(_loc6_,_loc7_,_loc5_[_loc6_]));
                    }
                }
                _loc4_++;
            }
            return _loc2_;
        }
        
        private function getVehicleMapForComponent(param1:ContextMenuVehicleVo) : Array
        {
            switch(param1.component)
            {
                case VehicleContextMenuGenerator.COMPONENT_HANGAR:
                    return this.getHangarMap(param1);
                default:
                    return null;
            }
        }
        
        private function getHangarMap(param1:ContextMenuVehicleVo) : Array
        {
            var _loc2_:Array = [VEHICLE_INFO,{},VEHICLE_STATISTIC,{"enabled":param1.wasInBattle},ContextMenuConstants.SEPARATE,{}];
            if(param1.isRented)
            {
                _loc2_.push(VEHICLE_BUY);
                _loc2_.push({"enabled":param1.canBuyOrRent});
                _loc2_.push(VEHICLE_REMOVE);
                _loc2_.push({"enabled":param1.rentalIsOver});
            }
            else
            {
                _loc2_.push(VEHICLE_SELL);
                _loc2_.push({"enabled":param1.canSell});
            }
            _loc2_.push(ContextMenuConstants.SEPARATE);
            _loc2_.push({});
            _loc2_.push(VEHICLE_RESEARCH);
            _loc2_.push({});
            if(param1.favorite)
            {
                _loc2_.push(VEHICLE_UNCHECK);
            }
            else
            {
                _loc2_.push(VEHICLE_CHECK);
            }
            _loc2_.push({});
            return App.utils.commons.createMappedArray(_loc2_);
        }
    }
}
