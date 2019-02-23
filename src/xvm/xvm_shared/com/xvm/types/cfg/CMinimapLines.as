/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapLines implements ICloneable
    {
        public var camera:Array;
        public var traverseAngle:Array;
        public var vehicle:Array;

        private var _camera:Vector.<CMinimapLine> = null;
        public function get parsedCamera():Vector.<CMinimapLine>
        {
            if (!_camera)
            {
                _camera = new Vector.<CMinimapLine>();
                for each (var value:Object in camera)
                {
                    _camera.push(ObjectConverter.convertData(value, CMinimapLine));
                }
            }
            return _camera;
        }

        private var _traverseAngle:Vector.<CMinimapLine> = null;
        public function get parsedTraverseAngle():Vector.<CMinimapLine>
        {
            if (!_traverseAngle)
            {
                _traverseAngle = new Vector.<CMinimapLine>();
                for each (var value:Object in traverseAngle)
                {
                    _traverseAngle.push(ObjectConverter.convertData(value, CMinimapLine));
                }
            }
            return _traverseAngle;
        }

        private var _vehicle:Vector.<CMinimapLine> = null;
        public function get parsedVehicle():Vector.<CMinimapLine>
        {
            if (!_vehicle)
            {
                _vehicle = new Vector.<CMinimapLine>();
                for each (var value:Object in vehicle)
                {
                    _vehicle.push(ObjectConverter.convertData(value, CMinimapLine));
                }
            }
            return _vehicle;
        }

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            applyGlobalBattleMacrosVector(parsedCamera);
            applyGlobalBattleMacrosVector(parsedTraverseAngle);
            applyGlobalBattleMacrosVector(parsedVehicle);
        }

        private function applyGlobalBattleMacrosVector(items:Vector.<CMinimapLine>):void
        {
            if (items)
            {
                var len:int = items.length;
                for (var i:int = 0; i < len; ++i)
                {
                    items[i].applyGlobalBattleMacros();
                }
            }
        }
    }
}
