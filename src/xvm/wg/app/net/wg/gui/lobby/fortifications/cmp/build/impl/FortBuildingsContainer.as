package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingsContainer;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuilding;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
    
    public class FortBuildingsContainer extends UIComponent implements IFortBuildingsContainer
    {
        
        public function FortBuildingsContainer()
        {
            var _loc2_:IFortBuilding = null;
            super();
            this._buildings = Vector.<IFortBuilding>([this.baseBuilding,this.building1,this.building2,this.building3,this.building4,this.building5,this.building6,this.building7,this.building8]);
            var _loc1_:Number = 4;
            for each(_loc2_ in this._buildings)
            {
                _loc2_.visible = false;
                _loc2_.UIID = _loc1_;
                _loc1_++;
            }
            addEventListener(FortBuildingEvent.BUILDING_SELECTED,this.buildingSelectedHandler);
        }
        
        public static function updateBuildings(param1:Vector.<BuildingVO>, param2:Vector.<IFortBuilding>, param3:Boolean) : void
        {
            var _loc6_:BuildingVO = null;
            var _loc7_:IFortBuilding = null;
            var _loc8_:* = 0;
            var _loc11_:* = 0;
            var _loc4_:int = param1.length;
            var _loc5_:Vector.<IFortBuilding> = param2.slice();
            _loc5_[0].userCanAddBuilding = param3;
            _loc5_[0].setData(param1[0]);
            var _loc9_:uint = 1;
            var _loc10_:uint = 2;
            var _loc12_:int = _loc9_;
            while(_loc12_ < _loc4_)
            {
                _loc6_ = param1[_loc12_];
                _loc8_ = _loc6_.direction;
                _loc11_ = _loc9_ + (_loc8_ - 1) * _loc10_ + _loc6_.position;
                _loc7_ = _loc5_[_loc11_];
                _loc5_[_loc11_] = null;
                _loc7_.userCanAddBuilding = param3;
                _loc7_.setData(_loc6_);
                _loc12_++;
            }
            var _loc13_:int = _loc9_;
            while(_loc13_ < _loc5_.length)
            {
                _loc7_ = _loc5_[_loc13_];
                if(_loc7_)
                {
                    _loc7_.setData(null);
                }
                _loc13_++;
            }
        }
        
        public var baseBuilding:IFortBuilding = null;
        
        public var building1:IFortBuilding = null;
        
        public var building2:IFortBuilding = null;
        
        public var building3:IFortBuilding = null;
        
        public var building4:IFortBuilding = null;
        
        public var building5:IFortBuilding = null;
        
        public var building6:IFortBuilding = null;
        
        public var building7:IFortBuilding = null;
        
        public var building8:IFortBuilding = null;
        
        private var _buildings:Vector.<IFortBuilding> = null;
        
        public function updateCommonMode(param1:FortModeVO) : void
        {
            var _loc2_:IFortBuilding = null;
            for each(_loc2_ in this._buildings)
            {
                _loc2_.updateCommonMode(param1);
            }
        }
        
        public function updateDirectionsMode(param1:FortModeVO) : void
        {
            var _loc2_:IFortBuilding = null;
            for each(_loc2_ in this._buildings)
            {
                _loc2_.updateDirectionsMode(param1);
            }
        }
        
        public function update(param1:Vector.<BuildingVO>, param2:Boolean) : void
        {
            updateBuildings(param1,this.buildings,param2);
        }
        
        public function get buildings() : Vector.<IFortBuilding>
        {
            return this._buildings;
        }
        
        public function setBuildingData(param1:BuildingVO, param2:Boolean) : void
        {
            var _loc3_:IFortBuilding = null;
            for each(_loc3_ in this._buildings)
            {
                if(_loc3_.uid == param1.uid)
                {
                    _loc3_.userCanAddBuilding = param2;
                    _loc3_.setData(param1);
                    break;
                }
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            removeEventListener(FortBuildingEvent.BUILDING_SELECTED,this.buildingSelectedHandler);
            for each(_loc1_ in this._buildings)
            {
                _loc1_.dispose();
            }
            this._buildings.splice(0,this._buildings.length);
            this._buildings = null;
            super.onDispose();
        }
        
        private function buildingSelectedHandler(param1:FortBuildingEvent) : void
        {
            var _loc3_:IFortBuilding = null;
            var _loc2_:String = IFortBuilding(param1.target).uid;
            for each(_loc3_ in this._buildings)
            {
                if(!(_loc3_.uid == _loc2_) && (_loc3_.selected))
                {
                    _loc3_.forceSelected = false;
                }
                else if(_loc3_.uid == _loc2_)
                {
                    if(param1.isOpenedCtxMenu)
                    {
                        _loc3_.forceSelected = true;
                    }
                    else
                    {
                        _loc3_.forceSelected = !_loc3_.selected;
                    }
                }
                
            }
        }
    }
}
