package net.wg.gui.lobby.hangar.tcarousel.helper
{
    import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
    
    public class VehicleCarouselVOManager extends Object
    {
        
        public function VehicleCarouselVOManager()
        {
            super();
        }
        
        private var _vehiclesDataList:Vector.<VehicleCarouselVO> = null;
        
        private var _vehiclesDataListIndexes:Array = null;
        
        private var _addedData:Vector.<VehicleCarouselVO> = null;
        
        private var _removedData:Vector.<VehicleCarouselVO> = null;
        
        private var _updatedData:Vector.<VehicleCarouselVO> = null;
        
        public function clear() : void
        {
            if(this._vehiclesDataList)
            {
                while(this._vehiclesDataList.length > 0)
                {
                    this._vehiclesDataList.pop();
                }
                this._vehiclesDataList = null;
            }
            if(this._vehiclesDataListIndexes)
            {
                while(this._vehiclesDataListIndexes.length > 0)
                {
                    this._vehiclesDataListIndexes.pop();
                }
                this._vehiclesDataListIndexes = null;
            }
            this._vehiclesDataList = new Vector.<VehicleCarouselVO>(0);
            this._vehiclesDataListIndexes = [];
            this.clearDiffData();
        }
        
        private function clearDiffData() : void
        {
            if(this._addedData)
            {
                while(this._addedData.length > 0)
                {
                    this._addedData.pop();
                }
                this._addedData = null;
            }
            if(this._removedData)
            {
                while(this._removedData.length > 0)
                {
                    this._removedData.pop();
                }
                this._removedData = null;
            }
            if(this._updatedData)
            {
                while(this._updatedData.length > 0)
                {
                    this._updatedData.pop();
                }
                this._updatedData = null;
            }
        }
        
        public function setData(param1:Object) : void
        {
            var _loc2_:String = null;
            if(!this._vehiclesDataListIndexes)
            {
                this.clear();
                this.initDynamicData();
                if(param1)
                {
                    for(_loc2_ in param1)
                    {
                        this.add(param1[_loc2_]);
                    }
                }
            }
            else
            {
                this.updateData(param1);
            }
        }
        
        public function updateData(param1:Object) : void
        {
            var _loc2_:String = null;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            this.initDynamicData();
            if(param1)
            {
                for(_loc2_ in param1)
                {
                    _loc3_ = Number(_loc2_);
                    _loc4_ = this._vehiclesDataListIndexes.indexOf(_loc3_);
                    if(param1[_loc2_] == null && _loc4_ >= 0)
                    {
                        this.deleteByIndex(_loc4_);
                    }
                    else if(_loc4_ == -1)
                    {
                        this.add(param1[_loc2_]);
                    }
                    else if(_loc4_ >= 0)
                    {
                        this.update(_loc4_,param1[_loc2_]);
                    }
                    
                    
                }
            }
        }
        
        public function clearAndInitDynamicData() : void
        {
            this.clearDiffData();
            this.initDynamicData();
        }
        
        private function initDynamicData() : void
        {
            if(!this._addedData)
            {
                this._addedData = new Vector.<VehicleCarouselVO>(0);
            }
            if(!this._removedData)
            {
                this._removedData = new Vector.<VehicleCarouselVO>(0);
            }
            if(!this._updatedData)
            {
                this._updatedData = new Vector.<VehicleCarouselVO>(0);
            }
        }
        
        private function update(param1:Number, param2:Object) : void
        {
            var _loc3_:VehicleCarouselVO = this._vehiclesDataList[param1];
            _loc3_.parsObj(param2);
            this._updatedData.push(_loc3_);
        }
        
        private function add(param1:Object) : void
        {
            var _loc2_:VehicleCarouselVO = new VehicleCarouselVO();
            var _loc3_:Number = _loc2_.parsObj(param1);
            this._vehiclesDataList.push(_loc2_);
            this._vehiclesDataListIndexes.push(_loc3_);
            this._addedData.push(_loc2_);
        }
        
        private function deleteByIndex(param1:Number) : void
        {
            this._vehiclesDataListIndexes.splice(param1,1);
            var _loc2_:VehicleCarouselVO = this._vehiclesDataList[param1];
            this._vehiclesDataList.splice(param1,1);
            this._removedData.push(_loc2_);
        }
        
        public function getVOByNum(param1:Number) : VehicleCarouselVO
        {
            if(param1 < 0)
            {
                return null;
            }
            if((this._vehiclesDataList) && (this._vehiclesDataList.length > 0) && param1 < this._vehiclesDataList.length)
            {
                return this._vehiclesDataList[param1];
            }
            return null;
        }
        
        public function getVehiclesLen() : Number
        {
            if(this._vehiclesDataList)
            {
                return this._vehiclesDataList.length;
            }
            return 0;
        }
        
        public function getAdded() : Vector.<VehicleCarouselVO>
        {
            return this._addedData;
        }
        
        public function getRemoved() : Vector.<VehicleCarouselVO>
        {
            return this._removedData;
        }
        
        public function getUpdated() : Vector.<VehicleCarouselVO>
        {
            return this._updatedData;
        }
    }
}
