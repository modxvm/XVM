package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Values;
    
    public class DirectionVO extends DAAPIDataClass
    {
        
        public function DirectionVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_BUILDINGS:String = "buildings";
        
        private static var FIELD_BASE_BUILDING:String = "baseBuilding";
        
        public var uid:int = -1;
        
        public var name:String = "";
        
        public var fullName:String = "";
        
        public var infoMessage:String = "";
        
        public var isMine:Boolean = true;
        
        public var isOpened:Boolean = true;
        
        public var isAvailable:Boolean = true;
        
        public var isBusy:Boolean = false;
        
        public var closeButtonVisible:Boolean = false;
        
        public var canBeClosed:Boolean = false;
        
        public var revertArrowDirection:Boolean = false;
        
        public var buildings:Array;
        
        public var baseBuilding:BuildingVO;
        
        public var isAttackDeclaredByMyClan:Boolean = false;
        
        public var attackerClanID:int = -1;
        
        public var attackerClanName:String = "";
        
        public var ttHeader:String = "";
        
        public var ttBody:String = "";
        
        public var buildingIndicatorTTHeader:String = "";
        
        public var buildingIndicatorTTBody:String = "";
        
        public function isAttackDeclared() : Boolean
        {
            return !(this.attackerClanID == Values.DEFAULT_INT);
        }
        
        public function get canBeAttacked() : Boolean
        {
            return (this.isOpened) && (this.isAvailable) && !this.isBusy;
        }
        
        public function get canAttackFrom() : Boolean
        {
            return (this.isOpened) && (this.isAvailable) && !this.isBusy;
        }
        
        public function get hasBuildings() : Boolean
        {
            return (this.buildings) && this.buildings.length > 0;
        }
        
        public function getBuildingUnderAttack() : String
        {
            var _loc1_:BuildingVO = null;
            if((this.baseBuilding) && (this.baseBuilding.underAttack))
            {
                return this.baseBuilding.uid;
            }
            if(this.hasBuildings)
            {
                for each(_loc1_ in this.buildings)
                {
                    if((_loc1_) && (_loc1_.underAttack))
                    {
                        return _loc1_.uid;
                    }
                }
            }
            return null;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:BuildingVO = null;
            if(param1 == FIELD_BUILDINGS)
            {
                this.buildings = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = _loc4_?new BuildingVO(_loc4_):null;
                    this.buildings.push(_loc5_);
                }
                return false;
            }
            if(param1 == FIELD_BASE_BUILDING)
            {
                this.baseBuilding = new BuildingVO(param2);
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            if(this.baseBuilding)
            {
                this.baseBuilding.dispose();
                this.baseBuilding = null;
            }
            this.disposeBuildings();
            super.onDispose();
        }
        
        private function disposeBuildings() : void
        {
            var _loc1_:BuildingVO = null;
            if(this.buildings)
            {
                for each(_loc1_ in this.buildings)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.buildings.splice(0);
                this.buildings = null;
            }
        }
    }
}
