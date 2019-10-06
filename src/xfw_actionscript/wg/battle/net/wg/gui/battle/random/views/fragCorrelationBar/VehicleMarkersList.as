package net.wg.gui.battle.random.views.fragCorrelationBar
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import net.wg.utils.IClassFactory;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.data.constants.Linkages;

    public class VehicleMarkersList extends Object implements IVehicleMarkerAnimFinishedHandler, IDisposable
    {

        private var _vehicleMarkers:Vector.<FCVehicleMarker>;

        private var _vehicleIDs:Vector.<Number>;

        private var _container:MovieClip = null;

        private var _color:String = "";

        private var _markerStartPosition:int = -1;

        private var _markerShift:int = -1;

        private var _classFactory:IClassFactory;

        private var _observerIDs:Vector.<Number>;

        private var _isVehicleCounterShown:Boolean = true;

        private const ALLY_MARKERS_START_POSITION:int = 433;

        private const ENEMY_MARKERS_START_POSITION:int = 556;

        private const MARKER_SHIFT:int = 16;

        public function VehicleMarkersList(param1:MovieClip, param2:Boolean, param3:String)
        {
            this._vehicleMarkers = new Vector.<FCVehicleMarker>(0);
            this._vehicleIDs = new Vector.<Number>();
            this._classFactory = App.utils.classFactory;
            this._observerIDs = new Vector.<Number>();
            super();
            this._container = param1;
            this._markerStartPosition = param2?this.ENEMY_MARKERS_START_POSITION:this.ALLY_MARKERS_START_POSITION;
            this._markerShift = param2?this.MARKER_SHIFT:-this.MARKER_SHIFT;
            this._color = param3;
        }

        public function updateMarkers(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : void
        {
            var _loc4_:FCVehicleMarker = null;
            var _loc5_:DAAPIVehicleInfoVO = null;
            var _loc3_:Vector.<DAAPIVehicleInfoVO> = this.removeObserversFromVehicleInfos(param1);
            for each(_loc4_ in this._vehicleMarkers)
            {
                this._container.removeChild(_loc4_);
                _loc4_.dispose();
            }
            this._vehicleMarkers.splice(0,this._vehicleMarkers.length);
            for each(_loc5_ in _loc3_)
            {
                this.addVehicle(_loc5_);
            }
            if(param2)
            {
                this._vehicleIDs = this.getCorrectVehicleIds(param2);
                this.sort();
            }
        }

        public function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : void
        {
            var _loc3_:DAAPIVehicleInfoVO = null;
            for each(_loc3_ in param1)
            {
                if(!this.removeObserverFromVehicleInfo(_loc3_))
                {
                    this.addVehicle(_loc3_);
                }
            }
            if(param2)
            {
                this._vehicleIDs = this.getCorrectVehicleIds(param2);
                this.sort();
            }
        }

        private function addVehicle(param1:DAAPIVehicleInfoVO) : void
        {
            var _loc2_:FCVehicleMarker = FCVehicleMarker(this._classFactory.getObject(Linkages.FC_MARKER_ITEM));
            _loc2_.init(param1.vehicleID,param1.vehicleType,param1.vehicleStatus,this._color,this);
            this._vehicleMarkers.push(_loc2_);
            if(!this._isVehicleCounterShown)
            {
                _loc2_.visible = false;
            }
            this._container.addChild(_loc2_);
        }

        public function hideVehicleMarkers() : void
        {
            var _loc1_:FCVehicleMarker = null;
            this._isVehicleCounterShown = false;
            for each(_loc1_ in this._vehicleMarkers)
            {
                _loc1_.visible = false;
            }
        }

        public function showVehicleMarkers() : void
        {
            var _loc1_:FCVehicleMarker = null;
            this._isVehicleCounterShown = true;
            this.sort();
            for each(_loc1_ in this._vehicleMarkers)
            {
                _loc1_.visible = true;
            }
        }

        public function updateVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>) : void
        {
            var _loc3_:DAAPIVehicleInfoVO = null;
            var _loc4_:FCVehicleMarker = null;
            for each(_loc3_ in param1)
            {
                _loc4_ = this.getVehicleMarkerByID(_loc3_.vehicleID);
                if(_loc4_)
                {
                    if(!this.removeObserverFromVehicleInfo(_loc3_))
                    {
                        _loc4_.update(_loc3_.vehicleType,_loc3_.vehicleStatus,this._color);
                    }
                    else
                    {
                        this._container.removeChild(_loc4_);
                        _loc4_.dispose();
                        _loc4_ = null;
                    }
                }
            }
            if(param2)
            {
                this._vehicleIDs = this.getCorrectVehicleIds(param2);
                this.sort();
            }
        }

        public function updateVehicleStatus(param1:Number, param2:uint, param3:Vector.<Number>) : void
        {
            var _loc4_:FCVehicleMarker = null;
            if(this._observerIDs.indexOf(param1) == -1)
            {
                _loc4_ = this.getVehicleMarkerByID(param1);
                if(_loc4_ && param3)
                {
                    this._vehicleIDs = this.getCorrectVehicleIds(param3);
                    _loc4_.updateVehicleStatus(param2);
                }
            }
        }

        private function getVehicleMarkerByID(param1:Number) : FCVehicleMarker
        {
            var _loc2_:FCVehicleMarker = null;
            for each(_loc2_ in this._vehicleMarkers)
            {
                if(_loc2_.vehicleID == param1)
                {
                    return _loc2_;
                }
            }
            return null;
        }

        public function sort() : void
        {
            var _loc1_:* = 0;
            var _loc2_:FCVehicleMarker = null;
            if(this._vehicleIDs != null)
            {
                this._vehicleMarkers.sort(this.compare);
                _loc1_ = this._markerStartPosition;
                for each(_loc2_ in this._vehicleMarkers)
                {
                    if(_loc2_.x != _loc1_)
                    {
                        _loc2_.x = _loc1_;
                    }
                    _loc1_ = _loc1_ + this._markerShift;
                }
            }
        }

        private function compare(param1:FCVehicleMarker, param2:FCVehicleMarker) : Number
        {
            var _loc3_:int = this._vehicleIDs.indexOf(param1.vehicleID);
            var _loc4_:int = this._vehicleIDs.indexOf(param2.vehicleID);
            if(_loc3_ == _loc4_)
            {
                return 0;
            }
            if(_loc3_ > _loc4_)
            {
                return 1;
            }
            return -1;
        }

        public function set color(param1:String) : void
        {
            var _loc2_:FCVehicleMarker = null;
            if(this._color != param1)
            {
                this._color = param1;
                for each(_loc2_ in this._vehicleMarkers)
                {
                    _loc2_.color = this._color;
                }
            }
        }

        public function dispose() : void
        {
            var _loc1_:FCVehicleMarker = null;
            for each(_loc1_ in this._vehicleMarkers)
            {
                _loc1_.dispose();
                this._container.removeChild(_loc1_);
            }
            this._container = null;
            this._vehicleMarkers.fixed = false;
            this._vehicleMarkers.splice(0,this._vehicleMarkers.length);
            this._vehicleMarkers = null;
            this._vehicleIDs.fixed = false;
            this._vehicleIDs.splice(0,this._vehicleIDs.length);
            this._vehicleIDs = null;
            this._observerIDs.splice(0,this._observerIDs.length);
            this._observerIDs = null;
            this._classFactory = null;
        }

        private function removeObserversFromVehicleInfos(param1:Vector.<DAAPIVehicleInfoVO>) : Vector.<DAAPIVehicleInfoVO>
        {
            var _loc4_:DAAPIVehicleInfoVO = null;
            var _loc2_:* = -1;
            var _loc3_:Vector.<DAAPIVehicleInfoVO> = new Vector.<DAAPIVehicleInfoVO>(0);
            for each(_loc4_ in param1)
            {
                if(_loc4_.isObserver)
                {
                    _loc2_ = this._observerIDs.indexOf(_loc4_.vehicleID);
                    if(_loc2_ == -1)
                    {
                        this._observerIDs.push(_loc4_.vehicleID);
                    }
                }
                else
                {
                    _loc3_.push(_loc4_);
                }
            }
            return _loc3_;
        }

        private function removeObserverFromVehicleInfo(param1:DAAPIVehicleInfoVO) : Boolean
        {
            var _loc3_:* = 0;
            var _loc2_:* = false;
            if(param1.isObserver)
            {
                _loc2_ = true;
                _loc3_ = this._observerIDs.indexOf(param1.vehicleID);
                if(_loc3_ == -1)
                {
                    this._observerIDs.push(param1.vehicleID);
                }
            }
            return _loc2_;
        }

        private function getCorrectVehicleIds(param1:Vector.<Number>) : Vector.<Number>
        {
            var _loc2_:Vector.<Number> = null;
            var _loc3_:* = 0;
            var _loc4_:* = NaN;
            if(param1)
            {
                _loc2_ = param1.concat();
                _loc2_.fixed = false;
                _loc3_ = -1;
                _loc4_ = -1;
                for each(_loc4_ in this._observerIDs)
                {
                    _loc3_ = _loc2_.indexOf(_loc4_);
                    if(_loc3_ != -1)
                    {
                        _loc2_.splice(_loc3_,1);
                    }
                }
            }
            return _loc2_;
        }
    }
}
