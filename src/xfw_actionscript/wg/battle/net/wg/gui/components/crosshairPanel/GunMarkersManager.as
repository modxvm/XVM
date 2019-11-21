package net.wg.gui.components.crosshairPanel
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.crosshairPanel.components.gunMarker.DualGunMarker;
    import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
    import flash.display.DisplayObjectContainer;
    import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
    import flash.display.DisplayObject;

    public class GunMarkersManager extends Object implements IDisposable
    {

        private var _gunMarkers:Object = null;

        private var _dualGunMarkers:Vector.<DualGunMarker>;

        private var _scale:Number = 1;

        private var _markerSettings:CrosshairSettingsVO;

        private var _currReloadingPercent:Number = 0;

        private var _currReloadingState:String = "reloadingInit";

        private var _container:DisplayObjectContainer;

        public function GunMarkersManager(param1:DisplayObjectContainer)
        {
            super();
            this._gunMarkers = {};
            this._dualGunMarkers = new Vector.<DualGunMarker>(0);
            this._container = param1;
        }

        private static function cleanupObject(param1:Object) : Object
        {
            var _loc3_:String = null;
            var _loc2_:Array = [];
            for(_loc3_ in param1)
            {
                _loc2_.push(_loc3_);
            }
            for each(_loc3_ in _loc2_)
            {
                delete param1[_loc3_];
            }
            _loc2_.splice(0,_loc2_.length);
            return null;
        }

        public function addGunMarker(param1:IGunMarker, param2:String) : void
        {
            this.destroyGunMarker(param2);
            this._gunMarkers[param2] = param1;
            param1.name = param2;
            param1.setScale(this._scale);
            if(param1 is DualGunMarker)
            {
                this._dualGunMarkers.push(param1);
            }
            if(this._markerSettings)
            {
                param1.setSettings(this._markerSettings.gunTagType,this._markerSettings.mixingType,this._markerSettings.gunTagAlpha,this._markerSettings.mixingAlpha);
            }
            param1.setReloadingParams(this._currReloadingPercent,this._currReloadingState);
            this._container.addChild(DisplayObject(param1));
        }

        public function cancelDualGunCharge() : void
        {
            var _loc1_:DualGunMarker = null;
            for each(_loc1_ in this._dualGunMarkers)
            {
                _loc1_.stopCharging();
            }
        }

        public function destroyGunMarker(param1:String) : Boolean
        {
            var _loc3_:* = 0;
            var _loc2_:IGunMarker = this._gunMarkers[param1];
            if(_loc2_)
            {
                _loc3_ = this._dualGunMarkers.indexOf(_loc2_);
                if(_loc3_ != -1)
                {
                    this._dualGunMarkers.splice(_loc3_,1);
                }
                _loc2_.dispose();
                this._container.removeChild(DisplayObject(_loc2_));
                delete this._gunMarkers[param1];
                return true;
            }
            return false;
        }

        public final function dispose() : void
        {
            var _loc1_:IGunMarker = null;
            for each(_loc1_ in this._gunMarkers)
            {
                _loc1_.dispose();
            }
            this._gunMarkers = cleanupObject(this._gunMarkers);
            this._dualGunMarkers.length = 0;
            this._dualGunMarkers = null;
            this._markerSettings = null;
            this._container = null;
        }

        public function setGunMarkerColor(param1:String, param2:String) : void
        {
            var _loc3_:IGunMarker = this._gunMarkers[param1];
            if(_loc3_)
            {
                _loc3_.setColor(param2);
            }
        }

        public function setScale(param1:Number) : void
        {
            var _loc2_:IGunMarker = null;
            this._scale = param1;
            for each(_loc2_ in this._gunMarkers)
            {
                _loc2_.setScale(param1);
            }
        }

        public function startDualGunCharging(param1:Number, param2:Number) : void
        {
            var _loc3_:DualGunMarker = null;
            for each(_loc3_ in this._dualGunMarkers)
            {
                _loc3_.startCharging(param1,param2);
            }
        }

        public function updateDualGunMarkerState(param1:int) : void
        {
            var _loc2_:DualGunMarker = null;
            for each(_loc2_ in this._dualGunMarkers)
            {
                _loc2_.setMarkerState(param1);
            }
        }

        public function updateReloadingParams(param1:Number, param2:String) : void
        {
            var _loc3_:IGunMarker = null;
            this._currReloadingPercent = param1;
            this._currReloadingState = param2;
            for each(_loc3_ in this._gunMarkers)
            {
                _loc3_.setReloadingParams(param1,param2);
            }
        }

        public function updateSettings(param1:CrosshairSettingsVO) : void
        {
            var _loc2_:IGunMarker = null;
            this._markerSettings = param1;
            for each(_loc2_ in this._gunMarkers)
            {
                _loc2_.setSettings(param1.gunTagType,param1.mixingType,param1.gunTagAlpha,param1.mixingAlpha);
            }
        }
    }
}
