/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapLines extends Object implements ICloneable
    {
        public var vehicle:Array;
        public var camera:Array;
        public var traverseAngle:Array;

        public function get parsedVehicle():Vector.<CMinimapLine>
        {
            return Vector.<CMinimapLine>(vehicle);
        }

        public function get parsedCamera():Vector.<CMinimapLine>
        {
            return Vector.<CMinimapLine>(camera);
        }

        public function get parsedTraverseAngle():Vector.<CMinimapLine>
        {
            return Vector.<CMinimapLine>(traverseAngle);
        }

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            vehicle = parseArray(vehicle);
            camera = parseArray(camera);
            traverseAngle = parseArray(traverseAngle);
        }

        private function parseArray(items:Array):Array
        {
            var a:Array = [];
            if (items && items.length)
            {
                var len:int = items.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var item:CMinimapLine = CMinimapLine.parse(items[i]);
                    item.applyGlobalBattleMacros();
                    a.push(item);
                }
            }
            return a;
        }
    }
}
